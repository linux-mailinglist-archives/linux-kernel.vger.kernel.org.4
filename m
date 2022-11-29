Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3555063C540
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 17:35:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235906AbiK2Qf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 11:35:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232537AbiK2QfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 11:35:23 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A6E5F87A
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 08:35:22 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id n20so35235536ejh.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 08:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3bzDizWscfG3+hy+wself0b3DVK5MDIXm+6RTdbFH5M=;
        b=oUJcgUiEmyeHeYloNm0QtToFOY5zMJBCwrftfRPOnkKtOVuKk7+GwO3oAez4IF2W2W
         iFlE6Ix5Gzp9GbBh6ZJgAPQ46OJLugCXgH5cBQmCX5xnPYcesE1NHk5SLC4lZd/AHTYs
         fpdLQzTa2qsNhqrO4mzxnDCmMKbkL8hVfxq7ZUk/iQopUM+jj5oCmDLP2eYolMeucN7X
         Z7Fsf2vj4W9XYsEKKKlFNLCTrHTyyGHcZ6Xk6uld1JDFPfzQJUXWe2uhQnMqEeXJ/8X3
         3JtOoXqXhCqrFwMei4sNneOXhoJri7YOy54a9atbaJgFZxbGwIod7P19Gki5zvAaUgow
         j/kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3bzDizWscfG3+hy+wself0b3DVK5MDIXm+6RTdbFH5M=;
        b=j68nnvZmb/NF18z4FZ4GZdWQA/7zzJ3WUKMqw2ZAzg489DmvjvoBKgTD36FMhm3FpW
         2V5meUIGwIV+U8cXAePbj0+dxg8keDfEYZIIpH1lZ/R3WvYPeGSsuko0QQi5NpYSdlNm
         lM1OEyiXvBQG/dQ6kO608MJy52HekonfaQxdmHX9dOTmUHWwCNWFBtfLI+PfmDZnqplK
         i8wi83Nid2iOKoMJnaIo0xdEd3QHtQRHQeVC4ZSoc4dkXGGQUJRySl1vubRvUOdkjZin
         UWS0Xly3UGPrK5Qa1LSLn8WNeFH6Yc+dZ9C/uBi5GrNhZwATqPGCWU/PikKNYJAphKjR
         O4SQ==
X-Gm-Message-State: ANoB5pki9K8+DTXsiCN7Irwy9iirnKdV9W9+kfAG3KL5UVWPt7XX52Z4
        jPAv/IoFFOiKxBTg9JoYPTWnkw==
X-Google-Smtp-Source: AA0mqf4kb0IlYXvkh3prsQJvS9xn5izyFm+Qr5JLbh7kcOgKD6eJpTpGiTJNOYeTOOF/IS3ECyBZPg==
X-Received: by 2002:a17:906:c011:b0:778:f9b6:6fc with SMTP id e17-20020a170906c01100b00778f9b606fcmr49024807ejz.580.1669739721090;
        Tue, 29 Nov 2022 08:35:21 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-748-2a9a-a2a6-1362.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:748:2a9a:a2a6:1362])
        by smtp.gmail.com with ESMTPSA id j18-20020a1709066dd200b0077016f4c6d4sm6343233ejt.55.2022.11.29.08.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 08:35:20 -0800 (PST)
Date:   Tue, 29 Nov 2022 17:35:19 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     linux-riscv@lists.infradead.org, aou@eecs.berkeley.edu,
        conor@kernel.org, devicetree@vger.kernel.org, guoren@kernel.org,
        heiko@sntech.de, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robh+dt@kernel.org
Subject: Re: [RFC 2/2] RISC-V: resort all extensions in "canonical" order
Message-ID: <20221129163519.mzgn3nrfiguc2v2s@kamzik>
References: <Y4XvnHIPw8ZuBZEk@wendy>
 <20221129144742.2935581-3-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221129144742.2935581-3-conor.dooley@microchip.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022 at 02:47:43PM +0000, Conor Dooley wrote:
