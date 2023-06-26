Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9084A73E4F5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 18:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbjFZQ0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 12:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbjFZQZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 12:25:32 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9231B1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 09:25:30 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-991aac97802so188192666b.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 09:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1687796729; x=1690388729;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4Gm0byWzIZvJKygPvrq4jnlftwE0Yo5FdjhxVJ4PNAE=;
        b=Ne2KXk/Uoxjt97ZERJ/38f00T4yqTnRxlkmWt4VLueghpQYZEWTFslb+q07Ff90vnM
         Q28N1PdFvy+/osrZTUDE7KeufuDp2ox5iC5oeuQXj34xy8pUMSbviwC6rk2/GXilOiUC
         XKhcIQ6oCXUErTh+Piv/iQ3H++7KCUr8nka3/Fs071ly3b8u/2YfZNgOhW1pCNvBviMt
         U4wxrS2I5C4a/uO6S528BRMugKGVIVVCx2WTVtk+PxPQ5q86xMR4UQsTTIo2aYEc/3k2
         N3IalRFKkKRUcsC4/6jQlKke0T7sRrUYb7Drta4ykvBYgOJgrSzNkxfZnJVuuv/huCHT
         dWYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687796729; x=1690388729;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Gm0byWzIZvJKygPvrq4jnlftwE0Yo5FdjhxVJ4PNAE=;
        b=HyNtcetDmx8sWkG2Tle65rF/b4Xqb2GW78HbGuYreuf73ObWWNgDiysnXxlOw1HMSp
         xb8UEJUYiVqamDdqU5N67ACmiuDw7zaE3vsePIa3isNK5whcWktsgR+lOFyBgGtC023U
         O4gPR004R4MXQUmzFrby4WHkpYDfh51QL2pTMfyW9CWRjRobxUznSNgsnT7GM+Is3lMI
         aVKKG54RhVJC0QqqEeaaszZjMjZxzw4mbwFJGN0vcNLiOPwgmEWeWHkagP0t301C7oMF
         yYTjLAS6f9dPDSe5z3ihbdBlXnL5bJ2uNWy9wLzAxP5FVOcogX8RlsKYbrt6HMmku21p
         yUPw==
X-Gm-Message-State: AC+VfDzyAz86kbbEJhupi1rjeirTnx4ACsl1j8pbdyhbxaYda5CkgzdL
        8/cOo07L+w1fIh4hHhinxsUhIA==
X-Google-Smtp-Source: ACHHUZ5aBiBeSUxla3z5EaON8Xp718BV5eWXZ6FB6tziHGOH3UN4WTuOXox8wp/dqsGVNjWJGveLrQ==
X-Received: by 2002:a17:907:97cf:b0:991:e961:a5f4 with SMTP id js15-20020a17090797cf00b00991e961a5f4mr1361813ejc.20.1687796729364;
        Mon, 26 Jun 2023 09:25:29 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id v8-20020a170906338800b0099027b40d85sm1716900eja.112.2023.06.26.09.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 09:25:29 -0700 (PDT)
Date:   Mon, 26 Jun 2023 18:25:28 +0200
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
Subject: Re: [PATCH v1 9/9] RISC-V: try new extension properties in
 of_early_processor_hartid()
Message-ID: <20230626-9ed40a55c71d2fe50ed3b8da@orel>
References: <20230626-provable-angrily-81760e8c3cc6@wendy>
 <20230626-ardently-caress-7c5886566ea6@wendy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230626-ardently-caress-7c5886566ea6@wendy>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 12:19:47PM +0100, Conor Dooley wrote:
> To fully deprecate the kernel's use of "riscv,isa",
> of_early_processor_hartid() needs to first try using the new properties,
> before falling back to "riscv,isa".
> 
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  arch/riscv/kernel/cpu.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> index 046d9d3dac16..332574f27c95 100644
> --- a/arch/riscv/kernel/cpu.c
> +++ b/arch/riscv/kernel/cpu.c
> @@ -61,8 +61,29 @@ int riscv_early_of_processor_hartid(struct device_node *node, unsigned long *har
>  		return -ENODEV;
>  	}
>  
> +	if (of_property_read_string(node, "riscv,isa-base", &isa))
> +		goto old_interface;
> +
> +	if (IS_ENABLED(CONFIG_32BIT) && strncasecmp(isa, "rv32i", 5))
> +		return -ENODEV;
> +
> +	if (IS_ENABLED(CONFIG_64BIT) && strncasecmp(isa, "rv64i", 5))
> +		return -ENODEV;
> +
> +	if (!of_property_present(node, "riscv,isa-extensions"))
> +		return -ENODEV;
> +
> +	if (of_property_match_string(node, "riscv,isa-extensions", "i") < 0 ||
> +	    of_property_match_string(node, "riscv,isa-extensions", "m") < 0 ||
> +	    of_property_match_string(node, "riscv,isa-extensions", "a") < 0)
> +		return -ENODEV;
> +
> +	return 0;
> +
> +old_interface:
>  	if (of_property_read_string(node, "riscv,isa", &isa)) {
> -		pr_warn("CPU with hartid=%lu has no \"riscv,isa\" property\n", *hart);
> +		pr_warn("CPU with hartid=%lu has no \"riscv,isa-base\" or \"riscv,isa\" property\n",
> +			*hart);
>  		return -ENODEV;
>  	}
>  
> -- 
> 2.40.1
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
