Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33583607E35
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 20:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbiJUSTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 14:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiJUSTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 14:19:19 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A99127EAC4;
        Fri, 21 Oct 2022 11:19:18 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id n12so6198072wrp.10;
        Fri, 21 Oct 2022 11:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6Q5dOOnQXsp0I8PekuUzOnV/Jb87rJs8XngVkoGhEg0=;
        b=I3dlYO3Zy2SjhI5EMAEFVEh8am4GOQLfg2FtlnVFvOAbwdabeRekIX0p4ZbWXMRd2y
         ZhVX48PKJD4JMyRa0KxBAjgyTc7d/pD0Bdu3w6IBmzAiHbFyrejDPn7Aq4Q7ExW6L6Qi
         U6TwzhdkOG8nrIcZJZVYQuWNYtDYWxopFfU0NYHzpolp61NpdCHbu0p5/XTxwbvqfKWo
         Mn1no0b6JD9lTrRj3MT3eBGknzdLOmV1ENqH2PE3kmfwKuz/v/qiHL6BsvlpdrXKJh8b
         LBvMikyH1YF6RlBlczLend0FlxKk3HbFCiWrTIIc//avqO6bpDuC1kJGiGHLw87zis3h
         27DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Q5dOOnQXsp0I8PekuUzOnV/Jb87rJs8XngVkoGhEg0=;
        b=YKQDY5SO5m0jQlrF9kcVYNjwNXlDFEWTVj6gRyi3EtZucp2XcfmIVZpoUDU/dkWuut
         aSY/18KFytfxITlhZX74snwztlUG/uRvykdZblvpZgVf7hKSghH6rXqcz3cBjtyzyUZJ
         HzirQ2GHLnZlIShBQxVB7lyHpzUtcNDQ4yeY40PEXfjeJR+lx+4b85xd1SmU8L5GfajN
         Xqt7vDnPyFa6t8rKjHqiXPKFRCilU5hgSTbUQwkMEgsszbcrpLddUk2DnORW6PJFCveB
         eBi7V9CUt0kooTJu40SlGTH2biqpMH2roHpZMIytcLnqp03FfApXWk2Jql1jzGq8k//b
         A9Dg==
X-Gm-Message-State: ACrzQf2eGbFjopdUouKIJ9nOwqYuHZTXmK0hBek2F8yP8VfiXRchi6mI
        nijWslUSaHi/mZ5ckrlX+Pw=
X-Google-Smtp-Source: AMsMyM6YkJPAL+OsRDQbgcvMsQwq9UQbv6vVd9djkFW+sIctX0BW2OJtYEjFirNW4xxdntQT1zhagA==
X-Received: by 2002:a5d:648c:0:b0:22e:63be:be09 with SMTP id o12-20020a5d648c000000b0022e63bebe09mr13079397wri.159.1666376356606;
        Fri, 21 Oct 2022 11:19:16 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-134.ip85.fastwebnet.it. [93.42.70.134])
        by smtp.googlemail.com with ESMTPSA id j8-20020a05600c1c0800b003c6b7f5567csm11157313wms.0.2022.10.21.11.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 11:19:16 -0700 (PDT)
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
Subject: [RESEND PATCH 1/2] thermal: qcom: tsens: init debugfs only with successful probe
Date:   Fri, 21 Oct 2022 20:19:05 +0200
Message-Id: <20221021181906.16647-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

