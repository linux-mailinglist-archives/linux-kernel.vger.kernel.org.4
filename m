Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC4E6AE11C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 14:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbjCGNsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 08:48:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjCGNr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 08:47:26 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618CB838A3
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 05:46:43 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id j19-20020a05600c191300b003eb3e1eb0caso10446568wmq.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 05:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1678196801;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HzSPP7tKpmDgMygbv6FfzcwtKqtIWlRKr/CY2KHoGGA=;
        b=Z7ODCrFGa6AJ0GtvhIqso5qyFzfQ8NsAQww90erwC3wSHzob3XEBgT8+zkwqAAORlW
         ZZ8Mt2vbk9KeWXzHXDWyAvj+6nFDZ9x/8qZZmAMKci64xOmal08AK8sJXsrFg/BgJ39h
         d9ct/pBRpECWYRlubAPXty4ThI7dXf91+0nq32uzEMwN3oqa/0B71B8fAMdakcpatp2u
         Y6m9prXwx6kg5mYWnjSq1RjTpicRxTvKQbkX7TwYVTJExKScvio6GZ8p01yks0k99Biy
         vLHKnJoTXbfg7bluVCIeZtuX6aqdr4MK0R8LgJxiA0PizJgGpBySg+8a3O3QYTJ78uMY
         ckCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678196801;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HzSPP7tKpmDgMygbv6FfzcwtKqtIWlRKr/CY2KHoGGA=;
        b=N0QeToudzUpaYy3WrXHNNBKbV4mUtLCkFx75yOCkLnLbSXcLQOxt7v+Vpk9EQ+KTe+
         TNbu2tXoNmtuynZwCnFOAUBeDoABkIfJqToojSCow0RRUFrQuh/oZQO2yBlw82CZ1sHs
         p0d4wkkb4s2FngqhajJZ+8HOtfLWkYRwlYfbLbF+W8N/iOX8RwSfvg77r35lb+qdRr8Y
         HvZid/hwOfccyayvmJXRbbsox5cRlYRk7S9ZVovvvMycPcp4Ipa3XCZmX9ex7wM4buzg
         HzenaNqujtKhBCgsGl4lr4qFp/747dTQc+IrSvfc88Zwq8sISgIEJNxj3JADYds9J4SZ
         uBkg==
X-Gm-Message-State: AO0yUKXP7JuWgsWNSk5mx0WN7zJBmA/N+iHY9HtXuHSpSedbGdkiaQs8
        QwOjYqGf8/ij73vq+Y/+wbwIftjvZ3suikvBUyQ=
X-Google-Smtp-Source: AK7set9A80XTJaBJRZGJ0NFVW6xppDxlmeTE+Ac0G8GrQqsRd4V/lXRbnCKr6tsJrhN0QVT2zxdufQ==
X-Received: by 2002:a05:600c:474c:b0:3eb:2de8:b74e with SMTP id w12-20020a05600c474c00b003eb2de8b74emr13385054wmo.27.1678196801725;
        Tue, 07 Mar 2023 05:46:41 -0800 (PST)
Received: from [127.0.1.1] (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id o13-20020a5d670d000000b002c8476dde7asm12657607wru.114.2023.03.07.05.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 05:46:41 -0800 (PST)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Tue, 07 Mar 2023 14:46:31 +0100
Subject: [PATCH 6/6] arm64: dts: mediatek: add iommu support for mt8365 SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230207-iommu-support-v1-6-4f0c81fd52c1@baylibre.com>
References: <20230207-iommu-support-v1-0-4f0c81fd52c1@baylibre.com>
In-Reply-To: <20230207-iommu-support-v1-0-4f0c81fd52c1@baylibre.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Yong Wu <yong.wu@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Alexandre Mergnat <amergnat@baylibre.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
X-Mailer: b4 0.10.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=969; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=r7GkCkHYdd12Bt7dFmR03rMsJTMhNcidJ4FTEsGU2Yk=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkB0A7CDFByNdlviQNt8kE2Cw9wrh0z75ZvZpOdikX
 kFOxAUGJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZAdAOwAKCRArRkmdfjHURYKWD/
 94UAAbnpoF14YAwi4BJcFcufFpJmrKQxWeHQnzyW4ELK2wbH5OUOcak4XA4TcLSl6Re4TlCu8DQt4w
 UFvzMALTpLAF1FHEXQ+Z4bQJ5Ejcg6vsv3EJogtvguC/TBwl6AsJdrEU5QBaULWNdOJ+zRsGAW+Nmy
 PXDGOcIhPUFMoEU1TOoQiLhECf6n+/JXr+lUskFw5+nSnUtNmW7UgB80CHgbkhznncOdoVaGhSO2n7
 8XIVHMWUyfrcNOCUElq+HzYFjo66T9Mc/EyoEgBFdKJA6kxzfOnigv5SxTRGhYa5wOLp/8aQhUVNdw
 bGzseWg8NbAas+ViGqwB4J/+BKCvLLWbFcmccTg6WZ+L2MeLqO6iLwMrz7ejVOIhVawn9nMvU0OUjY
 MYDM0V/qS/OMaeD3Ecj5NRBKWIKD2H5tkgVg5NFEBPsVrqx/85DLfIQzNuTorMzniJTzlxFy5a8JO6
 h1uV90ov460FnvMbPkuEiBrtrCyNdVHM+TGtlifHNIVevMZL6u9pwBsjLQspfH5giaiRzj4XvmijZW
 SeulrzQrnKx0FUUV7r0ATeH1BZmuQeSakFevKCi7cUoxxZldlKL7h5FO5m9CqUmA1BZgtknWttAIEv
 JFgNMvi/ylZqDx4vPPib+Yq//xdlLY1pMP7xolKZYzFf03OxSA7+OKiWiVcA==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
b4 0.10.1
