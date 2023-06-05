Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEBD572305F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 21:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236162AbjFETvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 15:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236101AbjFETvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 15:51:07 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9F8120
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 12:50:32 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-33b0cae115bso25213475ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 12:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685994620; x=1688586620;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=82nuFTgvyuCdNMh4cUoNyR7h+q8YBDGZLD/ENpdarFg=;
        b=r4bX/8q+XyFRAkjC/h/ZbQa49tzc2xVhtuvXPHNeiHJewTl0iNVmKG0qujmpJ2GVIG
         qkGZzWnAsCIccXyC5vQIw+KYeH1s7+4AusZLnXLAHTrcZgpSEhr0GTY++gbKjVS3Kw6A
         UZx8qAFdxPWnfkDEGvtF9ObWmMeHGCZU/fHv1pI8kqkI0WZL6vrcD75nrLgjkKT+O7Qj
         hK77F1zVl4dT9qo6G7x4lLP6oLLbUnD5Eblsr9hZX1m5D4N4hbahvX7eVIGH3GHH+YOR
         X1XRqWYgvLdByhxKPXSMjSnOu8WBo5ph8doQcB05nrOYTHtP3P+KtipdMxYI1bPxL/E9
         AcYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685994620; x=1688586620;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=82nuFTgvyuCdNMh4cUoNyR7h+q8YBDGZLD/ENpdarFg=;
        b=jJWL3KZU+GcVV+AXBtaDPSqGjCW639PGmi0NlcP1DWopseqDIhwD8sz4ACTFvcoUjK
         AJlyMPSm1i7NomfMdwWPEAM19t/h+n8iL7FGY4lFq7xH2dhS/Q+iR8gNpN30Zz27w8VY
         cUaQUzcNw5motmgCsZ6nAYJkJyf4zxQyueIezjRCF3sc9yolOU05lWkaCOTsW06s6nk+
         B+vvU/h4Wsf5AuOg4zxj2JQ9U8tRK6OrE0tgsm5gPZq0LSThWjGphjHER0FCw6nLkpk5
         Gz9L26Of5OlGYM6POJm2i1p/19/fwgcSlBHNf+lGQyXrtJjUwrmNfLd3GbUFjO7mDDPr
         jcgw==
X-Gm-Message-State: AC+VfDxzuJ1D2uUlcMlRaIaiu7Waqa5QXp0s3rJv2p0NRfoZ6CmuOz+D
        SdgmPBwQSMUAVntJsdC92NDr0g==
X-Google-Smtp-Source: ACHHUZ7+ZCb+ovtXIbVzGp6Om4MnYS49lhb5mIsXXqx34BOZuyxfpK4Ybvbum9H0Cv9Lf3Espah3TA==
X-Received: by 2002:a92:4a02:0:b0:33b:6cc0:ee6b with SMTP id m2-20020a924a02000000b0033b6cc0ee6bmr55690ilf.13.1685994620037;
        Mon, 05 Jun 2023 12:50:20 -0700 (PDT)
Received: from [172.22.22.28] ([98.61.227.136])
        by smtp.gmail.com with ESMTPSA id x12-20020a92060c000000b003350061b57csm2520290ilg.81.2023.06.05.12.50.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 12:50:19 -0700 (PDT)
Message-ID: <b70e18a6-551c-a7bc-32cf-8a8ae06bb993@linaro.org>
Date:   Mon, 5 Jun 2023 14:50:18 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From:   Alex Elder <elder@linaro.org>
Subject: Re: [PATCH v13 20/24] virt: gunyah: Add proxy-scheduled vCPUs
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
References: <20230509204801.2824351-1-quic_eberman@quicinc.com>
 <20230509204801.2824351-21-quic_eberman@quicinc.com>
Content-Language: en-US
In-Reply-To: <20230509204801.2824351-21-quic_eberman@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/9/23 3:47 PM, Elliot Berman wrote:
> Gunyah allows host virtual machines to schedule guest virtual machines
> and handle their MMIO accesses. vCPUs are presented to the host as a
> Gunyah resource and represented to userspace as a Gunyah VM function.
> 
> Creating the vcpu VM function will create a file descriptor that:
>   - can run an ioctl: GH_VCPU_RUN to schedule the guest vCPU until the
>     next interrupt occurs on the host or when the guest vCPU can no
>     longer be run.
>   - can be mmap'd to share a gh_vcpu_run structure which can look up the
>     reason why GH_VCPU_RUN returned and provide return values for MMIO
>     access.
> 
> Co-developed-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
> Signed-off-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>

To be honest I have spent less time immersed in the VCPU stuff
than I would like.

I have looked through this patch today, though, and with the
exception of a typo I point out, it looks generally good to me.

For now I'm going to give you this; I might take a closer look
at a future date when you have updated your code.

Acked-by: Alex Elder <elder@linaro.org>

> ---
>   Documentation/virt/gunyah/vm-manager.rst |  46 ++-
>   arch/arm64/gunyah/gunyah_hypercall.c     |  28 ++
>   drivers/virt/gunyah/Kconfig              |  11 +
>   drivers/virt/gunyah/Makefile             |   2 +
>   drivers/virt/gunyah/gunyah_vcpu.c        | 468 +++++++++++++++++++++++
>   drivers/virt/gunyah/vm_mgr.c             |   4 +
>   drivers/virt/gunyah/vm_mgr.h             |   1 +
>   include/linux/gunyah.h                   |  24 ++
>   include/uapi/linux/gunyah.h              | 128 +++++++
>   9 files changed, 710 insertions(+), 2 deletions(-)
>   create mode 100644 drivers/virt/gunyah/gunyah_vcpu.c
> 
> diff --git a/Documentation/virt/gunyah/vm-manager.rst b/Documentation/virt/gunyah/vm-manager.rst
> index 3b51bab9d793..6789d13fed14 100644
> --- a/Documentation/virt/gunyah/vm-manager.rst
> +++ b/Documentation/virt/gunyah/vm-manager.rst
> @@ -5,8 +5,7 @@ Virtual Machine Manager
>   =======================
>   
>   The Gunyah Virtual Machine Manager is a Linux driver to support launching
> -virtual machines using Gunyah. It presently supports launching non-proxy
> -scheduled Linux-like virtual machines.
> +virtual machines using Gunyah.
>   
>   Except for some basic information about the location of initial binaries,
>   most of the configuration about a Gunyah virtual machine is described in the
> @@ -98,3 +97,46 @@ GH_VM_START
>   ~~~~~~~~~~~
>   
>   This ioctl starts the VM.
> +
> +GH_VM_ADD_FUNCTION
> +~~~~~~~~~~~~~~~~~~
> +
> +This ioctl registers a Gunyah VM function with the VM manager. The VM function
> +is described with a &struct gh_fn_desc.type and some arguments for that type.
> +Typically, the function is added before the VM starts, but the function doesn't
> +"operate" until the VM starts with `GH_VM_START`_. For example, vCPU ioclts will

s/ioclts/ioctls/

> +all return an error until the VM starts because the vCPUs don't exist until the
> +VM is started. This allows the VMM to set up all the kernel functions needed for
> +the VM *before* the VM starts.
> +
> +.. kernel-doc:: include/uapi/linux/gunyah.h
> +   :identifiers: gh_fn_desc gh_fn_type
> +

. . .

