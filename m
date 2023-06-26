Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3710F73E4E9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 18:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjFZQZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 12:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjFZQY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 12:24:29 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52DDDC5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 09:24:13 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-987accb4349so539471066b.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 09:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1687796652; x=1690388652;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T6E3UmB0Xi/qXW41cURjsiNGhcMzRCNjnl7kad4wxhM=;
        b=ayeq224af98Jx+LrP3eLJUWZj9TMhgYYJma26yREUHV/piGkeZoBT34wR7JHVj32AN
         EqjDPzPDoVWxxrU94wNliHobVwNZFaOY6GgPRbO45xnUS4mFRg0a9B1GWpYqcqr/XM/L
         4J0GucrMdq4Us5x1aqYlN6A26GGOQwWCRkB6BWu5yM6tIAf6piigL0acPO2xkeXjnCfK
         CWGidXt5c2cDOsSRDHL37wKtDvBqQLs/oZ9v+SYn8zZFpAJEd6i3jPYKTVioK4kbaaNv
         /R1Gpiqhk1nIEQiLr/Nr2mh6R+dy80Fm5RzNJT4ech7iz1MyhDSJq7QaB8jgL+vP6b1F
         SUsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687796652; x=1690388652;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T6E3UmB0Xi/qXW41cURjsiNGhcMzRCNjnl7kad4wxhM=;
        b=DVGwM+yTebrSIbpDK37/B4XaF2vlNFkOLqlc8PqO8izHDZF61wAlUqGfm+zYNpgq5F
         RYEffgLW/4kkI/Ov0U3n5hyCNgV4Ngb2L3+FEPcIIJO/leD83jxedTeS1/VzhJI/ihbJ
         OuGN0/rqO/dmbw618DSTJgZJcws/S2maVNzhXPVzVdADDQtsa+KllQwsg3mp7GsagVoo
         O1GDYdnd0DsMGuU6jq2u9Zlt/p53NQTogOvZeRF0w1rVHfh9myuY58cVtrMILzuECGUz
         thpjcw6Oqj+Av4JsRrnB57GofseEwJ0ja9gfPPVNgiiPPtjl0oVBqjtO9vhyIhtmivHN
         PauQ==
X-Gm-Message-State: AC+VfDxAlZhiKUBXquEfwEQEEsYuIqyVcuT9aClxHsvHhtlsy0RPJAoE
        7PCpvLzL/rTpeyMVP8TkF//0FQ==
X-Google-Smtp-Source: ACHHUZ41eOYZp1TH49I6A9aYgNs+yMw+J+TafTqXSN2v/oTUhy5q8B5rXl0iGQILTxaoHl4ejeM8CQ==
X-Received: by 2002:a17:907:9449:b0:988:b58d:5e0 with SMTP id dl9-20020a170907944900b00988b58d05e0mr18664489ejc.16.1687796651679;
        Mon, 26 Jun 2023 09:24:11 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id bu5-20020a170906a14500b0096f6a131b9fsm3456504ejb.23.2023.06.26.09.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 09:24:11 -0700 (PDT)
Date:   Mon, 26 Jun 2023 18:24:10 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     palmer@dabbelt.com, conor@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Evan Green <evan@rivosinc.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 8/9] RISC-V: enable extension detection from new
 properties
Message-ID: <20230626-5dca67a91d6c1b29c51c6169@orel>
References: <20230626-provable-angrily-81760e8c3cc6@wendy>
 <20230626-unfasten-guidance-eac4d71d8876@wendy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230626-unfasten-guidance-eac4d71d8876@wendy>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 12:19:46PM +0100, Conor Dooley wrote:
> Add support for parsing the new riscv,isa-extensions property in
> riscv_fill_hwcap(), by means of a new "property" member of the
> riscv_isa_ext_data struct. For now, this shadows the name of the
> extension, however this may not be the case for all extensions.
> For the sake of backwards compatibility, fall back to the old scheme
> if the new properties are not detected. For now, just inform, rather
> than warn, when that happens.
> 
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> Naming things is hard, didn't know what to call the new function...

riscv_fill_hwcap_from_isa_extensions() ?

_new() won't age well.

