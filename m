Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71D026F6A1D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 13:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjEDLgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 07:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjEDLgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 07:36:43 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC7D44BB
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 04:36:37 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-50be17a1eceso656002a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 04:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683200195; x=1685792195;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fUBKpSomICRjHy5Tp+ncLX1lobSBgWGYo8r3PwUzI2I=;
        b=FZqQPmKXFnLUsRdXWJlmHFCcyC/RvgFi1QhKa073QATJJpKGbiZ0WCQENtnJT1wtn8
         1Ivglu3etS4QQhwASHA9KL5fljbrGWerYFJ+S6dn3HkSSi4Lop/YhWIWpOQ//2hCek8y
         3Kj30+50xF6ZZ7Z5YFDede0DamdZZnH9wTmIt+qh2jgIClQhYd+sLvmxm3uy6zhW8n7d
         /UQ2tINymwhodLqBnTV+Gr0c21mWJNTlHbSQiH4M0jukNh3J6/CR3v4lXMFoaQ5MM9rS
         TAlvy1UPJ+AVsXV0CRl2QI1NuwPFxwHrwBZg6uJuxxdS5kvc4pAY5dzbCwG9s3t/0PRz
         OeDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683200195; x=1685792195;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fUBKpSomICRjHy5Tp+ncLX1lobSBgWGYo8r3PwUzI2I=;
        b=Uo/lUvTm8fvqNvQxFqqJac9aOvwOOoogsZGC6l/bMOLPXcrCowVvZBClq2Lm6kkfMZ
         l0tJfgpEO/UwOPZhctb8MiMs6K1LHyBqp8OiWTVKLxVOCmFlgsV9f6cIsPPIl76kvPj5
         P7zpK0BzPrtaVpFXn0d/OaAU4fVGrvIDMQ5zlLmToV0g4GLN+A925gSRb1gOUS7wLqX+
         y/O5uyFPzZlVF7b2i2mgETxs2G2WHnidtZZcz2RUDVqIxH2LhLuZcv3HPUhk04gE0xcY
         irSOpstSIdulVXhpZhovI5I1ZLzd6NGsz9CgIat9T43Bm+WQzUqzqFVLJk7f8vXv3Q0F
         SxZw==
X-Gm-Message-State: AC+VfDyT5IFiWOvSX015BXpheDIeRU0uiQLKdmWSCvLYhM4gT4Aq94Oc
        O1mVs6ToPfb84oD2n7R74DzG3g==
X-Google-Smtp-Source: ACHHUZ4g81P9qr+5Gpog9oJPftl+QgaGGFKNtdJVZ4SWZDx2jGUFiY6e4EbeFjhqt6QiLdXHI6HUgg==
X-Received: by 2002:a17:907:8a12:b0:959:af74:4cf7 with SMTP id sc18-20020a1709078a1200b00959af744cf7mr6125665ejc.70.1683200195360;
        Thu, 04 May 2023 04:36:35 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:cbf1:e7ef:fb81:e912? ([2a02:810d:15c0:828:cbf1:e7ef:fb81:e912])
        by smtp.gmail.com with ESMTPSA id ww9-20020a170907084900b0095847a49ce7sm15770611ejb.55.2023.05.04.04.36.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 04:36:34 -0700 (PDT)
Message-ID: <c6f730b6-f702-91d4-4abd-71546e02f869@linaro.org>
Date:   Thu, 4 May 2023 13:36:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v3 04/18] soc: qcom: Add Qualcomm minidump kernel driver
Content-Language: en-US
To:     Mukesh Ojha <quic_mojha@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, corbet@lwn.net,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        catalin.marinas@arm.com, will@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        srinivas.kandagatla@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org
References: <1683133352-10046-1-git-send-email-quic_mojha@quicinc.com>
 <1683133352-10046-5-git-send-email-quic_mojha@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1683133352-10046-5-git-send-email-quic_mojha@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/05/2023 19:02, Mukesh Ojha wrote:
