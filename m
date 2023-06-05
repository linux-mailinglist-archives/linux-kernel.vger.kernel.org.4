Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D088723052
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 21:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235962AbjFETue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 15:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236117AbjFETuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 15:50:12 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D769F11C
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 12:49:51 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-777b2af1c53so78494239f.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 12:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685994590; x=1688586590;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cPlOjdlJ+dRPlBsswQpKMNmBPkhakhRaFVQ24sk5p48=;
        b=JfzQ4nFnxsDVVweSWRoSCcbfNulBTZT6AhFmi+GrblhAGn6SN9IyYc1Q9647sBsTVt
         5A3awQZoHTqt1RX1Wg/y+Yu5XoboQeFoAv4LZioXXGarpJ3XdGzj7V6x39toEaKe8xkx
         6T3rYZJWRHRKK/zrkJiuek556swCuPgBjcUlI0Md80mOQH8krj0JjbqziCLt8/YlhiDA
         td0e8yBRJMDomz+I7kuMIPsDBI+l+TP50udtaxGjpIxFrQNKRoYfB5uJRSACckH6tOe0
         gxcqJIritft3hxsvAafmv0YyHrlZ0xGc0lB1nGxGXYRgxFj3NFUKTSqr+2YeLNQnzR9f
         SdVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685994590; x=1688586590;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cPlOjdlJ+dRPlBsswQpKMNmBPkhakhRaFVQ24sk5p48=;
        b=iKQbDUZu1UM7XauSjDVduTDegVTif5rDEBKymaJAOK3KthDvtvIpgjVMfZ7zzvOZ2R
         zJJvU5Dhah4z1jqiLq3vWEdOqVspvMBhB4PR2l1roX+dlppY8eR5Y9LbKkyq9ul9LmNf
         ZoEIFebVfr4JB4QiuEehiy4ASwVqt1ZwUtHbdWAJXIQGW9lTK8+TnJZB7qPxcHoIewv1
         T6MYFdF4FJERIQ5r7hklLdM7fN2cEyWajRxvNpg8FOrZSQxCMSvtqEvHxr8Xwk/JQ+ii
         2pBbPTpb1UgYAjK3p6Ibo383JRrsaGM5zTgzoh5HrrhAJcuUK0k3N5ZRYTXaGDb625FB
         xKWQ==
X-Gm-Message-State: AC+VfDwgfmtCOJJmto3F3KUppqNtLIv42TA2dWHmfLX9q14kAjMy14XV
        d3gJFmE3btdqakkosPY96yIOlg==
X-Google-Smtp-Source: ACHHUZ6BgjxdZJaa9/9OIGfA+S4eoi5nWLa5slc+tS1TwE8UHFlKzkebBHIbP9/q7lYMkcbpshec8g==
X-Received: by 2002:a5e:d710:0:b0:774:9c64:e0a4 with SMTP id v16-20020a5ed710000000b007749c64e0a4mr287414iom.4.1685994590054;
        Mon, 05 Jun 2023 12:49:50 -0700 (PDT)
Received: from [172.22.22.28] ([98.61.227.136])
        by smtp.gmail.com with ESMTPSA id l22-20020a6bd116000000b0076c81bf2731sm2735824iob.20.2023.06.05.12.49.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 12:49:49 -0700 (PDT)
Message-ID: <3dd82ec0-2a9a-3401-5385-965c624f9f32@linaro.org>
Date:   Mon, 5 Jun 2023 14:49:48 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From:   Alex Elder <elder@linaro.org>
Subject: Re: [PATCH v13 17/24] gunyah: vm_mgr: Add framework for VM Functions
To:     Elliot Berman <quic_eberman@quicinc.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Jonathan Corbet <corbet@lwn.net>
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
        Will Deacon <will@kernel.org>, Andy Gross <agross@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230509204801.2824351-1-quic_eberman@quicinc.com>
 <20230509204801.2824351-18-quic_eberman@quicinc.com>
Content-Language: en-US
In-Reply-To: <20230509204801.2824351-18-quic_eberman@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/9/23 3:47 PM, Elliot Berman wrote:
> Introduce a framework for Gunyah userspace to install VM functions. VM
> functions are optional interfaces to the virtual machine. vCPUs,
> ioeventfs, and irqfds are examples of such VM functions and are

s/ioventfs/ioventfds/

Also, these aren't just examples of VM functions, they *are* the
VM functions implemented.

