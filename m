Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE7569D60B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 22:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232454AbjBTV6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 16:58:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232449AbjBTV6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 16:58:13 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C02A21974
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 13:58:03 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id e24so1431401pfn.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 13:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o6uK3JRKD9glmPZVrtfk/3zmVSx28VEnBekWkjPdr5Y=;
        b=JQdsgB85zsGpr7bJJtGBrfD6jVZ3ad3XG7mHodDwjrQOppO96CfKnvWDvn027EwEHC
         96gBnPMYLefqcV9GtDQ0+KdVQAIS6RA+3R1CqkJMaXPu7rOJpoBPfnZY1CbEx4/KGiY+
         VfP4cOljStALIu5BZ2RNwopsKcX+99WTfzFTQNDzn+y3tdQCnMs5sWt7qUe0ODIy7Iik
         rlyymb0gEjbJtJyh7Rd+hwcHOS4yxtkxXZAaAzwGwiygiwlezXQcXtGzZKN1IVWJrIZ6
         KYTBZopgGfTqij71ZSZLw/vf2qKwz80hU2KGTAh3EobzSPjUtDhENfl1b0+KTbQSPJ7m
         IUdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o6uK3JRKD9glmPZVrtfk/3zmVSx28VEnBekWkjPdr5Y=;
        b=a+IbtCV3dih9b4bhDtsI23Of/pGv4AVXKwJI7/JO7yyORWIxoIBjiNjsMbfZAt7GF9
         15ygE77ek3Nlcc5kI+SOgAB/+NgvrfS9TtKeXnPvKwBkt3oDmxgt0u1Je/SngbKLv1ce
         eOtfrPEjVlpqzhepicc5vdjhztBQbnId0uhnQhxtxLJH2Te7m/mZ1xYAF66yN3c/EMS0
         x0E0IVjnKAKwsBLrow8ORqVJBQe3Q4TGah0LhaDlY1JGCq/jsTC+7vhp30rCmPnGRPfe
         7Li1zQUxabtdF9A8jR8sWLp22B5mjBKMtBSlzQTFKPVtWvs5u8D9IUh+ESjriQkYalBy
         2m6A==
X-Gm-Message-State: AO0yUKWCLA3CBro1JH1gl4T9brq+DrFtS7GQbzZs9WG/QTdf0HrNrTqF
        Q2Zqbsg8M87FfTETCS7pZ6q0mA==
X-Google-Smtp-Source: AK7set+5H75omPr1jx07B6MYxxT9l6o0A4rTTnvrjrtvO9CaWBAnSNy7c5wG62GfASXCoYugnTS1OA==
X-Received: by 2002:a05:6a00:4194:b0:5a8:cc39:fc58 with SMTP id ca20-20020a056a00419400b005a8cc39fc58mr3447013pfb.6.1676930282962;
        Mon, 20 Feb 2023 13:58:02 -0800 (PST)
Received: from p14s ([2604:3d09:148c:c800:66c:5b9c:15ea:e519])
        by smtp.gmail.com with ESMTPSA id m20-20020aa79014000000b00593c1c5bd0esm1433029pfo.164.2023.02.20.13.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 13:58:02 -0800 (PST)
Date:   Mon, 20 Feb 2023 14:58:00 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     "Iuliana Prodan (OSS)" <iuliana.prodan@oss.nxp.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "S.J. Wang" <shengjiu.wang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Iuliana Prodan <iuliana.prodan@nxp.com>,
        linux-imx <linux-imx@nxp.com>, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH v4] remoteproc: imx_dsp_rproc: add custom memory copy
 implementation for i.MX DSP Cores
Message-ID: <20230220215800.GA794395@p14s>
References: <20230207134401.26724-1-iuliana.prodan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230207134401.26724-1-iuliana.prodan@oss.nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Iuliana,

