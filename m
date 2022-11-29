Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0516D63C4DF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 17:13:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236013AbiK2QM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 11:12:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236004AbiK2QM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 11:12:29 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C52368C4A
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 08:12:27 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id b2so18702116eja.7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 08:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a2BTyx6zja/aiP2vpU1kgbIcNE6NH07BMx/8T7jRK2A=;
        b=ANvZAIuNiA+jgFYRHiId7bCAXZ0st4A1Ivv1McCza4miewPJjMOnECcdKk8SgJhoEn
         xtw4y16QpvZ0E/V8080GtKCOvg2LMJMtzgqCEGoPi4rfQR2n84LHNczcRXT+8/xJ3VkU
         LGVDginlRkG/X+io9Ml3rtrtf0oPd7OaXKasWvdj3soNdyxD6fo9D5MBVVcvhF27mJ0f
         lEICX3kOVnfuG+b6ZbisSmnCk3Q30EWVlR9UDBK4wA3NuWRKENrPWb8kZ6ITfxmTD9+k
         kamM45FdTepWPGm9/Lmybfv9ZIQKSYlWOmqCqKOfGJp2a0i1Y+yf+jdYcDM8XbxkEG7j
         LivA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a2BTyx6zja/aiP2vpU1kgbIcNE6NH07BMx/8T7jRK2A=;
        b=AZL/RW55aLTAxuPa7rAzQ1Gs0rgvkbnCQE6beqqyuBwyd47uuMsq8o+jtg5xn+x5FZ
         emfekeS1JQOjIOqNnzaRrw0ZMFOS5bDC4CTUxBGOBy9yq0AR3zmNpYEMOLFiarGj9uLk
         aljE83GYWsUbKd1aeFHyKY5VJ3mfYncxg719sz2K9lXWwqXglMfIS6I1KriZ+JJWbGdS
         h8N85QNH314QJ3kz+MB2kRLipqMoN9wYlsx1SFmZZ1f+5CsAojFK7i+gRE5mmVr4DnVe
         3r/vq+R/yEAxkdW1nIEjxvCR12IgNorHQSfu57oRoDY0yZ0VuHYFcwiiu4aQgwZMrRpW
         Balg==
X-Gm-Message-State: ANoB5plJzruUYgKK7bi09I849a40H8HE1fGvZmmHxiv6o3cTGtFBlRqM
        aEQYXnzaixAIgdEvJb8OehajTQ==
X-Google-Smtp-Source: AA0mqf4omWTvqDfQ/sdcDi7RTXKGQ4FH+dy9PMnwghOxXXZ8/DddGvb6jwUaQVs9VfnK0zywMUMmxQ==
X-Received: by 2002:a17:906:844:b0:78c:2c03:804c with SMTP id f4-20020a170906084400b0078c2c03804cmr36090401ejd.107.1669738345813;
        Tue, 29 Nov 2022 08:12:25 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-748-2a9a-a2a6-1362.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:748:2a9a:a2a6:1362])
        by smtp.gmail.com with ESMTPSA id p23-20020a17090635d700b00780b1979adesm6318224ejb.218.2022.11.29.08.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 08:12:25 -0800 (PST)
Date:   Tue, 29 Nov 2022 17:12:23 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     linux-riscv@lists.infradead.org, aou@eecs.berkeley.edu,
        conor@kernel.org, devicetree@vger.kernel.org, guoren@kernel.org,
        heiko@sntech.de, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robh+dt@kernel.org
Subject: Re: [RFC 1/2] RISC-V: clarify ISA string ordering rules in cpu.c
Message-ID: <20221129161223.gelsvctfnqg7pdwb@kamzik>
References: <Y4XvnHIPw8ZuBZEk@wendy>
 <20221129144742.2935581-2-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221129144742.2935581-2-conor.dooley@microchip.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022 at 02:47:42PM +0000, Conor Dooley wrote:
> While the list of rules may have been accurate when created, it now
> lacks some clarity in the face of isa-manual updates. Specifically:
> 
> - there is no mention here of a distinction between regular 'Z'
>   extensions which are "Additional Standard Extensions" and "Zxm"
>   extensions which are "Standard Machine-Level Extensions"
> 
> - there is also no explicit mention of where either should be sorted in
>   the list
> 
> - underscores are only required between two *multi-letter* extensions but
>   the list of rules implies that this is required between a multi-letter
>   extension and any other extension. IOW "rv64imafdzicsr_zifencei" is a
>   valid string
> 
> Attempt to clean up the list of rules, by adding information on the
> above & sprinkling in some white space for readability.
> 
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  arch/riscv/kernel/cpu.c | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> index 852ecccd8920..5e42c92a8456 100644
> --- a/arch/riscv/kernel/cpu.c
> +++ b/arch/riscv/kernel/cpu.c
> @@ -120,20 +120,32 @@ device_initcall(riscv_cpuinfo_init);
>  		.uprop = #UPROP,				\
>  		.isa_ext_id = EXTID,				\
>  	}
> +
>  /*
>   * Here are the ordering rules of extension naming defined by RISC-V
>   * specification :
> - * 1. All extensions should be separated from other multi-letter extensions
> - *    by an underscore.
> + *
> + * 1. All multi-letter extensions should be separated from other multi-letter
> + *    extensions by an underscore.
> + *
>   * 2. The first letter following the 'Z' conventionally indicates the most
>   *    closely related alphabetical extension category, IMAFDQLCBKJTPVH.
> - *    If multiple 'Z' extensions are named, they should be ordered first
> - *    by category, then alphabetically within a category.
> + *    'Z' extensions should be sorted after single-letter extensions and before
> + *    any higher-privileged extensions.
> + *    If multiple 'Z' extensions are named, they should be ordered first by
> + *    category, then alphabetically within a category.
> + *
>   * 3. Standard supervisor-level extensions (starts with 'S') should be
>   *    listed after standard unprivileged extensions.  If multiple
>   *    supervisor-level extensions are listed, they should be ordered
>   *    alphabetically.
> - * 4. Non-standard extensions (starts with 'X') must be listed after all
> + *
> + * 4  Standard machine-level extensions (starts with 'Zxm') should be
> + *    listed after any lower-privileged, standard extensions.  If multiple
> + *    machine-level extensions are listed, they should be ordered
> + *    alphabetically.
> + *
> + * 5. Non-standard extensions (starts with 'X') must be listed after all
>   *    standard extensions. They must be separated from other multi-letter
>   *    extensions by an underscore.
>   */
> -- 
> 2.38.1
>

Alternatively, we could change the comment to just point out the spec
chapter and provide an example, e.g.

/*
 * The canonical order of ISA extension names in the ISA string is defined in
 * chapter 27 of the unprivileged spec. An example string following the
 * order is
 *
 *   rv64imadc_zifoo_zigoo_zafoo_sbar_scar_zxmbaz_xqux_xrux
 *
 * Notice how Z-extensions are first sorted by category using the canonical
 * order of the first letter following the Z. Extension groups are in the
 * order specified in chapter 27. Extensions within each group are sorted
 * alphabetically.
 */


Thanks,
drew
