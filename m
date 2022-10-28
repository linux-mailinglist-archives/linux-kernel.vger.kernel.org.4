Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4B59611BF0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 22:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiJ1U4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 16:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbiJ1U4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 16:56:04 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF8B2413D7;
        Fri, 28 Oct 2022 13:56:02 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E34E06602944;
        Fri, 28 Oct 2022 21:55:59 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666990561;
        bh=qWdkIlb4uY0ldwod8O1L1+MBmgoTBnCHuEAzyFzvduk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CatTo8ntRCB35RCQqr7MIKSSx49eqvxGewJ+wINf+RK1+ORKjUX9Jor0ULSHiw3du
         078Gf8xZKL8H2a42ftkNkxwapfbRuBgz+naGO1Fqj/+yejaSKFbODdUlgyLK6/bBuM
         QnVAmZ6WZdyzTi3RgW1t15Idv734HsfKlIJy8uT11CaKLrVyTN3baPzMTWjvyffsFA
         f75fckeGkna97+EeEwgZKv7ftpnpRDVf26MS00Tj+vfRT0a4jZ4gvlINr8bl0aAA0I
         GJW8AoaH3p+WmY6SO5gqw5a+bRjwTKrThJaewc40QRwSUNPov0GUEfj1wyA6VsMBcq
         x/Xfbo/bpB24Q==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Mark Brown <broonie@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] arm64: dts: qcom: sc7180-trogdor: Add missing supplies for rt5682
Date:   Fri, 28 Oct 2022 16:55:39 -0400
Message-Id: <20221028205540.3197304-8-nfraprado@collabora.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221028205540.3197304-1-nfraprado@collabora.com>
References: <20221028205540.3197304-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dbvdd and ldo1-in supplies for rt5682 are required but are missing.
They are supplied by the same power rail as AVDD. Add them.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---

 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
index 1a1c346d619c..1df507ffb267 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
@@ -768,6 +768,8 @@ alc5682: codec@1a {
 		interrupts = <28 IRQ_TYPE_EDGE_BOTH>;
 
 		AVDD-supply = <&pp1800_alc5682>;
+		dbvdd-supply = <&pp1800_alc5682>;
+		ldo1-in-supply = <&pp1800_alc5682>;
 		MICVDD-supply = <&pp3300_codec>;
 		VBAT-supply = <&pp3300_audio>;
 
-- 
2.38.1

