Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB6B6D7665
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 10:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237415AbjDEIIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 04:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237341AbjDEIIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 04:08:00 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7F8197
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 01:07:57 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id v14-20020a05600c470e00b003f06520825fso525624wmo.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 01:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680682077;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ty5wIc3Z81+kG82VSRnC8Apz5DxLYwgxvYQ6Q3KABLA=;
        b=2ZcQ8cMXUT+tCWIFKid8JjEtPLeTZHzhuLk1lgXVnCOJL5Pq9A0rkIz2UOfpxW+cq+
         haLAYAXlqgvCXrHAjIYZBAO4XEYQVNLkAx7BbF3N7yX2zduhEga7kzLuQhskSuiiJF4G
         pDFnhNGA8d/sCNsx90s0A/yO7kIPWoF1cPFmn19O9xIgWHh+amnglJ6Yjdev0F9Os2gp
         OvAzvli60SdLPcVbyLyuuBNxKGfpApuQTpdJjdOrkjBhGDSrABdlWLM9A/ci3BQYwfjk
         4H381LhK2Jz2QgJcM6V+HdfoLhRW5V8IoFPl+52XFjUYnJZT/7EqegVJufLgP1CCZrSr
         GNcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680682077;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ty5wIc3Z81+kG82VSRnC8Apz5DxLYwgxvYQ6Q3KABLA=;
        b=JzH3wM5lAKReDF/4GS2mkbfR7ZXagDPtlZjmv/KrCZkJR+EDrwp4HUdtIpk1s7U4c9
         YfeYMdGVV9+RS6YGSjzXhuO6KRuOUan9BaFQcUHMfQecRlLSZErI/8iEeIoSyOLxw0+V
         bS7YDO+eS6h2A5VTKOmYwQeqFZqwq3vTp6Ze0N03887HEe8vb36lETxJwqrir3BuEEin
         lfyArSuRfNHoJMXa9ZU6ZZM244Titz4znCoSELVBJGGGjk5NWCfRrpS7ZdeNf1Ol50mZ
         fbM5WSgaewspzaCrdjwq+XfHVbeEiaNFgmK2A6MTyVNvzjoZzt6ExLxEGq3dVYYaeFNY
         I9FA==
X-Gm-Message-State: AAQBX9eB/13g2wyqYdNMlwVqkioJOijTZZSNBFKrZQmsNkqcn+wMyEaz
        yZ5nGCoYNHXi1PcV3wZfjRe/HA==
X-Google-Smtp-Source: AKy350a+/HP4eT7mepbSgPrh3ZZezmR5cZh/uTdCLsA4vjYdPPommSHW67PUEHi6efoBDBMoS7tOMw==
X-Received: by 2002:a05:600c:2243:b0:3ee:4dc0:d4f6 with SMTP id a3-20020a05600c224300b003ee4dc0d4f6mr4055873wmm.17.1680682077364;
        Wed, 05 Apr 2023 01:07:57 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id d4-20020a05600c3ac400b003ee8a1bc220sm1378395wms.1.2023.04.05.01.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 01:07:57 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Wed, 05 Apr 2023 10:06:51 +0200
Subject: [PATCH v2 09/10] arm64: dts: mediatek: add iommu support for
 mt8365 SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230207-iommu-support-v2-9-60d5fa00e4e5@baylibre.com>
References: <20230207-iommu-support-v2-0-60d5fa00e4e5@baylibre.com>
In-Reply-To: <20230207-iommu-support-v2-0-60d5fa00e4e5@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1094; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=DnJEBHRsbqHL6qyjSRQDzaDxfH+izMrFh6xvaojG8T4=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkLSxTzSSOyVlKk+pu5ucK5KBC6oSvjigLIQZ1wJEe
 BFoarqKJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZC0sUwAKCRArRkmdfjHUReefEA
 CfZ6XqBVopXdvlrSr7JRl9epjtctr2LktwRUlcWmP666YL+2klZ5biMdhZNpTSKTCwranyUGVnHHnj
 78LH1as+UKfp0rtoNTws+8LyzHzB2uLZx/DhnCKCVOW5JTwxNA3HId41CcgsrH7C/fT9oRb4wrm9QM
 h/Wy4RrilonigDtaYbWWVOyROij0gCpwB/PusTwS+0L0hjaax+NdsIfla9MebFpK5/jduofNoFQoaZ
 w4RHjH+2nihAqFNO575K9U3t0srSnCfOxtXNU+iCXtusNe3f7x15auC3gc3NWw4qcfXiDjvVbqLHVO
 tgBxpi+OQro/i3m8cK+5GmxdMhG6MtdWHddIZ5zRUIBisLJ9eWhEZm2KbJZxf3YOqm3jzTDHAk66r9
 Vy3QvFXsAphJLFYxYhFNpZm3K4sASMGTsZpHaiis2BAgjszh7QSAL1iNhWgs7/59wKv4SyuWek8QBp
 TAF8h9Z9odOHxYT/cQNWe90YK2K2eo/3WTZ+QpmoSSHBPoAT/nK09l+r0OC+qNT3ZZNRBFlgtRHHrI
 F6NYlqyeWo7YGZBhAg9SkAkP4EEgfd1ZbMYboaLN+F2YuzoBOZH0OzZ3JCGA73LFohbHNhfzqribm+
 o/Ti5VqGbE5NtUXy/aWXjbgpkQipcK8M11/UtFvd3b0uzijxE0TcD/w3g8SQ==
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

Reviewed-by: Yong Wu <yong.wu@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8365.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8365.dtsi b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
index 07a7267f338e..6260744f4be5 100644
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

