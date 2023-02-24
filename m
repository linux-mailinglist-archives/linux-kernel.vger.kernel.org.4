Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE9F6A1A55
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 11:31:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjBXKbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 05:31:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbjBXKa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 05:30:58 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D0267990
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 02:30:25 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id d41-20020a05600c4c2900b003e9e066550fso1427743wmp.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 02:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6wxxz+sDh794uzv69vqKx5GNNub+zLdXfYsMvxxHBJ4=;
        b=ftm4FaeoP2zr5EYlxPFvlurlNxkZoU/u6gsYW0oFeC6dwiCYq7LzqS4DjcV6allT9l
         o/Zd+Pmt028rUJa2MyaU5OKEfubnqpL+UmCodhb+SdUnkYF5Fb/YnxjerOmIHjXoGRqw
         ESZRI42hZYoDZ0U3pi9wIWDp9PZQwRspsyZwRXQaWoqkfWjBLJUoVA2zZGWxS8BcV0BX
         qFwp7ZrtZwxGiSqybS1cdOPOJVED33eHxhSPYhV1+58yCHABO4rh2b65YXS15zu7GXJM
         YBvECCJThSbVQHkQ5bUcPR+98dfsIVcxn/0TuU1lJ/lil50PfGLT8Fw0csw+hYB8n9mr
         Uu9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6wxxz+sDh794uzv69vqKx5GNNub+zLdXfYsMvxxHBJ4=;
        b=FlG5Oj7ydGH+VjX/5cIQAHFt0WtSyzU2xTTkVkLGuAYf0XLeGlcF/lGkKsuhoW/wTb
         nQpA2m3d1Rbd9qVqJkUQzTkoIz+1C71a7Q72O+HRFTPWFzNZWNit52b0HxIyatL0P/tA
         yiJd0XNOYDpRX0g7Xx/oX3AE8QfiMX3Ngif3YVflV6RcK9h1Hg5/tWKRDW5ebHSoL25G
         c0gAgCdzf0J2MFAkhFhe/2p8AiYjVRz6bK+NLIMx6Dz4o+tl2vYpkP0hz1C6OpGS/ZG1
         kOp8jGpvPbCiR1AyNQZzf170i7MIl57Z4Uylf1zcQkJxnMagMAj3nPY5x3xU31e7tf5+
         J6Jg==
X-Gm-Message-State: AO0yUKW/Wq7TQr0qBT6eEEas052Hn1AoTRsocyrFfcYOKpH3UJm7CHLU
        RO0YNX8VwMvL7hXOtaUqUkhQ/A==
X-Google-Smtp-Source: AK7set+yKZPsTlp+cfnAvSBbyEIWpo7dQfPOGPoNPA8Ycci6zSnnqhHIygrGuXmhhimjWGXsjagJrw==
X-Received: by 2002:a05:600c:34cb:b0:3eb:a4e:a2b2 with SMTP id d11-20020a05600c34cb00b003eb0a4ea2b2mr1562593wmq.4.1677234588949;
        Fri, 24 Feb 2023 02:29:48 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id az35-20020a05600c602300b003eaf666cbe0sm2376659wmb.27.2023.02.24.02.29.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Feb 2023 02:29:48 -0800 (PST)
Message-ID: <a50fa44d-fbc3-9ce2-175b-85c8cd7a9f7f@linaro.org>
Date:   Fri, 24 Feb 2023 10:29:46 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v10 10/26] gunyah: vm_mgr: Introduce basic VM Manager
Content-Language: en-US
To:     Elliot Berman <quic_eberman@quicinc.com>,
        Alex Elder <elder@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
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
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230214211229.3239350-1-quic_eberman@quicinc.com>
 <20230214212356.3313181-1-quic_eberman@quicinc.com>
 <dbcfa4e9-a1ad-0f24-77bf-05934ca26bb2@linaro.org>
 <05c4aab8-2d26-b944-adb6-624d67e4a11d@quicinc.com>
 <52d944b1-3ea6-26b7-766a-2fed05dccf3a@linaro.org>
 <c5ff1523-7a62-3d3f-6fa9-792ce4d222e8@quicinc.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <c5ff1523-7a62-3d3f-6fa9-792ce4d222e8@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/02/2023 22:40, Elliot Berman wrote:
