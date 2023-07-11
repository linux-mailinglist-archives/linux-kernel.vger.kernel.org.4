Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63E7C74F013
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 15:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232358AbjGKN0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 09:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232665AbjGKN0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 09:26:23 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8DA10CB
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 06:26:15 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fbf1b82dc7so58857835e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 06:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1689081974; x=1691673974;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PQ4QN8lSbvwIJvfCRdu3GsuuZZlEHhucGRO0HI9BGps=;
        b=PJfb3hZxD1mSUs9MjHm73olK4DicwNoMYeSMv4SmVst2QOScBvpV3bO73RyIVyoHe2
         N5X9vYfSQjWudLAtnv07WQmHT+QF23RRXHweVCqULhdmyAU6lMupirK5K4HztNkFWyWQ
         2BonOqwO8PwpW6inaCDuPcH8dnBfjj4oQja4PwPNtEx4cINT9RASxaO26SONHSkmN7uC
         L3t3ZnpFv/koV3TAy3ZIGOylsAL1TnJ3vnByQ693U3g0D+TkJLQVaAHuCVPTwt4JEGGY
         ocYZHKHXFlXnFMe6c0q9JWMZcKLKMz9OoOBk2eqh2QdR4ZjP84jq2L/ucSC3egH5t/m9
         i7MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689081974; x=1691673974;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PQ4QN8lSbvwIJvfCRdu3GsuuZZlEHhucGRO0HI9BGps=;
        b=IFiQxreHrfsviF+j9z0GgvIlNPl0m/0M5AMV5Z3R4PULbhUV/yzg03uRfaruLm7Own
         qrAyQVvw6bMBnwQlgT7r1IRx3CYAwS46Ex542hClLZZb27FlqsVYr/B25AKf6+wMN+N/
         SXhPXIydyfwv6NfSjwVyZEntHUxkE9g2b+1f658vAG98oLY+gmbJOiSDCevuxz3+mX0z
         477Fj122+dcoVfjPWCXZNKEH5E4UoTE0FmLLnLP8QLnrERr5oXSnf0brbRf6fYml731y
         /I2d8ObccxpC+pBDcppatiYSdoeCiojfNfRy7fWbfvG6pArIf304LCvOetcrioSCLAeG
         CWRg==
X-Gm-Message-State: ABy/qLa2QIVgBIsLk4ZgU0AqZ5hUrgpG2oPYoAxql2EJDDLfuphHeQmm
        RCcN4S9pO0ocquVlaqRZqKpbNg==
X-Google-Smtp-Source: APBJJlEGoS/Ne6jFT4BxyKW4qL53mJ8lQhsxyb/J+w7fzAoEB4xWcd9fSFFT0sAfAO0UhTmyjZjZHQ==
X-Received: by 2002:a7b:c5ce:0:b0:3fc:5a3:367c with SMTP id n14-20020a7bc5ce000000b003fc05a3367cmr9822539wmk.32.1689081974174;
        Tue, 11 Jul 2023 06:26:14 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id 24-20020a05600c22d800b003fbaade072dsm2569934wmg.23.2023.07.11.06.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 06:26:13 -0700 (PDT)
Date:   Tue, 11 Jul 2023 15:26:12 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Atish Patra <atishp@atishpatra.org>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Conor Dooley <conor@kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 1/9] RISC-V: Add riscv_fw_parent_hartid() function
Message-ID: <20230711-3151a76400deb88b218e9f9b@orel>
References: <20230710094321.1378351-1-apatel@ventanamicro.com>
 <20230710094321.1378351-2-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710094321.1378351-2-apatel@ventanamicro.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 03:13:13PM +0530, Anup Patel wrote:
> We add common riscv_fw_parent_hartid() which help device drivers
> to get parent hartid of the INTC (i.e. local interrupt controller)
> fwnode. This should work for both DT and ACPI.
> 
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  arch/riscv/include/asm/processor.h |  3 +++
>  arch/riscv/kernel/cpu.c            | 16 ++++++++++++++++
>  2 files changed, 19 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
> index c950a8d9edef..39dc23a18f88 100644
> --- a/arch/riscv/include/asm/processor.h
> +++ b/arch/riscv/include/asm/processor.h
> @@ -81,6 +81,9 @@ int riscv_of_processor_hartid(struct device_node *node, unsigned long *hartid);
>  int riscv_early_of_processor_hartid(struct device_node *node, unsigned long *hartid);
>  int riscv_of_parent_hartid(struct device_node *node, unsigned long *hartid);
>  
> +struct fwnode_handle;
> +int riscv_fw_parent_hartid(struct fwnode_handle *node, unsigned long *hartid);
> +
>  extern void riscv_fill_hwcap(void);
>  extern int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src);
>  
> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> index a2fc952318e9..9be9b3b1f333 100644
> --- a/arch/riscv/kernel/cpu.c
> +++ b/arch/riscv/kernel/cpu.c
> @@ -96,6 +96,22 @@ int riscv_of_parent_hartid(struct device_node *node, unsigned long *hartid)
>  	return -1;
>  }
>  
> +/* Find hart ID of the CPU fwnode under which given fwnode falls. */

This comment matches the comment for riscv_of_parent_hartid(), but I don't
think it will be correct for the !is_of_node(node) case since
fwnode_property_read_u64_array() isn't obliged to walk up its tree.
Looking ahead it appears riscv_fw_parent_hartid() is only called with the
parent node, so we could just drop this function and use
fwnode_property_read_u64_array() directly at the two call sites.

Thanks,
drew

> +int riscv_fw_parent_hartid(struct fwnode_handle *node, unsigned long *hartid)
> +{
> +	int rc;
> +	u64 temp;
> +
> +	if (!is_of_node(node)) {
> +		rc = fwnode_property_read_u64_array(node, "hartid", &temp, 1);
> +		if (!rc)
> +			*hartid = temp;
> +	} else
> +		rc = riscv_of_parent_hartid(to_of_node(node), hartid);
> +
> +	return rc;
> +}
> +
>  DEFINE_PER_CPU(struct riscv_cpuinfo, riscv_cpuinfo);
>  
>  unsigned long riscv_cached_mvendorid(unsigned int cpu_id)
> -- 
> 2.34.1
> 
