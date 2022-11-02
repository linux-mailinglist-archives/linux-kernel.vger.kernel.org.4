Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97941616BF5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 19:20:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbiKBSUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 14:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbiKBSUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 14:20:22 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C801B2F39D;
        Wed,  2 Nov 2022 11:20:20 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (unknown [IPv6:2600:4041:5b1a:cd00:524d:e95d:1a9c:492a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4A87C66028C5;
        Wed,  2 Nov 2022 18:20:18 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667413219;
        bh=Y/oGfF2ZKbAfSuy9UNRSZc4k47fY8VQOpolmGqIEoTI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ataL7fEpHIx9UT+p1PoG0b8SvfuivGEoZFd9lfIONLl+K7lT0D5NlMPzrmJfneVnj
         qt3AGL2wbHVYDvZUoEF691Cue4hiO8rvqxAauJu/vYrdimN8i4uF22fvW4NrBoi8tS
         0pYRq/fk1iEMqPbqORY+6GddiE6gqarBd2QFzDTfOepbbfB0EedeBt6sCiawM/hfEW
         cfwy9FZym/2BdlL2nxxuCnFqMVEWl4I6B4eXCClbkjzc+DDxB2Dab7rM2bZ+OZufpp
         1wJfvYc/oT46wZ9SnfR9YWcFfsD8aa3Pvad7DrgO4MWH43LYO5BEpqCEUH5QTl1+CY
         GAgEppe5uNfew==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Mark Brown <broonie@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/8] arm64: dts: qcom: sc7180-trogdor: Add missing supplies for rt5682
Date:   Wed,  2 Nov 2022 14:20:01 -0400
Message-Id: <20221102182002.255282-8-nfraprado@collabora.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221102182002.255282-1-nfraprado@collabora.com>
References: <20221102182002.255282-1-nfraprado@collabora.com>
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

The DBVDD and LDO1-IN supplies for rt5682 are required but are missing.
They are supplied by the same power rail as AVDD. Add them.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---

Changes in v2:
- Made names uppercase

 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
index 1a1c346d619c..2adb2fbfebae 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
@@ -768,6 +768,8 @@ alc5682: codec@1a {
 		interrupts = <28 IRQ_TYPE_EDGE_BOTH>;
 
 		AVDD-supply = <&pp1800_alc5682>;
+		DBVDD-supply = <&pp1800_alc5682>;
+		LDO1-IN-supply = <&pp1800_alc5682>;
 		MICVDD-supply = <&pp3300_codec>;
 		VBAT-supply = <&pp3300_audio>;
 
-- 
2.38.1

