Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C96F86A83F0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 15:03:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjCBOD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 09:03:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjCBOD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 09:03:28 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A48D125AD
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 06:03:26 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id u9so18524210edd.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 06:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h/JXa3jl6N7Sx/fIVr6/rpxA4dj4ykaps8uQIwSRFHI=;
        b=SQe9A8zf+XRjs48CSJ+h4GnRYESyOz6AHJ2g25k/lwPj0Py8kP4rG8hhbJK3PRK/Ys
         g3JfMqTzkjAS07GFOOSo5vWwYNY4RjnyegQ/OwnuY/mIwkndxf/tRl69oSIjYCFEsha9
         1uivUu44qu8TIqf1FwmyDphbHfzYdzuMHmHW0+vQiB1MI+CoTV1HvTPaMBmotfy/pIXM
         3Ya/DW90qOpCzTz0iMBDoR/16Ny+HfrUtO9T+8TUzhnEeRvYG92vR7b848tcOs8uZSCk
         vTIm7M9BChxeqRZaVnDa7PfzMTULinMLJXWwlP6QFt4Pu4gBnY88Tnv+m57e1yTd1QRA
         McPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h/JXa3jl6N7Sx/fIVr6/rpxA4dj4ykaps8uQIwSRFHI=;
        b=xNfcJ+M+2w9jA4/mRj9A8m8smCOyUx/PUP9QzEnHr/NZZQmB5kCGldvwsAumJTCkA5
         VwwBc/zAieRu03fUH6vVTltkPnsnx1OMknAU9p7vX5jB9E/xY2h/KsKUhQ9bzbFQJEop
         NB2i/BbUMI2RIIYMa2DKLDgDEEZhAp/xWPYhcE+z023ypCPwkG+jS+KDw03sa0m8+rdw
         frW7eWp0sgcqz6hTc/e3CDZRQ2HWSzrrDY9yJc+wGxH3/8IBRjmTeKuHY21qTNkmUBGt
         GPKL2r6jie9mbWtUaNKwJt0C8/yR8QoJUeV0tbFLSUjUeUJ/L8TuxioQBzxqhy9IyQrx
         6q2A==
X-Gm-Message-State: AO0yUKWyF2fxA/rrakcKy44m5U9QSRN7lmkERNpPLun00at0jvERZ13N
        lD/+TbF2CqUUiOdhGDcPdm0=
X-Google-Smtp-Source: AK7set/gtIv/d5+qF714NjY0nEzkNgdHznl1CeO4qmEfZDHvPZB9UdsHo5ShI+zFg/5R6pNVkFnOVQ==
X-Received: by 2002:a05:6402:18a:b0:4ac:c3c0:24d7 with SMTP id r10-20020a056402018a00b004acc3c024d7mr10632959edv.42.1677765804566;
        Thu, 02 Mar 2023 06:03:24 -0800 (PST)
Received: from [192.168.5.8] (PC-176-101-165-146.tvk-net.pl. [176.101.165.146])
        by smtp.gmail.com with ESMTPSA id t19-20020a50d713000000b004af73333d6esm6981406edi.53.2023.03.02.06.03.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Mar 2023 06:03:24 -0800 (PST)
Message-ID: <7a0e256d-3ce1-3218-c930-ed518a679b8b@gmail.com>
Date:   Thu, 2 Mar 2023 15:03:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RFC kvmtool 18/31] arm64: Populate initial realm contents
Content-Language: en-US
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Alexandru Elisei <alexandru.elisei@arm.com>,
        Andrew Jones <andrew.jones@linux.dev>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Fuad Tabba <tabba@google.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Joey Gouly <Joey.Gouly@arm.com>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Quentin Perret <qperret@google.com>,
        Steven Price <steven.price@arm.com>,
        Thomas Huth <thuth@redhat.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>, linux-coco@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230127112248.136810-1-suzuki.poulose@arm.com>
 <20230127113932.166089-1-suzuki.poulose@arm.com>
 <20230127113932.166089-19-suzuki.poulose@arm.com>
