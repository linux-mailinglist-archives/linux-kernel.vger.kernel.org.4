Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD66872304A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 21:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236140AbjFETuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 15:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236249AbjFETty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 15:49:54 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD6E010D2
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 12:49:28 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-774867fd6f7so171283239f.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 12:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685994566; x=1688586566;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wtTjjHT5CTUXdvB6JknWClu6BA6lKhbvtH4FRzorLWI=;
        b=E1Ev02VgKfzRmJSBLh3zCUukvGn2rZgrMgi7nVOBUaeEBIP2o+AZzGcXhHMBBAgoo5
         +55Xu72M/t54WZ7ljWgM7hM0RHygj9YSzHfQbHGnfla4zu2KYoey/LxLzHLWtWSmrHYE
         u75spKNBPHTDhjHa2Rzq3K/xDvZqPucyepBTzpBVNaeiitvs6uf9RimUQrguY2MLQ15U
         uDzrId4bZg8rQR6J1lJvsjMW2K1WEKlLHNKHlWahhPoILHZa//XGoHKbB9LQWL/IWu6d
         ipS0lJDfOsSY30KkJFi/Ya/QUYgT7nAemgqojA6d8pfQAJ7PpOwF4cmPA+IOCERvv/kj
         RrSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685994566; x=1688586566;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wtTjjHT5CTUXdvB6JknWClu6BA6lKhbvtH4FRzorLWI=;
        b=bVhODqaItOyyAv+qt4SNGAdN0EXA85bt2wP7Y/n9wwDfn2U0h5rDemCMlCi5XLdkJa
         5ZKJMBnr/VfJ6SJe1/hLRSgueKvMdBZJFigHc86PIs0ILiwz5262l1IT0eXRcdqvlOEo
         mT/boDBruPuB5+1mJpL3NRZ6LwuDIJ0HUDwca1Ulgz++LYLu+27d4Q6AHG8YBi89WP3k
         9i/p06fWTwwK1hp1lDUf3VZ6GNrzTMxx1XZDkU4Jt/DWQSHMakXzP81P/rxR7R1gnfxC
         72Dwiks5izCeCwxJwsoRX93CrpLlGy961UhprGCetdkpHZLwb7LtpLSR97QQFFD+vBWr
         tmGg==
X-Gm-Message-State: AC+VfDyM5JN3D/B0peeQI0IbM+nXPw4WYmOgpiOzyFJrUcJ+jetHXDru
        eG0nJuM2CcOiMNE+4QCdP22pMVy5k+YF7qK14fr8pg==
X-Google-Smtp-Source: ACHHUZ5NUH7RpIcCsVW2rT3VDUV+aTHO4WNVhit3iaQrJr9ZeBUlDMt6gd7v6HR0GnISocoH7REDgw==
X-Received: by 2002:a6b:7a0c:0:b0:776:f992:78cf with SMTP id h12-20020a6b7a0c000000b00776f99278cfmr128026iom.12.1685994565932;
        Mon, 05 Jun 2023 12:49:25 -0700 (PDT)
Received: from [172.22.22.28] ([98.61.227.136])
        by smtp.gmail.com with ESMTPSA id i1-20020a02b681000000b0041ac9dd35f0sm2301285jam.132.2023.06.05.12.49.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 12:49:25 -0700 (PDT)
Message-ID: <0e2825da-e247-8656-2c18-f523a291cbcc@linaro.org>
Date:   Mon, 5 Jun 2023 14:49:24 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From:   Alex Elder <elder@linaro.org>
Subject: Re: [PATCH v13 15/24] docs: gunyah: Document Gunyah VM Manager
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
 <20230509204801.2824351-16-quic_eberman@quicinc.com>
Content-Language: en-US
In-Reply-To: <20230509204801.2824351-16-quic_eberman@quicinc.com>
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
> Document the ioctls and usage of Gunyah VM Manager driver.
> 
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>

This patch does not apply, because at this point in the
series, "Documentation/virt/gunyah/index.rst" does not
exist.  I'm going to ignore that.

I have some suggestions, but this generally looks good.
I'll wait to see v14 with the full "index.rst" before I
give my Reviewed-by.

					-Alex

