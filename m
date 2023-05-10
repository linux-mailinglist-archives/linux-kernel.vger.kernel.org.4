Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFD2A6FD873
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 09:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236096AbjEJHoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 03:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236240AbjEJHoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 03:44:17 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5932722
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 00:44:16 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f41d087b24so29137665e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 00:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683704655; x=1686296655;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BtQPFlqDJgsJOhJjphtgO9KU3wqmiLaUjxsYgolmkNY=;
        b=QmFEIJOHl50deNQSptWiiSgu6+lK0ojb2twXb2fNfhePK6cEQ7kFaCNqJ1hdmbE7L2
         l0yYrDfBefzqo90kb1jTg+4kdBDIU/IU6+vqPQkDA5WD8luFJJNjEjMhPW9GxjN0xzmE
         gW5MiB+sgw1BtTI2qPK7Y2tKcu+897yB8NuQ8b+YhqnZ+QkNYnVVr5YZH7SuzbILaGyF
         IM8orS0BqOTDyk8uHW8DajyR92lsao4HNqlXNUAZV6VAyZ+G6z0t4t+cpqr3EIJNiVYC
         Lb2ov029rl3Pt0ZeLKYZ66po39iWUjfQOdbLa1k1QoRt8isQeO4P5XIrLXoW2hG18FkY
         UY9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683704655; x=1686296655;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BtQPFlqDJgsJOhJjphtgO9KU3wqmiLaUjxsYgolmkNY=;
        b=XAZqT2M2qWIiq4v19D+8/cYX5XyT90oTtSSpmDx2yOpYVcQ7oYqeian35ApZeWdOSD
         bKSTFH36AO5aC5F8De6cLrxybSQHCXUd9kMmTrWEvrK+S8DEWmc5ukaI0E+cQ2fXTnw6
         nIWbCSnaG87qqfWKlJIWBx3PSMESp4txsq5+BeHznUwdbLQ5El/eCp+LzL0a8Z8GI4Ss
         m8OVlpoBO5PwqSJZIUXu389/cuQ0vGBNu78mYcIGj/BCyPnYmXUuUrgcnnw0nFxIBVm6
         I1ZUiuYijcMnvmWbUr+XE0yi7TR5UDyXK477/XrVn2XHnKio/R7QZJGskSE26wzgLFJh
         8zXg==
X-Gm-Message-State: AC+VfDzUbcRG9InKrQMRuipa7ZLQqxYbhpG75k3Hycv4lxK2k+R4GPOD
        /g50KlatZjHSAEPU/Pn+etIzaA==
X-Google-Smtp-Source: ACHHUZ65q8nnPXwnXG297J3KAXm87os0LF1VqdeR3GC8I3QkknH+TG+s0Li9tmLG1xcRm5IYMYXh3g==
X-Received: by 2002:a7b:c40f:0:b0:3f4:2300:e015 with SMTP id k15-20020a7bc40f000000b003f42300e015mr7651495wmi.5.1683704654737;
        Wed, 10 May 2023 00:44:14 -0700 (PDT)
Received: from hackbox.lan ([86.121.163.20])
        by smtp.gmail.com with ESMTPSA id p5-20020a7bcc85000000b003f4dde07956sm261653wma.42.2023.05.10.00.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 00:44:14 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] soc: qcom: Rename ice to qcom-ice to avoid module name conflict
Date:   Wed, 10 May 2023 10:44:04 +0300
Message-Id: <20230510074404.3520340-1-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following error was reported when building x86_64 allmodconfig:

error: the following would cause module name conflict:
  drivers/soc/qcom/ice.ko
  drivers/net/ethernet/intel/ice/ice.ko

Seems the 'ice' module name is already used by some Intel ethernet
driver, so lets rename the Qualcomm Inline Crypto Engine (ICE) from
'ice' to 'qcom-ice' to avoid any kind of errors/confusions.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Fixes: 2afbf43a4aec ("soc: qcom: Make the Qualcomm UFS/SDCC ICE a dedicated driver")
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---

The build failure was reported here:
https://lore.kernel.org/all/20230510111833.17810885@canb.auug.org.au/

 drivers/soc/qcom/Makefile              | 2 +-
 drivers/soc/qcom/{ice.c => qcom-ice.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename drivers/soc/qcom/{ice.c => qcom-ice.c} (100%)

diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
index 0f43a88b4894..30219c164cb0 100644
--- a/drivers/soc/qcom/Makefile
+++ b/drivers/soc/qcom/Makefile
@@ -32,4 +32,4 @@ obj-$(CONFIG_QCOM_RPMHPD) += rpmhpd.o
 obj-$(CONFIG_QCOM_RPMPD) += rpmpd.o
 obj-$(CONFIG_QCOM_KRYO_L2_ACCESSORS) +=	kryo-l2-accessors.o
 obj-$(CONFIG_QCOM_ICC_BWMON)	+= icc-bwmon.o
-obj-$(CONFIG_QCOM_INLINE_CRYPTO_ENGINE)	+= ice.o
+obj-$(CONFIG_QCOM_INLINE_CRYPTO_ENGINE)	+= qcom-ice.o
diff --git a/drivers/soc/qcom/ice.c b/drivers/soc/qcom/qcom-ice.c
similarity index 100%
rename from drivers/soc/qcom/ice.c
rename to drivers/soc/qcom/qcom-ice.c
-- 
2.34.1

