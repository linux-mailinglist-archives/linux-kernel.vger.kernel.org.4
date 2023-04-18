Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 785C66E6999
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 18:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232273AbjDRQdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 12:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjDRQdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 12:33:17 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E2946EA0;
        Tue, 18 Apr 2023 09:33:15 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-24736992dd3so1015359a91.1;
        Tue, 18 Apr 2023 09:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681835595; x=1684427595;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=00yd/b00VMDTGnIONMzl0dPq75Gv0LFssWOJWefjpaw=;
        b=DPAViHFInAzVqI8i4jL9oVEO402VQEhCxUsZ9FqE7Ti6tIivK1HoAWMsOUnBoJ9Hr+
         ngPT4vhd6+fikkd2884WAgu6VLaiLNNdLH2WhCQWUfVd3+M1VBhI6QuYTTHEeoKJrGbO
         JmVrSimHtX8i0pA+zQ3UNtk7Ornq/994UVpuqRtFh+zL9G0bnpizSsExR5Eix/UZWpQ1
         dHnqIHZWUvgitusR9MoR4689IInxLPLQk8tvKGnyM5CGI2HI+KhUsO1/06/SBWMMscdx
         QDNPlwgVPYT0NxA0oWdlxKGdx9KLwutPZjsCAK4vxnu2vcGErN8+Ly+kKNlQkXcASj22
         s3hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681835595; x=1684427595;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=00yd/b00VMDTGnIONMzl0dPq75Gv0LFssWOJWefjpaw=;
        b=Qg1v68tKsY/VDkyYjDVF9CX0FPJa1ETq3c849GGzwG2c17WbEhV+bigInGwKKI1x2C
         BlnpZVhU+6j6oztDsDQZMAO3ow2CyAtV80DV8eAtYOTJoAptBj3oP141f++SA3HTLBlj
         zpZufKeB1zkBPrSLMzGtV7/X9oLQUFz3idXtyujm/B3FH8KOIZVK4VnUAV2enc8MqFJn
         x0Chp+MTL9WKZL9CkPZ8rqZlv755k3YnLnK1eoib1YuTwThMRuj+Qeyvvq+H2aVZvrYp
         v22PDREJV/d3m/8Dqf7tfsKHT/k6BcG9eROy1o45HFzFxuWrrY5isqu++GSGJmCN8x1k
         ZZDQ==
X-Gm-Message-State: AAQBX9eeib2lMIt8ka+pN6VeJzifYWzuEUbgMliXgOfBy5+CDCi9OS4I
        A8mffE86/fNr2IjCE0v1RTE=
X-Google-Smtp-Source: AKy350Zh/sJxMVTBAgjSWr5N5lBGR5v4pCtY+keT/2Dv2W171DTq5BcU+EBNli/yr+YZasz79dpy4Q==
X-Received: by 2002:a17:90a:eacb:b0:246:5a79:a0e9 with SMTP id ev11-20020a17090aeacb00b002465a79a0e9mr205292pjb.30.1681835594602;
        Tue, 18 Apr 2023 09:33:14 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id gl13-20020a17090b120d00b0024781f5e8besm4353423pjb.26.2023.04.18.09.33.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 09:33:13 -0700 (PDT)
Message-ID: <40e91346-19d7-c0b4-7fcc-d5a2081fe8dd@gmail.com>
Date:   Tue, 18 Apr 2023 09:33:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 2/2] firmware: arm_scmi: Augment SMC/HVC to allow
 optional parameter
Content-Language: en-US
To:     Nikunj Kela <quic_nkela@quicinc.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     cristian.marussi@arm.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230409181918.29270-1-quic_nkela@quicinc.com>
 <20230417174401.19563-1-quic_nkela@quicinc.com>
 <20230417174401.19563-3-quic_nkela@quicinc.com>
 <02b34c80-f37e-deee-29cd-de7db902797d@gmail.com>
 <20230418095846.4lkncoa4beeih2hj@bogus>
 <d05b26ff-1c49-69eb-7146-8f7cef7e1ddb@quicinc.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <d05b26ff-1c49-69eb-7146-8f7cef7e1ddb@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/18/23 07:20, Nikunj Kela wrote:
