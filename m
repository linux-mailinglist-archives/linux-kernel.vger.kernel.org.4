Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC016607114
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 09:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbiJUHbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 03:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbiJUHa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 03:30:57 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C506F239207;
        Fri, 21 Oct 2022 00:30:54 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id fw14so1691991pjb.3;
        Fri, 21 Oct 2022 00:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TejV+PVlIWu1ZS6SsOoMljpzVPK//ltlKzLgsPTI8ds=;
        b=f2bTAw8/XqEr3YOFLjWtB9KLAKldY1acFLtSCfPGG5OoGIkd2H6iJDjE6APABzEF63
         JGoDEzsExcrI5mWxDO2jg1vv88QvdfZBQ1Mh+Cz1mUffZLv2nnxMXcfbE1QY3lW2YZof
         /VgAXVBbrO6lAtRRmzjoARjZl5IpuCGiQkoJuOcTdkOgpQzgDf7ngZevFsBwpiJI/6wF
         +RlxPzcK0aYb81QyprVLHJDl+YxL239FzD80rrJ/Yg53rv6U6m7vM7rC3AkVk8XGo3OZ
         +6E1yPzjtkRH1F4zF9ve1B1mFQ05SJkzeG5/G6GYTT8hu5/DI5GlEDcMukDtTd2R+bsi
         jw9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TejV+PVlIWu1ZS6SsOoMljpzVPK//ltlKzLgsPTI8ds=;
        b=MwEIQ12ZNiuszvoIcTqz7QLAf7KtOR8qWUrtaIe+oBPW5t/YZ/qvRoArcYhV5wqcy1
         +Cn4i/agOsq0q/PJilrGSAfr8+6ew2CBwH/YeiRz3GGV7haDSAg0LUFKDDC33hdXW5PS
         9CYVzzXYh4/vOi9lL0QeHOLjHwPSsB6Darm58YqljYS4n0EY7sd3W/5wcCy9SiJwyW+D
         /TdHYXFDvX4uod1hjzEKuKsFZx+rZB3QFAjHaWLrGawO6rfqI53bRVkcSvu+k9Z1Qaxh
         CxUysJ/ic/AYG74sq2s1PNNjXTooL7uDYQkVunp4Z/XtoMaJ1ElbSmjXltbtqG/Ocx6n
         1mPA==
X-Gm-Message-State: ACrzQf1PigBdE9Xr2XfpIocDVj1mPoF7O1g07w6wQ/lfgJ9KnpZTIr89
        EBOrLWDcmF+kCryrlNPdGH4=
X-Google-Smtp-Source: AMsMyM6Sip2fotY+h84K6gBuXU8yUHmnjy5xwNCZAkLHSpfsW9zmyJtRddLDDl7GaDSEhlJjDnELAQ==
X-Received: by 2002:a17:903:2442:b0:17f:8069:533a with SMTP id l2-20020a170903244200b0017f8069533amr17709846pls.46.1666337454271;
        Fri, 21 Oct 2022 00:30:54 -0700 (PDT)
Received: from xm06403pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id d4-20020a62f804000000b005628a30a500sm14531929pfh.41.2022.10.21.00.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 00:30:54 -0700 (PDT)
From:   Wenchao Chen <wenchao.chen666@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com,
        orsonzhai@gmail.com, baolin.wang@linux.alibaba.com,
        zhang.lyra@gmail.com, axboe@kernel.dk, avri.altman@wdc.com,
        kch@nvidia.com
Cc:     CLoehle@hyperstone.com, vincent.whitchurch@axis.com,
        bigeasy@linutronix.de, s.shtylyov@omp.ru,
        michael@allwinnertech.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, megoo.tang@gmail.com,
        lzx.stg@gmail.com
Subject: [PATCH V2 2/2] mmc: sdhci-sprd: enable fua_disable for SPRDSDHCI
Date:   Fri, 21 Oct 2022 15:30:25 +0800
Message-Id: <20221021073025.18831-3-wenchao.chen666@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221021073025.18831-1-wenchao.chen666@gmail.com>
References: <20221021073025.18831-1-wenchao.chen666@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wenchao Chen <wenchao.chen@unisoc.com>

Enable fua_disable in sdhci_sprd_probe.

Signed-off-by: Wenchao Chen <wenchao.chen@unisoc.com>
---
 drivers/mmc/host/sdhci-sprd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index b92a408f138d..d426624196f4 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -586,6 +586,8 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
 	host->mmc->caps = MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED |
 		MMC_CAP_WAIT_WHILE_BUSY;
 
+	host->mmc->fua_disable = true;
+
 	ret = mmc_of_parse(host->mmc);
 	if (ret)
 		goto pltfm_free;
-- 
2.17.1