On Tue, Feb 07, 2023 at 03:44:01PM +0200, Iuliana Prodan (OSS) wrote:
> From: Iuliana Prodan <iuliana.prodan@nxp.com>
> 
> The IRAM is part of the HiFi DSP.
> According to hardware specification only 32-bits write are allowed
> otherwise we get a Kernel panic.
> 
> Therefore add a custom memory copy and memset functions to deal with
> the above restriction.
> 
> Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
> 
> ---
> Changes since v3
> - remove Reported-by
> 
> Changes since v2
> - fix warning "cast from pointer to integer of different size"
> reported by kernel test robot.
> 
> Changes since v1
> - added missing check for cases when the memory slot is bigger than the file size;
> - added a custom memset function
> - removed is_iomem flag since is not used here
> - updated custom memcpy function to avoid reading after end of source
> 
> ---
>  drivers/remoteproc/imx_dsp_rproc.c | 181 ++++++++++++++++++++++++++++-
>  1 file changed, 180 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/imx_dsp_rproc.c b/drivers/remoteproc/imx_dsp_rproc.c
> index 2d9f4214a4c51..6a7cef1329329 100644
> --- a/drivers/remoteproc/imx_dsp_rproc.c
> +++ b/drivers/remoteproc/imx_dsp_rproc.c
> @@ -715,6 +715,185 @@ static void imx_dsp_rproc_kick(struct rproc *rproc, int vqid)
>  		dev_err(dev, "%s: failed (%d, err:%d)\n", __func__, vqid, err);
>  }
>  
> +/*
> + * Custom memory copy implementation for i.MX DSP Cores
> + *
> + * The IRAM is part of the HiFi DSP.
> + * According to hw specs only 32-bits writes are allowed.
> + */
> +static int imx_dsp_rproc_memcpy(void *dest, const void *src, size_t size)
> +{
> +	const u8 *src_byte = src;
> +	u32 affected_mask;
> +	u32 tmp;
> +	int i, q, r;
> +

	const u8 *src_byte = src;
	u32 affected_mask;
	int i, q, r;
	u32 tmp;

> +	/* destination must be 32bit aligned */
> +	if (!IS_ALIGNED((uintptr_t)dest, 4))
> +		return -EINVAL;
> +
> +	q = size / 4;
> +	r = size % 4;
> +
> +	/* __iowrite32_copy use 32bit size values so divide by 4 */
> +	__iowrite32_copy(dest, src, q);
> +
> +	if (r) {
> +		affected_mask = (1 << (8 * r)) - 1;

Please use GENMASK()

> +
> +		/* first read the 32bit data of dest, then change affected
> +		 * bytes, and write back to dest.
> +		 * For unaffected bytes, it should not be changed
> +		 */

Wrong multi-line comment format.

> +		tmp = ioread32(dest + q * 4);

This turns into readl().

> +		tmp &= ~affected_mask;
> +
> +		/* avoid reading after end of source */
> +		for (i = 0; i < r; i++)
> +			tmp |= (src_byte[q * 4 + i] << (8 * i));
> +
> +		iowrite32(tmp, dest + q * 4);

As far as I can tell this turns into a simple writel(), leading me to beleive
the above __iowrite32_copy() can safely be replaced by a loop that calls
writel().

> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * Custom memset implementation for i.MX DSP Cores
> + *
> + * The IRAM is part of the HiFi DSP.
> + * According to hw specs only 32-bits writes are allowed.
> + */
> +static int imx_dsp_rproc_memset(void *addr, u8 value, size_t size)
> +{
> +	u32 affected_mask;
> +	u32 tmp_val = value;
> +	u32 *tmp_dst = addr;
> +	u32 tmp;
> +	int q, r;
> +
> +	/* destination must be 32bit aligned */
> +	if (!IS_ALIGNED((uintptr_t)addr, 4))
> +		return -EINVAL;
> +

Same as above

> +	tmp_val |= tmp_val << 8;
> +	tmp_val |= tmp_val << 16;
> +
> +	q = size / 4;
> +	r = size % 4;
> +
> +	while (q--)
> +		iowrite32(tmp_val, tmp_dst++);
> +

This proves my point about __iowrite32_copy() above.

> +	if (r) {
> +		affected_mask = (1 << (8 * r)) - 1;

Please use GENMASK()

> +
> +		/* first read the 32bit data of addr, then change affected
> +		 * bytes, and write back to addr.
> +		 * For unaffected bytes, it should not be changed
> +		 */

Wrong multi-line comment format.

> +		tmp = ioread32(tmp_dst);

                readl();

> +		tmp &= ~affected_mask;
> +
> +		tmp |= (tmp_val & affected_mask);
> +		iowrite32(tmp, tmp_dst);

                writel();

Thanks,
Mathieu

> +	}
> +
> +	return 0;
> +}
> +/**
> + * imx_dsp_rproc_elf_load_segments() - load firmware segments to memory
> + * @rproc: remote processor which will be booted using these fw segments
> + * @fw: the ELF firmware image
> + *
> + * This function loads the firmware segments to memory, where the remote
> + * processor expects them.
> + *
> + * Return: 0 on success and an appropriate error code otherwise
> + */
> +static int imx_dsp_rproc_elf_load_segments(struct rproc *rproc, const struct firmware *fw)
> +{
> +	struct device *dev = &rproc->dev;
> +	const void *ehdr, *phdr;
> +	int i, ret = 0;
> +	u16 phnum;
> +	const u8 *elf_data = fw->data;
> +	u8 class = fw_elf_get_class(fw);
> +	u32 elf_phdr_get_size = elf_size_of_phdr(class);
> +
> +	ehdr = elf_data;
> +	phnum = elf_hdr_get_e_phnum(class, ehdr);
> +	phdr = elf_data + elf_hdr_get_e_phoff(class, ehdr);
> +
> +	/* go through the available ELF segments */
> +	for (i = 0; i < phnum; i++, phdr += elf_phdr_get_size) {
> +		u64 da = elf_phdr_get_p_paddr(class, phdr);
> +		u64 memsz = elf_phdr_get_p_memsz(class, phdr);
> +		u64 filesz = elf_phdr_get_p_filesz(class, phdr);
> +		u64 offset = elf_phdr_get_p_offset(class, phdr);
> +		u32 type = elf_phdr_get_p_type(class, phdr);
> +		void *ptr;
> +
> +		if (type != PT_LOAD || !memsz)
> +			continue;
> +
> +		dev_dbg(dev, "phdr: type %d da 0x%llx memsz 0x%llx filesz 0x%llx\n",
> +			type, da, memsz, filesz);
> +
> +		if (filesz > memsz) {
> +			dev_err(dev, "bad phdr filesz 0x%llx memsz 0x%llx\n",
> +				filesz, memsz);
> +			ret = -EINVAL;
> +			break;
> +		}
> +
> +		if (offset + filesz > fw->size) {
> +			dev_err(dev, "truncated fw: need 0x%llx avail 0x%zx\n",
> +				offset + filesz, fw->size);
> +			ret = -EINVAL;
> +			break;
> +		}
> +
> +		if (!rproc_u64_fit_in_size_t(memsz)) {
> +			dev_err(dev, "size (%llx) does not fit in size_t type\n",
> +				memsz);
> +			ret = -EOVERFLOW;
> +			break;
> +		}
> +
> +		/* grab the kernel address for this device address */
> +		ptr = rproc_da_to_va(rproc, da, memsz, NULL);
> +		if (!ptr) {
> +			dev_err(dev, "bad phdr da 0x%llx mem 0x%llx\n", da,
> +				memsz);
> +			ret = -EINVAL;
> +			break;
> +		}
> +
> +		/* put the segment where the remote processor expects it */
> +		if (filesz) {
> +			ret = imx_dsp_rproc_memcpy(ptr, elf_data + offset, filesz);
> +			if (ret) {
> +				dev_err(dev, "memory copy failed for da 0x%llx memsz 0x%llx\n",
> +					da, memsz);
> +				break;
> +			}
> +		}
> +
> +		/* zero out remaining memory for this segment */
> +		if (memsz > filesz) {
> +			ret = imx_dsp_rproc_memset(ptr + filesz, 0, memsz - filesz);
> +			if (ret) {
> +				dev_err(dev, "memset failed for da 0x%llx memsz 0x%llx\n",
> +					da, memsz);
> +				break;
> +			}
> +		}
> +	}
> +
> +	return ret;
> +}
> +
>  static int imx_dsp_rproc_parse_fw(struct rproc *rproc, const struct firmware *fw)
>  {
>  	if (rproc_elf_load_rsc_table(rproc, fw))
> @@ -729,7 +908,7 @@ static const struct rproc_ops imx_dsp_rproc_ops = {
>  	.start		= imx_dsp_rproc_start,
>  	.stop		= imx_dsp_rproc_stop,
>  	.kick		= imx_dsp_rproc_kick,
> -	.load		= rproc_elf_load_segments,
> +	.load		= imx_dsp_rproc_elf_load_segments,
>  	.parse_fw	= imx_dsp_rproc_parse_fw,
>  	.sanity_check	= rproc_elf_sanity_check,
>  	.get_boot_addr	= rproc_elf_get_boot_addr,
> -- 
> 2.17.1
> 