> 
> On 4/18/2023 2:58 AM, Sudeep Holla wrote:
>> On Mon, Apr 17, 2023 at 11:01:13AM -0700, Florian Fainelli wrote:
>>> On 4/17/23 10:44, Nikunj Kela wrote:
>>>> This patch add support for passing shmem channel address as parameter
>>>> in smc/hvc call. This patch is useful when multiple scmi instances are
>>>> using same smc-id and firmware needs to distiguish among the instances.
>>> Typo: distinguish.
>>>
>>> It really would have been a lot clearer and made a whole lot more 
>>> sense to
>>> encode a VM ID/channel number within some of the SMCCC parameters, 
>>> possibly
>>> as part of the function ID itself.
>>>
>> Yes I was about to suggest this but then remembered one main reason I 
>> have
>> been given in the past against that:
>> If the system launches high number of VMs then that means loads of FID
>> needs to be reserved for SCMI and the hypervisor needs to support it.
>> Basically it is not scalable which I agree but not sure if such large
>> number of VMs are used in reality with SCMI. But I agree with the 
>> technical
>> reasoning.
>>
>> The other reason why I preferred the shmem address itself instead of some
>> custom VM ID/channel number is that it can easily becomes vendor specific
>> for no real good reason and then we need to add support for each such
>> different parameters. Nikunj suggested getting them from DT which I 
>> really
>> don't like if the sole reason is just to identify the channel. We don't
>> have standard SCMI SMC/HVC but allowing such deviations with params from
>> DT will just explode with various combinations for silly/no reason.
>>
> Would you be ok to pass the smc/hvc parameters via kernel parameters in 
> commandline? If so, I can implement that. I just wanted to keep 
> everything in one place hence suggested using DTB node.

Command line arguments seem a bit unnecessary here and it would force 
you to invent a scheme to control per SCMI device/instance parameters.

> 
>> [...]
>>
>>>> @@ -137,6 +144,8 @@ static int smc_chan_setup(struct scmi_chan_info 
>>>> *cinfo, struct device *dev,
>>>>        if (ret < 0)
>>>>            return ret;
>>>> +    if (of_device_is_compatible(dev->of_node, "arm,scmi-smc-param"))
>>>> +        scmi_info->param = res.start;
>>> There is not even a check that this is going to be part of the 
>>> kernel's view
>>> of memory, that seems a bit brittle and possibly a security hole, 
>>> too. Your
>>> hypervisor presumably needs to have carved out some amount of memory in
>>> order for the messages to be written to/read from, and so would the VM
>>> kernel, so eventually we should have a 'reserved-memory' entry of 
>>> some sort,
>>> no?
>>>
>> Not disagreeing here. Just checking if my understanding is correct or 
>> not.
>> IIUC, we need reserved-memory if it is part of the memory presented to 
>> the
>> OS right ? You don't need that if it is dedicated memory like part of 
>> SRAM
>> or something similar.
> We are not using reserved-memory node. Instead using sram-mmio to carve 
> out shmem for scmi instances.

OK, that works too.

>>>>        /*
>>>>         * If there is an interrupt named "a2p", then the service and
>>>>         * completion of a message is signaled by an interrupt rather 
>>>> than by
>>>> @@ -156,6 +165,7 @@ static int smc_chan_setup(struct scmi_chan_info 
>>>> *cinfo, struct device *dev,
>>>>        }
>>>>        scmi_info->func_id = func_id;
>>>> +    scmi_info->is_smc64 = ARM_SMCCC_IS_64(func_id);
>>>>        scmi_info->cinfo = cinfo;
>>>>        smc_channel_lock_init(scmi_info);
>>>>        cinfo->transport_info = scmi_info;
>>>> @@ -188,7 +198,20 @@ static int smc_send_message(struct 
>>>> scmi_chan_info *cinfo,
>>>>        shmem_tx_prepare(scmi_info->shmem, xfer, cinfo);
>>>> -    arm_smccc_1_1_invoke(scmi_info->func_id, 0, 0, 0, 0, 0, 0, 0, 
>>>> &res);
>>>> +#ifdef CONFIG_ARM64
>>>> +    /*
>>>> +     * if SMC32 convention is used, pass 64 bit address in
>>>> +     * two parameters
>>>> +     */
>>>> +    if (!scmi_info->is_smc64)
>>> There is no need for scmi_info to store is_smc64, just check the func_id
>>> here and declare is_smc64 as a local variable to the function.
>>>
>> +1
> ACK!
>>> Also, another way to approach this would be to encode the parameters 
>>> region
>>> in 4KB units such that event on a 32-bit system with LPAE you are 
>>> guaranteed
>>> to fit the region into a 32-bit unsigned long. AFAIR virtualization 
>>> and LPAE
>>> are indistinguishable on real CPUs?
>>>
>> Agree with the idea. But can a single 4kB be used for multiple shmem 
>> across
>> VMs ? IIUC the hypervisor can deal with that, so I prefer it if it is 
>> possible
>> practically.
> We have multiple VMs and each VM has multiple instances. We will have 
> quite a few domains and I am not sure if single page will suffice.

I did not make myself clear enough, you can encode an offset into the 
shared memory area, and however big that shared memory area will be, 
that offset can be in a 4KB size. So for instance if you have your MMIO 
SRAM at 0x8000_0000, the first VM can use 0x8000_0ffff, the second VM 
can use 0x8000_1000 to 0x8000_1fff and so on and so forth.

Even if you need more than 4KB per VM, you can put that information into 
the two additional parameters you pass through the SMC/HVC call.
-- 
Florian

