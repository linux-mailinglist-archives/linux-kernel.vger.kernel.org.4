Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BAA06D7659
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 10:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237350AbjDEIIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 04:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237319AbjDEIHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 04:07:53 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A37449F1
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 01:07:51 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id n19so20385925wms.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 01:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680682069;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yJjfak4UG2kt7LD+AoFzMT7Gsf1sr+ZsaQfW8YlBLvI=;
        b=OCkUFW+mhgiZ+PUIVfbs11cDivBeCORYii0nVLvMvW3OS66SS8BoYvtzb5hRrt39i9
         reXTYadSz03nF0fYGRndHClKcTqdG3gjmOifCrOWHgF7R5ZJR/DMwSQCFMxERYqoLtqf
         Hcyq358sdsshob50bGFiPmc2rE33JPFa/zMXK4g4ZjJ7IPo3isi/7OtMAWvt8pg88UvL
         WZTJ8IE2I1QGSUCoYrNbkj5pKYy1GIGyVUYVOuVk5yD+DZO6HSlPDIMRjftSIAxi6a+6
         w9DhcEsDMS5jnBj5pRmYphqjC4gIpH5YejJYmTnJRUJSSHoIZNLxRWcG2i18NaRLmAXP
         CbTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680682069;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yJjfak4UG2kt7LD+AoFzMT7Gsf1sr+ZsaQfW8YlBLvI=;
        b=VIGmEMpHdL1I5qA+ifPS7inQpF9m7XSgU75zzPpHedRTQ/7Lz/SGXveoWhf7giaTu6
         DiyIlBUl2wgJhJ8eMx48+BQc+l754n1VkEuB9LNy2MPg+Q3zy2NJsK9T0mFmmLMKBL0t
         eUbipXO5krbviYxcZGDEX6hHiFMFD7dsKVv+LWBvtT6HL4zDWaEgzq5rafVAZHSFNI0r
         hpEBDQJSf+EC/UFB9oKe278U+Y7NhJsrncTETr8F1jr02ij4aoFwrAwV5Z9eHM/mvywH
         8ueJo7TEVL7sOD2RaycvjaMKJ79Ma6GEFvPi/fEy6HJBFuQ8us/9nDK5ntK0j2Khh0+3
         ANng==
X-Gm-Message-State: AAQBX9f6togoG7cRQ3bF0OjX4McWiRRhQ1cI7RG/YX8EvNzkDhSVqweq
        k3b7k1FBnbRFQze6cd1j6E99fg==
X-Google-Smtp-Source: AKy350YW7AQIPOkgBErc/VmRz3hML7NF7jikubeOIa+PdbQN8TrAl5wHjxnD7FkQ/tilP6etDizoPg==
X-Received: by 2002:a7b:c8d7:0:b0:3ee:6161:7d98 with SMTP id f23-20020a7bc8d7000000b003ee61617d98mr1192258wml.16.1680682069557;
        Wed, 05 Apr 2023 01:07:49 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id d4-20020a05600c3ac400b003ee8a1bc220sm1378395wms.1.2023.04.05.01.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 01:07:49 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Wed, 05 Apr 2023 10:06:43 +0200
Subject: [PATCH v2 01/10] dt-bindings: memory-controllers:
 mediatek,smi-common: add mt8365
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230207-iommu-support-v2-1-60d5fa00e4e5@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1196; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=vTUD/c9kbSLzmx+cLlLgYeDYjimwFLetURuSQCdLVkc=;
 b=owEBbAKT/ZANAwAKAStGSZ1+MdRFAcsmYgBkLSxSlglySpw8EC8jWMtiz5EoWRKGnIP273K6KU7P
 s0nj2uuJAjIEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZC0sUgAKCRArRkmdfjHURTXID/
 Y7o7mc0fMazZGCSJPm6JbpC6TUorPZDTIeAsVxgKVo23aCja1X3pmsg7tnFKxqN4DzlMproxKdocOY
 pkX865KHbsPD9LOHET25U+9GSAhnIkPF+8K6+vAdd24mSOcgkSiukihQg+QAS99HExeO9Kyg5p/1sc
 Zzl+CmuHfpaBoriCgsWfSnTnRniIpRKX4ZMShiyEtgT3+/nBQhKY746la0dooX9ovrRgT+Rs+clTXv
 Eirqh3FjzcMOA84m2EayxDVLvl60ldkYWV20IO4J4yM3mxvRY/wq/Ror99b2TikQ7BDzMxrSakHNvH
 YL9CDjndvqWL60QowK7Q/EyJcCSkytGRlszZ2kGEkoiNR/Vnthxqu4bSoBe6PYkl2mJgVxuNDNWzoj
 bj7vCVqizWfcymGQdcBSDedSVMuTkVV3sdl+drGYYnWGZTSWFJNS7pSz2jwiVAxR5lETU/QpQpa1Lv
 uAfnf7dNSk+2Q8g84yZ5DIee512FcMeb7J9vobtTNK1fn69DcdvmQ1W2PtPcKZtTWIAIVlyG60aOS8
 tx6Ny0Yhl2D9Tf9zWuShU64xiGa4Ud0Gy8sqrWnpN7D5liXxMmWIsMYNLhXAzBu1zbr2maEezJIWeX
 R5kUnYvm6NCRaAuFPD+TyzVGWFtOV6r0JFi0o7KjEyf+hvnUTOGmxuqBin
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

Add binding description for mediatek,mt8365-smi-common

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 .../devicetree/bindings/memory-controllers/mediatek,smi-common.yaml     | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
index a8fda30cccbb..2f36ac23604c 100644
--- a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
@@ -43,6 +43,7 @@ properties:
           - mediatek,mt8195-smi-common-vdo
           - mediatek,mt8195-smi-common-vpp
           - mediatek,mt8195-smi-sub-common
+          - mediatek,mt8365-smi-common
 
       - description: for mt7623
         items:
@@ -133,6 +134,7 @@ allOf:
             - mediatek,mt8192-smi-common
             - mediatek,mt8195-smi-common-vdo
             - mediatek,mt8195-smi-common-vpp
+            - mediatek,mt8365-smi-common
 
     then:
       properties:

-- 
2.25.1

