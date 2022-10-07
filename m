Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4D185F7800
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 14:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiJGMgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 08:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiJGMf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 08:35:59 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58004CA89E
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 05:35:57 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id f37so7081736lfv.8
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 05:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kw1mlKfiYXBJ9mmRKbWY2DRmP8o8zRpFSKtNK4NGUuk=;
        b=J/L2XrvRp32JFzkNCyWAtuEfTHeV6kM5NVRlUHMz8dXoxWurEDRPKBdAJT3qR1iVdi
         O4LcuBGecOIdXWrgVoQmS50Metkhrwjb/8332hmqC5taYrQfuyeN/jpm565MJT0O7Jwz
         LC+4CA40nRRT/zOOMyLapIQVuQrYmbzsJPM5otjUL36cyDk6rJiZ4ub93d8IsQtssoZ0
         r9X9doIF1on4JGETJi/eRD2nI0C7TC8ggVzoYrN8LQUaa4ib3j5EhCnwcn0wF3lmyE4u
         Lww4u8dxnsM0SG1eovk/LVQF0hMc5fWitcfow0KWVbUhH54mMg0N5bCcBT2mw8uQMo+Q
         4Now==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kw1mlKfiYXBJ9mmRKbWY2DRmP8o8zRpFSKtNK4NGUuk=;
        b=hjI64suaFxyJ589VgNgxt+l65uYccNbsZDB0wAtAEHaQmuOb0Dm97yqTPBysM/FfEb
         tGuehPdUiulTBjfILrM4qg+VBYUUCAsyJjclhaqTNevLbqvo9rgQve2d8FN9e5EtcJ0A
         O+I8FtWGwSNFoNP7kbooWnwdPuStk3m8lEo6OQtsIkCx6ZqmagbshLKwgp07P7T6tOiI
         HSPxx2sftFAOQt5fQqbnlINO9fWBL0De+vTN/fkjYDVzB8+rjEFBqG4aPbENV3LRhr+9
         C9APmiYEWwkj1633+b7DW2gHDDOPERZzCk95/OCRkHs5sMq8BebO9sI20T+fpBi3rT+R
         +96g==
X-Gm-Message-State: ACrzQf0xr42Gy3etk6xshS8jmIr662efuq1nku4bdJqpvWOtaNJmZ+mG
        CV+Uubh/2DIjVjAyJnP23czufw==
X-Google-Smtp-Source: AMsMyM56XK8sOb6T02cjy+yqjmC6ShdnQbLa8DY5Ld0odljIMDa/SdwrHLFsbEDyjxBvbK7eoy4R5w==
X-Received: by 2002:ac2:4465:0:b0:4a2:7c09:15de with SMTP id y5-20020ac24465000000b004a27c0915demr1945274lfl.117.1665146155734;
        Fri, 07 Oct 2022 05:35:55 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id c7-20020a056512324700b0048a9e899693sm290979lfr.16.2022.10.07.05.35.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Oct 2022 05:35:54 -0700 (PDT)
Message-ID: <6ac254ba-2eb2-550e-0e02-1e4c1a09bc81@linaro.org>
Date:   Fri, 7 Oct 2022 14:35:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2] greatlakes: dts: Add Facebook greatlakes (AST2600) BMC
Content-Language: en-US
To:     Delphine_CC_Chiu/WYHQ/Wiwynn <Delphine_CC_Chiu@wiwynn.com>,
        "krzysztof.kozlowski@linaro.or" <krzysztof.kozlowski@linaro.or>
Cc:     "patrick@stwcx.xyz" <patrick@stwcx.xyz>,
        "garnermic@fb.com" <garnermic@fb.com>,
        Bonnie Lo/WYHQ/Wiwynn <Bonnie_Lo@wiwynn.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20221007055008.3468691-1-Delphine_CC_Chiu@Wiwynn.com>
 <398470cd-7f2c-28eb-fc13-54ae5d5bc256@linaro.org>
 <HKAPR04MB40186502618E77D9B43FD740835F9@HKAPR04MB4018.apcprd04.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <HKAPR04MB40186502618E77D9B43FD740835F9@HKAPR04MB4018.apcprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/10/2022 11:31, Delphine_CC_Chiu/WYHQ/Wiwynn wrote:
>> Subject: Re: [PATCH v2] greatlakes: dts: Add Facebook greatlakes (AST2600) BMC
>>
>>   Security Reminder: Please be aware that this email is sent by an external
>> sender.
>>
>> On 07/10/2022 07:50, Delphine CC Chiu wrote:
>>> Document the new compatibles used on Facebook Greatlakes
>>>
>>> ---
>>> --- v2 - Add binding document
>>> ---
>>> --- v1 - Initial draft
>>
>> ????
>>
>> That's not how patches are sent... About this I commented and you ignored.
>>
>> This patch was a part of a patchset, so don't send it separately.
>>
>> The subject is now corrupted - entirely wrong.
> 
> Could you please guide us to contribute?
> [PATCH v4 1/2] greatlakes: dts: Add Facebook greatlakes (AST2600) BMC
> --> This is for binding document.
> [PATCH v4 2/2] greatlakes: dts: Add Facebook greatlakes (AST2600) BMC
> --> This is for greatlakes DTS.

The entire guide is already there:

https://elixir.bootlin.com/linux/v5.19.14/source/Documentation/process/submitting-patches.rst

https://elixir.bootlin.com/linux/v5.19.14/source/Documentation/process/4.Coding.rst
https://elixir.bootlin.com/linux/v5.19.14/source/Documentation/process/5.Posting.rst
https://elixir.bootlin.com/linux/v5.19.14/source/Documentation/process/6.Followthrough.rst
https://elixir.bootlin.com/linux/v5.19.14/source/Documentation/process/7.AdvancedTopics.rst

The patches are grouped together correctly, but still have wrong subjects.

Changelog is done like this:

https://lore.kernel.org/all/20220519073330.7187-1-krzysztof.kozlowski@linaro.org/

Best regards,
Krzysztof

