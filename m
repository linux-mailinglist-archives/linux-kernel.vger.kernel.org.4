Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5B7A6A05A0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 11:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233442AbjBWKI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 05:08:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232770AbjBWKIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 05:08:21 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B990C3E626
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 02:08:19 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id v3so10146932wrp.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 02:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ke8WHbWbibLsbnlIUAcRsivd2zh5bMURpmVkDLNCRTA=;
        b=uba7o7Jg1KA7oyMYTf0OLZkRwcNWMvkP3Zj7XO4KX04gKPLy/tASYW4IRzbtzhXGWq
         TYQl85jZQOb4Xit26KOcYe3HZNKdSbz3vXME99qUEwhQzgT+/V/h+ol6wE/uy76g/A9n
         gg8njB1qiUpoF4y/szyrlDe79INq81lCXY8H6TWVaJPIn8NEwUqAfUM0fRWf7vpXMXhI
         8muXTRFRthitLup80kGv3BliJeOW1F0QykuX9xNoCiugoGh7m2Sg2uF8+rf8iE95j2+r
         SxXuJyY4CXx6SDZSxA93KzGxTm6q7wHg42HDySuOe+62YF3O+qdrI4y10m7hyVhwKEdd
         d6dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ke8WHbWbibLsbnlIUAcRsivd2zh5bMURpmVkDLNCRTA=;
        b=llCI2EewL1KDTIMzEPNefztBPJi76oEShpDs2TDMd4xOLwHJ20R31wRIKSESv3IVKd
         f7P5Vy2ebqWNER5/TLNyPe+uYGSbNb/rLqO9bSzMAid4zE1boH5KuKqpdSFrhszIFOrr
         Pl1xJG/Gn1LKtoPMBi0CyJ/cuekystyncKAgOIWgzXHwcL1PNd5ONCFKvP8d0iNCEbmv
         lA6ZK0MuNU9cOdadwJlA1MpVZ9IKvsM7ciUYZKd5JAPvnRctTlhd/Cd2QfL4qRu+O4DY
         N6oXG55fMUJ0jSoHoeeVsah6ElIjgq0BWsJjycK6baRzy9NwnVukm0NPHf8zX9k7kS/F
         Jt6w==
X-Gm-Message-State: AO0yUKVVcqWPFBJypp1nQchxzFiGxR/RSHcHMFPsqho2CmZifLw4AmnE
        HOY3iOB2EtmVfPtIgJ7Dy7GmEQ==
X-Google-Smtp-Source: AK7set+BmbDbbKdIgNkTo9b/21mFB9dSkAXvOQRmHhE57X21GtBLl0p5WYTibYejrPnS+kiL9rLumA==
X-Received: by 2002:a5d:58ea:0:b0:2c7:d56:7d72 with SMTP id f10-20020a5d58ea000000b002c70d567d72mr3411917wrd.19.1677146898154;
        Thu, 23 Feb 2023 02:08:18 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id a8-20020adfed08000000b002c55cdb1de5sm9387495wro.116.2023.02.23.02.08.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 02:08:17 -0800 (PST)
