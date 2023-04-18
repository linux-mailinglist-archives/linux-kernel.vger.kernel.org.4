Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8B76E6B19
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 19:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232471AbjDRRby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 13:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbjDRRbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 13:31:53 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D8A444BC
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 10:31:41 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-329560b1994so9234975ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 10:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681839100; x=1684431100;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9k0KlA+hC9mQYzLLiZ5dVKxFl+N0hiQWlGuF5vi97i8=;
        b=D0UTH6M5dPG4GgnOzVwriV2+NDKoKL5/kNLhforDESMG/u/ksIB3f7cC1digDNG9mU
         Izf684xxrUfjTIcBEWq1EPzj+oD3URl4Q9VYR76aOyGzWAf8rSEHXKSgZ04Nx6NWZRmR
         xG9FSdR8p8aQI4X1O79h7uPKHDn1PyZDGEr2AdT20Cdg5sO8QyHwd1B1FLybHM/mV8EP
         ClrboJIgXnZcv7nDBLgttva5rZiFQ1HzozyiP0OeCgEGqjeiLCGBX9KntluwpydwUoF6
         fUdvF32E5ZwOTLznXRkSfu0mouBh2z9yAqSre6X/7qK4p5EdhE2SyqEb8+XDMZmB959s
         6dRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681839100; x=1684431100;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9k0KlA+hC9mQYzLLiZ5dVKxFl+N0hiQWlGuF5vi97i8=;
        b=FqXpJlR0N1hsW8XsOe0gjn8r9IvSBOiEjKW7CJbG2suu2mos7TyR2WQBCbldRSRhJC
         lsthLmaMj7Bj683QcBoMAyCKTHJQqh82ptlLtHB7hD7S+sNuN0w8we0YMjT/pI8bfAQ0
         L/eLLF17wI22gL/1ezwe56DXuHEtEbKjTtng01rD/XyUQ5MtIY87zkzVYv4+RIOb5P0z
         tF4ZpaF6jAQD+LRtV2LUsYOmoS7nxRmQrp1/JMv05gMh3l2yek00hDu6hBKjMCMX/+9i
         RI11zb9bLYbQ/ugn6BzBItVY+SLDnT8oxkZGFPRD3TMz6prHo6ArPWjuCm4fgUODsebq
         w6RA==
X-Gm-Message-State: AAQBX9eIt17KeZku5gl9Rlo725TqSaTc9H+xaOqALocaBDsin/PkO4BP
        zWXweAQGtT8AK/ztv/o0+QO00w==
X-Google-Smtp-Source: AKy350bj62+BTyW/FZVEfhapjoRt6avqgBtoYaT9Dg6gSGxqEFMKPd6uK9VuSnelkdtpkTplCqBjqg==
X-Received: by 2002:a92:db4e:0:b0:328:6412:df13 with SMTP id w14-20020a92db4e000000b003286412df13mr10708471ilq.19.1681839100441;
        Tue, 18 Apr 2023 10:31:40 -0700 (PDT)
Received: from [172.22.22.4] ([98.61.227.136])
        by smtp.googlemail.com with ESMTPSA id t33-20020a05663834a100b0040fadb4f6d8sm1303211jal.81.2023.04.18.10.31.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 10:31:40 -0700 (PDT)
Message-ID: <1c69a301-332b-3523-caeb-5d838bb5f5d2@linaro.org>
Date:   Tue, 18 Apr 2023 12:31:38 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v11 22/26] virt: gunyah: Add proxy-scheduled vCPUs
Content-Language: en-US
To:     Elliot Berman <quic_eberman@quicinc.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230304010632.2127470-1-quic_eberman@quicinc.com>
 <20230304010632.2127470-23-quic_eberman@quicinc.com>
 <98ad146d-492d-aa0c-4f6a-ba37e6bf74eb@linaro.org>
 <274ad221-f397-b634-5742-fe6c9cb18843@quicinc.com>
 <6d7ddd2c-526c-a131-1012-c09032579824@quicinc.com>
