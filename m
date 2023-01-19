Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BABE6741EB
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 20:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbjASTBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 14:01:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbjASTBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 14:01:12 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3FCD95199;
        Thu, 19 Jan 2023 11:00:16 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id t5so2815255wrq.1;
        Thu, 19 Jan 2023 11:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j6fyI86S1dFLIo7pjwIsRVc2Biw6w/Fz3+/A/hEEC7A=;
        b=jA5jAD6PAJPb4+4YJd6bs97KlMwrVPBr9W5+fQiVjdR5o2FQPQu5PEAR8RdFenWVg2
         EdBRvpxgs4kEHL++HLgfdSEa699p6KD/hSpenLjWGRWvKyt2qMh5I0PRC9j4YTOpuitB
         1BcTrqSiiyZqSCcVmymLRW5IQxFi9hkrCnKwV43cWfMWlNE8ikobC1A3YbMKitKjlMMR
         nbESkAqD7TboYQEv3VbMnAwgDe2ge9ZuYr1KrPycAxFQ5kh29didxn/0GcJF5tAdM5Db
         vLuR5zTflHL1UG5a/Vrs0EivuMMb7hzVN9IXiWBUzq2T7w2go6V6O7ZLFzZf0DH2c7Bn
         utCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j6fyI86S1dFLIo7pjwIsRVc2Biw6w/Fz3+/A/hEEC7A=;
        b=SCjm5HeMCP6sMYnG0z3i99DIj53RjMTbRd9rxstv+B8LXqo2nz8EvvwjgNdIoece+s
         G/PIMiCjDJdcdFZFJoMa2uJ5pTPR6mEv0p/iGouPEPvVlbykeALd8OS9syevrNBcpySb
         ZvKy7a82lBUHPYKjwxj08Hor/OixKHdJqh+N8EyuAwdvVfGY5macbHjR2a5pv838mK/l
         QV+Wd6n+XY//0QtnViN0NjUSbfMfJnNylgzmAni3a2NV6W2RZXYYPNJTitEpyiIPAo18
         mvHZ+C/hoq3dCSh2kDEXsNeP75mRdeIX9q2EehTDlyPCFF2Ck35Rn0SC/40myhRNNk9E
         9BrA==
X-Gm-Message-State: AFqh2kpH53m2/l9Ovgz02PI7L2CYacXE9mBNkV50TOx7dIEk0wnW2NNN
        sksxucqLu81rDqQc0V+G+giFFeqejsE=
X-Google-Smtp-Source: AMrXdXv+IeANuk4ZJ7v+Tcm6NHj1XhSHvng9UHgrJwy6eMqbkaNUdGIjWnM0S2jIeOSl/2CeY73z9Q==
X-Received: by 2002:adf:e30c:0:b0:2be:1fae:690e with SMTP id b12-20020adfe30c000000b002be1fae690emr10439357wrj.50.1674154794970;
        Thu, 19 Jan 2023 10:59:54 -0800 (PST)
Received: from localhost.localdomain ([37.55.203.63])
        by smtp.gmail.com with ESMTPSA id u14-20020adfdd4e000000b002366e3f1497sm34814488wrm.6.2023.01.19.10.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 10:59:54 -0800 (PST)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Markuss Broks <markuss.broks@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 2/3] arm: dts: exynos5420: Use Exynos5420 compatible for the MIPI video phy
Date:   Thu, 19 Jan 2023 20:59:38 +0200
Message-Id: <20230119185940.156558-3-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230119185940.156558-1-markuss.broks@gmail.com>
References: <20230119185940.156558-1-markuss.broks@gmail.com>
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

For some reason, the driver adding support for Exynos5420 MIPI phy
back in 2016 wasn't used on Exynos5420, which caused a kernel panic.
Add the proper compatible for it.

Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
---
 arch/arm/boot/dts/exynos5420.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 099bbdf76d83..b612468515eb 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -592,7 +592,7 @@ dp_phy: dp-video-phy {
 		};
 
 		mipi_phy: mipi-video-phy {
-			compatible = "samsung,s5pv210-mipi-video-phy";
+			compatible = "samsung,exynos5420-mipi-video-phy";
 			syscon = <&pmu_system_controller>;
 			#phy-cells = <1>;
 		};
-- 
2.39.0

