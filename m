Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14C736405E7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 12:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233241AbiLBLfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 06:35:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233320AbiLBLey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 06:34:54 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C336D5858
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 03:34:53 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id j4so7029992lfk.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 03:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DjU7gmeecy9X61DB+8CnNlr7X7DQnou4PN68yDZ7iyk=;
        b=xqC+4AXl8dQjgVXLH4YDTPUBgck4CaGtIFcFIIodspgqI6JcJCxLVhAHZPe1vUKrVU
         KfrFh0eDRyPvq9dCj+aiJWr0WPsIbRMZ+BxpCoCzz4gfxkzT5wMfxkC3sUqqUjVbAZFq
         Ra5tLu6Se62k9Txy16A7+RStF0Eb88H9j+tU8bOfD5g+wGqY++Zya42Y5/zL2oO2VGGL
         jmJJ7ZN9AVIuFmyPEmMv5CHS66NytjOSfylxmQMrHOfSaYAxP6Ym+xvMGNhtLD1FtkOm
         kaD3lO/rprhWd51PwYq6hId/45whAZsU++aApjIxItcaUau3/5izl2rTjCalX6639HC6
         Ev+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DjU7gmeecy9X61DB+8CnNlr7X7DQnou4PN68yDZ7iyk=;
        b=lUKW7krIVGPZR4aMMNVLkeOgaAwjXl/FM1Rc2jEF/JEOqvHMjrjgBprXYzrs1/2KpV
         Y9ANN4MrKEkUWribqCOqD19NmITFSvzcKt6loGFdPlItF2mOUEVceT5yAfBYHpwgJpnK
         iILCiJeofuAPshK12BCVJFGU+kLNHCjoTVe2sfEPJU0qhUv85c333fQReJKZZtQtVdgt
         SixPAiW7ESykgX5eG8aqkaBxCOynr8sQWgeN7hr72Jr5jm/XBtDoT1PgxSWkvSb7Hud4
         up9dNs3qcldEvZpHNvb5VlbGppn0yeFuymkFiODOer6FTcDOmXE5f6dGTPCu1aspweTm
         wTRA==
X-Gm-Message-State: ANoB5pnK2FBbmH3BJKFhguChGCSo0az2TqstPFa2oCeMzXyOXbeY3ZHl
        WlmXBXGRjkzNY3MCrE1eZt5iBQ==
X-Google-Smtp-Source: AA0mqf7Pu/NQeIo3r9+lq4/ieJWfM9TAq2n5oJUUrQKDBvMVWk362OTbtxfdjbZaH+0tV6uJgkQsdA==
X-Received: by 2002:a05:6512:260f:b0:4b4:caeb:c9b1 with SMTP id bt15-20020a056512260f00b004b4caebc9b1mr16910934lfb.500.1669980891389;
        Fri, 02 Dec 2022 03:34:51 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id bp25-20020a056512159900b00497a0ea92desm986276lfb.135.2022.12.02.03.34.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 03:34:51 -0800 (PST)
Message-ID: <dda27c55-0d95-1407-f5a0-94123298e50a@linaro.org>
Date:   Fri, 2 Dec 2022 12:34:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 02/21] dt-bindings: display: tegra: vi: add 'vip'
 property and example
Content-Language: en-US
To:     Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Rob Herring <robh@kernel.org>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-tegra@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Richard Leitner <richard.leitner@skidata.com>
References: <20221128152336.133953-1-luca.ceresoli@bootlin.com>
 <20221128152336.133953-3-luca.ceresoli@bootlin.com>
 <20221201231636.GA1660613-robh@kernel.org> <20221202091117.52a9a8f0@booty>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221202091117.52a9a8f0@booty>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/12/2022 09:11, Luca Ceresoli wrote:
> Hello Rob,
> 
> On Thu, 1 Dec 2022 17:16:36 -0600
> Rob Herring <robh@kernel.org> wrote:
> 
>> On Mon, Nov 28, 2022 at 04:23:17PM +0100, Luca Ceresoli wrote:
>>> The Tegra20 VI peripheral can receive parallel input from the VIP parallel
>>> input module. Add it to the allowed properties and augment the existing
>>> nvidia,tegra20-vi example to show a 'vip' property.
>>>
>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
>>>
>>> ---
>>>
>>> Changed in v2 (suggested by Krzysztof Kozlowski):
>>> - rename "i2c3" -> "ic2"
>>> - add review tag
>>> ---
>>>  .../display/tegra/nvidia,tegra20-vi.yaml      | 68 +++++++++++++++++++
>>>  MAINTAINERS                                   |  1 +
>>>  2 files changed, 69 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-vi.yaml b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-vi.yaml
>>> index 782a4b10150a..5b5583c2b562 100644
>>> --- a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-vi.yaml
>>> +++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-vi.yaml
>>> @@ -74,6 +74,22 @@ properties:
>>>    avdd-dsi-csi-supply:
>>>      description: DSI/CSI power supply. Must supply 1.2 V.
>>>  
>>> +  vip:
>>> +    $ref: /schemas/display/tegra/nvidia,tegra20-vip.yaml
>>> +
>>> +  ports:
>>> +    $ref: /schemas/graph.yaml#/properties/ports
>>> +
>>> +    properties:
>>> +      port@0:
>>> +        $ref: /schemas/graph.yaml#/properties/port
>>> +        description:
>>> +          Input from the VIP (parallel input capture) module
>>> +
>>> +        properties:
>>> +          endpoint:
>>> +            $ref: /schemas/graph.yaml#/properties/endpoint  
>>
>> You can drop 'endpoint'. You only need port nodes if there's no extra 
>> properties in the endpoints.
> 
> Oh, nice, will remove in v3.
> 
> Krzysztof, can I keep your Reviewed-by after this change?

Yes.

Best regards,
Krzysztof

