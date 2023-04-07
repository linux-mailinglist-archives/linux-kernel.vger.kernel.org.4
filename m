Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 341B36DAAB5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 11:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240519AbjDGJOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 05:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbjDGJOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 05:14:08 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97447AA0
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 02:14:06 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id j1-20020a05600c1c0100b003f04da00d07so4205805wms.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 02:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680858845; x=1683450845;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yJjfak4UG2kt7LD+AoFzMT7Gsf1sr+ZsaQfW8YlBLvI=;
        b=OajeO3O/qXkxLZpoot1SLLIdYXgjV4BiDAPRlXxnMUldzeW+b3H4YrsRw/xCLsZUEl
         LROCs5z2IY1AyERqEUT7Maqm3o/ajKCprSieO9pWzSMTnLXoejiI+DplNq7hdgdjOB4Q
         CxXyr0M80n8tpJ7ZyraoX7qqqD7q58C+Ej1xjeKJ1QqeqLuhpf3CoG/1JyL3b/NBCse0
         nuwaZywuBzg17T2/Whx/sHQ4DApT6fOJl/2l3wKyo6ecUtLD24D3zmHUOl191RngKY6p
         UzopT/Ky+wYfCLK310bSQ9pdOJdU5eqycfsBA9TmVeGdfAhYhWT85XGyxCtAH5YwO8Ia
         Fmew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680858845; x=1683450845;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yJjfak4UG2kt7LD+AoFzMT7Gsf1sr+ZsaQfW8YlBLvI=;
        b=VNeUrVrJUAgCHOJsXMv/cbogWm1rBoJvToCT1Hv2GewzihfAfifJFmhCMRTlbLejnn
         mjMlx/qWpjHbVKgVCdy3C5eajljLNpRYsAmY8ldO0+2wQdA1C1Dc1eK4FeDrPW94Zcqx
         ZnvSUlvBL8boCXuvEcVd+Gl6GdkmgUKiWxUOSzsWs849d+bQxoDdufMYmZ45zjoDiYs1
         5R9tGoY6NzfTP72btEgneOf91bYUv6hGsVKZNe8zPsccSFTbkt21F7guBLAbBnWFl4WH
         rgz39j8hF9WmDjZVX2JbxV9OmXJUUH6gKHJDkv54KHVrnAiZkMm7W2u1a4cOjxg8X7Bq
         B/WQ==
X-Gm-Message-State: AAQBX9fU3yZH3fLVwInAcnDhfebZKIq9LJGFICtcLxXOzQxK+BElVZIk
        pOvKSj5bvxE4NcfmijaMe/uOjg==
X-Google-Smtp-Source: AKy350YRyyblA2ED1NB7dgg4zlXhQ/NwohrnxiB+9oAsMQm2YpP5CEal0pHG1lm2ErKnHopqrmnnVA==
X-Received: by 2002:a7b:c00c:0:b0:3f0:3d47:2cbe with SMTP id c12-20020a7bc00c000000b003f03d472cbemr829714wmb.10.1680858845224;
        Fri, 07 Apr 2023 02:14:05 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id k22-20020a7bc416000000b003f04f0c5a6fsm4026429wmi.26.2023.04.07.02.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 02:14:04 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Fri, 07 Apr 2023 11:13:52 +0200
Subject: [PATCH v2 2/3] dt-bindings: memory-controllers:
 mediatek,smi-common: add mt8365
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230407-smi-driver-v2-2-8da6683cdb5c@baylibre.com>
References: <20230407-smi-driver-v2-0-8da6683cdb5c@baylibre.com>
In-Reply-To: <20230407-smi-driver-v2-0-8da6683cdb5c@baylibre.com>
To:     Yong Wu <yong.wu@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Alexandre Mergnat <amergnat@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1196; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=vTUD/c9kbSLzmx+cLlLgYeDYjimwFLetURuSQCdLVkc=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkL97ZTwWW1lBNlbsl6zFLUXT27WoZqxh+yur5qJw0
 7/uB5feJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZC/e2QAKCRArRkmdfjHURXeHD/
 4jwJ2NkMaaZkG4IPOWz9qEdPzHJectYFYU41nxo17Hmcufv89qEjOxLUpJ9G7UZ15QjdvkdqyNkV7e
 qOCjFiG9cwtUfyeoo5A9PEydCtRhOS4W+hmKks0UaMRQyXIXFCcG6j7IOnbmNgQ9+JQr/aurfrsCT8
 T43u6aNNSg0yB+DvFpmxsXkzkMbUFaxk6d5gWfMXOrqwNnxUK/SQiCeamM2yBrTQrhONG6TVFjONtW
 crV7NQXnIzCabu9QdykM7hxW7YTxhFAouZMtys7ZuZ9/Im9ZY9J1jGea1gu/YgouYB222VVxrc/vza
 e983I/+wub1e3fZmzfWrPRwb3E3ttj9teoVJo1SDVv85gazMCKqfouA3S2k3KYuSs55s2ByiPhKp/Z
 RE5wtY/V4Rfs/CjXfodePtSoUzr9NQYSxR8Z9cM9P5Mb+OWYZpldKSkOf1wBzJt105p9zxf+DaLUM1
 qqlWVgKu5UL2RwboCTznrfXsufgvYTLsGKdu6Ze4VKEs4B52zKNHvirTh0aBcJgxlsQ7Bwmw1FvpAv
 tknrTYi1A+fH6hIvmk7alYqLMsEGSHI+aElFiNMkgHUlgv3nP6dpbMQFKZbsV6f5DSiL6vVKzM/nwW
 o7Xri3hB7zVWSoPT9MD/UzJ28MIjVq/FSVx24xhAwIgJtN72eu+gq2mJH+AA==
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

