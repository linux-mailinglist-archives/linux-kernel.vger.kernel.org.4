Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3A96A1406
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 00:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbjBWXzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 18:55:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjBWXzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 18:55:09 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48E715545
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 15:55:07 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id cp7-20020a17090afb8700b0023756229427so1060784pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 15:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WtTBZYOExvc5n8giROfO1dPxIyNM2H7rqatYfqD4Z2M=;
        b=RFZBBqytynmIbxtT/qDXwgRBwOK9Gk56bsvh9xmjA7Yxedl+RTlB3fkZ0VUkHaq1JA
         +ZP42NGKrGrdjOJ+Di9kpP6KMRoX7SgtXO5fBDqNZsJjTfRt8YuEyilNutNlzp+V1wZR
         RthU6FPY7Rj9T57Ym0+vPebj2oImXwoWWlefcuv1mbqUPhHjgY+n8UhAn5D8YUJtU/h+
         H6/ib1PjFoX4R7axaUlmlBYu1KJECPV7dgJvu/HJFwlsACWNaB2FEXR3mi6nwTYrYwfX
         xKGvsX5nx6i137TdhNQWIUqtGOBx7jIT+E8BtipzlLkuYUbhNecH/kLTyFYQ+pgw127G
         mLxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WtTBZYOExvc5n8giROfO1dPxIyNM2H7rqatYfqD4Z2M=;
        b=PgivZSs9FPZM1AM2h0b/4OOMR9ra3aWcqZfoobk49idgYnXhztNLq9O6S4elX54RfO
         56K1W4SUuX6TQvf/OYeKjyAxphFtvud/pZHhH2/I3ktCV/At/M4guCgv/2uA7efLL8LV
         L4+io4BLlMbs312TZZpMIe64jWfLBRkqaoQY4QS1p4krMbDpsK9vON35etF4ym/fwjna
         bHXYpfYppZsJAMqdJBbo+JLgd21LNmgjNF7xyll0cT0u+qUTvfCIopTLbboGk4Bijexr
         l1tT4vVY6f6wcyU7/+O950ZOO6tIhsUEbXF5wU8HQLt6573surGjJyKU/FRI8Ut+Wev+
         ZAsw==
X-Gm-Message-State: AO0yUKXH8UP4DOIHCrUP71CFDCL5hD81AByEu2m4xgVn+JAXiEppDv85
        NtVo3RR8lO++rvmLjpZOr/Y4KQ==
X-Google-Smtp-Source: AK7set+s6o8UwSQnW1YrqNF6rOUbpd4d9XZVdYd+0rm0pY0ufGNSxdV/Kein2zFpBdyXfPXRVk+L1g==
X-Received: by 2002:a17:902:ec92:b0:19a:eef0:3392 with SMTP id x18-20020a170902ec9200b0019aeef03392mr17465284plg.43.1677196507180;
        Thu, 23 Feb 2023 15:55:07 -0800 (PST)
Received: from [10.211.55.3] (c-73-221-130-71.hsd1.wa.comcast.net. [73.221.130.71])
        by smtp.gmail.com with ESMTPSA id i3-20020a170902c28300b0019460ac7c6asm2054438pld.283.2023.02.23.15.55.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 15:55:06 -0800 (PST)
Message-ID: <a6f8c339-c126-dded-60fe-8cd9febb55af@linaro.org>
Date:   Thu, 23 Feb 2023 17:55:05 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v10 17/26] docs: gunyah: Document Gunyah VM Manager
Content-Language: en-US
To:     Elliot Berman <quic_eberman@quicinc.com>,
        Alex Elder <elder@linaro.org>,
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
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230214211229.3239350-1-quic_eberman@quicinc.com>
 <20230214212506.3320728-1-quic_eberman@quicinc.com>
