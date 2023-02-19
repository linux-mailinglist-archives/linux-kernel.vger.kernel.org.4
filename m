Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7225A69C027
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 13:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbjBSMO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 07:14:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjBSMOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 07:14:25 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDA2EB48
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 04:14:23 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id ee44so6084187edb.5
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 04:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Kxkd4//RPVCLi8yyo6/EUcCuKUtpxv+tcfETfHyl5Tc=;
        b=lUok8y13crnWg4US+/zCJWSqvwNztFNLO1MlPW38197fQcQreVFrBPBu8FJUezl6Hv
         m+HIOHBk6nxMxIgWg1ppEupLpLm+h7NZ3f5NFHE9sGroD3/kMjKy7SgmBRrzjA56cRrS
         U0djfU529pZtnXUIQTJWQhhYrA8XzrinQOnym7r71Y/ymSJPwW+U0TVmCQt5fO0slzvW
         qlIwEeB6dd1NYUOMEL6ri3ZmjAUdBBXJzmiQhBaK8BZoF5JbBtzeZ5tLuWDzeVCz7lwY
         fBd5s7fth3T/llOnsKpAfCABEEtc6WAw89MISQqhJaDM88lB5YlLFb3MOcUKMOEr3vDq
         QfgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kxkd4//RPVCLi8yyo6/EUcCuKUtpxv+tcfETfHyl5Tc=;
        b=yjJR8x6x7OvwgFtslVqngUiXQw3hBOXczOTA+K5t5YO2dA0Cg+CxFQlp12n1iiyPk0
         NX6fX5Ret9rESyukd3kKrsdN+korrlp1DFaBHC9PuRSUkIyn8mTstVKgCqzKTUn9eoTM
         JmNU53Zq1eWqfGz7f0wjpIFyWzwRtXl3CBgkcMUg57A+8E1X1QPQ6QpJQBQG6lwaItjZ
         lGLjDue/HjerD6yaqF9m5QGC+pUlmb9RKcjTONfbXH4ACAf2ZPCcE9Pj6EdEDygXknVh
         LURElUICyEG8Fk5FGjDVRpPnzAWmBajh+r/bWiHVbIilb0Gqleq4u7LGDrEVFJj2LZ2S
         JiMQ==
X-Gm-Message-State: AO0yUKUoeHoDGQRRm97Uw+wFW0i1JAOC6dw0uDuEsmMmMY7+wUeMENSa
        FNINRyGVvSF2YCvFpmWWKTAXDA==
X-Google-Smtp-Source: AK7set8r5En8t5kF8sy7TbBdXbnkn1cZFKrZZ5kevtvqC79aBGhRDkAOpGtHI8rCze/MLFNk5AXWKw==
X-Received: by 2002:a17:906:2a59:b0:8b1:392f:f847 with SMTP id k25-20020a1709062a5900b008b1392ff847mr7570520eje.25.1676808862175;
        Sun, 19 Feb 2023 04:14:22 -0800 (PST)
Received: from fedora.. (cpezg-94-253-130-228-cbl.xnet.hr. [94.253.130.228])
        by smtp.googlemail.com with ESMTPSA id qx3-20020a170906fcc300b008b13a1c3322sm4469538ejb.149.2023.02.19.04.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Feb 2023 04:14:21 -0800 (PST)
From:   Robert Marko <robert.marko@sartura.hr>
To:     andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH] arm64: dts: marvell: mochabin: enlarge PCI memory window
Date:   Sun, 19 Feb 2023 13:14:18 +0100
Message-Id: <20230219121418.1395401-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.39.2
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

Armada 7040 uses a rather small 15MB memory window for every PCI adapter,
however this is not sufficient for Qualcomm QCA6390 802.11ax cards that
are shipped along with the OpenWrt WLAN model of MOCHAbin as ath11k
requires at least 16MB of memory.

So, similar to what MACCHIATOBin has been doing for years, lets move
to using the second PCIe 2 memory window and expand it to 128MB to
make it future proof.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 arch/arm64/boot/dts/marvell/armada-7040-mochabin.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-7040-mochabin.dts b/arch/arm64/boot/dts/marvell/armada-7040-mochabin.dts
index 7ca71f2d7afb..39ce6e25a8ef 100644
--- a/arch/arm64/boot/dts/marvell/armada-7040-mochabin.dts
+++ b/arch/arm64/boot/dts/marvell/armada-7040-mochabin.dts
@@ -455,4 +455,5 @@ &cp0_pcie2 {
 	phys = <&cp0_comphy5 2>;
 	phy-names = "cp0-pcie2-x1-phy";
 	reset-gpios = <&cp0_gpio1 9 GPIO_ACTIVE_LOW>;
+	ranges = <0x82000000 0x0 0xc0000000 0x0 0xc0000000 0x0 0x8000000>;
 };
-- 
2.39.2

