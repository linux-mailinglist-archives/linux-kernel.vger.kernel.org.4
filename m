Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7747B733628
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 18:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345096AbjFPQef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 12:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344964AbjFPQe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 12:34:29 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367FC359D
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 09:34:20 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-3420dccf277so1917345ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 09:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686933259; x=1689525259;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SRh0KBrGgk8MtMYMha8LI//zbtFqZis9i/gE3m+zWsA=;
        b=Bu1bzyTC9xNXaz2aHpS/aCJRG6poEHKPM5EFvrvZbXpqmnlZOGyyeSXTGXVXZcn6ZT
         dtLWusgj9AwcVxeoaQeNTK51EzOMmx/o+Qkq+wheDMIdOi4jkJNHqMXtmzQ2k8zbI1qP
         RflDDd9vbZi8mbYNF8sD8hzIE0z0Fll1gTWJ/xnpFpFn9vjrPODyQtAXusavwlHSThSt
         jnbFA1eWGCYW0SkUhdB3a0ir5lLJ5JelRvQDc+1YLK+KYk5eMIi3IX78IrrmIPpNdGal
         M++X+iXaV8XeS+SL/H/MmA28nGHtBgXxfo9J2ctGW2/gtIuRJqukjzmB9oLI7mFI/hcE
         TIgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686933259; x=1689525259;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SRh0KBrGgk8MtMYMha8LI//zbtFqZis9i/gE3m+zWsA=;
        b=JF2wJulMxIrlCHD/J54Y3BI7RKuDAmCHzgZ8TIX3ykZhve8OC3AEM586+m1++FDuW6
         eyW5nFMmxwhGcLWmYpO4ce0SJ4NasW54r1EoT91mUGYNnT8gnegXWa78cNVUOWERfexe
         GCa3nihhInpW7RPRzYf73kuYFSbOJQnUFb6F5QEDZ/CovFBMTErUjVE9QHBsQv0sBiha
         wjZLTe6CIXOMboS54LU96AGR6PC3VnD9lEXYCxBNBspE3+mlPpglG3bIkILbtVCt3vGs
         rp4FaPvp7mwtUtnfXYYrhg1I8fSTtP9JWjDuNirtGTsgB/DOSpA4z07S0wHTFuKA9j6Z
         OgLA==
X-Gm-Message-State: AC+VfDzRCdo7UrNAP4pqHcV+zctd7b7jhYDOfN2USYOZVH/xY2rbkYdO
        Omsy9YT1PykN4Sagb996815/hQ==
X-Google-Smtp-Source: ACHHUZ5jDRn4LUUdsOusmr6zG73V19SaYCJQ5pffkrvXs5Ojfz7eXbrCU7ValuRLqnOlSJndc2H3Lg==
X-Received: by 2002:a92:d483:0:b0:33f:a995:31b2 with SMTP id p3-20020a92d483000000b0033fa99531b2mr2998588ilg.10.1686933259221;
        Fri, 16 Jun 2023 09:34:19 -0700 (PDT)
Received: from [172.22.22.28] ([98.61.227.136])
        by smtp.gmail.com with ESMTPSA id g14-20020a02b70e000000b00418ae2206b1sm6499847jam.107.2023.06.16.09.34.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 09:34:18 -0700 (PDT)
Message-ID: <a30c21b8-b213-c6cb-29fc-83e034d684e6@linaro.org>
Date:   Fri, 16 Jun 2023 11:34:16 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v14 16/25] docs: gunyah: Document Gunyah VM Manager
Content-Language: en-US
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
        Conor Dooley <conor+dt@kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Will Deacon <will@kernel.org>, Andy Gross <agross@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230613172054.3959700-1-quic_eberman@quicinc.com>
 <20230613172054.3959700-17-quic_eberman@quicinc.com>
From:   Alex Elder <elder@linaro.org>
In-Reply-To: <20230613172054.3959700-17-quic_eberman@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/13/23 12:20 PM, Elliot Berman wrote:
> Document the ioctls and usage of Gunyah VM Manager driver.
> 
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>

A few minor comments below, but regardless:

Reviewed-by: Alex Elder <elder@linaro.org>

> ---
>   Documentation/virt/gunyah/index.rst      |  1 +
>   Documentation/virt/gunyah/vm-manager.rst | 83 ++++++++++++++++++++++++
>   2 files changed, 84 insertions(+)
>   create mode 100644 Documentation/virt/gunyah/vm-manager.rst
> 
> diff --git a/Documentation/virt/gunyah/index.rst b/Documentation/virt/gunyah/index.rst
> index 74aa345e0a144..7058249825b16 100644
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
> index 0000000000000..df0e1a8279bf5
> --- /dev/null
> +++ b/Documentation/virt/gunyah/vm-manager.rst
> @@ -0,0 +1,83 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=======================
> +Virtual Machine Manager
> +=======================
> +
> +The Gunyah Virtual Machine Manager is a Linux driver to support launching
> +virtual machines using Gunyah. It presently supports launching virtual machines
> +scheduled by Gunyah's scheduler.

You referred to this as "behind-the-back" scheduling in patch 1.
(I don't know if this terminology is important to use.)

> +
> +Configuration of a Gunyah virtual machine is done via a devicetree. When the VM
> +is launched, memory is provided by the host VM which contains the devictree.
> +Gunyah reads the devicetree to configure the memory map and create resources
> +such as vCPUs for the VM. Memory can be shared with the VM with
> +`GH_VM_SET_USER_MEM_REGION`_. Userspace can interact with the resources in Linux
> +by adding "functions" to the VM.
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

Maybe reword this a bit so it's clearer that the IOCTL calls
are performed on the file descriptor resulting from opening
/dev/gunyah?

> +
> +/dev/gunyah API Descriptions
> +----------------------------
> +
> +GH_CREATE_VM
> +~~~~~~~~~~~~
> +
> +Creates a Gunyah VM. The argument is reserved for future use and must be 0.
> +A successful call will return a Gunyah VM file descriptor. See
> +`Gunyah VM API Descriptions`_ for list of IOCTLs that can be made on this file

Maybe "the next section" rather than an explicit reference.
But it's fine as-is.

Also (because you duplicate "file"):

s/on this file/on this/

> +file descriptor.
> +
> +Gunyah VM API Descriptions
> +--------------------------
> +
> +GH_VM_SET_USER_MEM_REGION
> +~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +This ioctl allows the user to create or delete a memory parcel for a guest

How are memory parcels deleted?  (Maybe add a sentence at the end
of this section.)

> +virtual machine. Each memory region is uniquely identified by a label;
> +attempting to create two regions with the same label is not allowed. Labels are
> +unique per virtual machine.
> +
> +While VMM is guest-agnostic and allows runtime addition of memory regions,
> +Linux guest virtual machines do not support accepting memory regions at runtime.
> +Thus, for Linux guests, memory regions should be provided before starting the VM
> +and the VM must be configured via the devicetree to accept these at boot-up.
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
> +Resource Manager to allocate resources. The guest physical memory must be part
> +of the primary memory parcel provided to the VM prior to GH_VM_START.
> +
> +.. kernel-doc:: include/uapi/linux/gunyah.h
> +   :identifiers: gh_vm_dtb_config
> +
> +GH_VM_START
> +~~~~~~~~~~~
> +
> +This ioctl starts the VM.

