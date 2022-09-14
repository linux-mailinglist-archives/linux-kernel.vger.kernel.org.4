Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4D235B8C2C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 17:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbiINPqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 11:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbiINPqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 11:46:45 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7680761710;
        Wed, 14 Sep 2022 08:46:42 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id lc7so35785042ejb.0;
        Wed, 14 Sep 2022 08:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=qCtdxjdxOBvkSvYtMMaZ3sW9JYkd4Tc2K0Q0H8m3kj4=;
        b=frFM1gVUuxqwG/DVL4XTMx2i5cLj/w0y9DyIK92XGVYgN+Zy0/WYP8i1vjckdg4Bfo
         WIOhjk1P+GDtqPvDrFbDh7E2VflLrzWRmI2q3/2Jh44EDDViunJU+0ZyQf97ZO4WH7Y+
         CyO728TkafnlZeiEe1JszXvOmMQt7gIzJHS/5Z1iNfojF6Bizx7OisUSJOppnK8sr5JC
         pD/GUwkUbQWtEdWiEIt2IzIcM2WBGk5shnZQ68MGkg3ti+nWISlchlHjL7GmDGINROqB
         ht0z9H6Vxa9othsmB/xSYlilvYUTHKnkj7iTtW9yeBj2B1TrbRNb7Rn3pcKKFjTp5FHr
         yt1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=qCtdxjdxOBvkSvYtMMaZ3sW9JYkd4Tc2K0Q0H8m3kj4=;
        b=6NqNZs3cuINC4rYnLZpEngdZQOQ2xOOsdt15dGfQhmLNGLahPnFtvph+a7EVjXditN
         xWbYAubcEyUjv6Vr+gsGsRJV8jpES75bRwD1PNhPBOZrNN3WItrmuOEcwKd2rqdT6V2B
         OrEXmAA9mrMNToCHMemySXZDtKYrM3Uqxq4CGQf8Cs9OM4piqI7ZHaLyi0JFBCsgHrg3
         wV0ex7g2pL3ZWRmKK74ygTRb2dMKxvqqf3vbZTfEIwiCUrG/vNmcby9ynA4NgAGfk6jT
         N9kD7UqnQC5WFja5sRUKqe8UepKOAvAIybujQtgd0shIQ41MbDQIynwgXJwj5JQVx4Qw
         P6HQ==
X-Gm-Message-State: ACgBeo2sVQiO0Elylkp+bAW/MszHZc/v8uTX6PIQ7t/uDxIfE5KSJeg6
        HZh5/2Fim6dN/yOL2wS1nbk=
X-Google-Smtp-Source: AA6agR7m5UIHgoP6PQV0w5Wvxq1/hmYZgsbZw8zxTNfidIPz1xUX5kfl1z4JD9dcDAT/aVNzl9eNtw==
X-Received: by 2002:a17:907:3da3:b0:780:3d46:cbe3 with SMTP id he35-20020a1709073da300b007803d46cbe3mr1834594ejc.175.1663170400329;
        Wed, 14 Sep 2022 08:46:40 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-134.ip85.fastwebnet.it. [93.42.70.134])
        by smtp.googlemail.com with ESMTPSA id u18-20020a1709061db200b0077077c62cadsm7800849ejh.31.2022.09.14.08.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 08:46:39 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>,
        Thara Gopinath <thara.gopinath@linaro.org>
Subject: [PATCH v2 1/2] thermal: qcom: tsens: init debugfs only with successful probe
Date:   Wed, 14 Sep 2022 17:46:34 +0200
Message-Id: <20220914154635.2928-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

calibrate and tsens_register can fail or PROBE_DEFER. This will cause a
double or a wrong init of the debugfs information. Init debugfs only
with successful probe fixing warning about directory already present.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Acked-by: Thara Gopinath <thara.gopinath@linaro.org>
---
v2:
- Change sob tag with new name

 drivers/thermal/qcom/tsens.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index b1b10005fb28..cc2965b8d409 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -918,8 +918,6 @@ int __init init_common(struct tsens_priv *priv)
 	if (tsens_version(priv) >= VER_0_1)
 		tsens_enable_irq(priv);
 
-	tsens_debug_init(op);
-
 err_put_device:
 	put_device(&op->dev);
 	return ret;
@@ -1153,7 +1151,12 @@ static int tsens_probe(struct platform_device *pdev)
 		}
 	}
 
-	return tsens_register(priv);
+	ret = tsens_register(priv);
+
+	if (!ret)
+		tsens_debug_init(pdev);
+
+	return ret;
 }
 
 static int tsens_remove(struct platform_device *pdev)
-- 
2.37.2

