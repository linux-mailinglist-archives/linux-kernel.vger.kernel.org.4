Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC4E62C902
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 20:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234523AbiKPTbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 14:31:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234142AbiKPTbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 14:31:35 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01FDC63167;
        Wed, 16 Nov 2022 11:31:35 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id y16so31603737wrt.12;
        Wed, 16 Nov 2022 11:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J3cqBPNXFCPM9SPqErLl5EqPv8TqD4kJvo+8/hC/Kvc=;
        b=Ynri9fVx0vI5Lf+znhqrG0iR+yweHI2N2z+TchOnPi+rYb8P2px3K77Xwh0/l1DADz
         KnPlh+H+WqbGCSbGTQOaAM0hHFm3NN7CYcdx4NBKIKTZHT7dgzf0/CiT017fApLyqagX
         gSEc39/+sS4RNlMwyuT2FYFgDEeCdD34P5Ff7zITXMaWTAzRIScMQVPMMCdYyBmDRhfK
         ELlX74FnK45uhYSQqVkku4MPhiKvQLCkOmomsik0I4Wg1z9jZgRlg7w1QzQY03geTJUU
         P+YXXL88pUeGLQXOgQ//mrclw0YqMHJ95ytcAnxGYq8l9Js7K7rTQgof4vOwy2KOdUkk
         XeDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J3cqBPNXFCPM9SPqErLl5EqPv8TqD4kJvo+8/hC/Kvc=;
        b=b4OO427T6rZ1yXOeOUyfSh1zwaxLPIrCATAoXhcdafFeCHTiVpC9knYBNBiLy3wq0V
         DfGuGYGS0Kf+/e4DMNMtXHZpSoFrngklyzU5f/955ETk0WSQwDg5+ly8IbJnu53ladYg
         0HYDPh4bT7b2LjB+0Ak4dus5tJt+OMADAkvQb7GitnQpwpL+1KxY0fYY7gUtsVCV6jhc
         DYjTZ5imZ2i8TF5uaCBwM9a42WjidUxose7I4FkDjV0KdWNpeJ+z9upX704rimcgTAw6
         gVEPDhQM/WYUJEGdzii79ZdhUAwZ62x5tDnmKsJKQQWFIHa07WfnQ7R04w06AKfC8hOP
         it3g==
X-Gm-Message-State: ANoB5pk14QaqAmWg+c7HCdpMLOQeN8pUR46/hO28JwFq+AI9hQjptCsE
        gpInxu8LXsChsgSLirE54jM=
X-Google-Smtp-Source: AA0mqf63+xcPwKEqO/zJar4BIbUp0DRdWtaKQPwkXJ8MVR2/sFn3Mdf7EVbj3yozb2stn+TxPMySpA==
X-Received: by 2002:a5d:63c6:0:b0:235:e6a9:b492 with SMTP id c6-20020a5d63c6000000b00235e6a9b492mr15033159wrw.212.1668627093629;
        Wed, 16 Nov 2022 11:31:33 -0800 (PST)
Received: from kista.localdomain (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id q125-20020a1c4383000000b003c6cd82596esm3044646wma.43.2022.11.16.11.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 11:31:33 -0800 (PST)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org,
        samuel@sholland.org
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 2/2] arm64: dts: allwinner: h6: Fix Cedrus IOMMU channels
Date:   Wed, 16 Nov 2022 20:31:05 +0100
Message-Id: <20221116193105.363297-3-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221116193105.363297-1-jernej.skrabec@gmail.com>
References: <20221116193105.363297-1-jernej.skrabec@gmail.com>
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

Cedrus H6 actually uses two IOMMU channels. During development page
faults from both were observed. Documentation also lists both of them
to be connected to Cedrus, but it doesn't make clear which is used for
what.

Add second IOMMU channel.

Fixes: 62a8ccf3a248 ("arm64: dts: allwinner: h6: Fix Cedrus IOMMU usage")
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index 53f6660656ac..7bff054a9bdf 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -172,7 +172,7 @@ video-codec@1c0e000 {
 			resets = <&ccu RST_BUS_VE>;
 			interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
 			allwinner,sram = <&ve_sram 1>;
-			iommus = <&iommu 3>;
+			iommus = <&iommu 1>, <&iommu 3>;
 		};
 
 		gpu: gpu@1800000 {
-- 
2.38.1

