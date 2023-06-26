Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF5273E34D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 17:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbjFZP3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 11:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjFZP3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 11:29:09 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3BBB18E
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 08:29:07 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-51bece5d935so4705812a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 08:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1687793346; x=1690385346;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bV69LujuUOskjbwAt+Ykc32yYmsOWfwLw8XOEZvRwcY=;
        b=f6laXhQxVHPkjD7kMD0jD9VZs+746R3zxFENrbzvjoQuSJ8sqpndwR2/hI7nGCj+zk
         LPb6iz12py5lzlQpVMbKYzPXM2eBlBXEfZkdAro08r/LiiGtcv3waA68zx3rGiYt5i1t
         iZHwBF1qET0Y1nODR32CuQNdK2dphW6g/Gqg3/39gfk4uvtKarRxfbpu7Ntza8JDjVSr
         CdUp+g9BTLRq0MtzBfjcdASS/kAMIRwD5BV6Ksx7vNCHJwiv+SdVHP+XNBPyE+YLLM5x
         n1aySynwhEIyW/zQxkO52xTdGuvgbOaAKtY4noCwiOslddizwRd8fiH47muMh6bdTv5t
         duIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687793346; x=1690385346;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bV69LujuUOskjbwAt+Ykc32yYmsOWfwLw8XOEZvRwcY=;
        b=OuPfcH7cwEIaQP/r+/e6V84x4U49BCyIL4x+EJcdqtMNAo1x0oikF74WCnkYseb8CO
         4eW6Pfq8LB18/x3e8p2zOuGumbQkBvBbNJY2oY6UmiZhaDaKG5towmNeHcWMU+Yr4yoL
         q/uNVrKvkyHUSGcFAd4I42OUBZcgaumFxPzKCO04uaVl+FqHUvssfT7C/z4UKKpYUrvQ
         KwiOQWtMAAebLalj+IPwJhAB9lX0gCjTPiUFpoHn87xwXZZebPWCEWUdNv9+bwbl1nCd
         PR41p3+XdX8h1DfbkTi7G7HZALOQsixhOmeGejGy/JiuThf/Lb48ctRPY3nAAV73Y2xN
         iH0g==
X-Gm-Message-State: AC+VfDweTzzsgTucQYHQBRVWUbnDfgh4ZVeahRFFQlbI0AEcsYRRhdkz
        eUv+X0+vQX+PDt9LBugUteIFqw==
X-Google-Smtp-Source: ACHHUZ6mpvDdVTSuCiCDJ4Uruk/XrW5nOpiqd0Ei9iT7vFRkOn52tmAjd/aWppvqEiGJFb8/vDwRDg==
X-Received: by 2002:a17:907:5ca:b0:987:59b6:c9fa with SMTP id wg10-20020a17090705ca00b0098759b6c9famr24557801ejb.19.1687793345961;
        Mon, 26 Jun 2023 08:29:05 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id l9-20020a1709060e0900b0098de7d28c34sm3308336eji.193.2023.06.26.08.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 08:29:05 -0700 (PDT)
Date:   Mon, 26 Jun 2023 17:29:04 +0200
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
Subject: Re: [PATCH v1 3/9] RISC-V: shunt isa_ext_arr to cpufeature.c
Message-ID: <20230626-79b06f642aa2996098c9353d@orel>
References: <20230626-provable-angrily-81760e8c3cc6@wendy>
 <20230626-endowment-crave-d72f9423c5b3@wendy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230626-endowment-crave-d72f9423c5b3@wendy>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 12:19:41PM +0100, Conor Dooley wrote:
