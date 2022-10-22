Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B254D608D4A
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 14:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbiJVM5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 08:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiJVM5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 08:57:12 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A1831E3EC;
        Sat, 22 Oct 2022 05:57:11 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id m16so15241289edc.4;
        Sat, 22 Oct 2022 05:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z7rhD1WXk3L0TCFvw5pkhsK28oe7XUuV2gNiSIm6BKo=;
        b=esAkwKbUQ2Fp7FXLvBIFGLPS8xQkqN/MCR8znYnQ587k2ew1B13CDmrIfKxlE+A1Yh
         8HDoPbeYBfwo3DsT35M4ad4fnZqin4fznFbQgnVsFt9GE/3NUo0Ce59M1SwFY0ISuL85
         WukPVszZOtG4hEOnPN0Py4lJrpHGHQxLKhcYpaRl0qNvf+iNQfJilgcee/xct/0QZ6ig
         qYWZQuq33njWgbBOAjK8VnJMjuaGzGEE/7GZqjA7VN95Gwck+CW0GV+i50uR3fWfdGeg
         umBJl9s4Qt3/YWfjJ+vpB+A4GXGfVe87yA4uoYlJKBfrXkZlA/NmX+H7UyufVfgmbcqg
         l5EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z7rhD1WXk3L0TCFvw5pkhsK28oe7XUuV2gNiSIm6BKo=;
        b=6omnLgrTnn6y55G09SCEsZU+22ouVZPVRaYp871tunemdpTBwzpIF9H1QMpEKOOqCN
         QVqEa3COJSI9rsV7uxx57Z502HRVivHv6lRjJRDfJq2xJH6JJNgmVg7PXJyuWMDMseYH
         mux7caDzejASfL1nH/OoMKKbDhGgnOicvHrcdbnd0K6wDIKqF9KEbx/tVTr5cKy67j63
         HfHQlUk7it9IJV3Y8mhhk9t2KcORN3s6vxPsN+v4ESo+JclP39FG6KtDT1tVP/gNMj/k
         d+U57dN2SeAAn3jo7RSA1vGv7avnbM/WeISvRbFJcXYUHvdOnVy/T9PgswYPqzSurlqD
         kkkA==
X-Gm-Message-State: ACrzQf0ItWUYM4oadgfEfosCdmFtmk2sCJHxUnREssqYfnsSjNNcy1MG
        5MvHqDKI7usljuYky/YFV6E=
X-Google-Smtp-Source: AMsMyM57ZLgGMNp1ECg8RqK2wZI1OnoPsaCLo9cWpduwDaCGRUFMAe1lfAxwK9rEkTOVv6osgPuXOg==
X-Received: by 2002:a17:907:75c6:b0:79c:d3f4:4a14 with SMTP id jl6-20020a17090775c600b0079cd3f44a14mr5975122ejc.61.1666443429649;
        Sat, 22 Oct 2022 05:57:09 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-134.ip85.fastwebnet.it. [93.42.70.134])
        by smtp.googlemail.com with ESMTPSA id t29-20020a056402241d00b0045ce419ecffsm15173970eda.58.2022.10.22.05.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Oct 2022 05:57:09 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>,
        Thara Gopinath <thara.gopinath@linaro.org>
Subject: [PATCH v3 1/3] thermal: qcom: tsens: init debugfs only with successful probe
Date:   Sat, 22 Oct 2022 14:56:55 +0200
Message-Id: <20221022125657.22530-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221022125657.22530-1-ansuelsmth@gmail.com>
References: <20221022125657.22530-1-ansuelsmth@gmail.com>
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
 drivers/thermal/qcom/tsens.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index b1b10005fb28..af688ce4d14d 100644
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
@@ -1153,7 +1151,11 @@ static int tsens_probe(struct platform_device *pdev)
 		}
 	}
 
-	return tsens_register(priv);
+	ret = tsens_register(priv);
+	if (!ret)
+		tsens_debug_init(pdev);
+
+	return ret;
 }
 
 static int tsens_remove(struct platform_device *pdev)
-- 
2.37.2

