Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28B8063EBC2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 10:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiLAJA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 04:00:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiLAJAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 04:00:45 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE90D135
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 01:00:44 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id n20so2690384ejh.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 01:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ihgFOMdbOj72daezQcXUxkrleoQgY2o2vWjYoNLQrxo=;
        b=WEn7KylKZ7zOCZ7kz0YK9BJUhJceDWRAd6TeWOttd6ho+BoBcgt6B8K3nSOFBoQU1k
         VP2I1AqD5n35oTsGh61JVYiPhNdSw/hX8K5wB2rcCas5YHc/FQUzBgOPDiBZIgXrX1pQ
         jVlULJrmXWQ7UVrsrF0q27KZz3gZQszzA6+NbWA+20mxkj/NRvIIVEt7/Q6tUUUd+uAK
         mJdXkMyFtMwZGMmrWevkTdg6Ni18EOVANpfZi8rlWc/SqrwYF8ilnarQJfcHaZvH1jQX
         /31QmI4BlI4huT42L5YJaOW+MlD17jeHkDQGEzjigou/GWwYmXp53wRQVrimBb5kCG+s
         jwMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ihgFOMdbOj72daezQcXUxkrleoQgY2o2vWjYoNLQrxo=;
        b=1xVL6pEH3R1ZnBmxWyb+D1WFxen2R/hhoF8F40oG5upDJgsE1Cu+3O1B8hlWDnARfD
         7mN6wCfi8UczhB/tWy4MWd/YQ2P1UiRteHn6EDnqE/qOxddzQRVubfvOZGDCTaLmrfJF
         J01W/m0vSrzf6NjhuW/yyCyn9iLhAaQ99EXHMjIJ/RJS6iO3zPcZtER3KU6V/p491taI
         mVRsFbUK1Wo4KeQTh4wdmoaTEzIIgYa8F83a4lpHrTazxPWhlK3oac6kogTrYoFZSRdW
         UzfwgSKh7wy0gKAWO41/49HYMZSQjpWY/irlDJ1kbiG7lwfTBz3zNn3UYEgoZdrv7Ch1
         i8eQ==
X-Gm-Message-State: ANoB5pnoxElZdu+bHzxzAkR/KEpU03hBU+maYonVu7kCjAPxxA9qtlCC
        ZbgERJg6dMfmUga70fGUul/17Q==
X-Google-Smtp-Source: AA0mqf6VsVxo9yHx2NQ5hoTS0qSyTGPy2mzsKgZHE37tmVF1xwqq2Rmgt8+NTNp8AqyN1dKZVRGjog==
X-Received: by 2002:a17:906:3982:b0:7ad:8bc6:46e7 with SMTP id h2-20020a170906398200b007ad8bc646e7mr48710eje.28.1669885243022;
        Thu, 01 Dec 2022 01:00:43 -0800 (PST)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id b18-20020aa7d492000000b004615e1bbaf4sm1474587edr.87.2022.12.01.01.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 01:00:42 -0800 (PST)
Date:   Thu, 1 Dec 2022 10:00:41 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org,
        Conor Dooley <conor.dooley@microchip.com>,
        aou@eecs.berkeley.edu, corbet@lwn.net, guoren@kernel.org,
        heiko@sntech.de, paul.walmsley@sifive.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v1 2/3] RISC-V: resort all extensions in consistent orders
Message-ID: <20221201090041.525op4sateq5wq4y@kamzik>
References: <20221130234125.2722364-1-conor@kernel.org>
 <20221130234125.2722364-3-conor@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130234125.2722364-3-conor@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 11:41:25PM +0000, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> Ordering between each and every list of extensions is wildly
> inconsistent. Per discussion on the lists pick the following policy:
> 
> - The array defining order in /proc/cpuinfo follows a narrow
>   interpretation of the ISA specifications, described in a comment
>   immediately presiding it.
> 
> - All other lists of extensions are sorted alphabetically.
> 
> This will hopefully allow for easier review & future additions, and
> reduce conflicts between patchsets as the number of extensions grows.
> 
> Link: https://lore.kernel.org/all/20221129144742.2935581-2-conor.dooley@microchip.com/
> Suggested-by: Andrew Jones <ajones@ventanamicro.com>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> I could not decide between adding an alphabetical comment to each
> alphabetical site or not. I did it anyway. Scream if you hate it!
> 
> I also moved a static branch thingy in this version, but that should not
> matter, right? riightt?