> To facilitate using one struct to define extensions, rather than having
> several, shunt isa_ext_arr to cpufeature.c, where it will be used for
> probing extension presence also.
> As that scope of the array as widened, prefix it with riscv & drop the
> type from the variable name.
> 
> Since the new array is const, print_isa() needs a wee bit of cleanup to
> avoid complaints about losing the const qualifier.
> 
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  arch/riscv/include/asm/hwcap.h |  3 ++
>  arch/riscv/kernel/cpu.c        | 75 +---------------------------------
>  arch/riscv/kernel/cpufeature.c | 68 ++++++++++++++++++++++++++++++
>  3 files changed, 73 insertions(+), 73 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
> index f041bfa7f6a0..7a57e6109aef 100644
> --- a/arch/riscv/include/asm/hwcap.h
> +++ b/arch/riscv/include/asm/hwcap.h
> @@ -76,6 +76,9 @@ struct riscv_isa_ext_data {
>  	unsigned int isa_ext_id;
>  };
>  
> +extern const struct riscv_isa_ext_data riscv_isa_ext[];
> +extern const size_t riscv_isa_ext_count;
> +
>  unsigned long riscv_isa_extension_base(const unsigned long *isa_bitmap);
>  
>  #define riscv_isa_extension_mask(ext) BIT_MASK(RISCV_ISA_EXT_##ext)
> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> index 01f7e5c62997..61fb92e7d524 100644
> --- a/arch/riscv/kernel/cpu.c
> +++ b/arch/riscv/kernel/cpu.c
> @@ -160,81 +160,10 @@ arch_initcall(riscv_cpuinfo_init);
>  
>  #ifdef CONFIG_PROC_FS
>  
> -#define __RISCV_ISA_EXT_DATA(UPROP, EXTID) \
> -	{							\
> -		.uprop = #UPROP,				\
> -		.isa_ext_id = EXTID,				\
> -	}
> -
> -/*
> - * The canonical order of ISA extension names in the ISA string is defined in
> - * chapter 27 of the unprivileged specification.
> - *
> - * Ordinarily, for in-kernel data structures, this order is unimportant but
> - * isa_ext_arr defines the order of the ISA string in /proc/cpuinfo.
> - *
> - * The specification uses vague wording, such as should, when it comes to
> - * ordering, so for our purposes the following rules apply:
> - *
> - * 1. All multi-letter extensions must be separated from other extensions by an
> - *    underscore.
> - *
> - * 2. Additional standard extensions (starting with 'Z') must be sorted after
> - *    single-letter extensions and before any higher-privileged extensions.
> -
> - * 3. The first letter following the 'Z' conventionally indicates the most
> - *    closely related alphabetical extension category, IMAFDQLCBKJTPVH.
> - *    If multiple 'Z' extensions are named, they must be ordered first by
> - *    category, then alphabetically within a category.
> - *
> - * 3. Standard supervisor-level extensions (starting with 'S') must be listed
> - *    after standard unprivileged extensions.  If multiple supervisor-level
> - *    extensions are listed, they must be ordered alphabetically.
> - *
> - * 4. Standard machine-level extensions (starting with 'Zxm') must be listed
> - *    after any lower-privileged, standard extensions.  If multiple
> - *    machine-level extensions are listed, they must be ordered
> - *    alphabetically.
> - *
> - * 5. Non-standard extensions (starting with 'X') must be listed after all
> - *    standard extensions. If multiple non-standard extensions are listed, they
> - *    must be ordered alphabetically.
> - *
> - * An example string following the order is:
> - *    rv64imadc_zifoo_zigoo_zafoo_sbar_scar_zxmbaz_xqux_xrux
> - *
> - * New entries to this struct should follow the ordering rules described above.
> - */
> -static struct riscv_isa_ext_data isa_ext_arr[] = {
> -	__RISCV_ISA_EXT_DATA(zicbom, RISCV_ISA_EXT_ZICBOM),
> -	__RISCV_ISA_EXT_DATA(zicboz, RISCV_ISA_EXT_ZICBOZ),
> -	__RISCV_ISA_EXT_DATA(zicntr, RISCV_ISA_EXT_ZICNTR),
> -	__RISCV_ISA_EXT_DATA(zicsr, RISCV_ISA_EXT_ZICSR),
> -	__RISCV_ISA_EXT_DATA(zifencei, RISCV_ISA_EXT_ZIFENCEI),
> -	__RISCV_ISA_EXT_DATA(zihintpause, RISCV_ISA_EXT_ZIHINTPAUSE),
> -	__RISCV_ISA_EXT_DATA(zihpm, RISCV_ISA_EXT_ZIHPM),
> -	__RISCV_ISA_EXT_DATA(zba, RISCV_ISA_EXT_ZBA),
> -	__RISCV_ISA_EXT_DATA(zbb, RISCV_ISA_EXT_ZBB),
> -	__RISCV_ISA_EXT_DATA(zbs, RISCV_ISA_EXT_ZBS),
> -	__RISCV_ISA_EXT_DATA(smaia, RISCV_ISA_EXT_SMAIA),
> -	__RISCV_ISA_EXT_DATA(ssaia, RISCV_ISA_EXT_SSAIA),
> -	__RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
> -	__RISCV_ISA_EXT_DATA(sstc, RISCV_ISA_EXT_SSTC),
> -	__RISCV_ISA_EXT_DATA(svinval, RISCV_ISA_EXT_SVINVAL),
> -	__RISCV_ISA_EXT_DATA(svnapot, RISCV_ISA_EXT_SVNAPOT),
> -	__RISCV_ISA_EXT_DATA(svpbmt, RISCV_ISA_EXT_SVPBMT),
> -	__RISCV_ISA_EXT_DATA("", RISCV_ISA_EXT_MAX),
> -};
> -
>  static void print_isa_ext(struct seq_file *f)
>  {
> -	struct riscv_isa_ext_data *edata;
> -	int i = 0, arr_sz;
> -
> -	arr_sz = ARRAY_SIZE(isa_ext_arr) - 1;
> -
> -	for (i = 0; i <= arr_sz; i++) {
> -		edata = &isa_ext_arr[i];
> +	for (int i = 0; i < riscv_isa_ext_count; i++) {
> +		const struct riscv_isa_ext_data *edata = &riscv_isa_ext[i];
>  		if (!__riscv_isa_extension_available(NULL, edata->isa_ext_id))
>  			continue;
>  		seq_printf(f, "_%s", edata->uprop);
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index bdcf460ea53d..f0ae310006de 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -99,6 +99,74 @@ static bool riscv_isa_extension_check(int id)
>  	return true;
>  }
>  
> +#define __RISCV_ISA_EXT_DATA(UPROP, EXTID) \
> +	{							\
> +		.uprop = #UPROP,				\
> +		.isa_ext_id = EXTID,				\
> +	}
> +
> +/*
> + * The canonical order of ISA extension names in the ISA string is defined in
> + * chapter 27 of the unprivileged specification.
> + *
> + * Ordinarily, for in-kernel data structures, this order is unimportant but
> + * isa_ext_arr defines the order of the ISA string in /proc/cpuinfo.
> + *
> + * The specification uses vague wording, such as should, when it comes to
> + * ordering, so for our purposes the following rules apply:
> + *
> + * 1. All multi-letter extensions must be separated from other extensions by an
> + *    underscore.
> + *
> + * 2. Additional standard extensions (starting with 'Z') must be sorted after
> + *    single-letter extensions and before any higher-privileged extensions.
> + *
> + * 3. The first letter following the 'Z' conventionally indicates the most
> + *    closely related alphabetical extension category, IMAFDQLCBKJTPVH.
> + *    If multiple 'Z' extensions are named, they must be ordered first by
> + *    category, then alphabetically within a category.
> + *
> + * 3. Standard supervisor-level extensions (starting with 'S') must be listed
> + *    after standard unprivileged extensions.  If multiple supervisor-level
> + *    extensions are listed, they must be ordered alphabetically.
> + *
> + * 4. Standard machine-level extensions (starting with 'Zxm') must be listed
> + *    after any lower-privileged, standard extensions.  If multiple
> + *    machine-level extensions are listed, they must be ordered
> + *    alphabetically.
> + *
> + * 5. Non-standard extensions (starting with 'X') must be listed after all
> + *    standard extensions. If multiple non-standard extensions are listed, they
> + *    must be ordered alphabetically.
> + *
> + * An example string following the order is:
> + *    rv64imadc_zifoo_zigoo_zafoo_sbar_scar_zxmbaz_xqux_xrux
> + *
> + * New entries to this struct should follow the ordering rules described above.
> + */
> +const struct riscv_isa_ext_data riscv_isa_ext[] = {
> +	__RISCV_ISA_EXT_DATA(zicbom, RISCV_ISA_EXT_ZICBOM),
> +	__RISCV_ISA_EXT_DATA(zicboz, RISCV_ISA_EXT_ZICBOZ),
> +	__RISCV_ISA_EXT_DATA(zicntr, RISCV_ISA_EXT_ZICNTR),
> +	__RISCV_ISA_EXT_DATA(zicsr, RISCV_ISA_EXT_ZICSR),
> +	__RISCV_ISA_EXT_DATA(zifencei, RISCV_ISA_EXT_ZIFENCEI),
> +	__RISCV_ISA_EXT_DATA(zihintpause, RISCV_ISA_EXT_ZIHINTPAUSE),
> +	__RISCV_ISA_EXT_DATA(zihpm, RISCV_ISA_EXT_ZIHPM),
> +	__RISCV_ISA_EXT_DATA(zba, RISCV_ISA_EXT_ZBA),
> +	__RISCV_ISA_EXT_DATA(zbb, RISCV_ISA_EXT_ZBB),
> +	__RISCV_ISA_EXT_DATA(zbs, RISCV_ISA_EXT_ZBS),
> +	__RISCV_ISA_EXT_DATA(smaia, RISCV_ISA_EXT_SMAIA),
> +	__RISCV_ISA_EXT_DATA(ssaia, RISCV_ISA_EXT_SSAIA),
> +	__RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
> +	__RISCV_ISA_EXT_DATA(sstc, RISCV_ISA_EXT_SSTC),
> +	__RISCV_ISA_EXT_DATA(svinval, RISCV_ISA_EXT_SVINVAL),
> +	__RISCV_ISA_EXT_DATA(svnapot, RISCV_ISA_EXT_SVNAPOT),
> +	__RISCV_ISA_EXT_DATA(svpbmt, RISCV_ISA_EXT_SVPBMT),
> +	__RISCV_ISA_EXT_DATA("", RISCV_ISA_EXT_MAX),

I think we can either drop this null entry or drop the count variable
below. My preference would be to drop the count variable, and always
loop to the null.

> +};
> +
> +const size_t riscv_isa_ext_count = ARRAY_SIZE(riscv_isa_ext);
> +
>  void __init riscv_fill_hwcap(void)
>  {
>  	struct device_node *node;
> -- 
> 2.40.1
>

Otherwise,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks,
drew
