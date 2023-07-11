Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A39374F1C8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 16:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233405AbjGKOV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 10:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232554AbjGKOVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 10:21:42 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 632C7170C
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 07:21:19 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4fba03becc6so8580293e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 07:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689085277; x=1691677277;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vHN7ug9Ao7x7+1HgDfpamR8MTCtlAVz1z00Xw4truvc=;
        b=pmG3kvdq6Vc57gAiyWxPiStsAnk15BmtQpGuSGEnwf1AkEyZ6KeBp/K+dL/LqkqGBh
         L+DrzByAjWN1mLEfOza54IoOjJKFhLXIjWvt9FQWZjN46h20TTqWucA3PVOFbd+/BWnn
         yonPUqEOAR9AaYQpQdTB12cIDBDDyCUfu3YhNhUXODYgXZpt0dTlMQbjli95/6ukVSnN
         u7JCgEU5QEl3vrtyFhVkSBAHVpv1PomuIrODfxE92EqINacO6AqzwGsUlyJxyeewOHdL
         GuA7DTweK0NJagkFB8/bPT9+LjiqSD7wZ1083zRBMczAzyhUziAZQ5Qug7zqtDYdvsHE
         QfPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689085277; x=1691677277;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vHN7ug9Ao7x7+1HgDfpamR8MTCtlAVz1z00Xw4truvc=;
        b=mCrY569/g6VzKEThIORRtOcB+vwCVIcwfvAsuE0lYSF63vfJ7+C1JWoSeMife1jg5t
         wukJlSRawZtZsZh82mXmq1Q6bbUwe39yxC1P9czsxu/lyqpthbGYUTj6Sr16L4Oh+z38
         y19Ll/blH1wQId7gOvvl54nvNzEvAAmE1iNq8BrOVCAKeqLD3dI4V5Skpf8tu6t9mLlZ
         Z1OUCTlylOWPvomsZuwoPd0NsswpWrXhWnKClcM9echnTAiWZGt9zOVhN9F6imc7x2kg
         2/FMm9aS232jU+UNE4yBFgFB9DgUDQjIByN7mZyyPKbmVLMQwkA8Pu+6cvY5LAIRfrpv
         8yJA==
X-Gm-Message-State: ABy/qLa3GtUwkzZAdNOW6Tfwms5AuQo+I5Ij6iz8KBDFgw7Rqg3+gZQC
        KhxsES8P6y8P7XevpFF74ssTSw==
X-Google-Smtp-Source: APBJJlGYSBKKsdG06w+GRMIvM7rSjoOIl+KaJPWq8gRKjWkorAUqN+nzTUm99cSoxgUhcYatXqLidw==
X-Received: by 2002:a05:6512:3c92:b0:4fb:7d09:ec75 with SMTP id h18-20020a0565123c9200b004fb7d09ec75mr7362048lfv.4.1689085277269;
        Tue, 11 Jul 2023 07:21:17 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id b17-20020a056512025100b004f8592a5180sm339779lfo.17.2023.07.11.07.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 07:21:16 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 07/18] soc: mediatek: Move power-domain drivers to the genpd dir
Date:   Tue, 11 Jul 2023 16:21:14 +0200
Message-Id: <20230711142114.751632-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To simplify with maintenance let's move the mediatek power-domain drivers
to the new genpd directory. Going forward, patches are intended to be
managed through a separate git tree, according to MAINTAINERS.

Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: <linux-mediatek@lists.infradead.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/genpd/Makefile                              | 1 +
 drivers/genpd/mediatek/Makefile                     | 3 +++
 drivers/{soc => genpd}/mediatek/mt6795-pm-domains.h | 0
 drivers/{soc => genpd}/mediatek/mt8167-pm-domains.h | 0
 drivers/{soc => genpd}/mediatek/mt8173-pm-domains.h | 0
 drivers/{soc => genpd}/mediatek/mt8183-pm-domains.h | 0
 drivers/{soc => genpd}/mediatek/mt8186-pm-domains.h | 0
 drivers/{soc => genpd}/mediatek/mt8188-pm-domains.h | 0
 drivers/{soc => genpd}/mediatek/mt8192-pm-domains.h | 0
 drivers/{soc => genpd}/mediatek/mt8195-pm-domains.h | 0
 drivers/{soc => genpd}/mediatek/mtk-pm-domains.c    | 0
 drivers/{soc => genpd}/mediatek/mtk-pm-domains.h    | 0
 drivers/{soc => genpd}/mediatek/mtk-scpsys.c        | 0
 drivers/soc/mediatek/Makefile                       | 2 --
 14 files changed, 4 insertions(+), 2 deletions(-)
 create mode 100644 drivers/genpd/mediatek/Makefile
 rename drivers/{soc => genpd}/mediatek/mt6795-pm-domains.h (100%)
 rename drivers/{soc => genpd}/mediatek/mt8167-pm-domains.h (100%)
 rename drivers/{soc => genpd}/mediatek/mt8173-pm-domains.h (100%)
 rename drivers/{soc => genpd}/mediatek/mt8183-pm-domains.h (100%)
 rename drivers/{soc => genpd}/mediatek/mt8186-pm-domains.h (100%)
 rename drivers/{soc => genpd}/mediatek/mt8188-pm-domains.h (100%)
 rename drivers/{soc => genpd}/mediatek/mt8192-pm-domains.h (100%)
 rename drivers/{soc => genpd}/mediatek/mt8195-pm-domains.h (100%)
 rename drivers/{soc => genpd}/mediatek/mtk-pm-domains.c (100%)
 rename drivers/{soc => genpd}/mediatek/mtk-pm-domains.h (100%)
 rename drivers/{soc => genpd}/mediatek/mtk-scpsys.c (100%)