> ---
>  arch/riscv/include/asm/hwcap.h |  1 +
>  arch/riscv/kernel/cpufeature.c | 80 ++++++++++++++++++++++++++++++----
>  2 files changed, 72 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
> index 6ad896dc4342..e7f235868aa2 100644
> --- a/arch/riscv/include/asm/hwcap.h
> +++ b/arch/riscv/include/asm/hwcap.h
> @@ -77,6 +77,7 @@ unsigned long riscv_get_elf_hwcap(void);
>  struct riscv_isa_ext_data {
>  	const unsigned int id;
>  	const char *name;
> +	const char *property;
>  	const bool multi_letter;
>  };
>  
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index 366477ba1eea..72eb757ad871 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -101,6 +101,7 @@ static bool riscv_isa_extension_check(int id)
>  
>  #define __RISCV_ISA_EXT_DATA(_name, _id, _multi) {	\
>  	.name = #_name,					\
> +	.property = #_name,				\
>  	.id = _id,					\
>  	.multi_letter = _multi,				\
>  }
> @@ -416,16 +417,66 @@ static void __init riscv_fill_hwcap_from_isa_string(unsigned long *isa2hwcap)
>  		acpi_put_table((struct acpi_table_header *)rhct);
>  }
>  
> +static int __init riscv_fill_hwcap_new(unsigned long *isa2hwcap)
> +{
> +	unsigned int cpu;
> +
> +	for_each_possible_cpu(cpu) {
> +		unsigned long this_hwcap = 0;
> +		struct device_node *cpu_node;
> +		DECLARE_BITMAP(this_isa, RISCV_ISA_EXT_MAX);
> +
> +		cpu_node = of_cpu_device_node_get(cpu);
> +		if (!cpu_node) {
> +			pr_warn("Unable to find cpu node\n");
> +			continue;
> +		}
> +
> +		if (!of_property_present(cpu_node, "riscv,isa-extensions"))
> +			continue;
> +
> +		for (int i = 0; i < riscv_isa_ext_count; i++) {
> +			if (of_property_match_string(cpu_node, "riscv,isa-extensions",
> +						     riscv_isa_ext[i].name) < 0)
> +				continue;
> +
> +			if (!riscv_isa_extension_check(riscv_isa_ext[i].id))
> +				continue;
> +
> +			if (!riscv_isa_ext[i].multi_letter)
> +				this_hwcap |= isa2hwcap[riscv_isa_ext[i].id];
> +
> +			set_bit(riscv_isa_ext[i].id, this_isa);
> +		}
> +
> +		of_node_put(cpu_node);
> +
> +		/*
> +		 * All "okay" harts should have same isa. Set HWCAP based on
> +		 * common capabilities of every "okay" hart, in case they don't.
> +		 */
> +		if (elf_hwcap)
> +			elf_hwcap &= this_hwcap;
> +		else
> +			elf_hwcap = this_hwcap;
> +
> +		if (bitmap_empty(riscv_isa, RISCV_ISA_EXT_MAX))
> +			bitmap_copy(riscv_isa, this_isa, RISCV_ISA_EXT_MAX);
> +		else
> +			bitmap_and(riscv_isa, riscv_isa, this_isa, RISCV_ISA_EXT_MAX);
> +	}
> +
> +	if (bitmap_empty(riscv_isa, RISCV_ISA_EXT_MAX))
> +		return -ENOENT;
> +
> +	return 0;
> +}
> +
>  void __init riscv_fill_hwcap(void)
>  {
> -	struct device_node *node;
> -	const char *isa;
>  	char print_str[NUM_ALPHA_EXTS + 1];
> -	int i, j, rc;
>  	unsigned long isa2hwcap[26] = {0};
> -	struct acpi_table_header *rhct;
> -	acpi_status status;
> -	unsigned int cpu;
> +	int i, j;
>  
>  	isa2hwcap['i' - 'a'] = COMPAT_HWCAP_ISA_I;
>  	isa2hwcap['m' - 'a'] = COMPAT_HWCAP_ISA_M;
> @@ -435,10 +486,21 @@ void __init riscv_fill_hwcap(void)
>  	isa2hwcap['c' - 'a'] = COMPAT_HWCAP_ISA_C;
>  	isa2hwcap['v' - 'a'] = COMPAT_HWCAP_ISA_V;
>  
> -	riscv_fill_hwcap_from_isa_string(isa2hwcap);
> +	if (!acpi_disabled) {
> +		riscv_fill_hwcap_from_isa_string(isa2hwcap);
> +	} else {
> +		int ret = riscv_fill_hwcap_new(isa2hwcap);
>  
> -	/* We don't support systems with F but without D, so mask those out
> -	 * here. */
> +		if (ret) {
> +			pr_info("Falling back to deprecated \"riscv,isa\"\n");
> +			riscv_fill_hwcap_from_isa_string(isa2hwcap);
> +		}
> +	}
> +
> +	/*
> +	 * We don't support systems with F but without D, so mask those out
> +	 * here.
> +	 */
>  	if ((elf_hwcap & COMPAT_HWCAP_ISA_F) && !(elf_hwcap & COMPAT_HWCAP_ISA_D)) {
>  		pr_info("This kernel does not support systems with F but not D\n");
>  		elf_hwcap &= ~COMPAT_HWCAP_ISA_F;
> -- 
> 2.40.1
>

Other than the name and moving the removal of the unused declarations to
the previous patch,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks,
drew