From:   Alex Elder <alex.elder@linaro.org>
In-Reply-To: <20230214212506.3320728-1-quic_eberman@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/23 3:25 PM, Elliot Berman wrote:
> 
> Document the ioctls and usage of Gunyah VM Manager driver.
> 
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> ---
>   Documentation/virt/gunyah/index.rst      |   1 +
>   Documentation/virt/gunyah/vm-manager.rst | 106 +++++++++++++++++++++++
>   2 files changed, 107 insertions(+)
>   create mode 100644 Documentation/virt/gunyah/vm-manager.rst
> 
> diff --git a/Documentation/virt/gunyah/index.rst b/Documentation/virt/gunyah/index.rst
> index 45adbbc311db..b204b85e86db 100644
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
> index 000000000000..c0126cfeadc7
> --- /dev/null
> +++ b/Documentation/virt/gunyah/vm-manager.rst
> @@ -0,0 +1,106 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=======================
> +Virtual Machine Manager
> +=======================
> +
> +The Gunyah Virtual Machine Manager is a Linux driver to support launching
> +virtual machines using Gunyah. It presently supports launching non-proxy
> +scheduled Linux-like virtual machines.
> +
> +Except for some basic information about the location of initial binaries,
> +most of the configuration about a Gunyah virtual machine is described in the
> +VM's devicetree. The devicetree is generated by userspace. Interacting with the
> +virtual machine is still done via the kernel and VM configuration requires some
> +of the corresponding functionality to be set up in the kernel. For instance,
> +sharing userspace memory with a VM is done via the GH_VM_SET_USER_MEM_REGION
> +ioctl. The VM itself is configured to use the memory region via the
> +devicetree.
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
> +To create a VM, use the GH_CREATE_VM ioctl. A successful call will return a
> +"Gunyah VM" file descriptor.
> +
> +/dev/gunyah API Descriptions
> +----------------------------
> +
> +GH_CREATE_VM
> +~~~~~~~~~~~~
> +
> +Creates a Gunyah VM. The argument is reserved for future use and must be 0.

I wouldn't say it "must be zero".  Instead maybe say it is
is currently ignored.

> +
> +Gunyah VM API Descriptions
> +--------------------------
> +
> +GH_VM_SET_USER_MEM_REGION
> +~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +::
> +
> +  struct gh_userspace_memory_region {
> +	__u32 label;
> +	__u32 flags;
> +	__u64 guest_phys_addr;
> +	__u64 memory_size;
> +	__u64 userspace_addr;
> +  };
> +
> +This ioctl allows the user to create or delete a memory parcel for a guest
> +virtual machine. Each memory region is uniquely identified by a label;
> +attempting to create two regions with the same label is not allowed.

Must the label be unique across a single instance of Gunyah (on
a single physical machine)?  Or is it unique within a VM?  Or
something else?  (It's not universally unique, right?)

> +
> +While VMM is guest-agnostic and allows runtime addition of memory regions,
> +Linux guest virtual machines do not support accepting memory regions at runtime.
> +Thus, memory regions should be provided before starting the VM and the VM must
> +be configured to accept these at boot-up.
> +
> +The guest physical address is used by Linux kernel to check that the requested
> +user regions do not overlap and to help find the corresponding memory region
> +for calls like GH_VM_SET_DTB_CONFIG. It should be page aligned.

The physical address must be page aligned.  Can a page be anything
other than 4096 bytes?

> +
> +memory_size and userspace_addr should be page-aligned.

Not should, must, right?  (The address isn't rounded down to a
page boundary, for example.)

> +
> +The flags field of gh_userspace_memory_region accepts the following bits. All
> +other bits must be 0 and are reserved for future use. The ioctl will return
> +-EINVAL if an unsupported bit is detected.
> +
> +  - GH_MEM_ALLOW_READ/GH_MEM_ALLOW_WRITE/GH_MEM_ALLOW_EXEC sets read/write/exec
> +    permissions for the guest, respectively.
> +  - GH_MEM_LENT means that the memory will be unmapped from the host and be
> +    unaccessible by the host while the guest has the region.
> +
> +To add a memory region, call GH_VM_SET_USER_MEM_REGION with fields set as
> +described above.
> +
> +To delete a memory region, call GH_VM_SET_USER_MEM_REGION with label set to the
> +desired region and memory_size set to 0.
> +
> +GH_VM_SET_DTB_CONFIG
> +~~~~~~~~~~~~~~~~~~~~
> +
> +::
> +
> +  struct gh_vm_dtb_config {
> +	__u64 gpa;

What is "gpa"?  Guest physical address?  Gunyah pseudo address?
Can this have a longer and more descriptive name please?

> +	__u64 size;
> +  };
> +
> +This ioctl sets the location of the VM's devicetree blob and is used by Gunyah
> +Resource Manager to allocate resources. The guest physical memory should be part
> +of the primary memory parcel provided to the VM prior to GH_VM_START.

Any alignment constraints?  (If not, you could say "there are no
alignment constraints on the address or size.")

> +
> +GH_VM_START
> +~~~~~~~~~~~
> +
> +This ioctl starts the VM.

Is there anything you can say about what gets returned for
these (at least for significant cases, like permission
problems or something)?

Are IOCTLs the normal way for virtual machine mechanisms
to set up things like this?  (Noob question.)

					-Alex
