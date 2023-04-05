Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7066D765F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 10:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237390AbjDEIIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 04:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237333AbjDEIH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 04:07:56 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 264FE46B7
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 01:07:55 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id l15-20020a05600c4f0f00b003ef6d684102so17874124wmq.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 01:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680682073;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=70JWiI3ir/yodHMirtpCr960hDJucp8ZmgOAZyHHfjo=;
        b=UIeNa8V4y0LfXdZ77i6wULMuSQuFfCnp1skP+YCmsKzBVPRiY62v3O5ijLSeQMw6e4
         KShG2PJFA1cbBXNvw9XfIWHIBEoASywcnK7eBgZ08MpbPTUdtU7/AwNQs4oInM9ldtPG
         +hxtXV4DnyDAx3M6y/jHA168S8YXAZH68Jck4N8uhSJcvpVajVZsSiy0sg7Ia3buO2Iq
         oVSLUW4UfYG2ecS9V18nUoTax5IWmheRCuMHSEm4mX4H68i2VMRKb7OQ0iCPq40oJGCh
         Qk3frWQ60i1ymoRkCMf3PZHCSEwGYMpGxmuFFae3PyOByXwYzvKko0h6hc3f5ArCc7+E
         OImg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680682073;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=70JWiI3ir/yodHMirtpCr960hDJucp8ZmgOAZyHHfjo=;
        b=GXhDP7tUoQpAQAZ6/Me04D5ljpdvXChEIMQ5tQf8GJHELy7hg+ID6c2BG6gMwOdhYo
         74qEBmF4EgK1FIJO0LjEvhPM0O8zKYumyAsd1ladjjf11yw/vtqGZBbGCXlvmWE+oK+h
         c5paT4xfpcgZvSk04+CLXCZfdpNVssE1O7wPopobjX6N8x0m013XDKibBotgL6F9b5fL
         R+JXtYaE2X7KuFBZTe1qUEFTonllMrQN3bLH05v0UjlyD6Y9VHwSa4lQEM8/euOWV9iB
         VmjGLV3fNIWxvyVfdFy8vbAcsXrI6E4KPuOYItNibMTFZTarHQJsrqkCEZFRJwjycvpt
         g1ug==
X-Gm-Message-State: AAQBX9eW11+ZjkSLLRU+85N/anA7SHhYew/hyApC9MndryeMO05M4a8m
        SfXBvmYEJOXA80DBHRj3Mx4wjQ==
X-Google-Smtp-Source: AKy350b9UOsxTOMqwUZY6vSkEawSnM4J8Hn5cHpyuKPSb9tChyLni5Q6tvJ96/RkzYE/aDoAlZbOGA==
X-Received: by 2002:a7b:c415:0:b0:3ed:c84c:7efe with SMTP id k21-20020a7bc415000000b003edc84c7efemr1210893wmi.7.1680682073579;
        Wed, 05 Apr 2023 01:07:53 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id d4-20020a05600c3ac400b003ee8a1bc220sm1378395wms.1.2023.04.05.01.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 01:07:53 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Wed, 05 Apr 2023 10:06:47 +0200
Subject: [PATCH v2 05/10] arm64: dts: mediatek: add apu support for mt8365
 SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230207-iommu-support-v2-5-60d5fa00e4e5@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1091; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=xWFAj8fuPjSh5BRKLkeGKOoKQ305/M/G1EGxpvjOkWE=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkLSxSoBzL686N39LczEX530ndyxmFITZo9OFEM7y4
 d9bivBOJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZC0sUgAKCRArRkmdfjHURTeoEA
 CkeVoBKqG7XeOy18vlet+vsXg/YxjsTHZMPQNhRXr32clxtVRsx6oTo0LQtwSw20QgVaeJAZVRy3ln
 auw9gGujEh/7bYDNi66KNssUYK3wXvAvHGDiZYBW94LBMWNQMiscOr4oHZglME0C0l28HMVKB29U2Z
 lqt3L93jF6rVumPtiTvpjIc4asQstBdMxMpOT+7q9C/3pEpg5pCLhbskKSJDMXTE0kZLduIHKMRn33
 LSZb/h5IGRROiBRwWyId4r9xPa1SpsrOkYUlo44ibjViePXoWBm+JOjLg8U2gil3NwlqpM8EZCRUUx
 P+Z6MMqpg/VqtC4W04F80CVlhC6RRWkvfvPx65RpsnKhX9WZhY2EaHdsaf5tdsBcyjnb8SLZo6vRz9
 xwYhcMZlzFegrepGZmiLi4M3TF2oKUimnFOHneNxt6D8sVtd3THQQz+HW9+jb+pm3st8+iStKFpzwz
 PKKnS4EQLExyiulo+eePE2wGTEFVtZynrTUb1+kKPcwK4FHSlkFpljuVzXj/YZVlHY/m2mCNSP5RWw
 YqAMVSyCGPTD5oySWjFEG/TSdE7Ftuyxz/vgLtdlsv+mQEzmAUd4ZHJH+YdaUPy4U9KVt9WX905qCS
 dVs6WKIBtHyeC3umaz/KvJJxR252kckS2JV1YdH1Hxt+Q3oaVV3y2LO1emow==
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

AI Processor Unit System (APUSYS) is a highly efficient computing unit
system which is most suitable for AI/CV algorithms. It includes one
programmable AI processor (Cadence VP6) for both AI and CV algorithms,
and an eDMA engine for data movement between external DRAM and VP6
internal memory.

For more detail, ask Mediatek for the MT8365 AIoT application processor
functional specification.

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8365.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8365.dtsi b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
index 73cb10d296fa..386ab8902b55 100644
--- a/arch/arm64/boot/dts/mediatek/mt8365.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
@@ -604,6 +604,12 @@ camsys: syscon@15000000 {
 			reg = <0 0x15000000 0 0x1000>;
 			#clock-cells = <1>;
 		};
+
+		apu: syscon@19020000 {
+			compatible = "mediatek,mt8365-apu", "syscon";
+			reg = <0 0x19020000 0 0x1000>;
+			#clock-cells = <1>;
+		};
 	};
 
 	timer {

-- 
2.25.1

