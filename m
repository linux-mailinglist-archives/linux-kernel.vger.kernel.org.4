Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4A9E6EA545
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 09:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbjDUHwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 03:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjDUHwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 03:52:49 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E307DAA
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 00:52:47 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-94a39f6e8caso217193666b.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 00:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682063565; x=1684655565;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5jyQvtkjr7ktOwnMvKFvNnF+GYCbKmPXGYqdPfrCCx0=;
        b=HZ7YH2uD3n7M1DYcAgjkiaCpV8J4YreupSN55YXHb8wdXMPQOTA86GGZu0g5EUyRqU
         U00W1VXUhKADBcaLcHJ84osfZCjnhoCWMmmB2Uh3nclRsHiACYsi7pMY1lm6Hgbp2YLz
         IfuZb5AbCNs3VSISX/PFB+k+Pqe1uqmRDThkZ4k8UXzc+bCOx9CJIpSbwO2PE9qZ0Chz
         54s+YL4CuqWekzRrzOc/9oVcUeb2heZMC8FsqGdsG7PBIBVPlNkZEODqOiA5VM/ZP9Jd
         o6/vQfWeecEkNPKYLVYlRwAGct19Ns6hf579+LzS/SBxwLKlQNrU0+kNdrf45d33J8xa
         wJ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682063565; x=1684655565;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5jyQvtkjr7ktOwnMvKFvNnF+GYCbKmPXGYqdPfrCCx0=;
        b=P2PFTP1LQdUkJfTJoIk9V0PuF4AXcMZQdOE8vGUYSSokfqRsaKHZwv6L1u5hVnNwDo
         Tsg9CR7K2ay+RvY0plEqMeKTgm+Hq0JqFiyD4nSBEI/7JFRn09/m2qFesZWU0vQQaW0K
         msYuXnu7Emia7xdpnCLqWZCkDZG+jQx+7TJl2WMUmDAkZMr6RziVbW1j0V9vjU2aG3xP
         vPJfoPlzrNBw2Hfv8Ffv4cu+0td3DpHvCZrLHBijj+uyfxwkhBBf+sPHt2H0C64RjvRE
         isXREZ9ctohAe8fQPaGKz/ZnZSROz7SxUsUBDQWB5PszYa5nVi4xADnzgMDXWPin2rmK
         uOPA==
X-Gm-Message-State: AAQBX9d6a1xh8+WAqMw0fP2aYuOWhgL/NRMwJL1/dMJ7RVyoybdrj+n0
        BxBEIoUuaTvshi51+GvNiQCiFA==
X-Google-Smtp-Source: AKy350ZBEewCEid1fXIGiqjdiiCmdX9Fux2UjvhL2POTMz2155hb0ctMfZVbcn4nm2URI0g5MdQa/Q==
X-Received: by 2002:a17:906:b354:b0:953:3e29:f35c with SMTP id cd20-20020a170906b35400b009533e29f35cmr1473060ejb.45.1682063565612;
        Fri, 21 Apr 2023 00:52:45 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:668b:1e57:3caa:4d06? ([2a02:810d:15c0:828:668b:1e57:3caa:4d06])
        by smtp.gmail.com with ESMTPSA id o23-20020a170906769700b0094e9f87c6d4sm1685207ejm.192.2023.04.21.00.52.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Apr 2023 00:52:44 -0700 (PDT)
Message-ID: <054a384b-b0ef-2697-4a70-09868694ec6d@linaro.org>
Date:   Fri, 21 Apr 2023 09:52:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v6 3/7] mfd: Add support for the Lantiq PEF2256 framer
Content-Language: en-US
To:     Lee Jones <lee@kernel.org>, Herve Codina <herve.codina@bootlin.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20230417171601.74656-1-herve.codina@bootlin.com>
 <20230417171601.74656-4-herve.codina@bootlin.com>
 <20230420123946.GB996918@google.com> <20230420151551.78c1288b@bootlin.com>
 <20230420134703.GC996918@google.com> <20230421092645.56127f11@bootlin.com>
 <20230421074558.GQ996918@google.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230421074558.GQ996918@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/04/2023 09:45, Lee Jones wrote:
> On Fri, 21 Apr 2023, Herve Codina wrote:
> 
>> Hi Lee, Krzysztof,
>>
>> On Thu, 20 Apr 2023 14:47:03 +0100
>> Lee Jones <lee@kernel.org> wrote:
>>
>>> On Thu, 20 Apr 2023, Herve Codina wrote:
>>>
>>>> On Thu, 20 Apr 2023 13:39:46 +0100
>>>> Lee Jones <lee@kernel.org> wrote:
>>>>   
>>>>> On Mon, 17 Apr 2023, Herve Codina wrote:
>>>>>   
>>>>>> The Lantiq PEF2256 is a framer and line interface component designed to
>>>>>> fulfill all required interfacing between an analog E1/T1/J1 line and the
>>>>>> digital PCM system highway/H.100 bus.
>>>>>>
>>>>>> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
>>>>>> ---
>>>>>>  drivers/mfd/Kconfig         |  16 +
>>>>>>  drivers/mfd/Makefile        |   1 +
>>>>>>  drivers/mfd/pef2256-regs.h  | 250 ++++++++++
>>>>>>  drivers/mfd/pef2256.c       | 950 ++++++++++++++++++++++++++++++++++++    
>>>>>
>>>>> 95% of this driver needs to be moved somewhere else.
>>>>>
>>>>> What is a Framer?  Perhaps sound/ is a good candidate?  
>>>>
>>>> The pef2256 framer is a device that transfers data to/from a TDM (time-slots
>>>> data) from/to quite old telecommunication lines (E1 in my case).
>>>> Several subsystem can set/get data to/from the TDM. Each device using their
>>>> own time-slots set.
>>>>
>>>> On my use-case, I have some audio consumer and a not yet upstreamed HDLC
>>>> consumer. Both of them uses the framer to know the E1 link state.
>>>> The framer needs to be initialized 'globally' and not by a specific consumer
>>>> as several consumers can use the framer.  
>>>
>>> I can't think of a good place for this.
>>>
>>> If all else fails, it's drivers/misc
>>>
>>>>>>  include/linux/mfd/pef2256.h |  52 ++
>>>>>>  5 files changed, 1269 insertions(+)
>>>>>>  create mode 100644 drivers/mfd/pef2256-regs.h
>>>>>>  create mode 100644 drivers/mfd/pef2256.c
>>>>>>  create mode 100644 include/linux/mfd/pef2256.h    
>>>>>
>>>>> [...]
>>>>>   
>>>>>> +static int pef2256_add_audio_devices(struct pef2256 *pef2256)
>>>>>> +{
>>>>>> +	const char *compatible = "lantiq,pef2256-codec";
>>>>>> +	struct mfd_cell *audio_devs;
>>>>>> +	struct device_node *np;
>>>>>> +	unsigned int count = 0;
>>>>>> +	unsigned int i;
>>>>>> +	int ret;
>>>>>> +
>>>>>> +	for_each_available_child_of_node(pef2256->dev->of_node, np) {
>>>>>> +		if (of_device_is_compatible(np, compatible))
>>>>>> +			count++;
>>>>>> +	}    
>>>>>
>>>>> Converting Device Tree nodes into MFD cells to register with the
>>>>> Platform Device API is not a reasonable use-case of MFD.
>>>>>
>>>>> Have the CODEC driver match on "lantiq,pef2256-codec" and let it
>>>>> instantiate itself.  
>>>>
>>>> As the framer is going to used by several subsystem, I cannot instantiate
>>>> it in the specific ASoC subsystem.
>>>>   
>>>>>
>>>>> Your first version using of_platform_populate() was closer to the mark.  
>>>>
>>>> The issue was that I need MFD cells for the pinctrl part.  
>>>
>>> Why can't it be represented in DT?
>>
>> The pinctrl part has no specific compatible string.
>> Not sure that a compatible string for pinctrl can be accepted
>> as there is only one pinctrl subnode and no specific reg for this
>> subnode.
>>
>> The DT looks like this:
>>     framer@2000000 {
>>       compatible = "lantiq,pef2256";
>>       reg = <0x2000000 0x100>;
>>       ...
>>       pinctrl {
>>         pef2256_rpa_sypr: rpa-pins {
>>           pins = "RPA";
>>           function = "SYPR";
>>         };
>>       };
>>
>>       pef2256_codec0: codec-0 {
>>         compatible = "lantiq,pef2256-codec";
>>         #sound-dai-cells = <0>;
>>         sound-name-prefix = "PEF2256_0";
>>       };
>>     };
>>
>> Krzysztof, is it acceptable to have a compatible string in the pinctrl node ?
> 
> Why wouldn't it be?
> 
> $ git grep ".compatible" -- drivers/pinctrl/
> 
>> In this case, it will looks like this:
>>     framer@2000000 {
>>       compatible = "lantiq,pef2256";
>>       reg = <0x2000000 0x100>;
>>       ...
>>       pinctrl {
>>         compatible = "lantiq,pef2256-pinctrl";

If you do not have any resources, there is no point in having separate
compatible for separate device node.

Anyway this discussions should not be about DT. How Linux drivers are
implementing DT is not really a guide how to write DT. Since these
series were brought there were some DT decisions made based how you want
to write the driver. No, please don't. I also do not see any problems in
handling more-or-less complex driver structures without poking the DT.
We have already many such device families.

Best regards,
Krzysztof