> Minidump is a best effort mechanism to collect useful and predefined
> data for first level of debugging on end user devices running on
> Qualcomm SoCs. It is built on the premise that System on Chip (SoC)
> or subsystem part of SoC crashes, due to a range of hardware and
> software bugs. Hence, the ability to collect accurate data is only
> a best-effort. The data collected could be invalid or corrupted,
> data collection itself could fail, and so on.
> 
> Qualcomm devices in engineering mode provides a mechanism for
> generating full system ramdumps for post mortem debugging. But in some
> cases it's however not feasible to capture the entire content of RAM.
> The minidump mechanism provides the means for selecting region should
> be included in the ramdump. The solution supports extracting the
> ramdump/minidump produced either over USB or stored to an attached
> storage device.
> 
> The core of minidump feature is part of Qualcomm's boot firmware code.
> It initializes shared memory(SMEM), which is a part of DDR and
> allocates a small section of it to minidump table i.e also called
> global table of content (G-ToC). Each subsystem (APSS, ADSP, ...) has
> their own table of segments to be included in the minidump, all
> references from a descriptor in SMEM (G-ToC). Each segment/region has
> some details like name, physical address and it's size etc. and it
> could be anywhere scattered in the DDR.
> 
> Minidump kernel driver adds the capability to add linux region to be
> dumped as part of ram dump collection. It provides appropriate symbol
> to check its enablement and register client regions.
> 
> To simplify post mortem debugging, it creates and maintain an ELF
> header as first region that gets updated upon registration
> of a new region.
> 
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> ---
>  drivers/soc/qcom/Kconfig         |  14 +
>  drivers/soc/qcom/Makefile        |   1 +
>  drivers/soc/qcom/qcom_minidump.c | 581 +++++++++++++++++++++++++++++++++++++++
>  drivers/soc/qcom/smem.c          |   8 +
>  include/soc/qcom/qcom_minidump.h |  61 +++-
>  5 files changed, 663 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/soc/qcom/qcom_minidump.c
> 
> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> index a491718..15c931e 100644
> --- a/drivers/soc/qcom/Kconfig
> +++ b/drivers/soc/qcom/Kconfig
> @@ -279,4 +279,18 @@ config QCOM_INLINE_CRYPTO_ENGINE
>  	tristate
>  	select QCOM_SCM
>  
> +config QCOM_MINIDUMP
> +	tristate "QCOM Minidump Support"
> +	depends on ARCH_QCOM || COMPILE_TEST
> +	select QCOM_SMEM
> +	help
> +	  Enablement of core minidump feature is controlled from boot firmware
> +	  side, and this config allow linux to query and manages APPS minidump
> +	  table.
> +
> +	  Client drivers can register their internal data structures and debug
> +	  messages as part of the minidump region and when the SoC is crashed,
> +	  these selective regions will be dumped instead of the entire DDR.
> +	  This saves significant amount of time and/or storage space.
> +
>  endmenu
> diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
> index 0f43a88..1ebe081 100644
> --- a/drivers/soc/qcom/Makefile
> +++ b/drivers/soc/qcom/Makefile
> @@ -33,3 +33,4 @@ obj-$(CONFIG_QCOM_RPMPD) += rpmpd.o
>  obj-$(CONFIG_QCOM_KRYO_L2_ACCESSORS) +=	kryo-l2-accessors.o
>  obj-$(CONFIG_QCOM_ICC_BWMON)	+= icc-bwmon.o
>  obj-$(CONFIG_QCOM_INLINE_CRYPTO_ENGINE)	+= ice.o
> +obj-$(CONFIG_QCOM_MINIDUMP) += qcom_minidump.o
> diff --git a/drivers/soc/qcom/qcom_minidump.c b/drivers/soc/qcom/qcom_minidump.c
> new file mode 100644
> index 0000000..d107a86
> --- /dev/null
> +++ b/drivers/soc/qcom/qcom_minidump.c
> @@ -0,0 +1,581 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +/*
> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include <linux/elf.h>
> +#include <linux/err.h>
> +#include <linux/errno.h>
> +#include <linux/export.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/string.h>
> +#include <linux/soc/qcom/smem.h>
> +#include <soc/qcom/qcom_minidump.h>
> +
> +/**
> + * struct minidump_elfhdr - Minidump table elf header
> + * @ehdr: Elf main header
> + * @shdr: Section header
> + * @phdr: Program header
> + * @elf_offset: Section offset in elf
> + * @strtable_idx: String table current index position
> + */
> +struct minidump_elfhdr {
> +	struct elfhdr		*ehdr;
> +	struct elf_shdr		*shdr;
> +	struct elf_phdr		*phdr;
> +	size_t			elf_offset;
> +	size_t			strtable_idx;
> +};
> +
> +/**
> + * struct minidump - Minidump driver private data
> + * @md_gbl_toc	: Global TOC pointer
> + * @md_apss_toc	: Application Subsystem TOC pointer
> + * @md_regions	: High level OS region base pointer
> + * @elf		: Minidump elf header
> + * @dev		: Minidump device
> + */
> +struct minidump {
> +	struct minidump_global_toc	*md_gbl_toc;
> +	struct minidump_subsystem	*md_apss_toc;
> +	struct minidump_region		*md_regions;
> +	struct minidump_elfhdr		elf;
> +	struct device			*dev;
> +};
> +
> +/*
> + * In some of the Old Qualcomm devices, boot firmware statically allocates 300
> + * as total number of supported region (including all co-processors) in
> + * minidump table out of which linux was using 201. In future, this limitation
> + * from boot firmware might get removed by allocating the region dynamically.
> + * So, keep it compatible with older devices, we can keep the current limit for
> + * Linux to 201.
> + */
> +#define MAX_NUM_ENTRIES	  201
> +#define MAX_STRTBL_SIZE	  (MAX_NUM_ENTRIES * MAX_REGION_NAME_LENGTH)
> +
> +static struct minidump *__md;