> Per the comment in cpu.c, re-sort all lists/tables/enums/whatever in
> arch/riscv (apart from KVM) in the current edition of what the isa
> manual considers to be "canonical" order.
> 
> None of this is in uapi, so we are free to re-order it? I'm never sure
> when it comes to hwcap...
> 
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  arch/riscv/include/asm/hwcap.h | 6 +++---
>  arch/riscv/kernel/cpu.c        | 4 ++--
>  arch/riscv/kernel/cpufeature.c | 4 ++--
>  3 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
> index b22525290073..d7d5f27619ee 100644
> --- a/arch/riscv/include/asm/hwcap.h
> +++ b/arch/riscv/include/asm/hwcap.h
> @@ -53,12 +53,12 @@ extern unsigned long elf_hwcap;
>   * available logical extension id.
>   */
>  enum riscv_isa_ext_id {
> -	RISCV_ISA_EXT_SSCOFPMF = RISCV_ISA_EXT_BASE,
> -	RISCV_ISA_EXT_SVPBMT,
> -	RISCV_ISA_EXT_ZICBOM,
> +	RISCV_ISA_EXT_ZICBOM = RISCV_ISA_EXT_BASE,
>  	RISCV_ISA_EXT_ZIHINTPAUSE,
> +	RISCV_ISA_EXT_SSCOFPMF,
>  	RISCV_ISA_EXT_SSTC,
>  	RISCV_ISA_EXT_SVINVAL,
> +	RISCV_ISA_EXT_SVPBMT,
>  	RISCV_ISA_EXT_ID_MAX = RISCV_ISA_EXT_MAX,

Or,

@@ -48,17 +48,16 @@ extern unsigned long elf_hwcap;
 /*
  * This enum represent the logical ID for each multi-letter RISC-V ISA extension.
  * The logical ID should start from RISCV_ISA_EXT_BASE and must not exceed
- * RISCV_ISA_EXT_MAX. 0-25 range is reserved for single letter
- * extensions while all the multi-letter extensions should define the next
- * available logical extension id.
+ * RISCV_ISA_EXT_MAX. While the order doesn't matter, we keep it sorted
+ * alphabetically for neatness.
  */
 enum riscv_isa_ext_id {
        RISCV_ISA_EXT_SSCOFPMF = RISCV_ISA_EXT_BASE,
+       RISCV_ISA_EXT_SSTC,
+       RISCV_ISA_EXT_SVINVAL,
        RISCV_ISA_EXT_SVPBMT,
        RISCV_ISA_EXT_ZICBOM,
        RISCV_ISA_EXT_ZIHINTPAUSE,
-       RISCV_ISA_EXT_SSTC,
-       RISCV_ISA_EXT_SVINVAL,
        RISCV_ISA_EXT_ID_MAX = RISCV_ISA_EXT_MAX,
 };


>  };
>  
> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> index 5e42c92a8456..1d0fa0ebf6a8 100644
> --- a/arch/riscv/kernel/cpu.c
> +++ b/arch/riscv/kernel/cpu.c
> @@ -150,12 +150,12 @@ device_initcall(riscv_cpuinfo_init);
>   *    extensions by an underscore.
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

Yes, this one should be put in canonical order (I guess).

>  
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index 694267d1fe81..d3df72c4b94f 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -199,12 +199,12 @@ void __init riscv_fill_hwcap(void)
>  				this_hwcap |= isa2hwcap[(unsigned char)(*ext)];
>  				set_bit(*ext - 'a', this_isa);
>  			} else {
> -				SET_ISA_EXT_MAP("sscofpmf", RISCV_ISA_EXT_SSCOFPMF);
> -				SET_ISA_EXT_MAP("svpbmt", RISCV_ISA_EXT_SVPBMT);
>  				SET_ISA_EXT_MAP("zicbom", RISCV_ISA_EXT_ZICBOM);
>  				SET_ISA_EXT_MAP("zihintpause", RISCV_ISA_EXT_ZIHINTPAUSE);
> +				SET_ISA_EXT_MAP("sscofpmf", RISCV_ISA_EXT_SSCOFPMF);
>  				SET_ISA_EXT_MAP("sstc", RISCV_ISA_EXT_SSTC);
>  				SET_ISA_EXT_MAP("svinval", RISCV_ISA_EXT_SVINVAL);
> +				SET_ISA_EXT_MAP("svpbmt", RISCV_ISA_EXT_SVPBMT);

Or,

@@ -199,12 +199,16 @@ void __init riscv_fill_hwcap(void)
                                this_hwcap |= isa2hwcap[(unsigned char)(*ext)];
                                set_bit(*ext - 'a', this_isa);
                        } else {
+                               /*
+                                * While the order doesn't matter here, we sort
+                                * alphabetically for neatness.
+                                */
                                SET_ISA_EXT_MAP("sscofpmf", RISCV_ISA_EXT_SSCOFPMF);
+                               SET_ISA_EXT_MAP("sstc", RISCV_ISA_EXT_SSTC);
+                               SET_ISA_EXT_MAP("svinval", RISCV_ISA_EXT_SVINVAL);
                                SET_ISA_EXT_MAP("svpbmt", RISCV_ISA_EXT_SVPBMT);
                                SET_ISA_EXT_MAP("zicbom", RISCV_ISA_EXT_ZICBOM);
                                SET_ISA_EXT_MAP("zihintpause", RISCV_ISA_EXT_ZIHINTPAUSE);
-                               SET_ISA_EXT_MAP("sstc", RISCV_ISA_EXT_SSTC);
-                               SET_ISA_EXT_MAP("svinval", RISCV_ISA_EXT_SVINVAL);
                        }
 #undef SET_ISA_EXT_MAP
                }

>  			}
>  #undef SET_ISA_EXT_MAP
>  		}
> -- 
> 2.38.1
>

Thanks,
drew
