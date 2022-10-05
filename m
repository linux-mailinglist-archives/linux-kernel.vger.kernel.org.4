Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3455E5F56E5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 16:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbiJEO5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 10:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbiJEO5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 10:57:44 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F0C5722C
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 07:57:43 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id j16so14396977wrh.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 07:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date;
        bh=GaS744uQPmWBXBI6ZqLder+xi41I4zdp+0x6pn9qEpI=;
        b=eQ3m/yEidIEhUShS4zxNMiIs8dd6pmamD7CRnjx84zkb5zOiWS5Me+HqrmXl3UjNBC
         tj5bGw4X+qj+YDp6I1DrYdQ+pvHpKQ5A2g/+4fYZlZ79poiNpLeJcdxVwuF4Qcsf2W5j
         U2vi7i1uemim1xtxUrprk49kvN6bpyIEUHI6xsb6f1qVnwBzahJaOv1zuD+s8rRZwPBr
         bJ1HrbtnerFdjCcPVbo9TvkOugpHSEqFE36Y/matOh/mRp4PgbC6uoN0qM0r/na3fSvd
         78tG/wZAw/bB4+0l67+IFL395IMPR2p4fOYrpR3HwT5NLOJAb57psy1EdIeu8CkyNjPt
         sIaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=GaS744uQPmWBXBI6ZqLder+xi41I4zdp+0x6pn9qEpI=;
        b=SqqAL/KHMObzS8EMeJhnuOa6Dn8PdViI8xKedUlZdiJmHlqjvjmU8TC18AGjLoJrpI
         rUUlDr6PNPGjYrGCsPSma2HPeg7BQQnKXryMxNLLvzotuY5eKluIjUI1SV12rSoArRzO
         USmOoxcPWdPQxEWFJvMtn7l7ZqugSPg8x3ZZ/1e8ayMLnlmxXfNS5Nnbm6Ee7d/0X2eN
         42t79w+y/yY/tohpNVlJ1wEV9FW4werTNT0T0YTrOGWh8cMLCRFXt1yv8iDVIlkdaROW
         6bfD7kk3tZ5fjfEedV8HtNZUqSLWm1qaMk4ZvmJY05TFW4YC9QyZJYo2jleXC/cn4sRw
         WFQw==
X-Gm-Message-State: ACrzQf3UkyoZPMrjZVQXRb4Ni2WtY3YSD2vra3rY1OoBU62qleRcFmLn
        giVLBAv0xfbaa9VJVRj4Qxpl2w==
X-Google-Smtp-Source: AMsMyM7Zru2v2oy2fc0p4s8WDOI8tV/3xktMI+8FiQsxGObnErT3TAgXT1mSA2pAQcKMOoEsE1Wyow==
X-Received: by 2002:a5d:526d:0:b0:22e:4f4d:2546 with SMTP id l13-20020a5d526d000000b0022e4f4d2546mr96570wrc.464.1664981861462;
        Wed, 05 Oct 2022 07:57:41 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id k38-20020a05600c1ca600b003a3170a7af9sm2313758wms.4.2022.10.05.07.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 07:57:40 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Wed, 05 Oct 2022 16:57:21 +0200
Subject: [PATCH v2 1/5] dt-bindings: mfd: mt6397: add binding for MT6357
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221005-mt6357-support-v2-1-f17ba2d2d0a9@baylibre.com>
References: <20221005-mt6357-support-v2-0-f17ba2d2d0a9@baylibre.com>
In-Reply-To: <20221005-mt6357-support-v2-0-f17ba2d2d0a9@baylibre.com>
To:     Lee Jones <lee@kernel.org>, Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Chen Zhong <chen.zhong@mediatek.com>
Cc:     linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, Fabien Parent <fparent@baylibre.com>,
        Alexandre Mergnat <amergnat@baylibre.com>
X-Mailer: b4 0.10.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=882; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=uiI/lTRtppBO+0nDIciFuabIoTVXVizM4YxyzOA2AfE=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBjPZtiqsXNeSVNW2Je72n7QruLLMGxh+hxZPVvbf+4
 5YOOY1WJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCYz2bYgAKCRArRkmdfjHURdebD/
 9RYcYBY/53YUJ9LuhhvvE86q5/Jf97d9LhIpsn8mrj4Wd9tkluXjGbeP/lYK+pQqcHIyRNJGPMTA09
 a7JHSyUzS6VsVO51ZIrsWcFjA0HVjTN2unOsP27q6hFVJPDUfI6uviDZaT2KrV2cGJlGvyYNRvb+ml
 eiSkwsMqMPXon+1ht14uWBHaowVIINJ432/50NjfV34Z0e9xeUQmopUNeOVkstbEPvrd5OpfXTJIfm
 ad4mbAAU5Rh6aFQx/N/9zS7LPp+nu8orXEUqr+84VQRYalE4F6kF4TqjXcWvOXR3daihVfvYxjyVjm
 vurRVuxuKfOTBABlEmkV9BG2LjH2PxWZknp+RpDy9FC74DeB35Jy9ydWBzii/2Sol4ZewPIu1PiAQW
 c7IDx+Sr2qXVmdWNNZLMaK18l6aqWYKCmJ/FROxoDW+nvaJ777CD3dEiUNa/Dl1NGt2gv39d1Duk3b
 T4peNdtyAtEnaaZmRUEU3GCP9Npi3xDNiOZ4HT3r+xWbgNnd95W4+7Xg94mesZOFdamhi3s1ag8wP6
 sRiZnYOLE/8QcNhkh/ckRYuxnucIGWKCdV1cv6qyFxgZ7McQytWq2SfLN2JNjkOBVDMF4cmxE55tqE
 t15U9Z7yo0D6LLd+PbrvC+lGenwl0d6K23EKsVx0W6vz3TAuJQzjKBJIcBiA==
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

From: Fabien Parent <fparent@baylibre.com>

Add binding documentation for the MT6357 PMIC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/mfd/mt6397.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/mt6397.txt b/Documentation/devicetree/bindings/mfd/mt6397.txt
index 0088442efca1..518986c44880 100644
--- a/Documentation/devicetree/bindings/mfd/mt6397.txt
+++ b/Documentation/devicetree/bindings/mfd/mt6397.txt
@@ -21,6 +21,7 @@ Required properties:
 compatible:
 	"mediatek,mt6323" for PMIC MT6323
 	"mediatek,mt6331" for PMIC MT6331 and MT6332
+	"mediatek,mt6357" for PMIC MT6357
 	"mediatek,mt6358" for PMIC MT6358 and MT6366
 	"mediatek,mt6359" for PMIC MT6359
 	"mediatek,mt6397" for PMIC MT6397

-- 
b4 0.10.1
