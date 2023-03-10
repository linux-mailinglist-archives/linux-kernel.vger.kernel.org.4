Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 969AB6B3E3F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 12:43:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjCJLno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 06:43:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjCJLnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 06:43:40 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9008113DF3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 03:43:38 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id cy23so19169381edb.12
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 03:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678448617;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XXII15CH7MYFfh54srfbDSk76SUFLnbMAlJIzw3D41s=;
        b=qDC8NqCLoCXp/8Sv71am8rVaa4PwHul/TUaHJcQCFCOqiCUxePjC82wzRPo3RqIBiJ
         fUtTp5sSk/EB4EDFEV//7E/0UdM3idkwpgzlURXApyG0uwCaBu+NOFg6BuC/Lyk2NcxI
         NT2taYogQ0RGOb+ve3RnAiKffhe7zcPPAG1dsFgOB9v8w/ZAFSyFsZDP/jUcdDkQy+JK
         C1K3QiHjpD4z4KxU/ehaGG8t7WVRnsyhIAjiQ/wW8gop1t1L4lkkTLFLA97RDd5Y7rsc
         fyxhRiXW25Uf+2L5k1iyKa0fWnCfTP0/VhC7bZ0hdinkY9Koxcr+GOotImVhYnOjPmAo
         nrsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678448617;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XXII15CH7MYFfh54srfbDSk76SUFLnbMAlJIzw3D41s=;
        b=fUi8H0yYpPGBVREk/I14h7el1iXm28F3CaMa66PJ6uuXGNg8lGw/SAAi1vYpQh3VWO
         opGnCCK7aiLCSneP6WtCnA4/cMUEQbDHdEf4AWGH3wNNoNEAT2SO56g7boBFlf/0qKV1
         ZRW6sMhj8Qnr2MH1TlDSEIwxhH964YvNV9q35URw28nkHiOhp0MdnOAHczDGThoQY1Bu
         aLlO+tSwfz5uh2lwTmyqLHScsZnbecXBcmO2bg3wgcwFBpTPh4O9P0ubMhlqZb8q/Bxj
         ak/UPq3LuYlBWh79o6e8DwUebJErHbcvUMr75Q3Rnsg7nmz9e7pSBkLXLotabgacuY20
         dyZw==
X-Gm-Message-State: AO0yUKUT1D8wJmXaT0dO8uCDy2ZuBEix1UF8Wiwp2xOa8E4tUITcTMV3
        tT6+isuY9BusBx2Zby8uogV84A==
X-Google-Smtp-Source: AK7set9XX2Tk842WNqeTCOB9kbdJvINY4C8MlsDz/uhUcEYQogE27njaMOiJjwwiz/hcNzXtSucCtA==
X-Received: by 2002:a50:fc03:0:b0:4bf:4b5c:1d58 with SMTP id i3-20020a50fc03000000b004bf4b5c1d58mr24499966edr.11.1678448617049;
        Fri, 10 Mar 2023 03:43:37 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id rs24-20020a170907037800b00905a1abecbfsm859403ejb.47.2023.03.10.03.43.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 03:43:36 -0800 (PST)
Message-ID: <7fc2206d-ddb0-5817-ac6a-51d41803f691@linaro.org>
Date:   Fri, 10 Mar 2023 11:43:34 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 17/20] nvmem: layouts: sl28vpd: Add new layout driver
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Walle <michael@walle.cc>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org
References: <20230308153200.682248-1-miquel.raynal@bootlin.com>
 <20230308153200.682248-18-miquel.raynal@bootlin.com>
 <54e7ee75-6035-c2e9-fb8b-fe96adbb571a@linaro.org>
 <20230310121602.109c58e7@xps-13>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230310121602.109c58e7@xps-13>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/03/2023 11:16, Miquel Raynal wrote:
> Hi Srinivas,
> 
> srinivas.kandagatla@linaro.org wrote on Fri, 10 Mar 2023 11:03:45 +0000:
> 
>> On 08/03/2023 15:31, Miquel Raynal wrote:
>>> +
>>> +static int __init sl28vpd_init(void)
>>> +{
>>> +	return nvmem_layout_register(&sl28vpd_layout);
>>> +}
>>> +
>>> +static void __exit sl28vpd_exit(void)
>>> +{
>>> +	nvmem_layout_unregister(&sl28vpd_layout);
>>> +}
>>> +
>>> +module_init(sl28vpd_init);
>>> +module_exit(sl28vpd_exit);
>> Looking at this pattern in two drivers, we could come up with some helper macro like.
>>
>> #define module_nvmem_layout_driver(__layout_driver) \
>>           module_driver(__layout_driver, nvmem_layout_register, \
>>                           nvmem_layout_unregister)
> 
> Nice idea! I will make a patch; is it okay do it on top?
sounds good

--srini
> 
> Thanks,
> Miquèl
