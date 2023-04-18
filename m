Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 019196E6423
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 14:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbjDRMq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 08:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbjDRMqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 08:46:24 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 779C014F42
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 05:46:22 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-32a7770f7d1so32155775ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 05:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681821982; x=1684413982;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aWKwSo+FXlLTrRAVOGN2C4OAabPij9dLF7fKxSc3DYk=;
        b=gj0HO7uJagRwA1ORIyOVM03tkZ2LBmCT36Agq63k77L3K78EOwVrZTuPbh7tlndYv7
         nmlmJ5bI2oONn377Mx+AJUbuuzAr3CpLV5i5/veAB0Lvxx50vMNQ6lXiY/6L8p4EDmYM
         cLiQntTWYCFTqU5kyus2jvXkJh85KiHzGnZQ8GWWpBPndXNN5HMCVXHh66TtGH2Ed1c6
         0CtcGVIhTP4gwmqIZNf2Wu1HNSznW/uGwPF387jaPfFSKQfjLqIAWEMVbJbC4I8e9k2c
         5Y2c5cpPV8HxCjA9kFgzox3XtqfHKcAf3BnvCj+vpikEJf5w5jc0XTLOV+gfgzBtAqzC
         bhsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681821982; x=1684413982;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aWKwSo+FXlLTrRAVOGN2C4OAabPij9dLF7fKxSc3DYk=;
        b=hiYjOs8IwUM+NPcnDNq65bLQHyGyDSgVra42ZihmYVKZdi6Urd7rJVTsX50HdgYmbw
         /jihH/LC3evvp7Zmb7mBqa7Q/vG2R5abRnU4+s8KoIiyle4WGhWHNhUcjURgcI5UtQ8A
         uJduIaMrrDmrtSTuBe1txwSL29GCleTCq5oH9FTbjWH70rZEgNeRL5cJ0GBh3jVaEPQh
         P8E0hQxNGpjtvD3OoA1oqlx0CjWp4xBepzR2K49+0m5v7khrTkVfPzaS4ld5UyiSae8c
         VH4dxudrVLXDW9K0xcNsTdYeFSYRkta6qy0EXSyyj4nzGcInEHhHxT3eeteq9GbQT46s
         DaHA==
X-Gm-Message-State: AAQBX9c1QyUDcv23k6zUw6q/fuNduV0ee2NkYqRxtrpxPieQx+4gALJD
        S1BU6NLrOgAqYk96Sr1LfoOdOw==
X-Google-Smtp-Source: AKy350YDR3JepDrmTcd6UZ6PhjUVBbJ1Yivi4q/MOQ+1Za4ZU3x+3g9nnsHtHlSdIEEVGv4sSIuhhg==
X-Received: by 2002:a05:6e02:10c7:b0:313:c32b:de26 with SMTP id s7-20020a056e0210c700b00313c32bde26mr11183052ilj.9.1681821981727;
        Tue, 18 Apr 2023 05:46:21 -0700 (PDT)
Received: from [172.22.22.4] ([98.61.227.136])
        by smtp.googlemail.com with ESMTPSA id p5-20020a027805000000b0040b64b68862sm2965285jac.165.2023.04.18.05.46.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 05:46:21 -0700 (PDT)
