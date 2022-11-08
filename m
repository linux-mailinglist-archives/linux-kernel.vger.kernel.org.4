Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D792621E8F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 22:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbiKHVcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 16:32:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiKHVcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 16:32:32 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 769106176A
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 13:32:31 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id q62-20020a25d941000000b006cac1a4000cso15051438ybg.14
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 13:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kBVQGngEncn0NZSSAaHpLzuK73jVMh32gfCGxaDII+E=;
        b=jXV4D6xaTeE0eo9PBU7NMovPnsWS90SveDmRPMUTvDwvWR0bsW5dzqSCvETI+a2r2N
         Oezh8eaoAuUwqhxvi++3mx2Yiz/8NXNlGZ5IhnAulUUS0+fJZYPggdH2tfvkeVnkBTQc
         7hnHlDIOXjFMvQ+RoB94PeLeSJVrozGYEmsJWtj8kvATAHSF5sBZSHrf8mMgUDiF5YzP
         Fdp17SdYZ3dFINtK5++d6DBaPGoaMjQXhcBX98tj5YsNty6jJhldQGQCHdgiCtZW+MWW
         LPvnnEhQ0eAWqxluAQpZ2DqapLdSknYpjTLL5tgyiVt1YDS3T/arX7sG1Wo52osK7Ry7
         hNog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kBVQGngEncn0NZSSAaHpLzuK73jVMh32gfCGxaDII+E=;
        b=GClets8GZGjn3atElfrLO0B2lOch1lmJcuXndH3bGVGN82f7JmE281LGPjGKtO+Qmw
         2E+ahnDxEl7xJ3LJSkxCKUSLP6kbAcV2IB8EI1Bg5U4lca54U+2EY4nqcl6s4ekCR4+T
         bDzY6HTV+MDDHUtWZRGoDRMyfkymCM79M1avx+0qZmVLorR5MwvXjmfUt7+FLfIoXkUB
         MklnyPhQbA5mdptQVfk/q51WPAGzK3c3FqjQv3i56S28Ph0NCpSCPPvCkPAKlvstuugP
         Z+SZL14F3ix4owTtgELFxYxSaI7l0cfCykh6Jj8XPuxEDeYcityGdfrJpeAIdhvafWbi
         tB2g==
X-Gm-Message-State: ACrzQf1/fD57IcXEm47DH666p91g0TjGftTjxtR8M2vKuhwx/PlzmAOf
        LOoF8JFMTJa1oiSRQ4ibEY6jbbEOTM8S6dWG0irpVJtRyDQgAKAmQI7vZvyZXfC0yDYcPTt711n
        FJB0eXufGsuAFwlfcvjQreS5BAhz0R2hTcq3sBTMMtXhl6bUoWs07se4y7xV1fIBT4gOGzyuA0O
        Oxf/fZ8IQ=
X-Google-Smtp-Source: AMsMyM5K6XK+TXSyYexqCfS/oaq2Hvne1JTrkZvVRGxZio5burT0CNL1mgF3sJVO044nOrj/gdMnRIh6G2PxjIQ20Q==
X-Received: from dionnaglaze.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2ee6])
 (user=dionnaglaze job=sendgmr) by 2002:a25:f451:0:b0:6cc:aeeb:8fed with SMTP
 id p17-20020a25f451000000b006ccaeeb8fedmr44888855ybe.11.1667943150710; Tue,
 08 Nov 2022 13:32:30 -0800 (PST)
Date:   Tue,  8 Nov 2022 21:32:25 +0000
In-Reply-To: <20221108213226.3340496-1-dionnaglaze@google.com>
Mime-Version: 1.0
References: <20221108213226.3340496-1-dionnaglaze@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221108213226.3340496-2-dionnaglaze@google.com>
Subject: [PATCH 1/2] kvm: sev: Add SEV-SNP guest request throttling
From:   Dionna Glaze <dionnaglaze@google.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Dionna Glaze <dionnaglaze@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AMD-SP is a precious resource that doesn't have a scheduler other
than a mutex lock queue. To avoid customers from causing a DoS, we
implement a module_param-set rate limit with a default of 2 requests
per 2 seconds.

These defaults were chosen empirically with a the assumption that
current server-grade SEV-SNP machines will rarely exceed 128 VMs under
usual circumstance.

The 2 burst per 2 seconds means on average 1 request every second. We
allow 2 requests back to back to allow for the guest to query the
certificate length in an extended guest request without a pause. The
1 second average is our target for quality of service since empirical
tests show that 64 VMs can concurrently request an attestation report
with a maximum latency of 1 second. We don't anticipate more
concurrency than that for a seldom used request for a majority well-
behaved set of VMs. The majority point is decided as >64 VMs given
the assumed 128 VM count for "extreme load".

