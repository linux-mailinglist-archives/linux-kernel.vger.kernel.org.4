Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9736CD703
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 11:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbjC2Jw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 05:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbjC2Jwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 05:52:40 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D83426BB
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 02:52:39 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id r11so14995396wrr.12
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 02:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680083557;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KweLqeTYS2Ohdp0JXAvcBR+AYZD2Iz+VUWSRR2JWGMw=;
        b=HqlZ9sMRyHoUrBFh0KoCVRzDqCmYNLcwoluVryjlRCLLEh1v9Bsj8dwlzExbNulINa
         yO4mF5JmUHrNy32vFA7Ty7skQ/WMgOb/ZGYoHwAHbZ3y6DFJHWpgE+V/l6Xgm/0E2ae5
         BUQc5T7UUoID+gpIfNNEQ9wjzyrPw6/mAHBYSva7NI8fda4jLJ1P5euLL2WW9kYRBfgd
         6zuWzH4XKN/wiNdfk+gQUcoaljLauRZSeSvuWg25cWrWD6J9z2MHIUVT5VF7EfCN/dc5
         C+Ai95JF/y5bGg5ruxAoAzIP9IojESpOpSvWINRwtZ8kI0/FdQqUdl0x6RM6b59tjhfy
         MwCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680083557;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KweLqeTYS2Ohdp0JXAvcBR+AYZD2Iz+VUWSRR2JWGMw=;
        b=rMcfT+OjxO3+lkFu1w5/rZ7MRyf1WJUpFD3wxZ7OC2UknfmyidO99Nt5KZCu9QgfBY
         uuP7ZB1bjkHPxT1rZefqS9oeCh8/kihLDgGWyShYOuirF5M7/F3NbeUdD99DKCvK19Tx
         xgDmsMqrnNV36XrkHgYcyS1l9yCpsPeJl0Z+aTyuY31/O0gjKfjEfr8+gSsgJPpc8sMK
         vXPj1qH4kNYKiIg+5Q24h+2VGJZggJY0n3CGoejvFooDczYFv/eT+tib0S7fN13KJy1z
         5+bRTTJC+UOZltZBxBouzun/i7gnrU645Jx57l2T5wBMUTaPJT23qq76Q0bFTw6nGEmC
         mAxg==
X-Gm-Message-State: AAQBX9cb/1yvt1Uqrhh9JcAGnJ6IeCcJ6GwLa3zwgdfN8MIPL29c2vlU
        e9AV1ZyNrc/5ECqeGnHHpOI0jw==
X-Google-Smtp-Source: AKy350YoxMUJF5MkGRYy9jG13/cYrGjkvHSJkFdz+xhnZvN3qTnjr/up4aM/z3jWL72ETzzkpgXkWA==
X-Received: by 2002:adf:db0a:0:b0:2df:7c0a:df33 with SMTP id s10-20020adfdb0a000000b002df7c0adf33mr9995255wri.30.1680083557649;
        Wed, 29 Mar 2023 02:52:37 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id a18-20020a5d4d52000000b002d1e49cff35sm29667158wru.40.2023.03.29.02.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 02:52:37 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Wed, 29 Mar 2023 11:52:25 +0200
Subject: [PATCH RESEND 6/6] arm64: dts: mediatek: add iommu support for
 mt8365 SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230207-iommu-support-v1-6-4a902f9aa412@baylibre.com>
References: <20230207-iommu-support-v1-0-4a902f9aa412@baylibre.com>
In-Reply-To: <20230207-iommu-support-v1-0-4a902f9aa412@baylibre.com>
To:     Yong Wu <yong.wu@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Alexandre Mergnat <amergnat@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=966; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=nW+TPcLBymBQumCyH7WLeKWdyOoyUYLYkL7HqpljFxc=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkJApfW1/fAC/a3iYXOsk9RlBGKnGk0HAwAjRg6xvk
 hYEdgMSJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZCQKXwAKCRArRkmdfjHURQqyEA
 CvE6mTUTCNWwjiA70MqDxweWMM/VPe2qK6QHZGay3IFpYohw1Z5F04gtPUJsecxo0gCwGZERF26YMo
 +pZCs3d2+bVfxztMABmi7B4AGQcXpNISVGseGoyVNMVS8Dqd5RoIzl5vVA/vTKpwCPxWaxxuzBtLKT
 dSYTe5I6LK0jBbCzOw/VuJptjQUY6yX5eYUMNsW58ecrVWFsR72ZTSgiTCHdWBSrNeKFQI57W0yhXA
 4jYf8PUNp2nJhwlapg7QIOueAaJynx9Xra5N17+jk0rVl2/rI3n3RsspgflsrWcOEuijUOcNCE7tYF
 DYGILJecNpQekLdvfjUW0QumB2teAHOk6iTg6hkwsN4TrjddhwvgFMbcK5YrBPyfkFZqLjMRPbSPyu
 SpW13uNZ6B1rSKpNlrDEseKj/ZX1mKxOrfZJIcxyz2AMW4gOlwynnD4Ry9rcdlmQJ8rhf9AgzMfwaP
 cUEpwnti33jNP1tlZrjZhnhiks3vxz4cED4nlyPUdpY9rVDimi+J2rgYejDmv66Q5kWyC+yfT/g1Ez
 aRDFtF4Mxamljws1Rr6xWldfSfurQ1rXxW+J4exwcrs0WVGH5LXS0TXqMxhAdTWx6sNJETzxqak7uV
 9MbPXIrCMGpQMST4WJWhu8ioojdCaexIp7p2tgYEVerXHMe5arDLtq1XPSGg==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add iommu support in the SoC DTS using the 4 local arbiters (LARBs)

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8365.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8365.dtsi b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
index db0b897f58bb..c713471c59dc 100644
--- a/arch/arm64/boot/dts/mediatek/mt8365.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
@@ -456,6 +456,14 @@ sysirq: interrupt-controller@10200a80 {
 			reg = <0 0x10200a80 0 0x20>;
 		};
 
+		iommu: iommu@10205000 {
+			compatible = "mediatek,mt8365-m4u";
+			reg = <0 0x10205000 0 0x1000>;
+			interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_LOW>;
+			mediatek,larbs = <&larb0>, <&larb1>, <&larb2>, <&larb3>;
+			#iommu-cells = <1>;
+		};
+
 		infracfg_nao: infracfg@1020e000 {
 			compatible = "mediatek,mt8365-infracfg", "syscon";
 			reg = <0 0x1020e000 0 0x1000>;

-- 
2.25.1