Message-ID: <7d97b0c3-9b0a-2e2f-13d9-b9969fd3c1d3@linaro.org>
Date:   Tue, 18 Apr 2023 07:46:19 -0500
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
From:   Alex Elder <elder@linaro.org>
In-Reply-To: <274ad221-f397-b634-5742-fe6c9cb18843@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/17/23 5:41 PM, Elliot Berman wrote:
> 
> 
> On 3/31/2023 7:27 AM, Alex Elder wrote:
>> On 3/3/23 7:06 PM, Elliot Berman wrote:
> 
> [snip]
> 
>>> diff --git a/include/uapi/linux/gunyah.h b/include/uapi/linux/gunyah.h
>>> index caeb3b3a3e9a..e52265fa5715 100644
>>> --- a/include/uapi/linux/gunyah.h
>>> +++ b/include/uapi/linux/gunyah.h
>>> @@ -62,8 +62,32 @@ struct gh_vm_dtb_config {
>>>   #define GH_VM_START        _IO(GH_IOCTL_TYPE, 0x3)
>>> +/**
>>> + * GH_FN_VCPU - create a vCPU instance to control a vCPU
>>> + *
>>> + * gh_fn_desc is filled with &struct gh_fn_vcpu_arg
>>> + *
>>> + * The vcpu type will register with the VM Manager to expect to control
>>> + * vCPU number `vcpu_id`. It returns a file descriptor allowing 
>>> interaction with
>>> + * the vCPU. See the Gunyah vCPU API description sections for 
>>> interacting with
>>> + * the Gunyah vCPU file descriptors.
>>> + *
>>> + * Return: file descriptor to manipulate the vcpu. See GH_VCPU_* ioctls
>>> + */
>>> +#define GH_FN_VCPU         1
>>
>> I think you should define GH_VN_VCPU, GN_FN_IRQFD, and GN_FN_IOEVENTFD
>> in an enumerated type.  Each has a type associated with it, and you can
>> add the explanation for the function in the kernel-doc comments above
>> thosse type definitions.
>>
> 
> I'd like to enumify the GH_FN_* macros, but one challenge I'm facing is 
> that it breaks the module alias implementation in patch 19.
> 
> MODULE_ALIAS("ghfunc:"__stringify(_type))
> 
> When the GH_FN_* are regular preprocessor macros backed by an integer, 
> the preprocessor will make the module alias ghfunc:0 (or ghfunc:1, etc). 
> This works well because I can do
> 
> request_module("ghfunc:%d", type);
> 
> If the function hasn't been registered and then gunyah_vcpu.ko gets 
> loaded automatically.
> 
> With enum, compiler knows the value of GH_FN_VCPU and preprocessor will 
> make the module alias like ghfunc:GH_FN_VCPU.
> 
> [snip]
> 
>>> +
>>> +/*
>>> + * Gunyah presently sends max 4 bytes of exit_reason.
>>> + * If that changes, this macro can be safely increased without breaking
>>> + * userspace so long as struct gh_vcpu_run < PAGE_SIZE.
>>
>> Is PAGE_SIZE allowed to be anything other than 4096 bytes?  Do you
>> expect this driver to work properly if the page size were configured
>> to be 16384 bytes?  In other words, is this a Gunyah constant, or
>> is it *really* the page size configured for Linux?
>>
> 
> Our implementations are only doing 4096 bytes. I expect the driver to 
> work properly when using 16k pages. This really is a Linux page. It's a 
> reflection of the alloc_page in gh_vcpu_bind().

OK.  I guess I'd be on the lookout for anything that uses 4096 when
PAGE_SIZE is what's actually meant.  I have no idea what's involved
with the hypervisor if you wanted to try something else, but if you
haven't tested that, you could maybe do an early check in your probe
function:
	BUILD_BUG_ON(PAGE_SIZE != 4096);

> The exit reason is copied from hypervisor into field accessible by 
> userspace directly. Gunyah makes the exit reason size dynamic -- there's 
> no architectural limitation preventing the exit reason from being a 
> string or some lengthy data.

Sounds good.  I like having statements like this tested, and maybe
you have.  I.e., test with the exit_reason size something like 16
bytes and ensure that works.  Testing this is not technically needed,
but your comment suggests it can be done.

> As I was writing this response, I realized that I should be able to make 
> this a zero-length array and ensure that reason[] doesn't overflow 
> PAGE_SIZE...

Maybe some good came out of it?

> The comment was trying to explain that Linux itself imposes a limitation 
> on the maximum exit reason size. If we need to support longer exit 

Your comment isn't clear that Linux is what limits the size.
This is all kind of picky though.  My main point was about
the PAGE_SIZE assumption.

					-Alex

> reason, we're OK to do so long as the total size doesn't overrun 
> PAGE_SIZE. There aren't any plans to need longer exit reasons than the 8 
> bytes mentioned today.
> 
> Thanks,
> Elliot

