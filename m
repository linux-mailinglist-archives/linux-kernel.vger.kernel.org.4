Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14D266D7654
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 10:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237339AbjDEIH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 04:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237310AbjDEIHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 04:07:53 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3357A4EC5
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 01:07:52 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id he13so755703wmb.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 01:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680682070;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9gvRZGzZ81MG5/Kz7opKkMvHNkqBqpdFUorIdo7o5i0=;
        b=Vh+ARxw+XBpCn6Cdbuf7qMigVJ30ZylLNEkKMlcjxc6FxUOMmsEMaBdynDPOffQ6H2
         jkob6hKQ3Beho32h+Qj+YX87SSFxsQSD+Rz1GIb4XqRjYVmf1R/7wQJgIsSVvkLMeC9i
         Rj+QMdbRNLqF41ls64vx4k7996jtfeiNQ+QfCYBG5vXZB0UlThEA/McqoHCu4+nMQAoe
         b6EFIPolerBdQiY3GuG4r4qOpfcpSGyUDTeku16QouVkaP9yLUFahTXiBi2HGU0OszAK
         Ja8tAZhgG2ewKmnDMsHlBKiB+Buwl5Wl14tiXp3tzjo/3pfGZjtc4P6UFwz9jADbIpF3
         3Cbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680682070;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9gvRZGzZ81MG5/Kz7opKkMvHNkqBqpdFUorIdo7o5i0=;
        b=ITR3AAmuJqL2rRyJ4h2qk1/an3lXx32/RfXmeVHh69cWx5jmwIairlY0LGzUd8oMia
         xp49JPtZr90FofTScL98NmyNV2ImPHNBIdNA38XuK5oS+rBF2oDSlGzdeARLHg1a4Och
         GD1FKYyQWrZ0nToDS5mTR3Tm7lZlR/KxYSi+2kcpVKnhVTUVs6uAb30fOsZCwgRcAInS
         g+OkwIn0Wz33kpimFMAlJaJGDDONGczt8ogI5GXBk7lgr6nlIGlWXQE/F3ttWgHlUzXx
         C8Vu2G5aFsp2sWMka5Om8g5jrMR0V6o6V7/swzfvQ4tDQ9wqcHbzYJCmCvdMyAU0lNpR
         SX9g==
X-Gm-Message-State: AAQBX9drDEQ7DqumrZ0J5SVS/hgha9z6uq1mZjSdOFFr+RZgF+QVisb0
        7l9BA8F7QOW5Ka5X/Csszh2ehw==
X-Google-Smtp-Source: AKy350YeXZxkfcHB5kV2nmFPc7FFrQ/RMUACXkLotNVpPgsteGsIlBZRNxyyl9ufeEdxfpQblczIEQ==
X-Received: by 2002:a05:600c:211a:b0:3ea:f73e:9d8a with SMTP id u26-20020a05600c211a00b003eaf73e9d8amr4072220wml.30.1680682070617;
        Wed, 05 Apr 2023 01:07:50 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id d4-20020a05600c3ac400b003ee8a1bc220sm1378395wms.1.2023.04.05.01.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 01:07:50 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Wed, 05 Apr 2023 10:06:44 +0200
Subject: [PATCH v2 02/10] dt-bindings: memory-controllers:
 mediatek,smi-larb: add mt8365
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230207-iommu-support-v2-2-60d5fa00e4e5@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=951; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=dRVBiL9RiPJX/FXqDzKoQWbHskXPf7KJD11X+Bn//b4=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkLSxSiN5AhJ8apXlByy8QrL9ZYngsCHSFSQdKonHj
 FeE4gqSJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZC0sUgAKCRArRkmdfjHURapED/
 429XxnIG2B1brCMTzSLIYyy9lNu+qP8yntLV62vo0uKlgMHDQuO7aWoJQxrew2nnCF68iwsalpu0E2
 zx3AoMJ7WZrFG4h8ixWoaISEJBw+ixclLyTHUDFur7JWSiBw2xkJrs5pkd7tGGSykvXrGacGFb0KQE
 BuFoO3i29xFLxDMZ6zFEKQn7BfLBuwRf5SG815XrmoICAJiOMoB/in7gaQWJZBYHlc6m2Iq5s0pfjS
 HKy2vCeQCy1VRVE5jA2F0Gu3pRwN9LP9DVyqTS6GwNllKUqN6gnR0bf/2P186ND5o6yH00fAgx+TTD
 dDRoTwIuRZES84gUaQwpDpiVH1I7SouNjzMenB+bsLdjAmTSGKTy+T8iHyt68jwbVzXBZOQCBPvugu
 /xw5bt8aTc4efrlapRnf7DNya6GtL2Xne7OKikS15uiYVfrLRP1OwIaRuO3xlO5BnlIcBpz1DNalmC
 CJ/mzM6gz8U9fGIWkeAqjsJfzw7tblLsx18/y5eZZ/0B1dl6d93ThmTE1vQGewShU0Gi2zbZA6xRrB
 38tfFystDk4TgJ3SgvIz229dNMe9H3cY8M8+EboWvaUlhK7w0K/gfQoyfJ0DZ+3ZP4bvFvYiLowVI2
 opx19618vF3shsEn3If/opFEwIXbtvp9rbJfBHy87pzgDYMkqQG3RDKKAuxA==
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

Add binding description for mediatek,mt8365-smi-larb

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 .../devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml     | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
index 5f4ac3609887..aee7f6cf1300 100644
--- a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
@@ -34,6 +34,10 @@ properties:
           - const: mediatek,mt7623-smi-larb
           - const: mediatek,mt2701-smi-larb
 
+      - items:
+          - const: mediatek,mt8365-smi-larb
+          - const: mediatek,mt8186-smi-larb
+
   reg:
     maxItems: 1
 

-- 
2.25.1

