Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9781E70F90D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 16:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235771AbjEXOrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 10:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233930AbjEXOrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 10:47:07 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 214D11B1
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 07:46:55 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-30a1fdde3d6so909120f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 07:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1684939613; x=1687531613;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W9Qke3iBXi7bHq6bOZpRdTikoykkN7piHbBurlNvIaA=;
        b=IHxSDxOcgTZ/KPYWpohVQG4p0ZbEiSTPcIVJB0YomCsORWeeWzEnP23G4lm4yKW3H4
         M8pWjpR3pqMS1rqjJLju/R+tua1H16uqbo32sKz9uro4i9hspQHSjFP3/Z4UIzFKnlA6
         9p0VlDcodzaicsH9Ckyd7rZ33qV2ENfP2Ke7a3h/8iPIsCGY8ULM6RIui9bJtK9ozZdM
         bcrhPYwILyuoV6Qy2aGfmD+tCnTHHY8Z/kYBfH7FG9kToWN73CDsLuSSrWItmYL7Wfat
         eoinQooIwTjvxXKYrOt4itiGM+fi+CGu9p4D7L8Yzd9NUYgIijY7yz/sEe6dyKxxKW1G
         vgVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684939613; x=1687531613;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W9Qke3iBXi7bHq6bOZpRdTikoykkN7piHbBurlNvIaA=;
        b=b8kOqZHtETxgjo4CIdYVGXIGCeya6iFny8LKb9A5yg+4SpECGkbkpxRD1KKHUlB+Qg
         evT15O9JO4WVf91vVcgdh7GSUtqkNNkomTTZRSLxZ04L/kBOu+vpZjr2gQ5aYCHlIlgn
         P+0rns69Yg+WaTjlx3stbGtW6ae4oaloegljyfhiO8g/QA/kb2wW72SxqQ6dwl3KuKhm
         y1YYBKYSMwro7uvrPpJ5/c9+vCkNCT4bQhEbxr+ETr9t4CliZkYFeecyR6KQbKqJluvd
         ffMKZsEDbH6h+DmPw91m2Y1D40eb1QRIYNSgujn6nd8cDup6m2cu2Wi5MTB1qnKZnsWh
         GJGw==
X-Gm-Message-State: AC+VfDxPzEG5gk0vCGAfU2bhBnUmxS/ZvKJfNYnwqVIls48nWwgX1w/A
        RoXucwxgFk43jVhs1O4ROZOPFA==
X-Google-Smtp-Source: ACHHUZ5w6sruo9TAxLIm5fq60R7miyYwyXDbuHMJ4cdoF0aoWVmUoBqb8izRaYYGP2bjSZwq4DIzCg==
X-Received: by 2002:adf:feca:0:b0:30a:b46a:a443 with SMTP id q10-20020adffeca000000b0030ab46aa443mr18120wrs.51.1684939613498;
        Wed, 24 May 2023 07:46:53 -0700 (PDT)
Received: from [192.168.1.172] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.gmail.com with ESMTPSA id c11-20020adfe74b000000b00306281cfa59sm14863678wrn.47.2023.05.24.07.46.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 07:46:52 -0700 (PDT)
Message-ID: <e7d82e49-340c-5eb1-27e3-e6cde900fcf2@baylibre.com>
Date:   Wed, 24 May 2023 16:46:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 2/7] ASoC: dt-bindings: mediatek,mt8188-mt6359: remove
 ADDA_BE from link-name
Content-Language: en-US
To:     =?UTF-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <20230523021933.3422-1-trevor.wu@mediatek.com>
 <20230523021933.3422-3-trevor.wu@mediatek.com>
 <cb69dbab-0966-8ecb-d9b9-017f430fd7ea@baylibre.com>
 <b9eecdf886b6496131e51e1e2f49536c782c3b67.camel@mediatek.com>
 <56b892cd-977e-5b24-55f0-df25e187308b@baylibre.com>
 <e0fb6da4974407726cdf668577fe0d40e6e6e9e2.camel@mediatek.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <e0fb6da4974407726cdf668577fe0d40e6e6e9e2.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/05/2023 15:45, Trevor Wu (吳文良) wrote:
> On Wed, 2023-05-24 at 15:28 +0200, Alexandre Mergnat wrote:
>> External email : Please do not click links or open attachments until
>> you have verified the sender or the content.
>>
>>
>> On 24/05/2023 04:25, Trevor Wu (吳文良) wrote:
>>> On Tue, 2023-05-23 at 18:26 +0200, Alexandre Mergnat wrote:
>>>> On 23/05/2023 04:19, Trevor Wu wrote:
>>>>> ADDA_BE is used to connect to mt6359. For machine mt8188-
>>>>> mt6359,
>>>>> codec
>>>>> for ADDA_BE must be mt6359 which are configured on the machine
>>>>> driver.
>>>>> Besides, ADDA_BE is divided into two dais, UL_SRC_BE and
>>>>> DL_SRC_BE.
>>>>> As a result, remove ADDA_BE from items of link-name.
>>>>>
>>>>> Signed-off-by: Trevor Wu<trevor.wu@mediatek.com>
>>>>
>>>> I don't understand how "DL_SRC_BE" and "UL_SRC_BE" links are
>>>> done.
>>>> Why these dais don't replace "ADDA_BE" in this binding ?
>>>>
>>>> Regards,
>>>> Alexandre
>>>>
>>>
>>> Hi Alexandre,
>>>
>>> Because the sound card is mt8188-mt6359, the codec for these two
>>> links
>>> must be mt6359. Thus, I specifiy the codec in machine driver
>>> directly.
>>> If the codec is changed, there will be a new sound card and binding
>>> file. In conclusion, the codec won't be updated via dts, and that's
>>> why
>>> I don't just replace ADDA_BE in this binding.
>>>
>>> Do you suggest me add some information in the commit message?
>>
>> No it's fine, I'm just trying to understand.
>>
>> When you say "I specifiy the codec in machine driver directly", you
>> are talking about this change ?
>>
>> +               } else if (strcmp(dai_link->name, "DL_SRC_BE") == 0
>> ||
>> +                          strcmp(dai_link->name, "UL_SRC_BE") == 0)
>> {
>> +                       if (!init_mt6359) {
>> +                               dai_link->init = mt8188_mt6359_init;
>>
>> I'm asking because the equivalent was done here:
>>
>> -       [DAI_LINK_ADDA_BE] = {
>> -               .name = "ADDA_BE",
>> +       [DAI_LINK_DL_SRC_BE] = {
>> +               .name = "DL_SRC_BE",
>>                  .no_pcm = 1,
>>                  .dpcm_playback = 1,
>> -               .dpcm_capture = 1,
>> -               .init = mt8188_mt6359_init,
>> -               SND_SOC_DAILINK_REG(adda),
>> +               SND_SOC_DAILINK_REG(dl_src),
>>
>> So I'm wondering why "ADDA_BE" & "DPTX_BE" & "ETDM3_OUT_BE" are in
>> the
>> enum list of the binding since the codec is already specified in
>> machine driver too. I probably miss something but I don't know what.
>>
>>
> 
> 
> The following code snippet is cut from [PATCH v2 1/7].
> 
>   /* BE */
> -SND_SOC_DAILINK_DEFS(adda,
> -                    DAILINK_COMP_ARRAY(COMP_CPU("ADDA")),
> +SND_SOC_DAILINK_DEFS(dl_src,
> +                    DAILINK_COMP_ARRAY(COMP_CPU("DL_SRC")),
>                       DAILINK_COMP_ARRAY(COMP_CODEC("mt6359-sound",
>                                                     "mt6359-snd-codec-
> aif1")),
>                       DAILINK_COMP_ARRAY(COMP_EMPTY()));
> @@ -140,6 +140,12 @@ SND_SOC_DAILINK_DEFS(pcm1,
>                       DAILINK_COMP_ARRAY(COMP_DUMMY()),
>                       DAILINK_COMP_ARRAY(COMP_EMPTY()));
>   
> +SND_SOC_DAILINK_DEFS(ul_src,
> +                    DAILINK_COMP_ARRAY(COMP_CPU("UL_SRC")),
> +                    DAILINK_COMP_ARRAY(COMP_CODEC("mt6359-sound",
> +                                                  "mt6359-snd-codec-
> aif1")),
> +                    DAILINK_COMP_ARRAY(COMP_EMPTY()));
> 
> 
> This is why I talk about specifying the codec it connects in the
> machine driver.
> If you check other dai-links, you would see COMP_DUMMY() in the
> COMP_CODEC() field.

Ok thanks for the explanation. If I understand well, ADDA_BE could have 
been removed from the enum list before your serie because the codec was 
already specified for ADDA_BE.

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

-- 
Regards,
Alexandre

