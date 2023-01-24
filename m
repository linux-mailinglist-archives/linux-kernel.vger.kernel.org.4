Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F66667A4C4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 22:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234970AbjAXVQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 16:16:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234899AbjAXVPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 16:15:45 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE57521C1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 13:15:25 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id h6-20020a17090aa88600b00223fccff2efso11723723pjq.6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 13:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JBzFUdybILoe8O9craXfERpc0jtsf4nQJK8kxIB3j/E=;
        b=EVNMKlTM19LGYN9Zq7dvfNaMSXJvWYcRRygrmiGp1NbryTDgQBhofHKxEGEzrApKBB
         ydVvCwPs2gj7utggt4WMvX7N+ydAP+7E4mBGnIKPxP4tutVrbkhYqFBlSIH8N0nWsGUs
         pXhVWeiWFCkyZCYGqGtlPdnaLsUlZe1suiEOxLJCXyYBNrbEqYtSG6UCRm98UM4IhYAN
         h3Pke9usobrHnyOylpVGk8sXT/SSk196OK0Yw+l0Ta/4MnkTyCzeqmw37aWNHU1kJTG9
         dLtwKI/wXDG+aWCSEz/lLxcwCPYMSy5Ro15+5qnU4h6ryBjbT801cnFDHwwUSGT8vSLy
         z2og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JBzFUdybILoe8O9craXfERpc0jtsf4nQJK8kxIB3j/E=;
        b=q/9Y4y7odRCv5up5Q90zl+VM8xGPBFCgc+B6RLNl/HkwKA7XG15O+JJ7L+9lHis8tG
         VzjZxy7ZtjthWAjPjyj/IbtoFsu86IosP4yWRQtJHUn5IrOWNeyNe7bzopk3Ab3c9kwB
         OnByPnMyAUUoDXXLxCWcqwU14DLRu9S/v5/uAFaynLzm96UDroT0R2eZdncbMO8YO7Tx
         n2B5rUBlUlpzLNMQ99fAEYp7JwMiyGqem63gkNHkUMjJWUWrjTSx+uBWD2NhvsMeCF6y
         Ee7JKJsDdvx2BKn2Jcdx2SsWShAz1iuZU5qiJ0KA7LicsBPITNS72GRTZQSGOVtbhyB2
         SnuQ==
X-Gm-Message-State: AFqh2krMaUtZ3wqRC4VU5v5SN8FaqOwN+/SbYGSi2/CgUkr34LxOZqJT
        P4Pl7uLlUcwJVufnFnLZdCHqwOhXY1WApuMh2a9UsPC2BBeBYPPZfMrgCFnL8ZZ9MtYhTt15k2g
        dl//5Va8QF4NCpeabQAofuwJBnfqzJUarX8V74BPa0YZCaoChVtuvHrp2A39X44JfrfMInbb9Dc
        2tAhpaVtM=
X-Google-Smtp-Source: AMrXdXs/rxPJO88KcgHzbLzGJJs/MW4Rg+/YmGZes573wdJg2Tif+mJ60qHw/sdJ7o5aZmZ3tSWphfQu10KE5V8Wvw==
X-Received: from dionnaglaze.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2ee6])
 (user=dionnaglaze job=sendgmr) by 2002:a17:902:6acc:b0:187:3921:2b2d with
 SMTP id i12-20020a1709026acc00b0018739212b2dmr2968716plt.13.1674594924957;
 Tue, 24 Jan 2023 13:15:24 -0800 (PST)
Date:   Tue, 24 Jan 2023 21:14:55 +0000
In-Reply-To: <20230124211455.2563674-1-dionnaglaze@google.com>
Mime-Version: 1.0
References: <20230124211455.2563674-1-dionnaglaze@google.com>
X-Mailer: git-send-email 2.39.1.405.gd4c25cc71f-goog
Message-ID: <20230124211455.2563674-5-dionnaglaze@google.com>
Subject: [PATCH v13 4/4] virt: sev-guest: self-throttle guest request retries
From:   Dionna Glaze <dionnaglaze@google.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Dionna Glaze <dionnaglaze@google.com>,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        Peter Gonda <pgonda@google.com>,
        Borislav Petkov <Borislav.Petkov@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Liam Merwick <liam.merwick@oracle.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Haowen Bai <baihaowen@meizu.com>
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

When throttled, the driver will reschedule itself and then try
again after sleeping half its ratelimit time to avoid a big wait queue.
The ioctl may block indefinitely, but that has always been the case
when deferring these requests to the host.

Cc: Tom Lendacky <Thomas.Lendacky@amd.com>
Cc: Peter Gonda <pgonda@google.com>
Cc: Borislav Petkov <Borislav.Petkov@amd.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Liam Merwick <liam.merwick@oracle.com>
Cc: Yang Yingliang <yangyingliang@huawei.com>
Cc: Haowen Bai <baihaowen@meizu.com>

Signed-off-by: Dionna Glaze <dionnaglaze@google.com>
---
 drivers/virt/coco/sev-guest/sev-guest.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index e82f080aa679..af0645f40e95 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -14,6 +14,7 @@
 #include <linux/io.h>
 #include <linux/platform_device.h>
 #include <linux/miscdevice.h>
+#include <linux/ratelimit.h>
 #include <linux/set_memory.h>
 #include <linux/fs.h>
 #include <crypto/aead.h>
@@ -48,12 +49,22 @@ struct snp_guest_dev {
 	struct snp_req_data input;
 	u32 *os_area_msg_seqno;
 	u8 *vmpck;
+
+	struct ratelimit_state rs;
 };
 
 static u32 vmpck_id;
 module_param(vmpck_id, uint, 0444);
 MODULE_PARM_DESC(vmpck_id, "The VMPCK ID to use when communicating with the PSP.");
 
+static int rate_s = 1;
+module_param(rate_s, int, 0444);
+MODULE_PARM_DESC(rate_s, "The rate limit interval in seconds to limit requests to.");
+
+static int rate_burst = 2;
+module_param(rate_burst, int, 0444);
+MODULE_PARM_DESC(rate_burst, "The rate limit burst amount to limit requests to.");
+
 /* Mutex to serialize the shared buffer access and command handling. */
 static DEFINE_MUTEX(snp_cmd_mutex);
 
@@ -339,6 +350,15 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code,
 		return rc;
 
 retry:
+	/*
+	 * Rate limit commands internally since the host can also throttle, and
+	 * the guest shouldn't create a tight request spin that could end up
+	 * getting this VM throttled more heavily.
+	 */
+	if (!__ratelimit(&snp_dev->rs)) {
+		schedule_timeout_interruptible((rate_s * HZ) / 2);
+		goto retry;
+	}
 	/*
 	 * Call firmware to process the request. In this function the encrypted
 	 * message enters shared memory with the host. So after this call the
@@ -760,6 +780,8 @@ static int __init sev_guest_probe(struct platform_device *pdev)
 	if (ret)
 		goto e_free_cert_data;
 
+	ratelimit_state_init(&snp_dev->rs, rate_s * HZ, rate_burst);
+
 	dev_info(dev, "Initialized SEV guest driver (using vmpck_id %d)\n", vmpck_id);
 	return 0;
 
-- 
2.39.1.405.gd4c25cc71f-goog

