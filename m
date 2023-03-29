Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED5A66CD6F9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 11:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbjC2Jwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 05:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbjC2Jwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 05:52:36 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D49A4200
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 02:52:35 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id r29so14979004wra.13
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 02:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680083554;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j5WwEAxGItsIpKUuUB3hcC/UquIk1bCmeeOB6uO9lrU=;
        b=tkneNf34o5trlHedcbEJBG1C/G/seUDMlCP15KhCrgv2UFRQTD0plONLuU+K4ZOqXK
         dc3Efji/EyVqO+RjidCTgeM8nSmo98t9eZ9sk79vZr7LFgbaFeE3H67pzOlmos4qNmY7
         OrcZVPc4E+NXKqwod5EMLGPw6zX2ihgjC6KPZtkuR72lVzrGk9AyfqzkDBuUz6phdaji
         Er7A//QzcZfxj3Dnp5n9XNVRekELt3dVu0gpAYO4odWpZ5zwpWRppRNZ9lMyadQJ0r60
         1XP5mx2utIcO0dn6/63TFIew2Ycs5HtcrW1o+v2g+rMXga6jZ4es039/szYRIVs9GijG
         gf8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680083554;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j5WwEAxGItsIpKUuUB3hcC/UquIk1bCmeeOB6uO9lrU=;
        b=lWM07YV1UnV6SjhmWBKZ588EpZ8JPkPM2VJe3fjB473wcJN5A6OC1Lf2AHXv5B2xvi
         hNj+QFvXxg32HrR/6prqYqHad1X7PmyAijxCEUZAsvHf4fOJUa7+RVc00ehOBcfxfbH6
         HPyEJd7Dopg26V0/QkamDQieJtpallXIgwxV8I+YdVUnh7kxHaxA7zOrFf4rKcgu8nE1
         N63AZcmmdUiFuX4kfSAHdtty5e4x6/u86p7mBft8f0uggmaBwydntHHAy2Gx+Fjl6p6d
         KN9yb0YcSVM88t526ZeghgzJY+jn4x9phh92ndk0WaxPJAPyFSXHcr8WnowUl2ZIilNH
         8D7A==
X-Gm-Message-State: AAQBX9dz4NWkuh+ktXAnBjJ9BZZ8QWHBoSrj9w/2409aG3XHxN1oTAAI
        08cQCKX2W/iOHGVKdWvJbkrAGME1D54M8c+xkJQ=
X-Google-Smtp-Source: AKy350byewSo7u029DsdGaH9KBuORmJdnk4e7uKUa4N0kYNWx8PgX4NtzFGwssEsCdZFFLDX+1+mcg==
X-Received: by 2002:a5d:414e:0:b0:2d7:531f:b15 with SMTP id c14-20020a5d414e000000b002d7531f0b15mr13224681wrq.42.1680083554206;
        Wed, 29 Mar 2023 02:52:34 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id a18-20020a5d4d52000000b002d1e49cff35sm29667158wru.40.2023.03.29.02.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 02:52:33 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Wed, 29 Mar 2023 11:52:21 +0200
Subject: [PATCH RESEND 2/6] dt-bindings: memory-controllers:
 mediatek,smi-larb: add mt8365
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230207-iommu-support-v1-2-4a902f9aa412@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=895; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=NVbTKEoEUh603XA7uYARxuPDAu5UoEtf9xrwI1znpgE=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkJApffBpaxAKuc7aTZi+s2URLQXTX+8hl3dvRDFh+
 5WJNvVGJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZCQKXwAKCRArRkmdfjHURZSPEA
 CNaXGxjj4cgfKrhuxRg6JRYJVaqabu/st50LIHZ+IM8roj+B8U3RpyI6Tg5kYXr+xSZAabcCB6g/S5
 tCWz8XkHw77IHJRhDU8cv3L372cVCL4i8mO4rbHHpLnQccQl5GlU+qdS1aiCgEHHRQSyx9L9uhUL+r
 8hGrhoM9JCx33yQAcjZvuUYNsSS07Vf5p/IV3v7J7NXwhEdjnqGjPfb2mura9Ja7hZV/Mj/yjNbz5Y
 fzEyFl0XLl1efv+n43Xp+cBMJ+bG/uLaRW5Py6MuS0P1TLEKvtWq92LTD0JX61P0jaUmu2U+OXfbFA
 SwcqrL4noGm1WBO5NWl4/FdWvK34W2dFZ9Z/em2OSCNlEYmMIZc5JJAroJujDuobm7VROwuEw9mAby
 L7iVjb8N/sify3HVbuV/H2LXa5vXBpoBc+dAWzqD6jZ7VVeP74Zl/sc7dz3NG4WJK9WdJOPz1VrNP0
 Ii6ohnjnZ3rUeCcYBrPE7YvGMBl/2LXh6ALtf1uGkl8fkIk8/hGWOWtqSi5K3Fm3Wy9bb3y6D55QIG
 gV0p0NQ7NY44zfNy60uxoTdBW8NQcvtIFGrH6ZTHj9NABvr9NzUkafxzv1e6eqVxgiX2B0XFVXqGvc
 ApAIJii3ESgbaJT5D/8Vn13UfSrbHvdE0Hkm0FerG6q0X5nRAdsyFM9xMduw==
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

