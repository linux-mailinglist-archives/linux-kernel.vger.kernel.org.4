Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 359C65EC564
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 16:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbiI0ODV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 10:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbiI0ODO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 10:03:14 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1DF42ACB
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 07:03:13 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id b75so9761972pfb.7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 07:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:mime-version:in-reply-to:references
         :user-agent:from:from:to:cc:subject:date;
        bh=wh+C9NAf7fyhTRzPTh+MKYKYRuDErBnhgOgiBqVy3dc=;
        b=WFviH4EqUR6kYjQp6x+cQUhPYii3lQYYZmfJlDXU5vgrdYVW5TvMAnjzuqH4hlWZ9R
         6MSorDUp5CAGAwGkDsbgqIo6h8J+x/B5EcVeW4mUYMkolFq2i49kRDnlyUoV6JoZXkVN
         RwQJb9tLucy2NO4OeirzxMQrjG5gHDPDQMq5hVuxIgNpfPFiAcU3PdOmGpIpuYGtmgjQ
         A3hH67P+p4d6WmHJ296e8RxVT/0YRNYQv8A1oEo5ebznQjhhtJytGmT6N2OjWeJjbpGH
         E6Mf8h1B/KVp2sRO5vAlBoS1nbXwNRZ2JmuFfccGMGCFtAxJQKi+q9xgLbpu6ZXd9Koc
         KBlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:mime-version:in-reply-to:references
         :user-agent:from:x-gm-message-state:from:to:cc:subject:date;
        bh=wh+C9NAf7fyhTRzPTh+MKYKYRuDErBnhgOgiBqVy3dc=;
        b=EWJJKwkItkiJvPZqi7x/rnQaKCG7cOcUr/5vFKiCO1q/1kzwSHSrDKz5WL07IsY+Tx
         Scciml4E5ivf+orMBCYu/6TuVQPvh6kURIpl0Pu+XQi4rl/lxzyeIGN5eSpkp4F52+zH
         kGWeYZgG+Pm1yUE+j9v2vAMJC88442lkmXgUwgpHVVMQz4XJhbJqaQRXgNwEJMRiS/YG
         YlgtTVNdOnMYJLLkdYa8uhVT7Areu+YjX4KNWYXdz6BWKZsIDzN6S7HzexXGeLLuxxCi
         a1FlrS+FYYgWdoaAM1RR8/AuhbbO9+IAhpBIWew820nwpCxrtapw9xU8/pATQwRwi61S
         ZzUQ==
X-Gm-Message-State: ACrzQf0z6Bc8D8moiH2oPIjW445yoNmM+0Ol4BfaycMh3dH2kpZGoFar
        BtZjkAb3OmBXj2v1sgfi58XU21SoX14XYjglwbN8AA==
X-Google-Smtp-Source: AMsMyM4AhyvViwVb+Xhe6VVlAW1UxwPvhNZlvy0VcZjmOqqSxzYURnmqx7ipZkYuEjhS4Di3Y/aYKi6FFyNoEfJMpIA=
X-Received: by 2002:a63:698a:0:b0:41c:8dfb:29cb with SMTP id
 e132-20020a63698a000000b0041c8dfb29cbmr24458682pgc.170.1664287393191; Tue, 27
 Sep 2022 07:03:13 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 27 Sep 2022 07:03:12 -0700
From:   Guillaume Ranquet <granquet@baylibre.com>
User-Agent: meli 0.7.2
References: <20220919-v1-0-4844816c9808@baylibre.com> <20220919-v1-6-4844816c9808@baylibre.com>
 <5a857097-30c2-3b37-6134-57cb942113ca@linaro.org>
In-Reply-To: <5a857097-30c2-3b37-6134-57cb942113ca@linaro.org>
MIME-Version: 1.0
Date:   Tue, 27 Sep 2022 07:03:12 -0700
Message-ID: <CABnWg9vDhEES=hfUzs7tkHfuzN7TCm1CKz3WysgWTHvPPiY41w@mail.gmail.com>
Subject: Re: [PATCH v1 06/17] dt-bindings: mediatek: set the hdmi to be
 compatible with syscon
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Vinod Koul <vkoul@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>, Jitao shi <jitao.shi@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-mediatek@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        Pablo Sun <pablo.sun@mediatek.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Sep 2022 09:19, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>On 19/09/2022 18:56, Guillaume Ranquet wrote:
>> In order to share register with a dedicated ddc driver, set the hdmi
>> compatible to syscon.
>>
>> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
>>
>> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,hdmi.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,hdmi.yaml
>> index abb231a0694b..86297b7eb7f7 100644
>> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,hdmi.yaml
>> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,hdmi.yaml
>> @@ -16,12 +16,14 @@ description: |
>>
>>  properties:
>>    compatible:
>> -    enum:
>> -      - mediatek,mt2701-hdmi
>> -      - mediatek,mt7623-hdmi
>> -      - mediatek,mt8167-hdmi
>> -      - mediatek,mt8173-hdmi
>> -      - mediatek,mt8195-hdmi
>> +    items:
>> +      - enum:
>> +          - mediatek,mt2701-hdmi
>> +          - mediatek,mt7623-hdmi
>> +          - mediatek,mt8167-hdmi
>> +          - mediatek,mt8173-hdmi
>> +      - const: syscon
>
>So you just broke all DTS and I do not see patches fixing them...
>
>Best regards,
>Krzysztof
>

I'll drop this patch for V2, as suggested by Angelo I'll do things differently
in the driver to drop this requirement.

Thx,
Guillaume.
