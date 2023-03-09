Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE9686B23E6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 13:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbjCIMRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 07:17:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjCIMRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 07:17:22 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE29FEABAA;
        Thu,  9 Mar 2023 04:17:06 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id k14so2003225lfj.7;
        Thu, 09 Mar 2023 04:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678364225;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=svtkLC8iDUMkkdyaLgq1IX9Kz9faHNXIyoOuo5M0tqI=;
        b=VnZBfXePwUmAI9r8qCY143k0jdNdtDpbxVRKxLaFwHlWPJE8VNaOvRyzfLsbe4ElfJ
         x9Yai5DpSH6Q8SkpTalRDKugKESbTJmqAWSlW2AhFFOpg5PGYNIvNv80rZRnXwALdL+r
         Y2Uc8p7RviZyzBanMztLH2ic4mZLRMtlIrmwBLgHtga6qjcKMURUOA+iEzf+EJLirTmy
         lr7gpNO2Zz4bscnzArY4r+kE/8m1asylvMrkZStsWHCC5gFjfGGffEYZIUM20ZcwfiKv
         jj0BoZeoVwRPZPo9IYD3L1w6jDFrYBjz+UQ/fgDNOZuGgfJ7dPl/4f1UuwCMi1MHtPEy
         RZvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678364225;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=svtkLC8iDUMkkdyaLgq1IX9Kz9faHNXIyoOuo5M0tqI=;
        b=ZF/3pypSLrk3HjPjS1oPFIrbkxAeMqlRpmZdsrMTUhFrvVIvOEDszpds+D5eG0n6vR
         W5DmzpYBtHekasY/oxLINXg6z+FQ2gvUYXder9Gte/j/77jurf7h5NkFPcNqMlKsTjNP
         QEmQYWWmoUxK+cwXRsOITHW2FRTt7QEIIjCKSEvnyBiP/oMUEq27htdeV0ZLl5jeM0Po
         HXQtvrTLfZ5mikWADSlfuuzOv+45Jmk7ee/06xZnT64st6qkq8DBEUXNdhh7lwvagI22
         ruYHWh1XmwmX79ysM0MLdsgQRJ9v5XBEpe7pxTTAQ5zpOIZxjwVW0lUZ/9GRBQk0RYYY
         SLOA==
X-Gm-Message-State: AO0yUKXcMhf+QIKG2ijbNYolDfJwXhrlMtPuw+Uhg6jWTiaSaMJrwZff
        aCBC4k8WadiVgKmBM4RHZyPsWJKJ239U9w==
X-Google-Smtp-Source: AK7set/jBrGP2pfuwiP6rCdG6DzXPu9Du9UXg7TrJkWMH735UD8cwPt68EiZtY2EFagkAANRdonZnQ==
X-Received: by 2002:a19:7405:0:b0:4e1:7d1c:85ce with SMTP id v5-20020a197405000000b004e17d1c85cemr5514896lfe.27.1678364224832;
        Thu, 09 Mar 2023 04:17:04 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id c17-20020a197611000000b004db44babad7sm2627408lff.260.2023.03.09.04.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 04:17:03 -0800 (PST)
Date:   Thu, 9 Mar 2023 15:17:00 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     wangjianli <wangjianli@cdjrlc.com>
Cc:     tsbogend@alpha.franken.de, tglx@linutronix.de, maz@kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/irqchip: fix repeated words in comments
Message-ID: <20230309121700.vc5hdpj4ld74uvvd@mobilestation>
References: <20221022054655.36496-1-wangjianli@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221022054655.36496-1-wangjianli@cdjrlc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 22, 2022 at 01:46:55PM +0800, wangjianli wrote:
> Delete the redundant word 'the'.

Thanks!
Acked-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> 
> Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
> ---
>  drivers/irqchip/irq-mips-gic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
> index ff89b36267dd..53daac318ccd 100644
> --- a/drivers/irqchip/irq-mips-gic.c
> +++ b/drivers/irqchip/irq-mips-gic.c
> @@ -490,7 +490,7 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int virq,
>  	map = GIC_MAP_PIN_MAP_TO_PIN | gic_cpu_pin;
>  
>  	/*
> -	 * If adding support for more per-cpu interrupts, keep the the
> +	 * If adding support for more per-cpu interrupts, keep the
>  	 * array in gic_all_vpes_irq_cpu_online() in sync.
>  	 */
>  	switch (intr) {
> -- 
> 2.36.1
> 
