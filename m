Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0B7B62E3DD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 19:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240411AbiKQSMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 13:12:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240200AbiKQSLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 13:11:51 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0A37FF3B
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 10:11:48 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id m2-20020a17090a730200b0021020cce6adso4640033pjk.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 10:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+DW5grLQa/cplZRP/qrf8uis0AH4MqPXCwF/prNP4d8=;
        b=DLv4LF4LpZOvyIb/TYzDQiC/8sszsLJYJFK8iY4HzP7/psWC3YjVIJr266ElEqGZSf
         l6izPjXDNEAFyFR3bBWyRaw7t/07Xiw6m4Gss3tLkPzWBCF8Pqqxtx54czoF+7e83Egq
         9FH5iFPJuF3CYdlREeniosEnCv7zRJrJPYiXVd1W1q5HpIyP18e9XwL7FQswYg4w5zO+
         6ojGsP/OIYqA/eBfMh0QYvkT6eEFqJOyir0B1t/3KT0ODFBvIMGsMZLsnW3JeKqfN7g+
         hqKpztpqy/cDIOy82+z0qmEu12L1WRffpl8O0Uq2lr4JlzZKJUye57W+p58o9qMxX0Wb
         cbwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+DW5grLQa/cplZRP/qrf8uis0AH4MqPXCwF/prNP4d8=;
        b=FUW7YM7jXEKA0zHdfXeG4t6WmGBfKRARUqJk2JkEXC9YIiy5LDbFVYJYdIP/5JWTIh
         iFIoF1oP3FYTrXLnL/xBqy4V733GJ/oweuOoCUtdkMVj+a9dMrywMKZG+eg8t1rPZXo8
         mc/E5OKyHacyhl+hF9rNRDkqAwMxVoti5+5cFJOxFp8PEik9Pv86zx5wbjg2aUL4UiVD
         1May8RDlopK4cLjVAVqNg2D7RFPFkgk+cimDokqEc3vpx+malqFMy/dMaM1DZuMmmPKC
         Ni1k3sfgttg7Ps6p6B16yf/OLAK+44lchD3RgHpdhWg3qL3idjOKqdqI0N8AGhvBDpRD
         0B/Q==
X-Gm-Message-State: ANoB5pnBi9tqOK3fqSpDk17ZC9a72/X5eMLuZCj6s7aWjFXnenqx5wEH
        ETEyn9Wd+fKb/DlNgEParQ4RezY+XM8krbmYbsrxMFdwSEl0Ww4q4QP9oeqSnHJikQ431rNcMZJ
        8FuizGnZCv2oY/litHMQvhv8V5V2lqbJuRfBZIKzDM3cQTnt4Sc+Z0oFhal97trdXlrGmSPRo26
        6MhSJwq4M=
X-Google-Smtp-Source: AA0mqf7UEP297Vu/sUmDgoVHzWF569uQiHTAkvOfWkYFTEsr/Ju7F2fAjrlnu0WoC+03Ri7+DQDjvO0kQrjF+WYMGQ==
X-Received: from dionnaglaze.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2ee6])
 (user=dionnaglaze job=sendgmr) by 2002:a17:903:48d:b0:17c:620f:13ac with SMTP
 id jj13-20020a170903048d00b0017c620f13acmr3993630plb.9.1668708708046; Thu, 17
 Nov 2022 10:11:48 -0800 (PST)
Date:   Thu, 17 Nov 2022 18:11:26 +0000
In-Reply-To: <20221117181127.1859634-1-dionnaglaze@google.com>
Mime-Version: 1.0
References: <20221117181127.1859634-1-dionnaglaze@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221117181127.1859634-2-dionnaglaze@google.com>
Subject: [PATCH v2 1/2] kvm: sev: Add SEV-SNP guest request throttling
From:   Dionna Glaze <dionnaglaze@google.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Dionna Glaze <dionnaglaze@google.com>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joerg Roedel <jroedel@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirsky <luto@kernel.org>,
        John Allen <john.allen@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Peter Gonda <pgonda@google.com>
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

Cc: Thomas Lendacky <Thomas.Lendacky@amd.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Joerg Roedel <jroedel@suse.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Andy Lutomirsky <luto@kernel.org>
Cc: John Allen <john.allen@amd.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Peter Gonda <pgonda@google.com>

Signed-off-by: Dionna Glaze <dionnaglaze@google.com>
---
 arch/x86/include/asm/sev-common.h |  1 +
 arch/x86/kvm/svm/sev.c            | 29 +++++++++++++++++++++++++++++
 arch/x86/kvm/svm/svm.h            |  3 +++
 3 files changed, 33 insertions(+)

diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index 9573ee1573ed..225b5e88f9a4 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -158,6 +158,7 @@ struct snp_psc_desc {
 
 /* Guest message request error code */
 #define SNP_GUEST_REQ_INVALID_LEN	BIT_ULL(32)
+#define SNP_GUEST_REQ_THROTTLED		(((u64)2) << 32)
 
 #define GHCB_MSR_TERM_REQ		0x100
 #define GHCB_MSR_TERM_REASON_SET_POS	12
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index a35cd9f33f16..3ced06c6e07a 100644
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
@@ -338,6 +346,9 @@ static int sev_guest_init(struct kvm *kvm, struct kvm_sev_cmd *argp)
 		init_srcu_struct(&sev->psc_srcu);
 		ret = sev_snp_init(&argp->error);
 		mutex_init(&sev->guest_req_lock);
+		ratelimit_state_init(&sev->snp_guest_msg_rs,
+				     guest_request_throttle_s * HZ,
+				     guest_request_throttle_burst);
 	} else {
 		ret = sev_platform_init(&argp->error);
 	}
@@ -3288,6 +3299,14 @@ static void snp_cleanup_guest_buf(struct sev_data_snp_guest_request *data, unsig
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
@@ -3304,6 +3323,11 @@ static void snp_handle_guest_request(struct vcpu_svm *svm, gpa_t req_gpa, gpa_t
 
 	sev = &to_kvm_svm(kvm)->sev_info;
 
+	if (snp_throttle_guest_request(sev)) {
+		rc = SNP_GUEST_REQ_THROTTLED;
+		goto e_fail;
+	}
+
 	mutex_lock(&sev->guest_req_lock);
 
 	rc = snp_setup_guest_buf(svm, &data, req_gpa, resp_gpa);
@@ -3341,6 +3365,11 @@ static void snp_handle_ext_guest_request(struct vcpu_svm *svm, gpa_t req_gpa, gp
 
 	sev = &to_kvm_svm(kvm)->sev_info;
 
+	if (snp_throttle_guest_request(sev)) {
+		rc = SNP_GUEST_REQ_THROTTLED;
+		goto e_fail;
+	}
+
 	data_gpa = vcpu->arch.regs[VCPU_REGS_RAX];
 	data_npages = vcpu->arch.regs[VCPU_REGS_RBX];
 
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index e68b3aab57d6..b2eaac449d60 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -18,6 +18,7 @@
 #include <linux/kvm_types.h>
 #include <linux/kvm_host.h>
 #include <linux/bits.h>
+#include <linux/ratelimit.h>
 
 #include <asm/svm.h>
 #include <asm/sev-common.h>
@@ -95,6 +96,8 @@ struct kvm_sev_info {
 	void *snp_certs_data;
 	struct mutex guest_req_lock;
 
+	struct ratelimit_state snp_guest_msg_rs;  /* Limit guest requests */
+	
 	u64 sev_features;	/* Features set at VMSA creation */
 };
 
-- 
2.38.1.584.g0f3c55d4c2-goog

