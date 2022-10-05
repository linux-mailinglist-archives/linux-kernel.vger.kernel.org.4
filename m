Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 352ED5F50AF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 10:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbiJEIPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 04:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiJEIOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 04:14:51 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15140DF61;
        Wed,  5 Oct 2022 01:14:48 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id z18so9890070qvn.6;
        Wed, 05 Oct 2022 01:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=+Gd9tGdNqsQu4v63s2hpxh7QJ0rYIJUhnAhh++yKUyU=;
        b=nz8aIgUVQ9bMxKt7JGxC6J/vkRhz7fPSdw9D3wPw4Eyty9FUwR8JXuavRFNVucCiKE
         TvkIG0SC5lrbtA1wFAX07FZqZeJMyxKD7dUH7o/4kMBlTrZOvLxI7dX5p9GeuCEgwbty
         5DrHHlSXZz9G+9hX3sqHLmqywj0wB00HWOOpQElYKpNJ4o4oQ4xlm9Q2L/YMrbIneftw
         /0LKvsGUJDtEmeFZfgmd0+qOcr6CdtgwN+gGiRxixTzUts04Fh+ifyrBq+InDVSNbyBU
         d0LqVBsYCuo4cbjqrKCRad0fyc9JdRsr6HL23K0MkLDIiWNN+nXf/+cPftHLB2EsSpaN
         oT7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=+Gd9tGdNqsQu4v63s2hpxh7QJ0rYIJUhnAhh++yKUyU=;
        b=Sbc7oWnW9aNdYqTHvMUbH/FJac8ulUVMWXlvjkZHnlyJCb+Hq4DkftZQ57idUx/sLd
         5hNTeU0k9oUS7QrUzn0ncWT5Pzmc+m08qGXgYurPQqgxhK+1OWHUxhvBkIQWpzkXCT5c
         GLmp8jW8r9i+w1F5WGiD4cwZp0mbWWExfOET8xQnyjCrP9w6EZmzsTnQCb052j+1Xq26
         KzKSWilfYFhgBDxhSmQYCd8pegy6lBU8xi7qFsEdGJ3/ZPx+k4wsr6F8eV8EMmYClwX7
         z7XpZ56lbDoNWpCR5DFL8iczE/UTE/Zup1D4BxYF6ygONj70iX9lS1XF79K4BkBwj2/I
         jm9A==
X-Gm-Message-State: ACrzQf2SLnmzHKmEa/kTFcCWKFNAzxs3zDNVWjUTru8BRNMXdFyYMxBF
        +8ayAaXp3QW+YpccPfpgCEZW/vRUfrNAguJxdBk=
X-Google-Smtp-Source: AMsMyM5ezlbQ1FH5UHLUmLn/HN9FgfeoEXzJaPgrUC0h/t/FLSf1bn3m7sMEJJ/noJ2bk8gG/KAPF37ISl6R/oDHUns=
X-Received: by 2002:ad4:5be1:0:b0:496:a686:2bec with SMTP id
 k1-20020ad45be1000000b00496a6862becmr22549207qvc.85.1664957688045; Wed, 05
 Oct 2022 01:14:48 -0700 (PDT)
MIME-Version: 1.0
References: <9dda705a8d67826306f6c6129722d3ad8edc96fc.1664816175.git.chiaen_wu@richtek.com>
 <CAL_Jsq+YeZRizJFYuU7RPTcFRe1cDjLgsTidisJ_P5PNC4eKiw@mail.gmail.com>
In-Reply-To: <CAL_Jsq+YeZRizJFYuU7RPTcFRe1cDjLgsTidisJ_P5PNC4eKiw@mail.gmail.com>
From:   ChiaEn Wu <peterwu.pub@gmail.com>
Date:   Wed, 5 Oct 2022 16:14:11 +0800
Message-ID: <CABtFH5Ld91S65RiDu4iSpFhAMiFWaQdj-yDRM79=WUkArpA0JA@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: mfd: mt6370: fix the interrupt order of
 the charger in the example
To:     Rob Herring <robh+dt@kernel.org>
Cc:     krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        matthias.bgg@gmail.com, sre@kernel.org, chiaen_wu@richtek.com,
        cy_huang@richtek.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 3, 2022 at 11:34 PM Rob Herring <robh+dt@kernel.org> wrote:
>

...

>
> This doesn't fix all the warnings. These still remain:
>
> /home/rob/proj/linux-dt/.build-arm64/Documentation/devicetree/bindings/mfd/mediatek,mt6370.example.dtb:
> pmic@34: indicator: 'color' is a required property
>         From schema:
> /home/rob/proj/linux-dt/Documentation/devicetree/bindings/mfd/mediatek,mt6370.yaml
> /home/rob/proj/linux-dt/.build-arm64/Documentation/devicetree/bindings/mfd/mediatek,mt6370.example.dtb:
> indicator: $nodename:0: 'indicator' does not match
> '^multi-led(@[0-9a-f])?$'
>         From schema:
> /home/rob/proj/linux-dt/Documentation/devicetree/bindings/leds/mediatek,mt6370-indicator.yaml

Hi Rob,

In my opinion, the root cause of these warnings is the incorrect usage
of 'allOf' in our LED indicator dts as follows,
(https://lore.kernel.org/all/27df85c30277a171ae85ff6d5b7d867625765d0a.1663926551.git.chiaen_wu@richtek.com/)
----------
+allOf:
+  - $ref: leds-class-multicolor.yaml#
+
+properties:
+  compatible:
+    const: mediatek,mt6370-indicator
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+patternProperties:
+  "^multi-led@[0-3]$":
+    type: object
----------

and this patch for Linux 6.0
(https://lore.kernel.org/all/20220624112106.111351-1-krzysztof.kozlowski@linaro.org/)

I will revise our LED indicator dts in the next version(v13) of
'MT6370 patch series' like this,
----------
// Remove 'allOf'

+properties:
+  compatible:
+    const: mediatek,mt6370-indicator
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+patternProperties:
+  "^multi-led@[0-3]$":
+    type: object
+    $ref: leds-class-multicolor.yaml#          // Add this line
+    unevaluatedProperties: false               // Add this line
----------

And this '[PATCH v2] dt-bindings: mfd: mt6370: fix the interrupt order
of the charger in the example' patch is for fix charger example in MFD
dts.
Thank you so much.

-- 
Best Regards,
ChiaEn Wu
