package metrics

import (
	"github.com/prometheus/client_golang/prometheus"
	"github.com/prometheus/client_golang/prometheus/promauto" // auto-registry collectors in default registry
)

var (
	jobShare = promauto.NewGaugeVec(
		prometheus.GaugeOpts{
			Subsystem: VolcanoNamespace,
			Name:      "job_share",
			Help:      "Share for one job",
		}, []string{"job_ns", "job_name"},
	)
)

// UpdateJobShare records share for one job
func UpdateJobShare(jobNs, jobName string, share float64) {
	jobShare.WithLabelValues(jobNs, jobName).Set(share)
}