From:   Piotr Sawicki <piotr.sawickas@gmail.com>
In-Reply-To: <20230127113932.166089-19-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> From: Alexandru Elisei <alexandru.elisei@arm.com>
> 
> Populate the realm memory with the initial contents, which include
> the device tree blob, the kernel image, and initrd, if specified,
> or the firmware image.
> 
> Populating an image in the realm involves two steps:
>   a) Mark the IPA area as RAM - INIT_IPA_REALM
>   b) Load the contents into the IPA - POPULATE_REALM
> 
> Wherever we know the actual size of an image in memory, we make
> sure the "memory area" is initialised to RAM.
> e.g., Linux kernel image size from the header which includes the bss etc.
> The "file size" on disk for the Linux image is much smaller.
> We mark the region of size Image.header.size as RAM (a), from the kernel
> load address. And load the Image file into the memory (b) above.
> At the moment we only detect the Arm64 Linux Image header format.
> 
> Since we're already touching the code that copies the
> initrd in guest memory, let's do a bit of cleaning and remove a
> useless local variable.
> 
> Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> [ Make sure the Linux kernel image area is marked as RAM ]
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>   arm/aarch32/include/asm/realm.h |   3 +
>   arm/aarch64/include/asm/realm.h |   3 +
>   arm/aarch64/realm.c             | 112 ++++++++++++++++++++++++++++++++
>   arm/fdt.c                       |   6 ++
>   arm/kvm.c                       |  20 ++++--
>   include/linux/kernel.h          |   1 +
>   6 files changed, 140 insertions(+), 5 deletions(-)
> 
> diff --git a/arm/aarch32/include/asm/realm.h b/arm/aarch32/include/asm/realm.h
> index 5aca6cca..fcff0e55 100644
> --- a/arm/aarch32/include/asm/realm.h
> +++ b/arm/aarch32/include/asm/realm.h
> @@ -6,5 +6,8 @@
>   #include "kvm/kvm.h"
>   
>   static inline void kvm_arm_realm_create_realm_descriptor(struct kvm *kvm) {}
> +static inline void kvm_arm_realm_populate_kernel(struct kvm *kvm) {}
> +static inline void kvm_arm_realm_populate_initrd(struct kvm *kvm) {}
> +static inline void kvm_arm_realm_populate_dtb(struct kvm *kvm) {}
>   
>   #endif /* ! __ASM_REALM_H */
> diff --git a/arm/aarch64/include/asm/realm.h b/arm/aarch64/include/asm/realm.h
> index e176f15f..6e760ac9 100644
> --- a/arm/aarch64/include/asm/realm.h
> +++ b/arm/aarch64/include/asm/realm.h
> @@ -6,5 +6,8 @@
>   #include "kvm/kvm.h"
>   
>   void kvm_arm_realm_create_realm_descriptor(struct kvm *kvm);
> +void kvm_arm_realm_populate_kernel(struct kvm *kvm);
> +void kvm_arm_realm_populate_initrd(struct kvm *kvm);
> +void kvm_arm_realm_populate_dtb(struct kvm *kvm);
>   
>   #endif /* ! __ASM_REALM_H */
> diff --git a/arm/aarch64/realm.c b/arm/aarch64/realm.c
> index fc7f8d6a..eddccece 100644
> --- a/arm/aarch64/realm.c
> +++ b/arm/aarch64/realm.c
> @@ -1,5 +1,7 @@
>   #include "kvm/kvm.h"
>   
> +#include <linux/byteorder.h>
> +#include <asm/image.h>
>   #include <asm/realm.h>
>   
>   
> @@ -80,3 +82,113 @@ void kvm_arm_realm_create_realm_descriptor(struct kvm *kvm)
>   	if (ioctl(kvm->vm_fd, KVM_ENABLE_CAP, &rme_create_rd) < 0)
>   		die_perror("KVM_CAP_RME(KVM_CAP_ARM_RME_CREATE_RD)");
>   }
> +
> +static void realm_init_ipa_range(struct kvm *kvm, u64 start, u64 size)
> +{
> +	struct kvm_cap_arm_rme_init_ipa_args init_ipa_args = {
> +		.init_ipa_base = start,
> +		.init_ipa_size = size
> +	};
> +	struct kvm_enable_cap rme_init_ipa_realm = {
> +		.cap = KVM_CAP_ARM_RME,
> +		.args[0] = KVM_CAP_ARM_RME_INIT_IPA_REALM,
> +		.args[1] = (u64)&init_ipa_args
> +	};
> +
> +	if (ioctl(kvm->vm_fd, KVM_ENABLE_CAP, &rme_init_ipa_realm) < 0)
> +		die("unable to intialise IPA range for Realm %llx - %llx (size %llu)",
> +		    start, start + size, size);
> +
> +}
> +
> +static void __realm_populate(struct kvm *kvm, u64 start, u64 size)
> +{
> +	struct kvm_cap_arm_rme_populate_realm_args populate_args = {
> +		.populate_ipa_base = start,
> +		.populate_ipa_size = size
> +	};
> +	struct kvm_enable_cap rme_populate_realm = {
> +		.cap = KVM_CAP_ARM_RME,
> +		.args[0] = KVM_CAP_ARM_RME_POPULATE_REALM,
> +		.args[1] = (u64)&populate_args
> +	};
> +
> +	if (ioctl(kvm->vm_fd, KVM_ENABLE_CAP, &rme_populate_realm) < 0)
> +		die("unable to populate Realm memory %llx - %llx (size %llu)",
> +		    start, start + size, size);
> +}
> +
> +static void realm_populate(struct kvm *kvm, u64 start, u64 size)
> +{
> +	realm_init_ipa_range(kvm, start, size);
> +	__realm_populate(kvm, start, size);
> +}
> +
> +static bool is_arm64_linux_kernel_image(void *header)
> +{
> +	struct arm64_image_header *hdr = header;
> +
> +	return memcmp(&hdr->magic, ARM64_IMAGE_MAGIC, sizeof(hdr->magic)) == 0;
> +}
> +
> +static ssize_t arm64_linux_kernel_image_size(void *header)
> +{
> +	struct arm64_image_header *hdr = header;
> +
> +	if (is_arm64_linux_kernel_image(header))
> +		return le64_to_cpu(hdr->image_size);
> +	die("Not arm64 Linux kernel Image");
> +}
> +
> +void kvm_arm_realm_populate_kernel(struct kvm *kvm)
> +{
> +	u64 start, end, mem_size;
> +	void *header = guest_flat_to_host(kvm, kvm->arch.kern_guest_start);
> +
> +	start = ALIGN_DOWN(kvm->arch.kern_guest_start, SZ_4K);
> +	end = ALIGN(kvm->arch.kern_guest_start + kvm->arch.kern_size, SZ_4K);
> +
> +	if (is_arm64_linux_kernel_image(header))
> +		mem_size = arm64_linux_kernel_image_size(header);
> +	else
> +		mem_size = end - start;
> +
> +	realm_init_ipa_range(kvm, start, mem_size);
> +	__realm_populate(kvm, start, end - start);
> +}
> +
> +void kvm_arm_realm_populate_initrd(struct kvm *kvm)
> +{
> +	u64 kernel_end, start, end;
> +
> +	kernel_end = ALIGN(kvm->arch.kern_guest_start + kvm->arch.kern_size, SZ_4K);
> +	start = ALIGN_DOWN(kvm->arch.initrd_guest_start, SZ_4K);
> +	/*
> +	 * Because we align the initrd to 4 bytes, it is theoretically possible
> +	 * for the start of the initrd to overlap with the same page where the
> +	 * kernel ends.
> +	 */
> +	if (start < kernel_end)
> +		start = kernel_end;
> +	end = ALIGN(kvm->arch.initrd_guest_start + kvm->arch.initrd_size, SZ_4K);
> +	if (end > start)
> +		realm_populate(kvm, start, end - start);
> +}
> +
> +void kvm_arm_realm_populate_dtb(struct kvm *kvm)
> +{
> +	u64 initrd_end, start, end;
> +
> +	initrd_end = ALIGN(kvm->arch.initrd_guest_start + kvm->arch.initrd_size, SZ_4K);
> +	start = ALIGN_DOWN(kvm->arch.dtb_guest_start, SZ_4K);
> +	/*
> +	 * Same situation as with the initrd, but now it is the DTB which is
> +	 * overlapping with the last page of the initrd, because the initrd is
> +	 * populated first.
> +	 */
> +	if (start < initrd_end)
> +		start = initrd_end;
> +	end = ALIGN(kvm->arch.dtb_guest_start + FDT_MAX_SIZE, SZ_4K);
> +	if (end > start)
> +		realm_populate(kvm, start, end - start);
> +}
> diff --git a/arm/fdt.c b/arm/fdt.c
> index 286ccadf..762a604d 100644
> --- a/arm/fdt.c
> +++ b/arm/fdt.c
> @@ -7,6 +7,8 @@
>   #include "arm-common/gic.h"
>   #include "arm-common/pci.h"
>   
> +#include <asm/realm.h>
> +
>   #include <stdbool.h>
>   
>   #include <linux/byteorder.h>
> @@ -231,6 +233,10 @@ static int setup_fdt(struct kvm *kvm)
>   
>   	if (kvm->cfg.arch.dump_dtb_filename)
>   		dump_fdt(kvm->cfg.arch.dump_dtb_filename, fdt_dest);
> +
> +	if (kvm->cfg.arch.is_realm)
> +		kvm_arm_realm_populate_dtb(kvm);
> +
>   	return 0;
>   }
>   late_init(setup_fdt);
> diff --git a/arm/kvm.c b/arm/kvm.c
> index acb627b2..57c5b5f7 100644
> --- a/arm/kvm.c
> +++ b/arm/kvm.c
> @@ -6,6 +6,7 @@
>   #include "kvm/fdt.h"
>   
>   #include "arm-common/gic.h"
> +#include <asm/realm.h>
>   
>   #include <sys/resource.h>
>   
> @@ -167,6 +168,9 @@ bool kvm__arch_load_kernel_image(struct kvm *kvm, int fd_kernel, int fd_initrd,
>   	pr_debug("Loaded kernel to 0x%llx (%llu bytes)",
>   		 kvm->arch.kern_guest_start, kvm->arch.kern_size);


I've noticed that multiple calling of the measurement test from the 
kvm-unit-tests suite results in different Realm Initial Measurements, 
although the kernel image is always the same.

After short investigation, I've found that the RIM starts being 
different while populating the last 4kB chunk of the kernel image.
The issue occurs when the image size is not aligned to the page size (4kB).

After zeroing the unused area of the last chunk, the measurements become 
repeatable.

> +	if (kvm->cfg.arch.is_realm)
> +		kvm_arm_realm_populate_kernel(kvm);
> +
>   	/*
>   	 * Now load backwards from the end of memory so the kernel
>   	 * decompressor has plenty of space to work with. First up is
> @@ -188,7 +192,6 @@ bool kvm__arch_load_kernel_image(struct kvm *kvm, int fd_kernel, int fd_initrd,
>   	/* ... and finally the initrd, if we have one. */
>   	if (fd_initrd != -1) {
>   		struct stat sb;
> -		unsigned long initrd_start;
>   
>   		if (fstat(fd_initrd, &sb))
>   			die_perror("fstat");
> @@ -199,7 +202,6 @@ bool kvm__arch_load_kernel_image(struct kvm *kvm, int fd_kernel, int fd_initrd,
>   		if (pos < kernel_end)
>   			die("initrd overlaps with kernel image.");
>   
> -		initrd_start = guest_addr;
>   		file_size = read_file(fd_initrd, pos, limit - pos);
>   		if (file_size == -1) {
>   			if (errno == ENOMEM)
> @@ -208,11 +210,13 @@ bool kvm__arch_load_kernel_image(struct kvm *kvm, int fd_kernel, int fd_initrd,
>   			die_perror("initrd read");
>   		}
>   
> -		kvm->arch.initrd_guest_start = initrd_start;
> +		kvm->arch.initrd_guest_start = guest_addr;
>   		kvm->arch.initrd_size = file_size;
>   		pr_debug("Loaded initrd to 0x%llx (%llu bytes)",
> -			 kvm->arch.initrd_guest_start,
> -			 kvm->arch.initrd_size);
> +			 kvm->arch.initrd_guest_start, kvm->arch.initrd_size);
> +
> +		if (kvm->cfg.arch.is_realm)
> +			kvm_arm_realm_populate_initrd(kvm);
>   	} else {
>   		kvm->arch.initrd_size = 0;
>   	}
> @@ -269,6 +273,8 @@ bool kvm__load_firmware(struct kvm *kvm, const char *firmware_filename)
>   
>   	/* Kernel isn't loaded by kvm, point start address to firmware */
>   	kvm->arch.kern_guest_start = fw_addr;
> +	kvm->arch.kern_size = fw_sz;
> +
>   	pr_debug("Loaded firmware to 0x%llx (%zd bytes)",
>   		 kvm->arch.kern_guest_start, fw_sz);
>   
> @@ -283,6 +289,10 @@ bool kvm__load_firmware(struct kvm *kvm, const char *firmware_filename)
>   		 kvm->arch.dtb_guest_start,
>   		 kvm->arch.dtb_guest_start + FDT_MAX_SIZE);
>   
> +	if (kvm->cfg.arch.is_realm)
> +		/* We hijack the kernel fields to describe the firmware. */
> +		kvm_arm_realm_populate_kernel(kvm);
> +
>   	return true;
>   }
>   
> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> index 6c22f1c0..25f19c20 100644
> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -9,6 +9,7 @@
>   
>   #define DIV_ROUND_UP(n,d) (((n) + (d) - 1) / (d))
>   
> +#define ALIGN_DOWN(x,a)		__ALIGN_MASK(x - (typeof(x))((a) - 1),(typeof(x))(a)-1)
>   #define ALIGN(x,a)		__ALIGN_MASK(x,(typeof(x))(a)-1)
>   #define __ALIGN_MASK(x,mask)	(((x)+(mask))&~(mask))
>   #define IS_ALIGNED(x, a)	(((x) & ((typeof(x))(a) - 1)) == 0)

Kind regards,
Piotr Sawicki
