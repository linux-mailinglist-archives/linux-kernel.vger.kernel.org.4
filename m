Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CED6962F0A7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 10:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241780AbiKRJME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 04:12:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241766AbiKRJL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 04:11:57 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601A2BF72
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 01:11:55 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id v17so6248221edc.8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 01:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jRa/PoxgqDRwmd3eIz//88s67gtNdYgRfX+YpZPu+BM=;
        b=pGDB+b0kZ/sQIJwkZVnS6mJ7ZHtv/wyTZg8nv9lMsZgqMRY3qSg3K4iYahUKU1UPMy
         6oxTtEbLtTIgMekKU6EGmV8xG8HOBX/eBx+zPYrgtTyt4MexT81gGPMcpve6KrHdllvi
         cAcT6AIjTv8pDRpLwf+HUKK/70BCiuZnkcpOm1e3f8Z+KVwdAD/dCjajmZ+YRdlPbnPQ
         gws48p64W7rF9njDLmrxgIoy8e+puJXk/Mu0Xg9vsi/JGcFXXOJI2nfrAPA1dnNWUR0P
         7VRGUTU3T2yg/LEmo20Tw7wpQv7cLZ6SSctEkUQXLss2NLsRH1POhLQBisnIX/fuxy7C
         yQZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jRa/PoxgqDRwmd3eIz//88s67gtNdYgRfX+YpZPu+BM=;
        b=M52Mir3NDBc7HC/mpNOsLjEB6nNqsnAi7TpeaC5rwz/nDJB6E6kduFcAG4nHVtu8Fk
         VNdjEoscsUAHPZiLX+XD/CGFyvClNiuNqSA8rpokAteUJ9VCrCqYL8FTI5MTxezDTh8p
         4DgnTuUdvAS3s3BWsAwcJQwNnunX8EI8Fjihr212g/iuOMf0LwgG62gS6Ee+fyGDrR0K
         C2vWiUZl7sgURidsbtWfsYRfsRXyYmm45WZrtm92BvBLJGomz7SdXoy4OY2xohLbbHMG
         8ZPpBhDVeq0UvCNMOtT89m/x29wIIEpil7LZKK61UZAqBOGrd4vX2Q7w2Ydr2irZ+/5l
         IS3g==
X-Gm-Message-State: ANoB5pnqQgxj8Jtvr6m75keW4x1bc/utJO5HDqjSfgteescYCHQwEsD1
        oWjCOF+7W8HauMnmrKFbjFPtRg==
X-Google-Smtp-Source: AA0mqf60UCoSoZCOMJgwUY56vTLWRzaG7YSp6S3dpTy4oD84LYoA1zTvMRFEHxf21XoMxzZMW30VRQ==
X-Received: by 2002:aa7:d593:0:b0:461:de5e:ba52 with SMTP id r19-20020aa7d593000000b00461de5eba52mr5304051edq.177.1668762713858;
        Fri, 18 Nov 2022 01:11:53 -0800 (PST)
Received: from otso.arnhem.chello.nl (k10064.upc-k.chello.nl. [62.108.10.64])
        by smtp.gmail.com with ESMTPSA id v15-20020aa7dbcf000000b0046182b3ad46sm1535647edt.20.2022.11.18.01.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 01:11:53 -0800 (PST)
From:   Luca Weiss <luca.weiss@fairphone.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>,
        Mukesh Ojha <quic_mojha@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        Siddharth Gupta <sidgup@codeaurora.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] remoteproc: qcom_q6v5_pas: disable wakeup on probe fail or remove
Date:   Fri, 18 Nov 2022 10:08:15 +0100
Message-Id: <20221118090816.100012-1-luca.weiss@fairphone.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Leaving wakeup enabled during probe fail (-EPROBE_DEFER) or remove makes
the subsequent probe fail.

[    3.749454] remoteproc remoteproc0: releasing 3000000.remoteproc
[    3.752949] qcom_q6v5_pas: probe of 3000000.remoteproc failed with error -17
[    3.878935] remoteproc remoteproc0: releasing 4080000.remoteproc
[    3.887602] qcom_q6v5_pas: probe of 4080000.remoteproc failed with error -17
[    4.319552] remoteproc remoteproc0: releasing 8300000.remoteproc
[    4.332716] qcom_q6v5_pas: probe of 8300000.remoteproc failed with error -17

Fix this by disabling wakeup in both cases so the driver can properly
probe on the next try.

Fixes: a781e5aa5911 ("remoteproc: core: Prevent system suspend during remoteproc recovery")
Fixes: dc86c129b4fb ("remoteproc: qcom: pas: Mark devices as wakeup capable")
Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Changes in v2:
* move new line before rproc_free which frees 'adsp' as well
* pick up tags

 drivers/remoteproc/qcom_q6v5_pas.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index 6afd0941e552..67f5152e2398 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -556,6 +556,7 @@ static int adsp_probe(struct platform_device *pdev)
 detach_proxy_pds:
 	adsp_pds_detach(adsp, adsp->proxy_pds, adsp->proxy_pd_count);
 free_rproc:
+	device_init_wakeup(adsp->dev, false);
 	rproc_free(rproc);
 
 	return ret;
@@ -572,6 +573,7 @@ static int adsp_remove(struct platform_device *pdev)
 	qcom_remove_sysmon_subdev(adsp->sysmon);
 	qcom_remove_smd_subdev(adsp->rproc, &adsp->smd_subdev);
 	qcom_remove_ssr_subdev(adsp->rproc, &adsp->ssr_subdev);
+	device_init_wakeup(adsp->dev, false);
 	rproc_free(adsp->rproc);
 
 	return 0;
-- 
2.38.1