> implemented in subsequent patches.
> 
> A generic framework is implemented instead of individual ioctls to
> create vCPUs, irqfds, etc., in order to simplify the VM manager core
> implementation and allow dynamic loading of VM function modules.

This also allows the set of VM functions to be extended without
updating the API (like it or not).

> 
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>

I have a few more comments, but this looks pretty good.

Reviewed-by: Alex Elder <elder@linaro.org>

> ---
>   Documentation/virt/gunyah/vm-manager.rst |  18 ++
>   drivers/virt/gunyah/vm_mgr.c             | 216 ++++++++++++++++++++++-
>   drivers/virt/gunyah/vm_mgr.h             |   4 +
>   include/linux/gunyah_vm_mgr.h            |  87 +++++++++
>   include/uapi/linux/gunyah.h              |  18 ++
>   5 files changed, 340 insertions(+), 3 deletions(-)
>   create mode 100644 include/linux/gunyah_vm_mgr.h
> 
> diff --git a/Documentation/virt/gunyah/vm-manager.rst b/Documentation/virt/gunyah/vm-manager.rst
> index 50d8ae7fabcd..3b51bab9d793 100644
> --- a/Documentation/virt/gunyah/vm-manager.rst
> +++ b/Documentation/virt/gunyah/vm-manager.rst
> @@ -17,6 +17,24 @@ sharing userspace memory with a VM is done via the `GH_VM_SET_USER_MEM_REGION`_
>   ioctl. The VM itself is configured to use the memory region via the
>   devicetree.
>   
> +Gunyah Functions
> +================
> +
> +Components of a Gunyah VM's configuration that need kernel configuration are
> +called "functions" and are built on top of a framework. Functions are identified
> +by a string and have some argument(s) to configure them. They are typically
> +created by the `GH_VM_ADD_FUNCTION`_ ioctl.

Is a function *type* (e.g., VCPU or ioeventfd) identified by a string?
Or a function *instance* (e.g. four VCPUs)?  Or both?

> +
> +Functions typically will always do at least one of these operations:

Typically, or always?

> +
> +1. Create resource ticket(s). Resource tickets allow a function to register
> +   itself as the client for a Gunyah resource (e.g. doorbell or vCPU) and
> +   the function is given the pointer to the &struct gh_resource when the
> +   VM is starting.
> +

What I think this means is that tickets are used to allow functions
to be defined *before* the VM is actually started.  So once it starts,
the functions get added.  (I might have this slightly wrong, but in
any case I'm not sure the above sentence is very clear.)

> +2. Register IO handler(s). IO handlers allow a function to handle stage-2 faults
> +   from the virtual machine.
> +
>   Sample Userspace VMM
>   ====================
>   
> diff --git a/drivers/virt/gunyah/vm_mgr.c b/drivers/virt/gunyah/vm_mgr.c
> index a800061f56bf..56464451b262 100644
> --- a/drivers/virt/gunyah/vm_mgr.c
> +++ b/drivers/virt/gunyah/vm_mgr.c
> @@ -6,10 +6,13 @@
>   #define pr_fmt(fmt) "gh_vm_mgr: " fmt
>   
>   #include <linux/anon_inodes.h>
> +#include <linux/compat.h>
>   #include <linux/file.h>
>   #include <linux/gunyah_rsc_mgr.h>
> +#include <linux/gunyah_vm_mgr.h>
>   #include <linux/miscdevice.h>
>   #include <linux/module.h>
> +#include <linux/xarray.h>
>   
>   #include <uapi/linux/gunyah.h>
>   
> @@ -17,6 +20,172 @@
>   
>   static void gh_vm_free(struct work_struct *work);
>   
> +static DEFINE_XARRAY(gh_vm_functions);
> +
> +static void gh_vm_put_function(struct gh_vm_function *fn)
> +{
> +	module_put(fn->mod);
> +}
> +
> +static struct gh_vm_function *gh_vm_get_function(u32 type)
> +{
> +	struct gh_vm_function *fn;
> +	int r;
> +
> +	fn = xa_load(&gh_vm_functions, type);
> +	if (!fn) {
> +		r = request_module("ghfunc:%d", type);
> +		if (r)
> +			return ERR_PTR(r > 0 ? -r : r);

Almost all callers of request_module() simply ignore the
return value.  What positive values are you expecting to
see here (and are you sure they're positive errno values)?

> +
> +		fn = xa_load(&gh_vm_functions, type);
> +	}
> +
> +	if (!fn || !try_module_get(fn->mod))
> +		fn = ERR_PTR(-ENOENT);
> +
> +	return fn;
> +}

. . .