From:   Alex Elder <elder@linaro.org>
In-Reply-To: <6d7ddd2c-526c-a131-1012-c09032579824@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/18/23 12:18 PM, Elliot Berman wrote:
> 
> 
> On 4/17/2023 3:41 PM, Elliot Berman wrote:
>>
>>
>> On 3/31/2023 7:27 AM, Alex Elder wrote:
>>> On 3/3/23 7:06 PM, Elliot Berman wrote:
>>
>> [snip]
>>
>>>> diff --git a/include/uapi/linux/gunyah.h b/include/uapi/linux/gunyah.h
>>>> index caeb3b3a3e9a..e52265fa5715 100644
>>>> --- a/include/uapi/linux/gunyah.h
>>>> +++ b/include/uapi/linux/gunyah.h
>>>> @@ -62,8 +62,32 @@ struct gh_vm_dtb_config {
>>>>   #define GH_VM_START        _IO(GH_IOCTL_TYPE, 0x3)
>>>> +/**
>>>> + * GH_FN_VCPU - create a vCPU instance to control a vCPU
>>>> + *
>>>> + * gh_fn_desc is filled with &struct gh_fn_vcpu_arg
>>>> + *
>>>> + * The vcpu type will register with the VM Manager to expect to 
>>>> control
>>>> + * vCPU number `vcpu_id`. It returns a file descriptor allowing 
>>>> interaction with
>>>> + * the vCPU. See the Gunyah vCPU API description sections for 
>>>> interacting with
>>>> + * the Gunyah vCPU file descriptors.
>>>> + *
>>>> + * Return: file descriptor to manipulate the vcpu. See GH_VCPU_* 
>>>> ioctls
>>>> + */
>>>> +#define GH_FN_VCPU         1
>>>
>>> I think you should define GH_VN_VCPU, GN_FN_IRQFD, and GN_FN_IOEVENTFD
>>> in an enumerated type.  Each has a type associated with it, and you can
>>> add the explanation for the function in the kernel-doc comments above
>>> thosse type definitions.
>>>
>>
>> I'd like to enumify the GH_FN_* macros, but one challenge I'm facing 
>> is that it breaks the module alias implementation in patch 19.
>>
>> MODULE_ALIAS("ghfunc:"__stringify(_type))
>>
>> When the GH_FN_* are regular preprocessor macros backed by an integer, 
>> the preprocessor will make the module alias ghfunc:0 (or ghfunc:1, 
>> etc). This works well because I can do
>>
>> request_module("ghfunc:%d", type);
>>
>> If the function hasn't been registered and then gunyah_vcpu.ko gets 
>> loaded automatically.
>>
>> With enum, compiler knows the value of GH_FN_VCPU and preprocessor 
>> will make the module alias like ghfunc:GH_FN_VCPU.
>>
> 
> I still like the idea of having enum for documentation and clarity. I 
> noticed that nfnetlink.h saw the same problem for NFNL_SUBSYS_*.
> 
> Is this compromise terrible and I should give up on the enum?

You know, I've seen this pattern in the kernel and never thought
too much about why it was done.  Maybe this is exactly the reason.

It sure *seems* like there might be some macro magic that might
cause the enum symbol's numeric value to be used but I think the
problem is that enums are C tokens, which are not evaluated at
preprocessor time.

You could probably skip the leading underscore, and do this as
it's done for nfnetlink_groups in that same header file.

Maybe somebody else can confirm, or has a better suggestion.

					-Alex


> enum gh_fn_type {
> /* _GH_FN_* macro required for MODULE_ALIAS, otherwise __stringify() trick
>   * won't work anymore */
> #define _GH_FN_VCPU        1
>      GH_FN_VCPU        = _GH_FN_VCPU,
> #define _GH_FN_IRQFD        2
>      GH_FN_IRQFD        = _GH_FN_IRQFD,
> #define _GH_FN_IOEVENTFD    3
>      GH_FN_IOEVENTFD        = _GH_FN_IOEVENTFD,
> };
> 
>> [snip]
>>
>>>> +
>>>> +/*
>>>> + * Gunyah presently sends max 4 bytes of exit_reason.
>>>> + * If that changes, this macro can be safely increased without 
>>>> breaking
>>>> + * userspace so long as struct gh_vcpu_run < PAGE_SIZE.
>>>
>>> Is PAGE_SIZE allowed to be anything other than 4096 bytes?  Do you
>>> expect this driver to work properly if the page size were configured
>>> to be 16384 bytes?  In other words, is this a Gunyah constant, or
>>> is it *really* the page size configured for Linux?
>>>
>>
>> Our implementations are only doing 4096 bytes. I expect the driver to 
>> work properly when using 16k pages. This really is a Linux page. It's 
>> a reflection of the alloc_page in gh_vcpu_bind().
>>
>> The exit reason is copied from hypervisor into field accessible by 
>> userspace directly. Gunyah makes the exit reason size dynamic -- 
>> there's no architectural limitation preventing the exit reason from 
>> being a string or some lengthy data.
>>
>> As I was writing this response, I realized that I should be able to 
>> make this a zero-length array and ensure that reason[] doesn't 
>> overflow PAGE_SIZE...
>>
>> The comment was trying to explain that Linux itself imposes a 
>> limitation on the maximum exit reason size. If we need to support 
>> longer exit reason, we're OK to do so long as the total size doesn't 
>> overrun PAGE_SIZE. There aren't any plans to need longer exit reasons 
>> than the 8 bytes mentioned today.
>>
>> Thanks,
>> Elliot