The throttling code is 2 << 32 given that invalid length is 1 and 2 is
the next available code. This was suggested by Tom Lendacky, and will
be included in a new revision of the GHCB specification.

Signed-off-by: Dionna Glaze <dionnaglaze@google.com>
---
 arch/x86/include/asm/sev-common.h |  1 +
 arch/x86/kvm/svm/sev.c            | 29 +++++++++++++++++++++++++++++
 arch/x86/kvm/svm/svm.h            |  3 +++
 3 files changed, 33 insertions(+)

diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index 1b111cde8c82..e3a6b039480d 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -158,6 +158,7 @@ struct snp_psc_desc {
 
 /* Guest message request error code */
 #define SNP_GUEST_REQ_INVALID_LEN	BIT_ULL(32)
+#define SNP_GUEST_REQ_THROTTLED		(((u64)2) << 32)
 
 #define GHCB_MSR_TERM_REQ		0x100
 #define GHCB_MSR_TERM_REASON_SET_POS	12
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index e1dd67e12774..a9f67bfd60d9 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -61,6 +61,14 @@ module_param_named(sev_es, sev_es_enabled, bool, 0444);
 /* enable/disable SEV-SNP support */
 static bool sev_snp_enabled = true;
 module_param_named(sev_snp, sev_snp_enabled, bool, 0444);
+
+/* Throttle guest requests to a burst # per this many seconds */
+unsigned int guest_request_throttle_s = 2;
+module_param(guest_request_throttle_s, int, 0444);
+
+/* Throttle guest requests to this many per the above many seconds */
+unsigned int guest_request_throttle_burst = 2;
+module_param(guest_request_throttle_burst, int, 0444);
 #else
 #define sev_enabled false
 #define sev_es_enabled false
@@ -345,6 +353,9 @@ static int sev_guest_init(struct kvm *kvm, struct kvm_sev_cmd *argp)
 		spin_lock_init(&sev->psc_lock);
 		ret = sev_snp_init(&argp->error);
 		mutex_init(&sev->guest_req_lock);
+		ratelimit_state_init(&sev->snp_guest_msg_rs,
+				     guest_request_throttle_s * HZ,
+				     guest_request_throttle_burst);
 	} else {
 		ret = sev_platform_init(&argp->error);
 	}
@@ -3594,6 +3605,14 @@ static void snp_cleanup_guest_buf(struct sev_data_snp_guest_request *data, unsig
 		*rc = SEV_RET_INVALID_ADDRESS;
 }
 
+static bool snp_throttle_guest_request(struct kvm_sev_info *sev) {
+	if (__ratelimit(&sev->snp_guest_msg_rs))
+		return false;
+
+	pr_info_ratelimited("svm: too many guest message requests\n");
+	return true;
+}
+
 static void snp_handle_guest_request(struct vcpu_svm *svm, gpa_t req_gpa, gpa_t resp_gpa)
 {
 	struct sev_data_snp_guest_request data = {0};
@@ -3610,6 +3629,11 @@ static void snp_handle_guest_request(struct vcpu_svm *svm, gpa_t req_gpa, gpa_t
 
 	sev = &to_kvm_svm(kvm)->sev_info;
 
+	if (snp_throttle_guest_request(sev)) {
+		rc = SNP_GUEST_REQ_THROTTLED;
+		goto e_fail;
+	}
+
 	mutex_lock(&sev->guest_req_lock);
 
 	rc = snp_setup_guest_buf(svm, &data, req_gpa, resp_gpa);
@@ -3647,6 +3671,11 @@ static void snp_handle_ext_guest_request(struct vcpu_svm *svm, gpa_t req_gpa, gp
 
 	sev = &to_kvm_svm(kvm)->sev_info;
 
+	if (snp_throttle_guest_request(sev)) {
+		rc = SNP_GUEST_REQ_THROTTLED;
+		goto e_fail;
+	}
+
 	data_gpa = vcpu->arch.regs[VCPU_REGS_RAX];
 	data_npages = vcpu->arch.regs[VCPU_REGS_RBX];
 
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 2cdfc79bf2cf..2201458c4cf7 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -18,6 +18,7 @@
 #include <linux/kvm_types.h>
 #include <linux/kvm_host.h>
 #include <linux/bits.h>
+#include <linux/ratelimit.h>
 
 #include <asm/svm.h>
 #include <asm/sev-common.h>
@@ -101,6 +102,8 @@ struct kvm_sev_info {
 	void *snp_certs_data;
 	struct mutex guest_req_lock;
 
+	struct ratelimit_state snp_guest_msg_rs;  /* Limit guest requests */
+
 	u64 sev_features;	/* Features set at VMSA creation */
 };
 
-- 
2.38.1.431.g37b22c650d-goog

