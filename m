Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7341C6CD6FD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 11:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbjC2Jwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 05:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbjC2Jwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 05:52:36 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D647F2D57
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 02:52:34 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id d17so14991690wrb.11
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 02:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680083553;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lRWy59m9AcnRjc2fmHsxRpHlVgHZhVLnEx85hZ46BJw=;
        b=HGsZcS3nbA0Q7VTarfFbDHUm3xAerDi9I5AK/zBHDyjPM1VZSCpsS2OHluTIknkQKc
         ZXX7P5O7JjlIZA0RDfKKT4ij4yziAhuxfAB73x9+yjznWX+iD4tmWNSpghKrxTgL+9y4
         45Zz92JHQgjA9WC8DCDYSkhhBkGKV8P+UbJ+T7S7rfZayxtS7CCZx8PC50pQHwWB01j2
         K9VJbuyqqtkhCGYmkFRI+UzdnZ1KDIryBrwSw9+I2wjrF5ydUqbnue6SbEhm2K/1Mmfi
         dv/CcCABRFtr+ZVbVP2cXEHtNoDF0B1OVI+1X0Ml7pThYTD8ApgrPpCbB3a02tsqb7Tc
         brng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680083553;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lRWy59m9AcnRjc2fmHsxRpHlVgHZhVLnEx85hZ46BJw=;
        b=pfAWd9L9Tm5sm5EEUT2WvLudmzrhTbl99PA329SPal38qE+0yC3zQ2ygveM8R1cKLC
         Yqo7NWiA3HcH5tIDnkJeaKSt9Rdp3A3D62aI6IuzxoBlEt5+khGa12im+4U2Dk6zxjiZ
         cn9/y5RA05OWdt5MmdCLS3Tn3HdjFLr16TjLt4ydPHnK5/wwR92IqByKiugwRA7Ap2rn
         Am+rlT6dUGjf/XKqBnqob406R77Apt4AUX7uzdW6uDMI73eLe4XmQrLJc6p4Zpc2NqRM
         UZI7JBc+VQlwkTEjcT4ShTSsFGkJBPND9/+dmJDsMCvaTUnqSmXRLdr8dwwdgvkGgagE
         zV0w==
X-Gm-Message-State: AAQBX9eDsyMMmc2fWiPGQAU9FpCfFIcO0jPPtmx+gRr2dClXT5jSBVUE
        rjWKRhYn70dA0DEyRajBY3laCk8s11oIdI3H8kE=
X-Google-Smtp-Source: AKy350b0g044+MfIMYFBIarz3KOgjOGcfcYYACpoeHBupriobhjpp8ueHWz/AvH4sKT3Vf7PUgpPAg==
X-Received: by 2002:adf:ef91:0:b0:2ce:a697:75c7 with SMTP id d17-20020adfef91000000b002cea69775c7mr15074416wro.33.1680083553394;
        Wed, 29 Mar 2023 02:52:33 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id a18-20020a5d4d52000000b002d1e49cff35sm29667158wru.40.2023.03.29.02.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 02:52:33 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Wed, 29 Mar 2023 11:52:20 +0200
Subject: [PATCH RESEND 1/6] dt-bindings: memory-controllers:
 mediatek,smi-common: add mt8365
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230207-iommu-support-v1-1-4a902f9aa412@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=913; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=2lmQpBSfKmkj53baZh+RDOWdyXIwY8mMHHkJ6yWng4A=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkJApf/J4/8wpCXgD5rDw3NQgdD8grhM9Af9YbqxIy
 yEBp/raJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZCQKXwAKCRArRkmdfjHURVC8EA
 CI4QEuomNhbASJLZdi5d/r5EegnsYbWHR8rkXNntq59Qwx/6Twleypy6HYlGUsG3WBFPio9aLGR8d5
 qMIChp6WqHEhdHWALqAILvjPM1Zi9FsvlEJCrzbqrkVcOE8L1MGpWwnGGJ8nV9fh6gGLJYdMzKFVOR
 bL0I6eaA54G3qtVqefcr7FnZHypqktPUkbw6F5e5u7a+zFne1k7SF+wJ9Ytu32qTcld4lpZ0OBxOdj
 EFVrFNQOLNsnIXT0b/ZsHtZVdyYDMJwLJBuHKvIoc/75hZEZN1i4fRSolP5KUCbsk66cvYUD5V4t/+
 i9GwcjvDR/LCi31daJLpX9watDEQuK22QfgOfh0X8lXekA2GL8FX5DAalJK0ArIXp+Vs9lQ8UNpLmJ
 8fQdTiUKkK0lf+d4a8zlzIGn0iHT881mGYd/TyWbddIxGIrEezUsZ5Dy3j39OGvR7DWllONgmfeR7H
 9QCIFZTfye7OXr8EmL8oZOkO9/cQC3lFpKdsH8zQ0bsPYjBvFyZFXL+5dSe4leNcc7QzlTMrHVOaYW
 CqN0xEsw2eY7vXsrNnCsp59zKI+o6g8vS1AXJAoYGnp1EvMiICLb8e8qp/zCKqla1PFG3Y1aWckrOU
 H7rUOpBDVsekJIG7DwOhuxiWb83tJQGD4iuhirFOwx9UnTpyEcW58f/amJkA==
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
2.25.1