diff --git a/drivers/genpd/Makefile b/drivers/genpd/Makefile
index 6b9e9fe907f3..1a0a56925756 100644
--- a/drivers/genpd/Makefile
+++ b/drivers/genpd/Makefile
@@ -3,3 +3,4 @@ obj-y					+= actions/
 obj-y					+= amlogic/
 obj-y					+= apple/
 obj-y					+= bcm/
+obj-y					+= mediatek/
diff --git a/drivers/genpd/mediatek/Makefile b/drivers/genpd/mediatek/Makefile
new file mode 100644
index 000000000000..8cde09e654b3
--- /dev/null
+++ b/drivers/genpd/mediatek/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_MTK_SCPSYS)		+= mtk-scpsys.o
+obj-$(CONFIG_MTK_SCPSYS_PM_DOMAINS) 	+= mtk-pm-domains.o
diff --git a/drivers/soc/mediatek/mt6795-pm-domains.h b/drivers/genpd/mediatek/mt6795-pm-domains.h
similarity index 100%
rename from drivers/soc/mediatek/mt6795-pm-domains.h
rename to drivers/genpd/mediatek/mt6795-pm-domains.h
diff --git a/drivers/soc/mediatek/mt8167-pm-domains.h b/drivers/genpd/mediatek/mt8167-pm-domains.h
similarity index 100%
rename from drivers/soc/mediatek/mt8167-pm-domains.h
rename to drivers/genpd/mediatek/mt8167-pm-domains.h
diff --git a/drivers/soc/mediatek/mt8173-pm-domains.h b/drivers/genpd/mediatek/mt8173-pm-domains.h
similarity index 100%
rename from drivers/soc/mediatek/mt8173-pm-domains.h
rename to drivers/genpd/mediatek/mt8173-pm-domains.h
diff --git a/drivers/soc/mediatek/mt8183-pm-domains.h b/drivers/genpd/mediatek/mt8183-pm-domains.h
similarity index 100%
rename from drivers/soc/mediatek/mt8183-pm-domains.h
rename to drivers/genpd/mediatek/mt8183-pm-domains.h
diff --git a/drivers/soc/mediatek/mt8186-pm-domains.h b/drivers/genpd/mediatek/mt8186-pm-domains.h
similarity index 100%
rename from drivers/soc/mediatek/mt8186-pm-domains.h
rename to drivers/genpd/mediatek/mt8186-pm-domains.h
diff --git a/drivers/soc/mediatek/mt8188-pm-domains.h b/drivers/genpd/mediatek/mt8188-pm-domains.h
similarity index 100%
rename from drivers/soc/mediatek/mt8188-pm-domains.h
rename to drivers/genpd/mediatek/mt8188-pm-domains.h
diff --git a/drivers/soc/mediatek/mt8192-pm-domains.h b/drivers/genpd/mediatek/mt8192-pm-domains.h
similarity index 100%
rename from drivers/soc/mediatek/mt8192-pm-domains.h
rename to drivers/genpd/mediatek/mt8192-pm-domains.h
diff --git a/drivers/soc/mediatek/mt8195-pm-domains.h b/drivers/genpd/mediatek/mt8195-pm-domains.h
similarity index 100%
rename from drivers/soc/mediatek/mt8195-pm-domains.h
rename to drivers/genpd/mediatek/mt8195-pm-domains.h
diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/genpd/mediatek/mtk-pm-domains.c
similarity index 100%
rename from drivers/soc/mediatek/mtk-pm-domains.c
rename to drivers/genpd/mediatek/mtk-pm-domains.c
diff --git a/drivers/soc/mediatek/mtk-pm-domains.h b/drivers/genpd/mediatek/mtk-pm-domains.h
similarity index 100%
rename from drivers/soc/mediatek/mtk-pm-domains.h
rename to drivers/genpd/mediatek/mtk-pm-domains.h
diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/genpd/mediatek/mtk-scpsys.c
similarity index 100%
rename from drivers/soc/mediatek/mtk-scpsys.c
rename to drivers/genpd/mediatek/mtk-scpsys.c
diff --git a/drivers/soc/mediatek/Makefile b/drivers/soc/mediatek/Makefile
index 8c0ddacbcde8..9d3ce7878c5c 100644
--- a/drivers/soc/mediatek/Makefile
+++ b/drivers/soc/mediatek/Makefile
@@ -4,8 +4,6 @@ obj-$(CONFIG_MTK_DEVAPC) += mtk-devapc.o
 obj-$(CONFIG_MTK_INFRACFG) += mtk-infracfg.o
 obj-$(CONFIG_MTK_PMIC_WRAP) += mtk-pmic-wrap.o
 obj-$(CONFIG_MTK_REGULATOR_COUPLER) += mtk-regulator-coupler.o
-obj-$(CONFIG_MTK_SCPSYS) += mtk-scpsys.o
-obj-$(CONFIG_MTK_SCPSYS_PM_DOMAINS) += mtk-pm-domains.o
 obj-$(CONFIG_MTK_MMSYS) += mtk-mmsys.o
 obj-$(CONFIG_MTK_MMSYS) += mtk-mutex.o
 obj-$(CONFIG_MTK_SVS) += mtk-svs.o
-- 
2.34.1

