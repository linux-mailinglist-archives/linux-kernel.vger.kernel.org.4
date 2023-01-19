Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 246986741E9
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 20:01:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbjASTBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 14:01:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbjASTBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 14:01:09 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 378274860F;
        Thu, 19 Jan 2023 11:00:16 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id d2so2782776wrp.8;
        Thu, 19 Jan 2023 11:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uc0VKcDzax/1V9zWdQ/xXMfQihzfRsDYfybAXLoMhnU=;
        b=pZOniIzPd0rYf7ISX0XA4fdUqIOZ7OnVCMEi1TKIP1CXt9pLGGqpkAN6g+6xFQjG36
         iwqyhNYcV3UV25OkpZThL+oiLccJAOm7LKGYKLFMxU6BW8F3yVpWMMna4lDd0vajylSX
         /066czCarfllIb2I6mwUkq264s6vaN5XlPjt9sNxIy2ELGOI4l1r5/jaTBTG0ua0x0nY
         tgqIuLg3yQ/FXz7StKoOG7FDpLVK405nckq8P66vqKYqiJdJ5R8cKIOie5x0EGJILNw7
         dt1hP3bYXGildSWZdQB3Hwe6kg/ppSAUGR49ebrsC1OzQW7t5YDS1CVRV4yRy/wGJemV
         ax9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uc0VKcDzax/1V9zWdQ/xXMfQihzfRsDYfybAXLoMhnU=;
        b=WmgHHrEEV6MB9ua4zzGcB83uNsEFAt/7euMj4C6MU29p/iwE716uUtbane4QcpH/Dr
         RKwIsYEpjkas3ZObk5KPnCLeyvkgr4HeEUKzUzkjRxlLyZprNghhg9nAqFhyHHWhCI8b
         MMIbhiCmdLsogZIA/4KdmLVLzXiCXBdsme1X3RqDD/N8+Y8krPJ1HX7gg6KDJv0P6RLE
         wjtQCAUSuGsxBcI0uT/I/FasN897lk5IxaQLC4s6fbev1+RRnMpGBPRjAm0omWa54VG2
         RpCeTlXAW3hF8n76jrTZRWQZBr2ixJx8b8EsDDxvU0gDa7LWtAuyOzF4Qki5o9OnNqAm
         I2Tg==
X-Gm-Message-State: AFqh2krNU2a0sBcyZfE3I2dxVRNp/upgxS3/5o/MHkisjxe4CgBIjtLU
        FQ5gIl4kI+uXlVeuIy6rVprrT6oiNmQ=
X-Google-Smtp-Source: AMrXdXugqAr+O2rOkoHbQuMGjPp2zSNQMC/IGCog4S7SW5FW/h0Wohy9uDzpN/2I8WJSTg2held1AA==
X-Received: by 2002:a05:6000:1049:b0:242:15d6:1a75 with SMTP id c9-20020a056000104900b0024215d61a75mr9525290wrx.66.1674154793202;
        Thu, 19 Jan 2023 10:59:53 -0800 (PST)
Received: from localhost.localdomain ([37.55.203.63])
        by smtp.gmail.com with ESMTPSA id u14-20020adfdd4e000000b002366e3f1497sm34814488wrm.6.2023.01.19.10.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 10:59:52 -0800 (PST)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Markuss Broks <markuss.broks@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 1/3] arm: dts: exynos5420: Add a label to the DSI controller node
Date:   Thu, 19 Jan 2023 20:59:37 +0200
Message-Id: <20230119185940.156558-2-markuss.broks@gmail.com>
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

Add a label to the DSI controller node so board device-trees
could add subnodes.

Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
---
 arch/arm/boot/dts/exynos5420.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 9f2523a873d9..099bbdf76d83 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -597,7 +597,7 @@ mipi_phy: mipi-video-phy {
 			#phy-cells = <1>;
 		};
 
-		dsi@14500000 {
+		dsi: dsi@14500000 {
 			compatible = "samsung,exynos5410-mipi-dsi";
 			reg = <0x14500000 0x10000>;
 			interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.39.0