No, no file scope or global scope statics.

> +static DEFINE_MUTEX(minidump_lock);

Neither this.

Also you need to clearly express what is protected by newn lock.

> +
> +static struct elf_shdr *elf_shdr_entry_addr(struct elfhdr *ehdr, int idx)
> +{
> +	struct elf_shdr *eshdr = (struct elf_shdr *)((size_t)ehdr + ehdr->e_shoff);
> +
> +	return &eshdr[idx];
> +}
> +
> +static struct elf_phdr *elf_phdr_entry_addr(struct elfhdr *ehdr, int idx)
> +{
> +	struct elf_phdr *ephdr = (struct elf_phdr *)((size_t)ehdr + ehdr->e_phoff);
> +
> +	return &ephdr[idx];
> +}
> +
> +static char *elf_str_table_start(struct elfhdr *ehdr)
> +{
> +	struct elf_shdr *eshdr;
> +
> +	if (ehdr->e_shstrndx == SHN_UNDEF)
> +		return NULL;
> +
> +	eshdr = elf_shdr_entry_addr(ehdr, ehdr->e_shstrndx);
> +	return (char *)ehdr + eshdr->sh_offset;
> +}
> +
> +static char *elf_lookup_string(struct elfhdr *ehdr, int offset)
> +{
> +	char *strtab = elf_str_table_start(ehdr);
> +
> +	if (!strtab || (__md->elf.strtable_idx < offset))
> +		return NULL;
> +
> +	return strtab + offset;
> +}
> +
> +static unsigned int append_str_to_strtable(const char *name)
> +{
> +	char *strtab = elf_str_table_start(__md->elf.ehdr);
> +	unsigned int old_idx = __md->elf.strtable_idx;
> +	unsigned int ret;
> +
> +	if (!strtab || !name)
> +		return 0;
> +
> +	ret = old_idx;
> +	old_idx += strscpy((strtab + old_idx), name, MAX_REGION_NAME_LENGTH);
> +	__md->elf.strtable_idx = old_idx + 1;
> +	return ret;
> +}
> +
> +static int
> +get_apss_minidump_region_index(const struct qcom_apss_minidump_region *region)
> +{
> +	struct minidump_region *mdr;
> +	unsigned int i;
> +	unsigned int count;
> +
> +	count = le32_to_cpu(__md->md_apss_toc->region_count);
> +	for (i = 0; i < count; i++) {
> +		mdr = &__md->md_regions[i];
> +		if (!strcmp(mdr->name, region->name))
> +			return i;
> +	}
> +	return -ENOENT;
> +}
> +
> +static void
> +qcom_apss_minidump_update_elf_header(const struct qcom_apss_minidump_region *region)

You need to name everything shorter. Neither functions nor structs are
making it easy to follow.

