Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72FE66272ED
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 23:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235485AbiKMW2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 17:28:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233909AbiKMW2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 17:28:42 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B5A645E;
        Sun, 13 Nov 2022 14:28:41 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id t25-20020a1c7719000000b003cfa34ea516so8070064wmi.1;
        Sun, 13 Nov 2022 14:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DejAkKVANtN+Gn7CtQB2BM1M5Gg2Igelqp1H0xZD8K8=;
        b=ThCbd944EnlEnU0ELIRidN8c9d4ACPhsff8izbu9n59l+Kf2pUlLoNoSt/tJ4UDESZ
         CxaAgcz8RuNjGLyJgEz0n2HvFtvvxPiMIsrs5g2YAOrHI7Md3MdovTmxnSVF/THRU3UQ
         8qN0Uv/HwFHI5b021fgnofHPWInPH6unahjmfKoZdsI3DLAyVe/p/KUVnJuKa2z2r2tT
         pFhWK8jOmZzPFxmeIztZ0lAyk+QiFvbpFqN26q06FEsuCeBf0+O8hDCQb3hAQiPzeCdF
         NqzgSkjJS2+a5N+XjV5fj28abfF014nmgf+pz92LkFGox5OciJOt2H6wF/836prbbADN
         +IQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DejAkKVANtN+Gn7CtQB2BM1M5Gg2Igelqp1H0xZD8K8=;
        b=GP9TVt9lZTFvstlvzu4QtJScgSFJ0r7GDjIJWdRsi/RkoWQl7COTu8h+tFOvkKqMRC
         HGSwAgpax6j1WJURuZALsDyKO1L3slKeH+FhJNNkXE4iZfo2OOWxy7zW2mjsnlRMDNcw
         5q0tTBnLaDh70i4eNkpwPu3nzozqUvBmLP0FKnqpynZkgJFUniRSSp4RwB9ztLj3LIfx
         PVIqgq3kG70pn5XuPn+aOMynqlooy3rnm2G/laYOcIa2EjXDYWqIu6lcNN64FxSJe/FA
         HeMokbNLZIfTnL6ZKxMQiqX1027WpiAoJdP6dBJzUc246RCP1B+howq/bkUVkGlq86gm
         wm7A==
X-Gm-Message-State: ANoB5pn6TkBdpieCnkZyGAX+DeSS96W1x5rJqEYKE+FwBh6fzMcNb6T/
        us9lLqMHWrnAuQhmmbXzaiuhqJ6KIAA=
X-Google-Smtp-Source: AA0mqf7xpdU3vTBrwNnJsb553ICVwAHBDfAHcu9CzRAnJXzkiuWCLsqwvTECJuavuy2uGP6vcQx2xw==
X-Received: by 2002:a05:600c:3482:b0:3cf:7b67:f692 with SMTP id a2-20020a05600c348200b003cf7b67f692mr6213428wmq.139.1668378519471;
        Sun, 13 Nov 2022 14:28:39 -0800 (PST)
Received: from [192.168.1.131] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id t5-20020a5d4605000000b0022dc6e76bbdsm7903687wrq.46.2022.11.13.14.28.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Nov 2022 14:28:37 -0800 (PST)
Message-ID: <3a7cfa0a-970a-bc86-b519-7a7c925467b9@gmail.com>
Date:   Sun, 13 Nov 2022 23:28:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: Aw: Re: [RFC v3 00/11] Add BananaPi R3
Content-Language: en-US
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Frank Wunderlich <linux@fw-web.de>
References: <20221106085034.12582-1-linux@fw-web.de>
 <trinity-e9c6aa94-6656-4d9c-9d9b-90ede6c8e6fc-1668099812662@3c-app-gmx-bs29>
 <a34fd2d5-b7ed-2fea-7a6c-acc7659cb001@gmail.com>
 <trinity-b1022e89-9e6b-417e-9506-431574251dc3-1668170275463@3c-app-gmx-bap63>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <trinity-b1022e89-9e6b-417e-9506-431574251dc3-1668170275463@3c-app-gmx-bap63>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/11/2022 13:37, Frank Wunderlich wrote:
> Hi
> 
>> Gesendet: Freitag, 11. November 2022 um 10:17 Uhr
>> Von: "Matthias Brugger" <matthias.bgg@gmail.com>
>> An: "Frank Wunderlich" <frank-w@public-files.de>, "Rob Herring" <robh+dt@kernel.org>
>> Cc: linux-mediatek@lists.infradead.org, "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, "Frank Wunderlich" <linux@fw-web.de>
>> Betreff: Re: Aw: [RFC v3 00/11] Add BananaPi R3
>>
>>
>>
>> On 10/11/2022 18:03, Frank Wunderlich wrote:
>>> Hi Rob,
>>>
>>> can you please take Patches 1+3 of v1 into your tree?
>>> due to reordering in my tree i missed them in this version
>>>
>>> https://patchwork.kernel.org/project/linux-mediatek/list/?series=685798
>>>
>>
>> They should go through the subsystem maintainers trees. I'd advise to resend,
>> dropping the RFC prefix and add the corresponding maintainers.
> 
> ok, wait for your push and i create v4 including the missing binding-patches and the reorder of wed-node together with my fixes.
> 
>> Regards,
>> Matthias
>>
>>> pcie-bindings are here:
>>>
>>> https://patchwork.kernel.org/project/linux-mediatek/list/?series=690172
>>>
>>> i found 1 error in bpi-r3 dts (properties from sfp1 not plural) which i will fix in next version and will drop
>>> the compile comment in dt overlays.
>>>
>>> also i've found this commit:
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git/commit/?h=dt/next&id=363547d2191cbc32ca954ba75d72908712398ff2
>>>
>>> so maybe i need to rename my overlay dts files to dtso?
>>>
>>> maybe the others can be applied (at least the mt7986 nodes)?
> 
> does this solve your question about dt-overlays?
> 
> just to note for all...it is all 1 board having sd+emmc on 1 mmc-controller and nand+nor on one spi. it depends on hardware-switches which devices are accessable (1mmc+1 spi). Adding dts for all possible combinations will add more dts (sd+nor, sd+nand, emmc+nor, emmc+nand) than adding the 2 overlays or adds redundant config.
> 

I wonder if in the end that wouldn't be part of U-Boot to pass the correct DTB 
depending on the HW switches. Just one idea I had is, to create on DTS with 
sd+nor+nand+emmc if that's possible. And then leave the permutations to the boot 
firmware (U-Boot).

Regards,
Matthias

> or should i copy the emmc/sd dts and adding once nor or nand? so we have the dtsi and dts for combinations above (=5 total)?
> 
>>> regards Frank
>>
