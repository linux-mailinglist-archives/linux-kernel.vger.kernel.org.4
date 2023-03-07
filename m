Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD5FB6AE113
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 14:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbjCGNrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 08:47:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjCGNrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 08:47:23 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 228A38389B
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 05:46:39 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id h14so12180524wru.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 05:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1678196797;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6cg9HCDND3GEgH3vKCid4qUViJxuJk258AZzVEc7UK0=;
        b=nZulM4LiZhCrWN5dGGfsaTtcvuOcFva+Mf/NyFyqPZ+Gx+ab5MgsgvBD+zUgRtwW7Q
         fmoScdgNja8tD43YAoyDJ+wIil6AZzk2fBFQw/7TzBDgnvKYojxVIJZYlAfAwaEVmnRd
         REMvRPG0fbxMtuCOk78751qpC9vSwX3vpboGBeXc7ttbEg6RyyZqXGj33xdScP7+ZHiY
         4I/BCo1NqREKIPl9Z0zlBRGEKPKIXFpgiwH7FXCe+kS2JhZO8ECWxK0RI2dSiKW/onbY
         Gxd1di+TDP/dYWSwZ7BcGkcl256FfD2fUrBAjog4aceLV1nhvjOGmmeFnKZeFGCIs5M/
         nQGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678196797;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6cg9HCDND3GEgH3vKCid4qUViJxuJk258AZzVEc7UK0=;
        b=RBvmtqv+ks5UATHteX8UnWKvxsyY4uWFIA85zBaS2vihILdgpeWw30D9o0ZwDudrQT
         pDLSG4IvJpZzlxdkdzhZy5VF2xluvfAjXmIDcvayi/htfcYRmHXC8fQtf3d3PZVWsKfO
         w4lYHgOODzWiw1VrdmHsmXoVL+sBad2B2rzudFtZVmRsyyqjkLcN5Yydpm/z/A0yBs+L
         b+KOYihS3JHx14zKBWqtbFmMM4PXRJd0u1KhbtBYwF6y72GyZlKr/n1U9TKqerf3OHJI
         NiZE1OOdOoip9pUutrgHya1teruqlhaAQRM6LdCYcNpqoDlvJW5jS/6k61Y9TCJl3mE/
         HaKw==
X-Gm-Message-State: AO0yUKXIqFBOO+ge75Zi+c2mBILUS081mpnL7F7NDU0STq9du0Qk84lC
        BzhKiujGwa/kTOklXCrA+NcejarBS6pj2vFiJnM=
X-Google-Smtp-Source: AK7set/dC5yOlFU9rcWuAmivcfyv+LVau0QJ8iSiJD3wGphV4LPmgMYwQYC/Fb8yO+ZLrrDTR3Hk9Q==
X-Received: by 2002:a05:6000:1817:b0:2ce:50a9:6d8a with SMTP id m23-20020a056000181700b002ce50a96d8amr7861387wrh.32.1678196797352;
        Tue, 07 Mar 2023 05:46:37 -0800 (PST)
Received: from [127.0.1.1] (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id o13-20020a5d670d000000b002c8476dde7asm12657607wru.114.2023.03.07.05.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 05:46:36 -0800 (PST)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Tue, 07 Mar 2023 14:46:26 +0100
Subject: [PATCH 1/6] dt-bindings: memory-controllers: mediatek,smi-common: add
 mt8365
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230207-iommu-support-v1-1-4f0c81fd52c1@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=916; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=DtGGRXbyTxce1ZCliJaQcicHc6O5LZx7VMpDiib11T8=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkB0A76McPWNiyzuoBC2/uH6vyhEJ5wZicabx41LHK
 rOI+CNqJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZAdAOwAKCRArRkmdfjHURcEdD/
 9CYfOxJr4rB0ORoZN2tOKczuo9Ya0nmSJsbJWmZIXFhFrj9HIHgkF3L9D7ijqPVTtG4FuW6Tj5XFQI
 yx1coIxJjjYTeWy17sW9ZiBCyJufWv7CHomn8BDrcSkBq7r1QBMk14XYCYeWcMVdFkhxWKDY4b1uMj
 Gp1cA6SrTR0ahbqlmSRYpcdr7pASa2C2xPTKfYG0UCVXrzkBsoAfFbeX66DRn9fhCLghCx40klphm9
 RFZg81Fz9vgymC9JyQ9+QIjjFSCYvRKcManlU9006mFiWp0OSXZSxTNxWZ07A3hWhGm0RNmUaGPLYf
 XMM/6GYLOZCdLam1FLSYxMThwI3kHQiWFOyz7Uf4db0q6MdETjbf1Ghxyyd+VIgAXAo1eZwQifeYU9
 cqTF5RNPAfZoHFANsn1W67Yx4ea+vOLD2uVqO5DcBMjn+MhXm+WDUsQCj67+iN2enU+2Q3JQC5XLpT
 3aPw6+kPZ+hWlvMxzKdmOylgcAa3fAEP9BC7pK2go706dYV28QPJvNuwmKI/m2DHw9puylUDezQ+RF
 MSruJX8UH9AlaMb6Uuf63XH6HIsH+YXgiPAWX2lZDV9itMJ+S/WLc+Ms+vOTKbWSogrSRBEMjQJklf
 aPU/Ziiq8VEWnfashNYuj5AMoTAsCBK9mukJXt7ddd/c2ZQF0C1Y7iGYsWsA==
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

Add binding description for mediatek,mt8365-smi-common

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 .../devicetree/bindings/memory-controllers/mediatek,smi-common.yaml   | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
index a8fda30cccbb..d599a190952f 100644
--- a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
@@ -49,6 +49,10 @@ properties:
           - const: mediatek,mt7623-smi-common
           - const: mediatek,mt2701-smi-common
 
+      - items:
+          - const: mediatek,mt8365-smi-common
+          - const: mediatek,mt8186-smi-common
+
   reg:
     maxItems: 1
 

-- 
b4 0.10.1
