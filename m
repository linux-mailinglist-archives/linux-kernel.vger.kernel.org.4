Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A880B6877BF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 09:44:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbjBBIov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 03:44:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231821AbjBBIom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 03:44:42 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886558627C
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 00:44:39 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id n28-20020a05600c3b9c00b003ddca7a2bcbso749619wms.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 00:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zSdGfZDhD9SG6czAcftql0hcyxrwJGaxYjADtCqEBXo=;
        b=VWNE8vJlCbaY2J05+r4g+pR+CFHynx4X0NHo7DRKjSu1AXREUATK5Muf8MRTaT3p0t
         4ffWkkwDFQqkDKOMZ0BfeYlv6u1M8Y4xwKVn3OV5GLa6G5L6ge6acJY6Nnz43xfpIEdf
         KXzNQSbn1Q3yIIGMZ5vBTeANx9DwSVVv/VQZhtK0fjcTnRBJaoqc9yTsl3gOqu5mPtI3
         mvurJwtfheuqCKSfDu/DOSdqlrXn8jxeS2BpzhdD25+nQFFhtf4cgfG83GjNNkR03aIL
         vtY9c67oCapbUCE4IWBFGEKwftr25UGRd+NZYDhVCRTIJ+N1NKfn8pzLsRhPcptzkBwA
         2c2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zSdGfZDhD9SG6czAcftql0hcyxrwJGaxYjADtCqEBXo=;
        b=j/bcLYGxusS+Z4QHODmdul9hYH2RZFHITdtLHjxtZYBgaCHfD0pXvoknwpKerZMQ+j
         nMMm7Q5XSMxHqjnD3ERBX6yy7SA/3vdUKm8KWrKnIliI1UmSl/+ZXjMLrxqaChStPTQn
         xS+FLBeRfUqYMy4JbKGEk9lN9SvLpQBsRDI3HnWQzzgD9+H6dQNVeYiEdkD8WK8bPQTC
         jUOmk6+LuHyMWQ9dV84fvTVESdSulJbQA3TGkR2LQXKpQczI4sH4vr3c96EOpMnkUKEm
         bdjXBUvCBO8NaCCY55j1MZO5NUwZ7QwIaGQaWK0C4M5ZsUfOWe1oEot0Su4sDYz3XV8P
         7kyA==
X-Gm-Message-State: AO0yUKWQse0orz333nAWX0VSfNOWOsDqH1oVS3MUHanpc8IMilKPBCpM
        Pk+qRkNYmV+tegwbYcl76fbH3v1nXeYNUv9q
X-Google-Smtp-Source: AK7set9WwxqLeD78t9sZUqS6ql4d1ZeQ8t6LBkKAYoDpz6+6y5ykC46oY5UyQz2yTcokR5gG8zah7w==
X-Received: by 2002:a05:600c:3d8c:b0:3dd:62fe:9914 with SMTP id bi12-20020a05600c3d8c00b003dd62fe9914mr5018345wmb.18.1675327478086;
        Thu, 02 Feb 2023 00:44:38 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id r17-20020a05600c459100b003dee8c5d814sm4021173wmo.24.2023.02.02.00.44.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 00:44:37 -0800 (PST)
Message-ID: <6439a587-0b65-a037-1013-b697e19000a4@linaro.org>
Date:   Thu, 2 Feb 2023 09:44:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] ASoC: dt-bindings: Drop broken irondevice,sma1303 binding
To:     Ki-Seok Jo <kiseok.jo@irondevice.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230201131059.65527-1-krzysztof.kozlowski@linaro.org>
 <1bcd61d6-810f-1239-1b6e-367e0fe87370@linaro.org>
 <Y9pxGUMWyMeXQpZM@sirena.org.uk>
 <6491d6fb-2a10-1c80-d422-8300d5a75ce4@linaro.org>
 <Y9p+p6wt8WugDBuH@sirena.org.uk>
 <SLXP216MB00776F066D70DB2F3F77B09E8CD69@SLXP216MB0077.KORP216.PROD.OUTLOOK.COM>
 <SLXP216MB0077228B6071F62B183F4D648CD69@SLXP216MB0077.KORP216.PROD.OUTLOOK.COM>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <SLXP216MB0077228B6071F62B183F4D648CD69@SLXP216MB0077.KORP216.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/02/2023 06:28, Ki-Seok Jo wrote:
>>>> I tried. I started writing patch to fix few things in this binding
>>>> and then noticed that it is entirely empty and documents nothing.
>>>
>>> I really don't see an empty binding as a major problem in and of
>>> itself, we can always add properties later.  Again, I can't tell what
>>> the problems you're seeing are.
>>>
>>>> The trouble is that soon you will send it to Linus and then it
>>>> becomes the ABI even though no one ever approved or reviewed the
>> actual ABI.
>>>
>>> So send a patch to delete the property parsing code then, like I say
>>> removing the entire driver is very much an overraction.  The
>>> properties are all optional in the code.
>>
>> Ok. I'm sorry for not checking correctly.
>> I only reviewed using the full source build and checkpatch.pl.
>> But I missed the config setting...
>>
>> So, could I get the information how to test the binding files?
>> From what I've checked now, using make dt_binding_check, right?
>>
>> I'll try to read again like submitting-patches.rst and writing-
>> bindings.rst.
>> And then re-write the patch. I'm sorry again for not checking properly.
>>
>>
>> Thanks Mark and Krzysztof to feedback.
>>
>> Best Regards,
>> Kiseok Jo
> 
> So, was the entire thing dropped, or was only the binding dropped?
> If they are not also, can I just patch in the current state?
> 
> And I tested the rewritten file with the following command.
> 
>   make dt_binding_check DT_SCHEMA_FILES=irondevice,sma1303.yaml

Yes.

> 
> Is there anything else I should do?

Correct the binding:
1. Add all properties - just open example-schema and your file and
document everything
2. Fix non-existing reference (there is no such file as name-prefix.yaml)
3. i2c_bus -> i2c


> 
> Thanks to your help, I think I am becoming a better developer.
> I'll try harder. Thanks so much!
> 
> Best regards,
> Kiseok Jo

Best regards,
Krzysztof