riiighttt. And it goes away with [1] anyway.

[1] https://lore.kernel.org/all/20221006070818.3616-1-jszhang@kernel.org/

> ---
>  arch/riscv/include/asm/hwcap.h | 12 +++++++-----
>  arch/riscv/kernel/cpu.c        |  4 ++--
>  arch/riscv/kernel/cpufeature.c |  6 ++++--
>  3 files changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
> index b22525290073..ce522aad641a 100644
> --- a/arch/riscv/include/asm/hwcap.h
> +++ b/arch/riscv/include/asm/hwcap.h
> @@ -51,14 +51,15 @@ extern unsigned long elf_hwcap;
>   * RISCV_ISA_EXT_MAX. 0-25 range is reserved for single letter
>   * extensions while all the multi-letter extensions should define the next
>   * available logical extension id.
> + * Entries are sorted alphabetically.
>   */
>  enum riscv_isa_ext_id {
>  	RISCV_ISA_EXT_SSCOFPMF = RISCV_ISA_EXT_BASE,
> +	RISCV_ISA_EXT_SSTC,
> +	RISCV_ISA_EXT_SVINVAL,
>  	RISCV_ISA_EXT_SVPBMT,
>  	RISCV_ISA_EXT_ZICBOM,
>  	RISCV_ISA_EXT_ZIHINTPAUSE,
> -	RISCV_ISA_EXT_SSTC,
> -	RISCV_ISA_EXT_SVINVAL,
>  	RISCV_ISA_EXT_ID_MAX = RISCV_ISA_EXT_MAX,
>  };

Unrelated to this patch, but every time I look at this enum I want to post
the diff below, but I haven't bothered, because this enum also goes away
with [1].

@@ -59,8 +59,9 @@ enum riscv_isa_ext_id {
        RISCV_ISA_EXT_ZIHINTPAUSE,
        RISCV_ISA_EXT_SSTC,
        RISCV_ISA_EXT_SVINVAL,
-       RISCV_ISA_EXT_ID_MAX = RISCV_ISA_EXT_MAX,
+       RISCV_ISA_EXT_ID_MAX
 };
+static_assert(RISCV_ISA_EXT_ID_MAX <= RISCV_ISA_EXT_MAX);

 /*
  * This enum represents the logical ID for each RISC-V ISA extension static

>  
> @@ -66,11 +67,12 @@ enum riscv_isa_ext_id {
>   * This enum represents the logical ID for each RISC-V ISA extension static
>   * keys. We can use static key to optimize code path if some ISA extensions
>   * are available.
> + * Entries are sorted alphabetically.
>   */
>  enum riscv_isa_ext_key {
>  	RISCV_ISA_EXT_KEY_FPU,		/* For 'F' and 'D' */
> -	RISCV_ISA_EXT_KEY_ZIHINTPAUSE,
>  	RISCV_ISA_EXT_KEY_SVINVAL,
> +	RISCV_ISA_EXT_KEY_ZIHINTPAUSE,
>  	RISCV_ISA_EXT_KEY_MAX,
>  };
>  
> @@ -90,10 +92,10 @@ static __always_inline int riscv_isa_ext2key(int num)
>  		return RISCV_ISA_EXT_KEY_FPU;

And every time I look at this switch I want to delete the return line above...

