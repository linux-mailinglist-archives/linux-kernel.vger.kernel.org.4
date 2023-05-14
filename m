Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52CBF701DAC
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 15:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233829AbjENN4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 09:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjENN4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 09:56:07 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B7919AC;
        Sun, 14 May 2023 06:56:05 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f139de8cefso60571219e87.0;
        Sun, 14 May 2023 06:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684072564; x=1686664564;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/ZVKIUKzGX05OMg0P/SQC1TBuz/zx2SrEhQdY2C1eVk=;
        b=e0jL1+x+B+CVF5D5kZvCOlSKlGE+7Pz/TLv0uhcK/uzns0Bh8hero3o8Fo/erRqUCJ
         PitZDzEqXuKhiXoferofSQxwm1+ZlDLyTDQ9Wtm8fL2MD5Nd8nS2mmp68juxCoACoad7
         eCKBMLrKglQPGDfshYP4i/xyujCWSCEQxjAKTeZSzTyc5uXpVTkbkKIqAZ6VmYwjo9b6
         D+2IpuJ/raLjQcDG5x8whLooOicrUw8ENJKD2xmQR8NPmEH1RZ8yMZhYb8Sur8qNM+WC
         nvna/yVJ9DvOrUp4eXaSwvVEidy5kuDXu5Ipg9O5hWOLCFai3Bpijjkpbf6zaPkE8A5M
         0fGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684072564; x=1686664564;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ZVKIUKzGX05OMg0P/SQC1TBuz/zx2SrEhQdY2C1eVk=;
        b=Orx5QsZaPkG3VwhWkf25+rbeGZwHjVBqjrG/u45Lp5wzMDIW16TbNzQJvVdcXkjET9
         I2w3RTnCmvQwAzlofs3x9MnAzhJBpk9CSum7ME6F7Fa/t1YWU99zoBQ8EF/s71mSSJv3
         Ph3FfDxDm9llvMVq/o1hzbe3UIm5BYzv78G/0FI1IWcfVnmnTcP9FfHkNPOm8do3K8jA
         SOKzTCcni2VtOWdC2faWzXE0UtWqbR7DC9Vc2gqS0n8HXFeA4ieEFMzJLnjrZxMD0Rqn
         5IjRPIE0MJ4hi9rd5ZTsk4Fu0239cd8otRDu00ITioWYCe0txjp01l563jSpr6J4lQdM
         VGqg==
X-Gm-Message-State: AC+VfDxd/e++HlYpaJcJXpfGsOW0oF8QQ7TxPYVjAoMYiTlPh1QX+/Aa
        uzZPBribhfBO5RxdqaFerRw=
X-Google-Smtp-Source: ACHHUZ7mQ7RO6cdlG9W7P4VAMMcMRRu+pFti/c2Y25RROUCnNz6dYcMDHV9/AJDpmEfzZe3BiBUSKw==
X-Received: by 2002:ac2:47f8:0:b0:4f3:78dd:8e0b with SMTP id b24-20020ac247f8000000b004f378dd8e0bmr928479lfp.32.1684072563576;
        Sun, 14 May 2023 06:56:03 -0700 (PDT)
Received: from mobilestation ([95.79.140.35])
        by smtp.gmail.com with ESMTPSA id n15-20020ac2490f000000b004efe9a169d2sm2224611lfi.64.2023.05.14.06.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 May 2023 06:56:03 -0700 (PDT)
Date:   Sun, 14 May 2023 16:56:01 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     maz@kernel.org, tsbogend@alpha.franken.de, tglx@linutronix.de,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 2/2] irqchip/mips-gic: Use raw spinlock for gic_lock
Message-ID: <20230514135601.5irhslf6tdv4tk5z@mobilestation>
References: <20230424103156.66753-1-jiaxun.yang@flygoat.com>
 <20230424103156.66753-3-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230424103156.66753-3-jiaxun.yang@flygoat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2023 at 11:31:56AM +0100, Jiaxun Yang wrote:
> Since we may hold gic_lock in hardirq context, use raw spinlock
> makes more sense given that it is for low-level interrupt handling
> routine and the critical section is small.
> 
> Fixes BUG:
> 
> [    0.426106] =============================
> [    0.426257] [ BUG: Invalid wait context ]
> [    0.426422] 6.3.0-rc7-next-20230421-dirty #54 Not tainted
> [    0.426638] -----------------------------
> [    0.426766] swapper/0/1 is trying to lock:
> [    0.426954] ffffffff8104e7b8 (gic_lock){....}-{3:3}, at: gic_set_type+0x30/08
> 
> Fixes: 95150ae8b330 ("irqchip: mips-gic: Implement irq_set_type callback")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>

LGTM especially in the RT-patch context. Feel free to add:
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

Please see a tiny nitpick below.

> ---
>  drivers/irqchip/irq-mips-gic.c | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
> index b568d55ef7c5..6d5ecc10a870 100644
> --- a/drivers/irqchip/irq-mips-gic.c
> +++ b/drivers/irqchip/irq-mips-gic.c
> @@ -50,7 +50,7 @@ void __iomem *mips_gic_base;
>  
>  static DEFINE_PER_CPU_READ_MOSTLY(unsigned long[GIC_MAX_LONGS], pcpu_masks);
>  
> -static DEFINE_SPINLOCK(gic_lock);
> +static DEFINE_RAW_SPINLOCK(gic_lock);
>  static struct irq_domain *gic_irq_domain;
>  static int gic_shared_intrs;
>  static unsigned int gic_cpu_pin;
> @@ -210,7 +210,7 @@ static int gic_set_type(struct irq_data *d, unsigned int type)
>  
>  	irq = GIC_HWIRQ_TO_SHARED(d->hwirq);
>  

