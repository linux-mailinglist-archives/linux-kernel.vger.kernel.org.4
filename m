Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35FC274F1D3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 16:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232556AbjGKOWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 10:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232428AbjGKOVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 10:21:53 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23821BCF
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 07:21:29 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4fb7769f15aso9308371e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 07:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689085287; x=1691677287;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kmUPzGEd9b2mcw9T8mFnw1Yxkb2+JnWrNijHr7xIcuI=;
        b=StVO58mC4uRlLbQia8BsbrUTAPZ9qwbkvIkGshFkyeiLlWSDJxOglfC/y3mPwBxYZl
         U+/sy3Uon0nHALLekkVWAiNrHDytJKpDz0QUkgCTdmvkQgyJ9uWk0GbRCasVPBjn5sbB
         TdVyPB0MEI0iWM4Pp7fM/m2f81LnzzocyErpQRo8/9kvmpVCa0rXh2NJiv1yDF+TSIjG
         WL/Fswe3GTIZPKWlbB9PZZzqcqWpXs6Jrpkfk1ZaTlm5BzM85peRsuS4PO/XiMjYMxRC
         BxqxWPIS2FlzLMNRcjBEQN86dbolLmckdG3X11GFp34EoXyQeCnylJpD93Dxt715NdVQ
         UFVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689085287; x=1691677287;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kmUPzGEd9b2mcw9T8mFnw1Yxkb2+JnWrNijHr7xIcuI=;
        b=lNGbMfKADijrLtxgel2+sP4N8wGePWfphnJ+EnAmeNO0qfYIc0oNfzAzuozc4M45cj
         3zBrTAcCECWUXzH+XCGrdG29siQsOT3jmFBM6FALzOK5Ofg/+FEmkZez3uTCzDSV2VOL
         VxgmL5p22vKzYckqZrWkiqLH8B2cXkFrmucpBhgM/SYufhy4mnjPD88QovY2bc+p5y6E
         7xkSj2+V1y5CnbBA2Wi9nF+a0pNeIC6LukjZm44mqwq1pKSCovhmPiKU5a1SvVCY8yUI
         wJp7tK4qrrv68+9khPhrI3PTJklS7QKmgrD88MQh9wnsg4cs61pgfB3z2N1NDhoGnwEf
         blHA==
X-Gm-Message-State: ABy/qLYFqsuyTrmnnDDoBQBYUVtHw6obdDUytxYWxiX97DxxxDo/rKvK
        NxRKQOlBs59ipYHJ0epu2t2/6LAXBaNaNB7vANM=
X-Google-Smtp-Source: APBJJlGGd0BJTHp96g3V9AE1cOKMZOPmEz3SSo5nfPuTaPLXgh5DNMltDB/etEPzUkQiIafUXhOV3w==
X-Received: by 2002:ac2:51bb:0:b0:4fb:90c6:c31a with SMTP id f27-20020ac251bb000000b004fb90c6c31amr11259667lfk.14.1689085287277;
        Tue, 11 Jul 2023 07:21:27 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id x7-20020ac259c7000000b004f84b36a24fsm340318lfn.51.2023.07.11.07.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 07:21:26 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 08/18] soc: qcom: Move power-domain drivers to the genpd dir
Date:   Tue, 11 Jul 2023 16:21:24 +0200
Message-Id: <20230711142124.751652-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To simplify with maintenance let's move the qcom power-domain drivers to
the new genpd directory. Going forward, patches are intended to be managed
through a separate git tree, according to MAINTAINERS.

Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Andy Gross <agross@kernel.org>
Cc: <linux-arm-msm@vger.kernel.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 MAINTAINERS                          | 2 +-
 drivers/genpd/Makefile               | 1 +
 drivers/genpd/qcom/Makefile          | 4 ++++
 drivers/{soc => genpd}/qcom/cpr.c    | 0
 drivers/{soc => genpd}/qcom/rpmhpd.c | 0
 drivers/{soc => genpd}/qcom/rpmpd.c  | 0
 drivers/soc/qcom/Makefile            | 3 ---
 7 files changed, 6 insertions(+), 4 deletions(-)
 create mode 100644 drivers/genpd/qcom/Makefile
 rename drivers/{soc => genpd}/qcom/cpr.c (100%)
 rename drivers/{soc => genpd}/qcom/rpmhpd.c (100%)
 rename drivers/{soc => genpd}/qcom/rpmpd.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 77629ab4a5f0..9abd868abfc8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17524,7 +17524,7 @@ L:	linux-pm@vger.kernel.org
 L:	linux-arm-msm@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/power/avs/qcom,cpr.yaml