>  	case RISCV_ISA_EXT_d:
>  		return RISCV_ISA_EXT_KEY_FPU;
> -	case RISCV_ISA_EXT_ZIHINTPAUSE:
> -		return RISCV_ISA_EXT_KEY_ZIHINTPAUSE;
>  	case RISCV_ISA_EXT_SVINVAL:
>  		return RISCV_ISA_EXT_KEY_SVINVAL;
> +	case RISCV_ISA_EXT_ZIHINTPAUSE:
> +		return RISCV_ISA_EXT_KEY_ZIHINTPAUSE;
>  	default:
>  		return -EINVAL;
>  	}
> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> index 68b2bd0cc3bc..686d41b14206 100644
> --- a/arch/riscv/kernel/cpu.c
> +++ b/arch/riscv/kernel/cpu.c
> @@ -161,12 +161,12 @@ device_initcall(riscv_cpuinfo_init);
>   * New entries to this struct should follow the ordering rules described above.
>   */
>  static struct riscv_isa_ext_data isa_ext_arr[] = {
> +	__RISCV_ISA_EXT_DATA(zicbom, RISCV_ISA_EXT_ZICBOM),
> +	__RISCV_ISA_EXT_DATA(zihintpause, RISCV_ISA_EXT_ZIHINTPAUSE),
>  	__RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
>  	__RISCV_ISA_EXT_DATA(sstc, RISCV_ISA_EXT_SSTC),
>  	__RISCV_ISA_EXT_DATA(svinval, RISCV_ISA_EXT_SVINVAL),
>  	__RISCV_ISA_EXT_DATA(svpbmt, RISCV_ISA_EXT_SVPBMT),
> -	__RISCV_ISA_EXT_DATA(zicbom, RISCV_ISA_EXT_ZICBOM),
> -	__RISCV_ISA_EXT_DATA(zihintpause, RISCV_ISA_EXT_ZIHINTPAUSE),
>  	__RISCV_ISA_EXT_DATA("", RISCV_ISA_EXT_MAX),
>  };

Technically we should have leave these in the wrong order if we want to be
strict about the ISA string published to userspace, but I'm in favor of
changing this array as necessary and hoping we teach userspace to use
flexible parsers. Actually, IMO, we shouldn't teach userspace to parse
this at all. We should instead create sysfs nodes:

 .../isa/zicbom
 .../isa/zihintpause
 .../isa/sscofpmf

and teach userspace to list .../isa/ to learn about extensions. That would
also allow us to publish extension version numbers which we are not
current doing with the proc isa string.

 .../isa/zicbom/major
 .../isa/zicbom/minor

and we could add other properties if necessary too, e.g.

 .../isa/zicbom/block_size

>  
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index 694267d1fe81..8a76a6ce70cf 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -199,12 +199,13 @@ void __init riscv_fill_hwcap(void)
>  				this_hwcap |= isa2hwcap[(unsigned char)(*ext)];
>  				set_bit(*ext - 'a', this_isa);
>  			} else {
> +				/* sorted alphabetically */
>  				SET_ISA_EXT_MAP("sscofpmf", RISCV_ISA_EXT_SSCOFPMF);
> +				SET_ISA_EXT_MAP("sstc", RISCV_ISA_EXT_SSTC);
> +				SET_ISA_EXT_MAP("svinval", RISCV_ISA_EXT_SVINVAL);
>  				SET_ISA_EXT_MAP("svpbmt", RISCV_ISA_EXT_SVPBMT);
>  				SET_ISA_EXT_MAP("zicbom", RISCV_ISA_EXT_ZICBOM);
>  				SET_ISA_EXT_MAP("zihintpause", RISCV_ISA_EXT_ZIHINTPAUSE);
> -				SET_ISA_EXT_MAP("sstc", RISCV_ISA_EXT_SSTC);
> -				SET_ISA_EXT_MAP("svinval", RISCV_ISA_EXT_SVINVAL);
>  			}
>  #undef SET_ISA_EXT_MAP
>  		}
> @@ -284,6 +285,7 @@ static bool __init_or_module cpufeature_probe_zicbom(unsigned int stage)
>   * This code may also be executed before kernel relocation, so we cannot use
>   * addresses generated by the address-of operator as they won't be valid in
>   * this context.
> + * Tests, unless otherwise required, are to be added in alphabetical order.
>   */
>  static u32 __init_or_module cpufeature_probe(unsigned int stage)
>  {
> -- 
> 2.38.1
> 

I realize that I have a suggested-by tag in the commit message, but I
don't really have a strong opinion on how we order extensions where the
order doesn't matter. A consistent policy of alphabetical or always at
the bottom both work for me. I personally prefer alphabetical when
reading the lists, but I realize we'll eventually merge stuff out of
order and then that'll generate some churn to reorder (but hopefully not
too frequently).

My biggest concern is how much we need to care about the order of the
string in proc and whether or not we're allowed to fix its order like
we're doing with this patch. I hope we can, and I vote we do.

Anyway, none of my comments apply directly to this patch, so

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks,
drew