> -	spin_lock_irqsave(&gic_lock, flags);
> +	raw_spin_lock_irqsave(&gic_lock, flags);

AFAICS this call can be moved way down to be after the switch-case
block.

-Serge(y)

>  	switch (type & IRQ_TYPE_SENSE_MASK) {
>  	case IRQ_TYPE_EDGE_FALLING:
>  		pol = GIC_POL_FALLING_EDGE;
> @@ -250,7 +250,7 @@ static int gic_set_type(struct irq_data *d, unsigned int type)
>  	else
>  		irq_set_chip_handler_name_locked(d, &gic_level_irq_controller,
>  						 handle_level_irq, NULL);
> -	spin_unlock_irqrestore(&gic_lock, flags);
> +	raw_spin_unlock_irqrestore(&gic_lock, flags);
>  
>  	return 0;
>  }
> @@ -268,7 +268,7 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *cpumask,
>  		return -EINVAL;
>  
>  	/* Assumption : cpumask refers to a single CPU */
> -	spin_lock_irqsave(&gic_lock, flags);
> +	raw_spin_lock_irqsave(&gic_lock, flags);
>  
>  	/* Re-route this IRQ */
>  	write_gic_map_vp(irq, BIT(mips_cm_vp_id(cpu)));
> @@ -279,7 +279,7 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *cpumask,
>  		set_bit(irq, per_cpu_ptr(pcpu_masks, cpu));
>  
>  	irq_data_update_effective_affinity(d, cpumask_of(cpu));
> -	spin_unlock_irqrestore(&gic_lock, flags);
> +	raw_spin_unlock_irqrestore(&gic_lock, flags);
>  
>  	return IRQ_SET_MASK_OK;
>  }
> @@ -357,12 +357,12 @@ static void gic_mask_local_irq_all_vpes(struct irq_data *d)
>  	cd = irq_data_get_irq_chip_data(d);
>  	cd->mask = false;
>  
> -	spin_lock_irqsave(&gic_lock, flags);
> +	raw_spin_lock_irqsave(&gic_lock, flags);
>  	for_each_online_cpu(cpu) {
>  		write_gic_vl_other(mips_cm_vp_id(cpu));
>  		write_gic_vo_rmask(BIT(intr));
>  	}
> -	spin_unlock_irqrestore(&gic_lock, flags);
> +	raw_spin_unlock_irqrestore(&gic_lock, flags);
>  }
>  
>  static void gic_unmask_local_irq_all_vpes(struct irq_data *d)
> @@ -375,12 +375,12 @@ static void gic_unmask_local_irq_all_vpes(struct irq_data *d)
>  	cd = irq_data_get_irq_chip_data(d);
>  	cd->mask = true;
>  
> -	spin_lock_irqsave(&gic_lock, flags);
> +	raw_spin_lock_irqsave(&gic_lock, flags);
>  	for_each_online_cpu(cpu) {
>  		write_gic_vl_other(mips_cm_vp_id(cpu));
>  		write_gic_vo_smask(BIT(intr));
>  	}
> -	spin_unlock_irqrestore(&gic_lock, flags);
> +	raw_spin_unlock_irqrestore(&gic_lock, flags);
>  }
>  
>  static void gic_all_vpes_irq_cpu_online(void)
> @@ -393,7 +393,7 @@ static void gic_all_vpes_irq_cpu_online(void)
>  	unsigned long flags;
>  	int i;
>  
> -	spin_lock_irqsave(&gic_lock, flags);
> +	raw_spin_lock_irqsave(&gic_lock, flags);
>  
>  	for (i = 0; i < ARRAY_SIZE(local_intrs); i++) {
>  		unsigned int intr = local_intrs[i];
> @@ -407,7 +407,7 @@ static void gic_all_vpes_irq_cpu_online(void)
>  			write_gic_vl_smask(BIT(intr));
>  	}
>  
> -	spin_unlock_irqrestore(&gic_lock, flags);
> +	raw_spin_unlock_irqrestore(&gic_lock, flags);
>  }
>  
>  static struct irq_chip gic_all_vpes_local_irq_controller = {
> @@ -437,11 +437,11 @@ static int gic_shared_irq_domain_map(struct irq_domain *d, unsigned int virq,
>  
>  	data = irq_get_irq_data(virq);
>  
> -	spin_lock_irqsave(&gic_lock, flags);
> +	raw_spin_lock_irqsave(&gic_lock, flags);
>  	write_gic_map_pin(intr, GIC_MAP_PIN_MAP_TO_PIN | gic_cpu_pin);
>  	write_gic_map_vp(intr, BIT(mips_cm_vp_id(cpu)));
>  	irq_data_update_effective_affinity(data, cpumask_of(cpu));
> -	spin_unlock_irqrestore(&gic_lock, flags);
> +	raw_spin_unlock_irqrestore(&gic_lock, flags);
>  
>  	return 0;
>  }
> @@ -533,12 +533,12 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int virq,
>  	if (!gic_local_irq_is_routable(intr))
>  		return -EPERM;
>  
> -	spin_lock_irqsave(&gic_lock, flags);
> +	raw_spin_lock_irqsave(&gic_lock, flags);
>  	for_each_online_cpu(cpu) {
>  		write_gic_vl_other(mips_cm_vp_id(cpu));
>  		write_gic_vo_map(mips_gic_vx_map_reg(intr), map);
>  	}
> -	spin_unlock_irqrestore(&gic_lock, flags);
> +	raw_spin_unlock_irqrestore(&gic_lock, flags);
>  
>  	return 0;
>  }
> -- 
> 2.34.1
> 
