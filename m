Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA3F968DBEE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 15:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbjBGOoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 09:44:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231621AbjBGOnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 09:43:53 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E38F7113EA
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 06:43:16 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id n28-20020a05600c3b9c00b003ddca7a2bcbso11641624wms.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 06:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9eJcdK33kbMuH5ai6iARWjcmTl9tVJH21z5yGLcInUU=;
        b=UmfVVlx/ec2e2TXm9nQZS1e+zH7HH7qFD+ddEwhe5DwqYg4jQobWm9RgiIPyFmo3m0
         OIoOzBxo2gw8kVXBhOgDZRyksHsXsC9urdtJ+PxvOCmh1jzoW1UycacPUumjLNRto4RA
         gPFGvn1xb4uMTMie6dKOxF5drUo34owcecAXZMurZOdze6RUsjowP1+ZbgM6MUkIu6XF
         XY15EUSDhULDaRGyn1MYg7B7gw164na7Glt3B7uaPLphYBUwbk6TSC37RyNowPZFIrXj
         645JfxQOV1tsN3ou8f7VUquWB95MgfvjbyqXf6nDdrB3T8xD30PXeUpe1PwoERfGWFOB
         7CQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9eJcdK33kbMuH5ai6iARWjcmTl9tVJH21z5yGLcInUU=;
        b=ucffGrEXhad86PoxF/YqnLkb/SQwUwAgsozTxarB5dbfTCVXlFG2GapDZAr2Be5f/c
         s178Me4VGqNfpOYfgnXQD5UbyWkFdxwKdCHfXbCy16GFizDmJ/jdRUEAxJH/haSa9zba
         Ny2IaScY9VISEaE/WuLHZILRK2WBmE5KWHr8VfhCQehsOHsn7oMV9COkahtd00DElrF+
         B2VckQRMeyS118SDfGUKbbkG2LVbVgeJGFaPxPENROKDj0ZVIMPvDfPSMOkqPd4q5FyL
         8fywz8GNsX4o68TS0HOuvSglQtAcAEv/OwBU22UrcFN1dcoMKhP5oRE3psjoWbz5zkE2
         +gbg==
X-Gm-Message-State: AO0yUKXaIbV6JWXfv9b9Mq3+EqacJVyR2AiIYZ1NdLWXhxNZNBa+4Srp
        bqLSAUi6F8UlCj7h13te72vgtw==
X-Google-Smtp-Source: AK7set84RHq3tiHrHR4tEwQ8xJ5n+3oh/OsmVDE7KLrRmI17T7U2C9R6e2cWWeZbLP5J6BciOQZgmQ==
X-Received: by 2002:a05:600c:1613:b0:3df:b5ae:5289 with SMTP id m19-20020a05600c161300b003dfb5ae5289mr3275850wmn.8.1675780995526;
        Tue, 07 Feb 2023 06:43:15 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id n2-20020a05600c3b8200b003dfe659f9b1sm2575467wms.3.2023.02.07.06.43.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 06:43:14 -0800 (PST)
Message-ID: <8b03eafd-8d8e-6e80-2b88-0e186f3ab392@linaro.org>
Date:   Tue, 7 Feb 2023 14:43:13 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v9 24/27] virt: gunyah: Add proxy-scheduled vCPUs
Content-Language: en-US
To:     Elliot Berman <quic_eberman@quicinc.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Alex Elder <elder@linaro.org>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230120224627.4053418-1-quic_eberman@quicinc.com>
 <20230120224627.4053418-25-quic_eberman@quicinc.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230120224627.4053418-25-quic_eberman@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/01/2023 22:46, Elliot Berman wrote:
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
> ---
>   Documentation/virt/gunyah/vm-manager.rst |  30 +-
>   arch/arm64/gunyah/gunyah_hypercall.c     |  28 ++
>   drivers/virt/gunyah/Kconfig              |  11 +
>   drivers/virt/gunyah/Makefile             |   2 +
>   drivers/virt/gunyah/gunyah_vcpu.c        | 358 +++++++++++++++++++++++
>   drivers/virt/gunyah/vm_mgr.c             |  25 ++
>   drivers/virt/gunyah/vm_mgr.h             |   1 +
>   include/linux/gunyah.h                   |   7 +
>   include/uapi/linux/gunyah.h              |  30 ++
>   9 files changed, 490 insertions(+), 2 deletions(-)
>   create mode 100644 drivers/virt/gunyah/gunyah_vcpu.c
> 
...


> diff --git a/include/uapi/linux/gunyah.h b/include/uapi/linux/gunyah.h
> index ec8da6fde045..b4afb11f538a 100644
> --- a/include/uapi/linux/gunyah.h
> +++ b/include/uapi/linux/gunyah.h
> @@ -53,9 +53,14 @@ struct gh_vm_dtb_config {
>   #define GUNYAH_FUNCTION_NAME_SIZE		32
>   #define GUNYAH_FUNCTION_MAX_ARG_SIZE		1024
>   
> +struct gh_fn_vcpu_arg {
> +	__u32 vcpu_id;
> +};
> +
>   struct gh_vm_function {
>   	char name[GUNYAH_FUNCTION_NAME_SIZE];
>   	union {
> +		struct gh_device_vcpu_arg vcpu;
>   		char data[GUNYAH_FUNCTION_MAX_ARG_SIZE];
>   	};
>   };
> @@ -63,4 +68,29 @@ struct gh_vm_function {
>   #define GH_VM_ADD_FUNCTION	_IOW(GH_IOCTL_TYPE, 0x4, struct gh_vm_function)
>   #define GH_VM_REMOVE_FUNCTION	_IOW(GH_IOCTL_TYPE, 0x7, struct gh_vm_function)
>   
> +/* for GH_VCPU_RUN, returned by mmap(vcpu_fd, offset=0) */
> +struct gh_vcpu_run {
this looks unused, I dont see any reference to this.

> +	/* in */
> +	__u8 immediate_exit;
> +	__u8 padding1[7];
> +
> +	/* out */
> +#define GH_VM_EXIT_UNKNOWN            0
> +#define GH_VM_EXIT_MMIO               1
> +	__u32 exit_reason;

If this is ment to go in any of the ioctl arguments then this suffers 
same issue of padding.

> +
> +	union {
> +		/* GH_VM_EXIT_MMIO */
> +		struct {
> +			__u64 phys_addr;
> +			__u8  data[8];
> +			__u32 len;
> +			__u8  is_write;
> +		} mmio;
> +	};
> +};
> +
> +#define GH_VCPU_RUN		_IO(GH_IOCTL_TYPE, 0x5)
> +#define GH_VCPU_MMAP_SIZE	_IO(GH_IOCTL_TYPE, 0x6)
> +
>   #endif