-F:	drivers/soc/qcom/cpr.c
+F:	drivers/genpd/qcom/cpr.c
 
 QUALCOMM CPUFREQ DRIVER MSM8996/APQ8096
 M:	Ilia Lin <ilia.lin@kernel.org>
diff --git a/drivers/genpd/Makefile b/drivers/genpd/Makefile
index 1a0a56925756..dfdea14e2a8a 100644
--- a/drivers/genpd/Makefile
+++ b/drivers/genpd/Makefile
@@ -4,3 +4,4 @@ obj-y					+= amlogic/
 obj-y					+= apple/
 obj-y					+= bcm/
 obj-y					+= mediatek/
+obj-y					+= qcom/
diff --git a/drivers/genpd/qcom/Makefile b/drivers/genpd/qcom/Makefile
new file mode 100644
index 000000000000..403dfc5af095
--- /dev/null
+++ b/drivers/genpd/qcom/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_QCOM_CPR)		+= cpr.o
+obj-$(CONFIG_QCOM_RPMPD)	+= rpmpd.o
+obj-$(CONFIG_QCOM_RPMHPD)	+= rpmhpd.o
diff --git a/drivers/soc/qcom/cpr.c b/drivers/genpd/qcom/cpr.c
similarity index 100%
rename from drivers/soc/qcom/cpr.c
rename to drivers/genpd/qcom/cpr.c
diff --git a/drivers/soc/qcom/rpmhpd.c b/drivers/genpd/qcom/rpmhpd.c
similarity index 100%
rename from drivers/soc/qcom/rpmhpd.c
rename to drivers/genpd/qcom/rpmhpd.c
diff --git a/drivers/soc/qcom/rpmpd.c b/drivers/genpd/qcom/rpmpd.c
similarity index 100%
rename from drivers/soc/qcom/rpmpd.c
rename to drivers/genpd/qcom/rpmpd.c
diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
index 99114c71092b..f548a7150bb2 100644
--- a/drivers/soc/qcom/Makefile
+++ b/drivers/soc/qcom/Makefile
@@ -3,7 +3,6 @@ CFLAGS_rpmh-rsc.o := -I$(src)
 obj-$(CONFIG_QCOM_AOSS_QMP) +=	qcom_aoss.o
 obj-$(CONFIG_QCOM_GENI_SE) +=	qcom-geni-se.o
 obj-$(CONFIG_QCOM_COMMAND_DB) += cmd-db.o
-obj-$(CONFIG_QCOM_CPR)		+= cpr.o
 obj-$(CONFIG_QCOM_GSBI)	+=	qcom_gsbi.o
 obj-$(CONFIG_QCOM_MDT_LOADER)	+= mdt_loader.o
 obj-$(CONFIG_QCOM_OCMEM)	+= ocmem.o
@@ -29,8 +28,6 @@ obj-$(CONFIG_QCOM_STATS)	+= qcom_stats.o
 obj-$(CONFIG_QCOM_WCNSS_CTRL) += wcnss_ctrl.o
 obj-$(CONFIG_QCOM_APR) += apr.o
 obj-$(CONFIG_QCOM_LLCC) += llcc-qcom.o
-obj-$(CONFIG_QCOM_RPMHPD) += rpmhpd.o
-obj-$(CONFIG_QCOM_RPMPD) += rpmpd.o
 obj-$(CONFIG_QCOM_KRYO_L2_ACCESSORS) +=	kryo-l2-accessors.o
 obj-$(CONFIG_QCOM_ICC_BWMON)	+= icc-bwmon.o
 qcom_ice-objs			+= ice.o
-- 
2.34.1