> 
> 
> On 2/23/2023 2:08 AM, Srinivas Kandagatla wrote:
>>
>>
>> On 22/02/2023 00:27, Elliot Berman wrote:
>>>
>>>>> +    .llseek = noop_llseek,
>>>>> +};
>>>>> +
>>>>> +static long gh_dev_ioctl_create_vm(struct gh_rm *rm, unsigned long 
>>>>> arg)
>>>> Not sure what is the gain of this multiple levels of redirection.
>>>>
>>>> How about
>>>>
>>>> long gh_dev_create_vm(struct gh_rm *rm, unsigned long arg)
>>>> {
>>>> ...
>>>> }
>>>>
>>>> and rsc_mgr just call it as part of its ioctl call
>>>>
>>>> static long gh_dev_ioctl(struct file *filp, unsigned int cmd, 
>>>> unsigned long arg)
>>>> {
>>>>      struct miscdevice *miscdev = filp->private_data;
>>>>      struct gh_rm *rm = container_of(miscdev, struct gh_rm, miscdev);
>>>>
>>>>      switch (cmd) {
>>>>      case GH_CREATE_VM:
>>>>          return gh_dev_create_vm(rm, arg);
>>>>      default:
>>>>          return -ENOIOCTLCMD;
>>>>      }
>>>> }
>>>>
>>>
>>> I'm anticipating we will add further /dev/gunyah ioctls and I thought 
>>> it would be cleaner to have all that in vm_mgr.c itself.
>>>
>>>>
>>>>> +{
>>>>> +    struct gh_vm *ghvm;
>>>>> +    struct file *file;
>>>>> +    int fd, err;
>>>>> +
>>>>> +    /* arg reserved for future use. */
>>>>> +    if (arg)
>>>>> +        return -EINVAL;
>>>>
>>>> The only code path I see here is via GH_CREATE_VM ioctl which 
>>>> obviously does not take any arguments, so if you are thinking of 
>>>> using the argument for architecture-specific VM flags.  Then this 
>>>> needs to be properly done by making the ABI aware of this.
>>>
>>> It is documented in Patch 17 (Document Gunyah VM Manager)
>>>
>>> +GH_CREATE_VM
>>> +~~~~~~~~~~~~
>>> +
>>> +Creates a Gunyah VM. The argument is reserved for future use and 
>>> must be 0.
>>>
>> But this conficts with the UAPIs that have been defined. GH_CREATE_VM 
>> itself is defined to take no parameters.
>>
>> #define GH_CREATE_VM                    _IO(GH_IOCTL_TYPE, 0x0)
>>
>> so where are you expecting the argument to come from?
>>  >>>
>>>> As you mentioned zero value arg imply an "unauthenticated VM" type, 
>>>> but this was not properly encoded in the userspace ABI. Why not make 
>>>> it future compatible. How about adding arguments to GH_CREATE_VM and 
>>>> pass the required information correctly.
>>>> Note that once the ABI is accepted then you will not be able to 
>>>> change it, other than adding a new one.
>>>>
>>>
>>> Does this means adding #define GH_VM_DEFAULT_ARG 0 ? I am not sure 
>>> yet what arguments to add here.
>>>
>>> The ABI can add new "long" values to GH_CREATE_VM and that wouldn't 
>>
>> Sorry, that is exactly what we want to avoid, we can not change the 
>> UAPI its going to break the userspace.
>>
>>> break compatibility with old kernels; old kernels reject it as -EINVAL.
>>
>> If you have userspace built with older kernel headers then that will 
>> break. Am not sure about old-kernels.
>>
>> What exactly is the argument that you want to add to GH_CREATE_VM?
>>
>> If you want to keep GH_CREATE_VM with no arguments that is fine but 
>> remove the conflicting comments in the code and document so that its 
>> not misleading readers/reviewers that the UAPI is going to be modified 
>> in near future.
>>
>>
> 
> The convention followed here comes from KVM_CREATE_VM. Is this ioctl 
> considered bad example?
> 

It is recommended to only use _IO for commands without arguments, and 
use pointers for passing data. Even though _IO can indicate either 
commands with no argument or passing an integer value instead of a 
pointer. Am really not sure how this works in compat case.

Am sure there are tricks that can be done with just using _IO() macro 
(ex vfio), but this does not mean that we should not use _IOW to be more 
explicit on the type and size of argument that we are expecting.

On the other hand If its really not possible to change this IOCTL to 
_IOW and argument that you are referring would be with in integer range, 
then what you have with _IO macro should work.

--srini

>>>
>>>>> +
>>>>> +    ghvm = gh_vm_alloc(rm);
>>>>> +    if (IS_ERR(ghvm))
>>>>> +        return PTR_ERR(ghvm);
>>>>> +
>>>>> +    fd = get_unused_fd_flags(O_CLOEXEC);
>>>>> +    if (fd < 0) {
>>>>> +        err = fd;
>>>>> +        goto err_destroy_vm;
>>>>> +    }
>>>>> +
>>>>> +    file = anon_inode_getfile("gunyah-vm", &gh_vm_fops, ghvm, 
>>>>> O_RDWR);
>>>>> +    if (IS_ERR(file)) {
>>>>> +        err = PTR_ERR(file);
>>>>> +        goto err_put_fd;
>>>>> +    }
>>>>> +
>>>>> +    fd_install(fd, file);
>>>>> +
>>>>> +    return fd;
>>>>> +
>>>>> +err_put_fd:
>>>>> +    put_unused_fd(fd);
>>>>> +err_destroy_vm:
>>>>> +    kfree(ghvm);
>>>>> +    return err;
>>>>> +}
>>>>> +
>>>>> +long gh_dev_vm_mgr_ioctl(struct gh_rm *rm, unsigned int cmd, 
>>>>> unsigned long arg)
>>>>> +{
>>>>> +    switch (cmd) {
>>>>> +    case GH_CREATE_VM:
>>>>> +        return gh_dev_ioctl_create_vm(rm, arg);
>>>>> +    default:
>>>>> +        return -ENOIOCTLCMD;
>>>>> +    }
>>>>> +}
>>>>> diff --git a/drivers/virt/gunyah/vm_mgr.h 
>>>>> b/drivers/virt/gunyah/vm_mgr.h
>>>>> new file mode 100644
>>>>> index 000000000000..76954da706e9
>>>>> --- /dev/null
>>>>> +++ b/drivers/virt/gunyah/vm_mgr.h
>>>>> @@ -0,0 +1,22 @@
>>>>> +/* SPDX-License-Identifier: GPL-2.0-only */
>>>>> +/*
>>>>> + * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All 
>>>>> rights reserved.
>>>>> + */
>>>>> +
>>>>> +#ifndef _GH_PRIV_VM_MGR_H
>>>>> +#define _GH_PRIV_VM_MGR_H
>>>>> +
>>>>> +#include <linux/gunyah_rsc_mgr.h>
>>>>> +
>>>>> +#include <uapi/linux/gunyah.h>
>>>>> +
>>>>> +long gh_dev_vm_mgr_ioctl(struct gh_rm *rm, unsigned int cmd, 
>>>>> unsigned long arg);
>>>>> +
>>>>> +struct gh_vm {
>>>>> +    u16 vmid;
>>>>> +    struct gh_rm *rm;
>>>>> +
>>>>> +    struct work_struct free_work;
>>>>> +};
>>>>> +
>>>>> +#endif
>>>>> diff --git a/include/uapi/linux/gunyah.h b/include/uapi/linux/gunyah.h
>>>>> new file mode 100644
>>>>> index 000000000000..10ba32d2b0a6
>>>>> --- /dev/null
>>>>> +++ b/include/uapi/linux/gunyah.h
>>>>> @@ -0,0 +1,23 @@
>>>>> +/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
>>>>> +/*
>>>>> + * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All 
>>>>> rights reserved.
>>>>> + */
>>>>> +
>>>>> +#ifndef _UAPI_LINUX_GUNYAH
>>>>> +#define _UAPI_LINUX_GUNYAH
>>>>> +
>>>>> +/*
>>>>> + * Userspace interface for /dev/gunyah - gunyah based virtual machine
>>>>> + */
>>>>> +
>>>>> +#include <linux/types.h>
>>>>> +#include <linux/ioctl.h>
>>>>> +
>>>>> +#define GH_IOCTL_TYPE            'G'
>>>>> +
>>>>> +/*
>>>>> + * ioctls for /dev/gunyah fds:
>>>>> + */
>>>>> +#define GH_CREATE_VM            _IO(GH_IOCTL_TYPE, 0x0) /* Returns 
>>>>> a Gunyah VM fd */
>>>>
>>>> Can HLOS forcefully destroy a VM?
>>>> If so should we have a corresponding DESTROY IOCTL?
>>>
>>> It can forcefully destroy unauthenticated and protected virtual 
>>> machines. I don't have a userspace usecase for a DESTROY ioctl yet, 
>>> maybe this can be added later? By the way, the VM is forcefully 
>> that should be fine, but its also nice to add it for completeness, but 
>> not a compulsory atm
>>
>>> destroyed when VM refcount is dropped to 0 (close(vm_fd) and any 
>>> other relevant file descriptors).
>> I have noticed that path.
>>
>> --srini
>>>
>>> - Elliot