> ---
>   Documentation/virt/gunyah/index.rst      |  1 +
>   Documentation/virt/gunyah/vm-manager.rst | 82 ++++++++++++++++++++++++
>   2 files changed, 83 insertions(+)
>   create mode 100644 Documentation/virt/gunyah/vm-manager.rst
> 
> diff --git a/Documentation/virt/gunyah/index.rst b/Documentation/virt/gunyah/index.rst
> index 74aa345e0a14..7058249825b1 100644
> --- a/Documentation/virt/gunyah/index.rst
> +++ b/Documentation/virt/gunyah/index.rst
> @@ -7,6 +7,7 @@ Gunyah Hypervisor
>   .. toctree::
>      :maxdepth: 1
>   
> +   vm-manager
>      message-queue
>   
>   Gunyah is a Type-1 hypervisor which is independent of any OS kernel, and runs in
> diff --git a/Documentation/virt/gunyah/vm-manager.rst b/Documentation/virt/gunyah/vm-manager.rst
> new file mode 100644
> index 000000000000..50d8ae7fabcd
> --- /dev/null
> +++ b/Documentation/virt/gunyah/vm-manager.rst
> @@ -0,0 +1,82 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=======================
> +Virtual Machine Manager
> +=======================
> +
> +The Gunyah Virtual Machine Manager is a Linux driver to support launching
> +virtual machines using Gunyah. It presently supports launching non-proxy
> +scheduled Linux-like virtual machines.

Does everyone know what "non-proxy-scheduled virtual machines" are?

> +Except for some basic information about the location of initial binaries,
> +most of the configuration about a Gunyah virtual machine is described in the
> +VM's devicetree. The devicetree is generated by userspace. Interacting with the
> +virtual machine is still done via the kernel and VM configuration requires some
> +of the corresponding functionality to be set up in the kernel. For instance,
> +sharing userspace memory with a VM is done via the `GH_VM_SET_USER_MEM_REGION`_
> +ioctl. The VM itself is configured to use the memory region via the
> +devicetree.

Without looking at the code, I'm a little unsure what that last
sentence reallly means.

> +
> +Sample Userspace VMM
> +====================
> +
> +A sample userspace VMM is included in samples/gunyah/ along with a minimal
> +devicetree that can be used to launch a VM. To build this sample, enable
> +CONFIG_SAMPLE_GUNYAH.
> +
> +IOCTLs and userspace VMM flows
> +==============================
> +
> +The kernel exposes a char device interface at /dev/gunyah.
> +
> +To create a VM, use the `GH_CREATE_VM`_ ioctl. A successful call will return a
> +"Gunyah VM" file descriptor.
> +
> +/dev/gunyah API Descriptions
> +----------------------------
> +
> +GH_CREATE_VM
> +~~~~~~~~~~~~
> +
> +Creates a Gunyah VM. The argument is reserved for future use and must be 0.

Maybe mention it returns a file descriptor representing the created VM?

> +
> +Gunyah VM API Descriptions
> +--------------------------
> +
> +GH_VM_SET_USER_MEM_REGION
> +~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +This ioctl allows the user to create or delete a memory parcel for a guest
> +virtual machine. Each memory region is uniquely identified by a label;
> +attempting to create two regions with the same label is not allowed. Labels are
> +unique per virtual machine.
> +
> +While VMM is guest-agnostic and allows runtime addition of memory regions,
> +Linux guest virtual machines do not support accepting memory regions at runtime.
> +Thus, memory regions should be provided before starting the VM and the VM must

Thus, for Linux guests, memory regions must be provided...

> +be configured to accept these at boot-up.
> +
> +The guest physical address is used by Linux kernel to check that the requested
> +user regions do not overlap and to help find the corresponding memory region
> +for calls like `GH_VM_SET_DTB_CONFIG`_. It must be page aligned.
> +
> +To add a memory region, call `GH_VM_SET_USER_MEM_REGION`_ with fields set as
> +described above.
> +
> +.. kernel-doc:: include/uapi/linux/gunyah.h
> +   :identifiers: gh_userspace_memory_region gh_mem_flags
> +
> +GH_VM_SET_DTB_CONFIG
> +~~~~~~~~~~~~~~~~~~~~
> +
> +This ioctl sets the location of the VM's devicetree blob and is used by Gunyah
> +Resource Manager to allocate resources. The guest physical memory should be part

s/should/must/		/* ? */

> +of the primary memory parcel provided to the VM prior to GH_VM_START.

Is it possible to provide multiple memory parcels?  If so, is the
"primary" memory parcel the first?

> +
> +.. kernel-doc:: include/uapi/linux/gunyah.h
> +   :identifiers: gh_vm_dtb_config
> +
> +GH_VM_START
> +~~~~~~~~~~~
> +
> +This ioctl starts the VM.

