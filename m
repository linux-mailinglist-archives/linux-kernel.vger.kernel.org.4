Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A83260BD57
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 00:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbiJXW11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 18:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbiJXW1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 18:27:05 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B8DB56FE
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 13:48:38 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id z17so4192735qkj.8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 13:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XVN5s6sMhOFIPJeqtsM76g2DVj2bXeI3EB/RIEcARr8=;
        b=VNAub8lyONhGwszi1PHPFm4UVcV1BpMoEh6ZrJ4NmdcK5Rb0fqBgEHUSYlPyjIwh+u
         giEwCe1z+SmP2gXbFNVip0BYrdK7pJgjScIdQm/FnX78KPwwlp5IBlzYVCtdxiSKuEzt
         MAXBsPhf43H89HAI6Q43OGFcWm4wQ8s5nUAPUYE9YxAdGBu8WN7/uAu8YywodbWXcFrv
         cMl3IOqyQmVYbBa+9kxqdMESxruB6CVF+K9Xsx3Zy7kY0OnBKbCYu9Yubc+k5YghLhHm
         LOE0Mo/rRGePTRUiZcct/cmD3phe9MyRrjmBb7LDftsMyD3g6gjd6RTZ7gycxWeOIguT
         dUig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XVN5s6sMhOFIPJeqtsM76g2DVj2bXeI3EB/RIEcARr8=;
        b=cO00a94hHRW5a65EZHYEUPkC5nDkXV2UKh7y2tAOPHEsRtea7ewwXCWm1gJ0J+r/9/
         zTdxq6KT5ZViX5BeT+Ze0fye15qJs2aH5ayCL4Q+GUpHzT8KKiQnFW2OXy2SH7hAuz6Y
         O8BaFs4Ob5fOURHasTBjPC+XiOKueHCj4q39slY1174cBBTJeGJrmlK3cGqxTOLS1HFx
         R+dAB5QJvL13g14dGqNFr9E0MF5WSUk95IDqVXPvoxOhjDlDH/Ta49Di3XuPqrbLmlGp
         44NSJj2ksyfoYcg0Jcr7YSwbc3F3JjeE9B4+yQrIYQ/2OG1cSEwQo49H95/pnC2diNrN
         QTcA==
X-Gm-Message-State: ACrzQf0n3G/yxrcW2FiVB9tUuSvwEysU6issW0fm2udq66oQSOgQ64sY
        6l5l5BmsNX03yrQNbOa6AqbDPw==
X-Google-Smtp-Source: AMsMyM4q3eydvQ5uJfp4IjWRHW1sy5SS0YVO3IL9Z3efyCBZI2HfdJMTWhC3BhepW6tv1XQZfNJIDg==
X-Received: by 2002:a37:5d2:0:b0:6ee:7931:825a with SMTP id 201-20020a3705d2000000b006ee7931825amr23907302qkf.591.1666644382181;
        Mon, 24 Oct 2022 13:46:22 -0700 (PDT)
Received: from [192.168.1.8] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id hh5-20020a05622a618500b0039cb8cdaa6bsm479599qtb.63.2022.10.24.13.46.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 13:46:21 -0700 (PDT)
Message-ID: <4ef59d94-d045-55fc-d531-c84e7edb8333@linaro.org>
Date:   Mon, 24 Oct 2022 16:46:19 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v1 2/2] dt-bindings: ASoC: simple-card: Add
 system-clock-id property
Content-Language: en-US
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     broonie@kernel.org, lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        kuninori.morimoto.gx@renesas.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221022162742.21671-1-aidanmacdonald.0x0@gmail.com>
 <20221022162742.21671-2-aidanmacdonald.0x0@gmail.com>
 <ef6a326b-5c61-988b-2ec2-cd8e233e5d28@linaro.org>
 <GMvEU8xVTkjIoQ518XWAaLkhldSZHlk7@localhost>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <GMvEU8xVTkjIoQ518XWAaLkhldSZHlk7@localhost>
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

On 23/10/2022 09:47, Aidan MacDonald wrote:
> 
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> writes:
> 
>> On 22/10/2022 12:27, Aidan MacDonald wrote:
>>> This is a new per-DAI property used to specify the clock ID argument
>>> to snd_soc_dai_set_sysclk().
>>
>> You did no show the use of this property and here you refer to some
>> specific Linux driver implementation, so in total this does no look like
>>  a hardware property.
>>
>> You also did not explain why do you need it (the most important piece of
>> commit msg).
>>
>>>
>>> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
>>> ---
>>>  Documentation/devicetree/bindings/sound/simple-card.yaml | 8 ++++++++
>>>  1 file changed, 8 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/sound/simple-card.yaml b/Documentation/devicetree/bindings/sound/simple-card.yaml
>>> index ed19899bc94b..cb7774e235d0 100644
>>> --- a/Documentation/devicetree/bindings/sound/simple-card.yaml
>>> +++ b/Documentation/devicetree/bindings/sound/simple-card.yaml
>>> @@ -57,6 +57,12 @@ definitions:
>>>        single fixed sampling rate.
>>>      $ref: /schemas/types.yaml#/definitions/flag
>>>
>>> +  system-clock-id:
>>> +    description: |
>>> +      Specify the clock ID used for setting the DAI system clock.
>>
>>
>> With lack of explanation above, I would say - use common clock framework
>> to choose a clock...
>>
>>
>> Best regards,
>> Krzysztof
> 
> Sorry, I didn't explain things very well. The system clock ID is indeed
> a property of the DAI hardware. The ID is not specific to Linux in any
> way, and really it's an enumeration that requires a dt-binding.
> 
> A DAI may support multiple system clock inputs or outputs identified by
> the clock ID. In the case of outputs, these could be distinct clocks
> that have their own I/O pins, or the clock ID could select the internal
> source clock used for a clock generator. For inputs, the system clock ID
> may inform the DAI how or where the system clock is being provided so
> hardware registers can be configured appropriately.
> 
> Really the details do not matter, except that in a particular DAI link
> configuration a specific clock ID must be used. This is determined by
> the actual hardware connection between the DAIs; if the wrong clock is
> used, the DAI may not function correctly.
> 
> Currently the device tree is ambiguous as to which system clock should
> be used when the DAI supports more than one, because there is no way to
> specify which clock was intended. Linux just treats the ID as zero, but
> that's currently a Linux-specific numbering so there's guarantee that
> another OS would choose the same clock as Linux.
> 
> The system-clock-id property is therefore necessary to fully describe
> the hardware connection between DAIs in a DAI link when a DAI offers
> more than one choice of system clock.
> 
> I will resend the patch with the above in the commit message.

For example if you want to define which input pin to use (so you have
internal mux), it's quite unspecific to give them some indexes. What is
0? What is 1? Number of pin? Number of pin counting from where?

Since this is unanswered, the IDs are also driver and implementation
dependent, thus you still have the same problem - another OS can choose
different clock. That's not then a hardware description, but software
configuration.

Best regards,
Krzysztof

