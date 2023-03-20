Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD5576C1FB4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 19:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbjCTS3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 14:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbjCTS3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 14:29:18 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9E317CCB
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 11:22:02 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id cy23so50285062edb.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 11:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679336501;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/X9WXUcUsiurfEv5uSz+kyXpuEydk+JbwaKqCGJ/9xc=;
        b=FRrtmnC2erBBSvcnfzAxZ0K+BNPrRJi9gvV+Y0DLpIQtW9/q8vTte52DHucVARi5H/
         iclHcJca1gpjlufGutbrbuwc00BP02ijcdvHXFUkU25oUNNbWEEKyoQvEZDbdZtn8t1h
         98euk1Ifedp56RVTl6lrri/uS/bNgxHQKaeinYrOOHIO3N9/vUDJ1EqYl5aEbE1iGOOR
         IUR3ZXzHvz1cNRsN/VPaWWMvImetsMXlGM8sS6wmyZAF3qOADyXPbR2B8aBL+nYhZ0UQ
         TTKzSsx2aI4XnTJWxlbglCJ+4TdHPspN3cb4xSfJze97oV18jxT1eC5k5ZXCzqeT4UIH
         34Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679336501;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/X9WXUcUsiurfEv5uSz+kyXpuEydk+JbwaKqCGJ/9xc=;
        b=M6CpTqj1Zk8bFjm+Tvi7ssh9tH66ij2oPjscp7ZVWEClTxX+T4Ru8o+oZE6eJ39+U7
         R1P8VAzkGQDAYJyuS/SP5igaybHa7xp5STSCDcqq2MYzQAI8Vz1rEXTYnujyxHm4qxWA
         /flk+SyyTc2N+SsUDNyqZG+j6XefunoMvOhlZWyVgI45Iam0SjCcNzis1be5x6JJ95Ob
         NwMzTrj35l8fh5lGNFLj+I1dVuyIR1wfFGCBgzxGxaDdRXOWQ85DXcMor9ugk8UmPnuM
         bpzGBRqCBA9IDYkEhLadNZDKcc4ojZmqsdBrw1d+gnbQl9Jrx+2DA9HXhZLZzUGkhg2X
         SDGA==
X-Gm-Message-State: AO0yUKXGfjjz7xZ3Xv04kC8bc/YL8q6aEEOc4oHQPfByKR4yuy8ALrxN
        DKzjgI5OAMr5HB2WXa3drSKBIA==
X-Google-Smtp-Source: AK7set/TzLbyJz/SUqgVkIflRB13JN7Q1OB7bH1C/bWuRTHbXNImEIuhuCpFYE0Hfc2BS6vLAusRJw==
X-Received: by 2002:a17:906:7fcb:b0:930:6ead:f81 with SMTP id r11-20020a1709067fcb00b009306ead0f81mr9440396ejs.71.1679336500884;
        Mon, 20 Mar 2023 11:21:40 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:458e:64e7:8cf1:78b0? ([2a02:810d:15c0:828:458e:64e7:8cf1:78b0])
        by smtp.gmail.com with ESMTPSA id i27-20020a170906251b00b0093128426980sm4743489ejb.48.2023.03.20.11.21.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 11:21:40 -0700 (PDT)
Message-ID: <f8227202-95ba-7dae-8f41-2023d7a08691@linaro.org>
Date:   Mon, 20 Mar 2023 19:21:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 5/7] dt-bindings: sound: Add support for the Lantiq
 PEF2256 codec
Content-Language: en-US
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20230316122741.577663-1-herve.codina@bootlin.com>
 <20230316122741.577663-6-herve.codina@bootlin.com>
 <2d4dae57-e46d-7e81-9b56-2148074c8406@linaro.org>
 <20230320191700.3d48e264@bootlin.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230320191700.3d48e264@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/03/2023 19:17, Herve Codina wrote:
> Hi Krzysztof
> 
> On Fri, 17 Mar 2023 09:57:11 +0100
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> 
>> On 16/03/2023 13:27, Herve Codina wrote:
>>> The Lantiq PEF2256, also known as Infineon PEF2256 or FALC256, is a
>>> framer and line interface component designed to fulfill all required
>>> interfacing between an analog E1/T1/J1 line and the digital PCM system
>>> highway/H.100 bus.
>>>
>>> The codec support allows to use some of the PCM system highway
>>> time-slots as audio channels to transport audio data over the E1/T1/J1
>>> lines.
>>>   
>>
>> Your other file should also have specific compatible, unless this codec
>> is actually part of the framer. Did not look like this in the binding -
>> not $ref.
> 
> No sure to understand what you mean.

Compatible "lantiq,pef2256" in the context of this file is confusing.
Two devices without parent-child having similar but different
compatibles, of which one is generic (covers entire device) and one is
function (codec) specific.


> 
> Anyway, I plan to use a MFD device for pef2256 and reference this yaml
> from the lantiq,pef2256.yaml in the node related to the codec.

It should be part of these series. Submit complete bindings.

> 
> One question related to bindings and related checks:
> Is there a way to check the compatible property of the parent node.
> I mean, here is the binding of a child node of a MFD node.
> From this binding, I would like to be sure that the parent is really a
> pef2256 MFD node.

You cannot and you shouldn't. Parent checks children, not vice-versa.

> 
> May be something like:
>   parent-properties:
>     allOf:
>       compatible:
>         contains:
>           const: lantiq,pef2256
> 
> The idea is to have dtbs_check raise an error if the parent's compatible
> property is not 'lantiq,pef2256'.

But it does not matter. Why your device cannot be used in
lantiq,foobar-9999?


Best regards,
Krzysztof