> +{
> +	struct elfhdr *ehdr = __md->elf.ehdr;
> +	struct elf_shdr *shdr;
> +	struct elf_phdr *phdr;
> +
> +	shdr = elf_shdr_entry_addr(ehdr, ehdr->e_shnum++);
> +	phdr = elf_phdr_entry_addr(ehdr, ehdr->e_phnum++);
> +
> +	shdr->sh_type = SHT_PROGBITS;
> +	shdr->sh_name = append_str_to_strtable(region->name);
> +	shdr->sh_addr = (elf_addr_t)region->virt_addr;
> +	shdr->sh_size = region->size;
> +	shdr->sh_flags = SHF_WRITE;
> +	shdr->sh_offset = __md->elf.elf_offset;
> +	shdr->sh_entsize = 0;
> +
> +	phdr->p_type = PT_LOAD;
> +	phdr->p_offset = __md->elf.elf_offset;
> +	phdr->p_vaddr = (elf_addr_t)region->virt_addr;
> +	phdr->p_paddr = region->phys_addr;
> +	phdr->p_filesz = phdr->p_memsz = region->size;
> +	phdr->p_flags = PF_R | PF_W;
> +	__md->elf.elf_offset += shdr->sh_size;
> +}
> +
> +static void
> +qcom_apss_minidump_add_region(const struct qcom_apss_minidump_region *region)
> +{
> +	struct minidump_region *mdr;
> +	unsigned int region_cnt = le32_to_cpu(__md->md_apss_toc->region_count);
> +
> +	mdr = &__md->md_regions[region_cnt];
> +	strscpy(mdr->name, region->name, sizeof(mdr->name));
> +	mdr->address = cpu_to_le64(region->phys_addr);
> +	mdr->size = cpu_to_le64(region->size);
> +	mdr->valid = cpu_to_le32(MINIDUMP_REGION_VALID);
> +	region_cnt++;
> +	__md->md_apss_toc->region_count = cpu_to_le32(region_cnt);
> +}
> +
> +static bool
> +qcom_apss_minidump_valid_region(const struct qcom_apss_minidump_region *region)
> +{
> +	return region &&
> +		strnlen(region->name, MAX_NAME_LENGTH) < MAX_NAME_LENGTH &&
> +		region->virt_addr &&
> +		region->size &&
> +		IS_ALIGNED(region->size, 4);
> +}
> +
> +static int qcom_apss_minidump_add_elf_header(void)
> +{
> +	struct qcom_apss_minidump_region elfregion;
> +	struct elfhdr *ehdr;
> +	struct elf_shdr *shdr;
> +	struct elf_phdr *phdr;
> +	unsigned int  elfh_size;
> +	unsigned int strtbl_off;
> +	unsigned int phdr_off;
> +	char *banner;
> +	unsigned int banner_len;
> +
> +	banner_len = strlen(linux_banner);
> +	/*
> +	 * Header buffer contains:
> +	 * ELF header, (MAX_NUM_ENTRIES + 4) of Section and Program ELF headers,
> +	 * where, 4 additional entries, one for empty header, one for string table
> +	 * one for minidump table and one for linux banner.
> +	 *
> +	 * Linux banner is stored in minidump to aid post mortem tools to determine
> +	 * the kernel version.
> +	 */
> +	elfh_size = sizeof(*ehdr);
> +	elfh_size += MAX_STRTBL_SIZE;
> +	elfh_size += banner_len + 1;
> +	elfh_size += ((sizeof(*shdr) + sizeof(*phdr)) * (MAX_NUM_ENTRIES + 4));
> +	elfh_size = ALIGN(elfh_size, 4);
> +
> +	__md->elf.ehdr = kzalloc(elfh_size, GFP_KERNEL);
> +	if (!__md->elf.ehdr)
> +		return -ENOMEM;
> +
> +	/* Register ELF header as first region */
> +	strscpy(elfregion.name, "KELF_HEADER", sizeof(elfregion.name));
> +	elfregion.virt_addr = __md->elf.ehdr;
> +	elfregion.phys_addr = virt_to_phys(__md->elf.ehdr);
> +	elfregion.size = elfh_size;
> +	qcom_apss_minidump_add_region(&elfregion);
> +
> +	ehdr = __md->elf.ehdr;
> +	/* Assign Section/Program headers offset */
> +	__md->elf.shdr = shdr = (struct elf_shdr *)(ehdr + 1);
> +	__md->elf.phdr = phdr = (struct elf_phdr *)(shdr + MAX_NUM_ENTRIES);
> +	phdr_off = sizeof(*ehdr) + (sizeof(*shdr) * MAX_NUM_ENTRIES);
> +
> +	memcpy(ehdr->e_ident, ELFMAG, SELFMAG);
> +	ehdr->e_ident[EI_CLASS] = ELF_CLASS;
> +	ehdr->e_ident[EI_DATA] = ELF_DATA;
> +	ehdr->e_ident[EI_VERSION] = EV_CURRENT;
> +	ehdr->e_ident[EI_OSABI] = ELF_OSABI;
> +	ehdr->e_type = ET_CORE;
> +	ehdr->e_machine  = ELF_ARCH;
> +	ehdr->e_version = EV_CURRENT;
> +	ehdr->e_ehsize = sizeof(*ehdr);
> +	ehdr->e_phoff = phdr_off;
> +	ehdr->e_phentsize = sizeof(*phdr);
> +	ehdr->e_shoff = sizeof(*ehdr);
> +	ehdr->e_shentsize = sizeof(*shdr);
> +	ehdr->e_shstrndx = 1;
> +
> +	__md->elf.elf_offset = elfh_size;
> +
> +	/*
> +	 * The zeroth index of the section header is reserved and is rarely used.
> +	 * Set the section header as null (SHN_UNDEF) and move to the next one.
> +	 * 2nd Section is String table.
> +	 */
> +	__md->elf.strtable_idx = 1;
> +	strtbl_off = sizeof(*ehdr) + ((sizeof(*phdr) + sizeof(*shdr)) * MAX_NUM_ENTRIES);
> +	shdr++;
> +	shdr->sh_type = SHT_STRTAB;
> +	shdr->sh_offset = (elf_addr_t)strtbl_off;
> +	shdr->sh_size = MAX_STRTBL_SIZE;
> +	shdr->sh_entsize = 0;
> +	shdr->sh_flags = 0;
> +	shdr->sh_name = append_str_to_strtable("STR_TBL");
> +	shdr++;
> +
> +	/* 3rd Section is Linux banner */
> +	banner = (char *)ehdr + strtbl_off + MAX_STRTBL_SIZE;
> +	memcpy(banner, linux_banner, banner_len);
> +
> +	shdr->sh_type = SHT_PROGBITS;
> +	shdr->sh_offset = (elf_addr_t)(strtbl_off + MAX_STRTBL_SIZE);
> +	shdr->sh_size = banner_len + 1;
> +	shdr->sh_addr = (elf_addr_t)linux_banner;
> +	shdr->sh_entsize = 0;
> +	shdr->sh_flags = SHF_WRITE;
> +	shdr->sh_name = append_str_to_strtable("linux_banner");
> +
> +	phdr->p_type = PT_LOAD;
> +	phdr->p_offset = (elf_addr_t)(strtbl_off + MAX_STRTBL_SIZE);
> +	phdr->p_vaddr = (elf_addr_t)linux_banner;
> +	phdr->p_paddr = virt_to_phys(linux_banner);
> +	phdr->p_filesz = phdr->p_memsz = banner_len + 1;
> +	phdr->p_flags = PF_R | PF_W;
> +
> +	/*
> +	 * Above are some prdefined sections/program header used
> +	 * for debug, update their count here.
> +	 */
> +	ehdr->e_phnum = 1;
> +	ehdr->e_shnum = 3;
> +
> +	return 0;
> +}
> +
> +/**
> + * qcom_minidump_subsystem_desc() - Get minidump subsystem descriptor.
> + * @minidump_index: minidump index for a subsystem in minidump table
> + *
> + * Return: minidump subsystem descriptor address on success and error
> + * on failure
> + */
> +struct minidump_subsystem *qcom_minidump_subsystem_desc(unsigned int minidump_index)
> +{
> +	struct minidump_subsystem *md_ss_toc;
> +
> +	mutex_lock(&minidump_lock);
> +	if (!__md) {
> +		md_ss_toc = ERR_PTR(-EPROBE_DEFER);
> +		goto unlock;
> +	}
> +
> +	md_ss_toc = &__md->md_gbl_toc->subsystems[minidump_index];
> +unlock:
> +	mutex_unlock(&minidump_lock);
> +	return md_ss_toc;
> +}
> +EXPORT_SYMBOL_GPL(qcom_minidump_subsystem_desc);
> +
> +/**
> + * qcom_apss_minidump_region_register() - Register a region in Minidump table.
> + * @region: minidump region.
> + *
> + * Return: On success, it returns 0, otherwise a negative error value on failure.
> + */
> +int qcom_apss_minidump_region_register(const struct qcom_apss_minidump_region *region)
> +{
> +	unsigned int num_region;
> +	int ret;
> +
> +	if (!__md)
> +		return -EPROBE_DEFER;
> +
> +	if (!qcom_apss_minidump_valid_region(region))
> +		return -EINVAL;
> +
> +	mutex_lock(&minidump_lock);
> +	ret = get_apss_minidump_region_index(region);
> +	if (ret >= 0) {
> +		dev_info(__md->dev, "%s region is already registered\n", region->name);
> +		ret = -EEXIST;
> +		goto unlock;
> +	}
> +
> +	/* Check if there is a room for a new entry */
> +	num_region = le32_to_cpu(__md->md_apss_toc->region_count);
> +	if (num_region >= MAX_NUM_ENTRIES) {
> +		dev_err(__md->dev, "maximum region limit %u reached\n", num_region);
> +		ret = -ENOSPC;
> +		goto unlock;
> +	}
> +
> +	qcom_apss_minidump_add_region(region);
> +	qcom_apss_minidump_update_elf_header(region);
> +	ret = 0;
> +unlock:
> +	mutex_unlock(&minidump_lock);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(qcom_apss_minidump_region_register);
> +
> +static int
> +qcom_apss_minidump_clear_header(const struct qcom_apss_minidump_region *region)
> +{
> +	struct elfhdr *ehdr = __md->elf.ehdr;
> +	struct elf_shdr *shdr;
> +	struct elf_shdr *tmp_shdr;
> +	struct elf_phdr *phdr;
> +	struct elf_phdr *tmp_phdr;
> +	unsigned int phidx;
> +	unsigned int shidx;
> +	unsigned int len;
> +	unsigned int i;
> +	char *shname;
> +
> +	for (i = 0; i < ehdr->e_phnum; i++) {
> +		phdr = elf_phdr_entry_addr(ehdr, i);
> +		if (phdr->p_paddr == region->phys_addr &&
> +		    phdr->p_memsz == region->size)
> +			break;
> +	}
> +
> +	if (i == ehdr->e_phnum) {
> +		dev_err(__md->dev, "Cannot find program header entry in elf\n");
> +		return -EINVAL;
> +	}
> +
> +	phidx = i;
> +	for (i = 0; i < ehdr->e_shnum; i++) {
> +		shdr = elf_shdr_entry_addr(ehdr, i);
> +		shname = elf_lookup_string(ehdr, shdr->sh_name);
> +		if (shname && !strcmp(shname, region->name) &&
> +		    shdr->sh_addr == (elf_addr_t)region->virt_addr &&
> +		    shdr->sh_size == region->size)
> +			break;
> +	}
> +
> +	if (i == ehdr->e_shnum) {
> +		dev_err(__md->dev, "Cannot find section header entry in elf\n");
> +		return -EINVAL;
> +	}
> +
> +	shidx = i;
> +	if (shdr->sh_offset != phdr->p_offset) {
> +		dev_err(__md->dev, "Invalid entry details for region: %s\n", region->name);
> +		return -EINVAL;
> +	}
> +
> +	/* Clear name in string table */
> +	len = strlen(shname) + 1;
> +	memmove(shname, shname + len,
> +		__md->elf.strtable_idx - shdr->sh_name - len);
> +	__md->elf.strtable_idx -= len;
> +
> +	/* Clear program header */
> +	tmp_phdr = elf_phdr_entry_addr(ehdr, phidx);
> +	for (i = phidx; i < ehdr->e_phnum - 1; i++) {
> +		tmp_phdr = elf_phdr_entry_addr(ehdr, i + 1);
> +		phdr = elf_phdr_entry_addr(ehdr, i);
> +		memcpy(phdr, tmp_phdr, sizeof(struct elf_phdr));
> +		phdr->p_offset = phdr->p_offset - region->size;
> +	}
> +	memset(tmp_phdr, 0, sizeof(struct elf_phdr));
> +	ehdr->e_phnum--;
> +
> +	/* Clear section header */
> +	tmp_shdr = elf_shdr_entry_addr(ehdr, shidx);
> +	for (i = shidx; i < ehdr->e_shnum - 1; i++) {
> +		tmp_shdr = elf_shdr_entry_addr(ehdr, i + 1);
> +		shdr = elf_shdr_entry_addr(ehdr, i);
> +		memcpy(shdr, tmp_shdr, sizeof(struct elf_shdr));
> +		shdr->sh_offset -= region->size;
> +		shdr->sh_name -= len;
> +	}
> +
> +	memset(tmp_shdr, 0, sizeof(struct elf_shdr));
> +	ehdr->e_shnum--;
> +	__md->elf.elf_offset -= region->size;
> +
> +	return 0;
> +}
> +
> +/**
> + * qcom_apss_minidump_region_unregister() - Unregister region from Minidump table.
> + * @region: minidump region.
> + *
> + * Return: On success, it returns 0 and negative error value on failure.
> + */
> +int qcom_apss_minidump_region_unregister(const struct qcom_apss_minidump_region *region)
> +{
> +	struct minidump_region *mdr;
> +	unsigned int num_region;
> +	unsigned int idx;
> +	int ret;
> +
> +	if (!region)
> +		return -EINVAL;
> +
> +	mutex_lock(&minidump_lock);
> +	if (!__md) {
> +		ret = -EPROBE_DEFER;
> +		goto unlock;
> +	}
> +
> +	idx = get_apss_minidump_region_index(region);
> +	if (idx < 0) {
> +		dev_err(__md->dev, "%s region is not present\n", region->name);
> +		ret = idx;
> +		goto unlock;
> +	}
> +
> +	mdr = &__md->md_regions[0];
> +	num_region = le32_to_cpu(__md->md_apss_toc->region_count);
> +	/*
> +	 * Left shift all the regions exist after this removed region
> +	 * index by 1 to fill the gap and zero out the last region
> +	 * present at the end.
> +	 */
> +	memmove(&mdr[idx], &mdr[idx + 1],
> +		(num_region - idx - 1) * sizeof(struct minidump_region));
> +	memset(&mdr[num_region - 1], 0, sizeof(struct minidump_region));
> +	ret = qcom_apss_minidump_clear_header(region);
> +	if (ret) {
> +		dev_err(__md->dev, "Failed to remove region: %s\n", region->name);
> +		goto unlock;
> +	}
> +
> +	num_region--;
> +	__md->md_apss_toc->region_count = cpu_to_le32(num_region);
> +unlock:
> +	mutex_unlock(&minidump_lock);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(qcom_apss_minidump_region_unregister);
> +
> +static int qcom_minidump_init_apss_subsystem(struct minidump *md)
> +{
> +	struct minidump_subsystem *apsstoc;
> +
> +	apsstoc = &md->md_gbl_toc->subsystems[MINIDUMP_APSS_DESC];
> +	md->md_regions = devm_kcalloc(md->dev, MAX_NUM_ENTRIES,
> +				      sizeof(struct minidump_region), GFP_KERNEL);
> +	if (!md->md_regions)
> +		return -ENOMEM;
> +
> +	md->md_apss_toc = apsstoc;
> +	apsstoc->regions_baseptr = cpu_to_le64(virt_to_phys(md->md_regions));
> +	apsstoc->enabled = cpu_to_le32(MINIDUMP_SS_ENABLED);
> +	apsstoc->status = cpu_to_le32(1);
> +	apsstoc->region_count = cpu_to_le32(0);
> +
> +	/* Tell bootloader not to encrypt the regions of this subsystem */
> +	apsstoc->encryption_status = cpu_to_le32(MINIDUMP_SS_ENCR_DONE);
> +	apsstoc->encryption_required = cpu_to_le32(MINIDUMP_SS_ENCR_NOTREQ);
> +
> +	return 0;
> +}
> +
> +static int qcom_minidump_probe(struct platform_device *pdev)
> +{
> +	struct minidump_global_toc *mdgtoc;
> +	struct minidump *md;
> +	size_t size;
> +	int ret;
> +
> +	md = devm_kzalloc(&pdev->dev, sizeof(*md), GFP_KERNEL);
> +	if (!md)
> +		return -ENOMEM;
> +
> +	mdgtoc = qcom_smem_get(QCOM_SMEM_HOST_ANY, SBL_MINIDUMP_SMEM_ID, &size);
> +	if (IS_ERR(mdgtoc)) {
> +		ret = PTR_ERR(mdgtoc);
> +		dev_err(&pdev->dev, "Couldn't find minidump smem item: %d\n", ret);
> +		return ret;
> +	}
> +
> +	if (size < sizeof(*mdgtoc) || !mdgtoc->status) {
> +		ret = -EINVAL;
> +		dev_err(&pdev->dev, "minidump table is not initialized: %d\n", ret);
> +		return ret;
> +	}
> +
> +	mutex_lock(&minidump_lock);
> +	md->dev = &pdev->dev;
> +	md->md_gbl_toc = mdgtoc;

What are you protecting here? It's not possible to have concurrent
access to md, is it?

> +	ret = qcom_minidump_init_apss_subsystem(md);
> +	if (ret) {
> +		dev_err(&pdev->dev, "apss minidump initialization failed: %d\n", ret);
> +		goto unlock;
> +	}
> +
> +	__md = md;

No. This is a platform device, so it can have multiple instances.

> +	/* First entry would be ELF header */
> +	ret = qcom_apss_minidump_add_elf_header();
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to add elf header: %d\n", ret);
> +		memset(md->md_apss_toc, 0, sizeof(struct minidump_subsystem));
> +		__md = NULL;
> +	}
> +
> +unlock:
> +	mutex_unlock(&minidump_lock);
> +	return ret;
> +}
> +
> +static int qcom_minidump_remove(struct platform_device *pdev)
> +{
> +	memset(__md->md_apss_toc, 0, sizeof(struct minidump_subsystem));
> +	__md = NULL;

Don't use __ in variable names. Drop it everywhere.

> +
> +	return 0;
> +}
> +
> +static struct platform_driver qcom_minidump_driver = {
> +	.probe = qcom_minidump_probe,
> +	.remove = qcom_minidump_remove,
> +	.driver  = {
> +		.name = "qcom-minidump",
> +	},
> +};
> +
> +module_platform_driver(qcom_minidump_driver);
> +
> +MODULE_DESCRIPTION("Qualcomm APSS minidump driver");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:qcom-minidump");
> diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
> index 6be7ea9..d459656 100644
> --- a/drivers/soc/qcom/smem.c
> +++ b/drivers/soc/qcom/smem.c
> @@ -279,6 +279,7 @@ struct qcom_smem {
>  
>  	u32 item_count;
>  	struct platform_device *socinfo;
> +	struct platform_device *minidump;
>  	struct smem_ptable *ptable;
>  	struct smem_partition global_partition;
>  	struct smem_partition partitions[SMEM_HOST_COUNT];
> @@ -1151,12 +1152,19 @@ static int qcom_smem_probe(struct platform_device *pdev)
>  	if (IS_ERR(smem->socinfo))
>  		dev_dbg(&pdev->dev, "failed to register socinfo device\n");
>  
> +	smem->minidump = platform_device_register_data(&pdev->dev, "qcom-minidump",
> +						      PLATFORM_DEVID_NONE, NULL,
> +						      0);
> +	if (IS_ERR(smem->minidump))
> +		dev_dbg(&pdev->dev, "failed to register minidump device\n");
> +
>  	return 0;
>  }
>  
>  static int qcom_smem_remove(struct platform_device *pdev)
>  {
>  	platform_device_unregister(__smem->socinfo);
> +	platform_device_unregister(__smem->minidump);

Wrong order. You registered first socinfo, right?

>  
>  	hwspin_lock_free(__smem->hwlock);
>  	__smem = NULL;
> diff --git a/include/soc/qcom/qcom_minidump.h b/include/soc/qcom/qcom_minidump.h
> index 84c8605..1872668 100644
> --- a/include/soc/qcom/qcom_minidump.h
> +++ b/include/soc/qcom/qcom_minidump.h
> @@ -1,6 +1,7 @@
>  /* SPDX-License-Identifier: GPL-2.0-only */
>  /*
> - * Qualcomm minidump shared data structures and macros
> + * This file contain Qualcomm minidump data structures and macros shared with
> + * boot firmware and also apss minidump client's data structure
>   *
>   * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
>   */
> @@ -9,12 +10,27 @@
>  #define _QCOM_MINIDUMP_H_
>  
>  #define MAX_NUM_OF_SS           10
> +#define MAX_NAME_LENGTH		12
>  #define MAX_REGION_NAME_LENGTH  16
> +
> +#define MINIDUMP_REVISION	1
>  #define SBL_MINIDUMP_SMEM_ID	602
> +
> +/* Application processor minidump descriptor */
> +#define MINIDUMP_APSS_DESC	0
> +#define SMEM_ENTRY_SIZE		40
> +
>  #define MINIDUMP_REGION_VALID		('V' << 24 | 'A' << 16 | 'L' << 8 | 'I' << 0)
> +#define MINIDUMP_REGION_INVALID		('I' << 24 | 'N' << 16 | 'V' << 8 | 'A' << 0)
> +#define MINIDUMP_REGION_INIT		('I' << 24 | 'N' << 16 | 'I' << 8 | 'T' << 0)
> +#define MINIDUMP_REGION_NOINIT		0
> +
> +#define MINIDUMP_SS_ENCR_REQ		(0 << 24 | 'Y' << 16 | 'E' << 8 | 'S' << 0)
> +#define MINIDUMP_SS_ENCR_NOTREQ		(0 << 24 | 0 << 16 | 'N' << 8 | 'R' << 0)
> +#define MINIDUMP_SS_ENCR_NONE		('N' << 24 | 'O' << 16 | 'N' << 8 | 'E' << 0)
>  #define MINIDUMP_SS_ENCR_DONE		('D' << 24 | 'O' << 16 | 'N' << 8 | 'E' << 0)
> +#define MINIDUMP_SS_ENCR_START		('S' << 24 | 'T' << 16 | 'R' << 8 | 'T' << 0)
>  #define MINIDUMP_SS_ENABLED		('E' << 24 | 'N' << 16 | 'B' << 8 | 'L' << 0)
> -

Why removing this?

>  /**
>   * struct minidump_region - Minidump region
>   * @name		: Name of the region to be dumped
> @@ -63,4 +79,45 @@ struct minidump_global_toc {
>  	struct minidump_subsystem	subsystems[MAX_NUM_OF_SS];
>  };
>  
> +/**
> + * struct qcom_apss_minidump_region - APSS Minidump region information
> + *
> + * @name:	Entry name, Minidump will dump binary with this name.
> + * @virt_addr:  Virtual address of the entry.
> + * @phys_addr:	Physical address of the entry to dump.
> + * @size:	Number of byte to dump from @address location,
> + *		and it should be 4 byte aligned.
> + */
> +struct qcom_apss_minidump_region {
> +	char		name[MAX_NAME_LENGTH];
> +	void		*virt_addr;
> +	phys_addr_t	phys_addr;
> +	size_t		size;
> +};

You expose way too much internals in global header.

> +
> +#if IS_ENABLED(CONFIG_QCOM_MINIDUMP)
> +extern struct minidump_subsystem *

No externs.

The header is unreadable.

> +qcom_minidump_subsystem_desc(unsigned int minidump_index);
> +extern int
> +qcom_apss_minidump_region_register(const struct qcom_apss_minidump_region *region);
> +extern int
> +qcom_apss_minidump_region_unregister(const struct qcom_apss_minidump_region *region);

Blank line

> +#else

Blank line

> +static inline
> +struct minidump_subsystem *qcom_minidump_subsystem_desc(unsigned int minidump_index)
> +{
> +	return NULL;
> +}

Blank line

> +static inline int
> +qcom_apss_minidump_region_register(const struct qcom_apss_minidump_region *region)
> +{
> +	/* Return quietly, if minidump is not enabled */
> +	return 0;
> +}


> +static inline int
> +qcom_apss_minidump_region_unregister(const struct qcom_apss_minidump_region *region)
> +{
> +	return 0;
> +}

> +#endif

/* CONFIG_QCOM_MINIDUMP */

>  #endif  /* _QCOM_MINIDUMP_H_ */

Best regards,
Krzysztof