Message-ID: <52d944b1-3ea6-26b7-766a-2fed05dccf3a@linaro.org>
Date:   Thu, 23 Feb 2023 10:08:14 +0000
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
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <05c4aab8-2d26-b944-adb6-624d67e4a11d@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/02/2023 00:27, Elliot Berman wrote:
> 
>>> +    .llseek = noop_llseek,
>>> +};
>>> +
>>> +static long gh_dev_ioctl_create_vm(struct gh_rm *rm, unsigned long arg)
>> Not sure what is the gain of this multiple levels of redirection.
>>
>> How about
>>
>> long gh_dev_create_vm(struct gh_rm *rm, unsigned long arg)
>> {
>> ...
>> }
>>
>> and rsc_mgr just call it as part of its ioctl call
>>
>> static long gh_dev_ioctl(struct file *filp, unsigned int cmd, unsigned 
>> long arg)
>> {
>>      struct miscdevice *miscdev = filp->private_data;
>>      struct gh_rm *rm = container_of(miscdev, struct gh_rm, miscdev);
>>
>>      switch (cmd) {
>>      case GH_CREATE_VM:
>>          return gh_dev_create_vm(rm, arg);
>>      default:
>>          return -ENOIOCTLCMD;
>>      }
>> }
>>
> 
> I'm anticipating we will add further /dev/gunyah ioctls and I thought it 
> would be cleaner to have all that in vm_mgr.c itself.
> 
>>
>>> +{
>>> +    struct gh_vm *ghvm;
>>> +    struct file *file;
>>> +    int fd, err;
>>> +
>>> +    /* arg reserved for future use. */
>>> +    if (arg)
>>> +        return -EINVAL;
>>
>> The only code path I see here is via GH_CREATE_VM ioctl which 
>> obviously does not take any arguments, so if you are thinking of using 
>> the argument for architecture-specific VM flags.  Then this needs to 
>> be properly done by making the ABI aware of this.
> 
> It is documented in Patch 17 (Document Gunyah VM Manager)
> 
> +GH_CREATE_VM
> +~~~~~~~~~~~~
> +
> +Creates a Gunyah VM. The argument is reserved for future use and must 
> be 0.
> 
But this conficts with the UAPIs that have been defined. GH_CREATE_VM 
itself is defined to take no parameters.

#define GH_CREATE_VM                    _IO(GH_IOCTL_TYPE, 0x0)

so where are you expecting the argument to come from?

>>
>> As you mentioned zero value arg imply an "unauthenticated VM" type, 
>> but this was not properly encoded in the userspace ABI. Why not make 
>> it future compatible. How about adding arguments to GH_CREATE_VM and 
>> pass the required information correctly.
>> Note that once the ABI is accepted then you will not be able to change 
>> it, other than adding a new one.
>>
> 
> Does this means adding #define GH_VM_DEFAULT_ARG 0 ? I am not sure yet 
> what arguments to add here.
> 
> The ABI can add new "long" values to GH_CREATE_VM and that wouldn't 

Sorry, that is exactly what we want to avoid, we can not change the UAPI 
its going to break the userspace.

> break compatibility with old kernels; old kernels reject it as -EINVAL.

If you have userspace built with older kernel headers then that will 
break. Am not sure about old-kernels.

What exactly is the argument that you want to add to GH_CREATE_VM?

If you want to keep GH_CREATE_VM with no arguments that is fine but 
remove the conflicting comments in the code and document so that its not 
misleading readers/reviewers that the UAPI is going to be modified in 
near future.


> 
>>> +
>>> +    ghvm = gh_vm_alloc(rm);
>>> +    if (IS_ERR(ghvm))
>>> +        return PTR_ERR(ghvm);
>>> +
>>> +    fd = get_unused_fd_flags(O_CLOEXEC);
>>> +    if (fd < 0) {
>>> +        err = fd;
>>> +        goto err_destroy_vm;
>>> +    }
>>> +
>>> +    file = anon_inode_getfile("gunyah-vm", &gh_vm_fops, ghvm, O_RDWR);
>>> +    if (IS_ERR(file)) {
>>> +        err = PTR_ERR(file);
>>> +        goto err_put_fd;
>>> +    }
>>> +
>>> +    fd_install(fd, file);
>>> +
>>> +    return fd;
>>> +
>>> +err_put_fd:
>>> +    put_unused_fd(fd);
>>> +err_destroy_vm:
>>> +    kfree(ghvm);
>>> +    return err;
>>> +}
>>> +
>>> +long gh_dev_vm_mgr_ioctl(struct gh_rm *rm, unsigned int cmd, 
>>> unsigned long arg)
>>> +{
>>> +    switch (cmd) {
>>> +    case GH_CREATE_VM:
>>> +        return gh_dev_ioctl_create_vm(rm, arg);
>>> +    default:
>>> +        return -ENOIOCTLCMD;
>>> +    }
>>> +}
>>> diff --git a/drivers/virt/gunyah/vm_mgr.h b/drivers/virt/gunyah/vm_mgr.h
>>> new file mode 100644
>>> index 000000000000..76954da706e9
>>> --- /dev/null
>>> +++ b/drivers/virt/gunyah/vm_mgr.h
>>> @@ -0,0 +1,22 @@
>>> +/* SPDX-License-Identifier: GPL-2.0-only */
>>> +/*
>>> + * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All 
>>> rights reserved.
>>> + */
>>> +
>>> +#ifndef _GH_PRIV_VM_MGR_H
>>> +#define _GH_PRIV_VM_MGR_H
>>> +
>>> +#include <linux/gunyah_rsc_mgr.h>
>>> +
>>> +#include <uapi/linux/gunyah.h>
>>> +
>>> +long gh_dev_vm_mgr_ioctl(struct gh_rm *rm, unsigned int cmd, 
>>> unsigned long arg);
>>> +
>>> +struct gh_vm {
>>> +    u16 vmid;
>>> +    struct gh_rm *rm;
>>> +
>>> +    struct work_struct free_work;
>>> +};
>>> +
>>> +#endif
>>> diff --git a/include/uapi/linux/gunyah.h b/include/uapi/linux/gunyah.h
>>> new file mode 100644
>>> index 000000000000..10ba32d2b0a6
>>> --- /dev/null
>>> +++ b/include/uapi/linux/gunyah.h
>>> @@ -0,0 +1,23 @@
>>> +/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
>>> +/*
>>> + * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All 
>>> rights reserved.
>>> + */
>>> +
>>> +#ifndef _UAPI_LINUX_GUNYAH
>>> +#define _UAPI_LINUX_GUNYAH
>>> +
>>> +/*
>>> + * Userspace interface for /dev/gunyah - gunyah based virtual machine
>>> + */
>>> +
>>> +#include <linux/types.h>
>>> +#include <linux/ioctl.h>
>>> +
>>> +#define GH_IOCTL_TYPE            'G'
>>> +
>>> +/*
>>> + * ioctls for /dev/gunyah fds:
>>> + */
>>> +#define GH_CREATE_VM            _IO(GH_IOCTL_TYPE, 0x0) /* Returns a 
>>> Gunyah VM fd */
>>
>> Can HLOS forcefully destroy a VM?
>> If so should we have a corresponding DESTROY IOCTL?
> 
> It can forcefully destroy unauthenticated and protected virtual 
> machines. I don't have a userspace usecase for a DESTROY ioctl yet, 
> maybe this can be added later? By the way, the VM is forcefully 
that should be fine, but its also nice to add it for completeness, but 
not a compulsory atm

> destroyed when VM refcount is dropped to 0 (close(vm_fd) and any other 
> relevant file descriptors).
I have noticed that path.

--srini
> 
> - Elliot
