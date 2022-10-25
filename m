Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 007C260C31A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 07:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbiJYFIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 01:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbiJYFH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 01:07:56 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311C0144E19
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 22:07:04 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id h2so4405428pgp.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 22:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b0wunblmCvoNzFQ+Ax4TKZ+hqx1Bra2g+X5BnPCtjKo=;
        b=jFE6Hyrm+Lpe5udXJpySAIwraZa4iNCeSxsMwbiR3bPbgfHIJPH/lve2TrBnc+E4FU
         LtdFeGTgkaXgPerN3IywVP/HEEntwVO88rSgCxOnhi+WBaQYK0FDZG471nn4pFKByfGX
         gyxZd9tnTcC2K0fxAw4bG4Mz6edA+CWsNhNPMwiLXpgmS8BGsPB+ZU4Rx9zWBhHsq1PZ
         CE6HbEs/jt6Tq26FMWZb+MTX9CxQ7TzNKDIRxp+eG4dYELo+2Aiq5tB2lltb80+zYV66
         qCMv87gcoTavBPMSu+YFwyYZKcfj7L+CCCiAhAfSAs43CyxPzxKlhoqw6+Mm6TN4SaTs
         jJPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b0wunblmCvoNzFQ+Ax4TKZ+hqx1Bra2g+X5BnPCtjKo=;
        b=Nyk7tuydml3T8Ig7cweQGnTJZl3LJ8onhjHL+Rz/QqcinKHPiWe6kNe8gziGgd9pQD
         QaNp4T7bAatSrjMy2LsmrYkc/qkQBwKimpeul+f45flH3C7b9Ocn995nVn+0xueXWnsz
         CLy9ZNtmLdbuYq7GrTBOIK/xiZMTYM0uutSsmljbWiKcR6Rf738GpI9VfvDk5uHSiu2x
         JBzgpT0cTq189/rMs7jnvqARSG3XCBX9wFmJiydfnrU/k8BtWHKK8e85K6NcLC25agUM
         OmpRTRjNFIWNa3dvam+O2yF3cuNwKxuUubGzimi9hAyzhhwsXXpiRWP4ThhhyEb1/w24
         Ehig==
X-Gm-Message-State: ACrzQf1xufDQMbAjUBApvHi7SiG3DYsRfUZ9w7D4netZv9onYRW/yJ9p
        9kxVwnis6pzQ8zLTFGgcWzKmAQ==
X-Google-Smtp-Source: AMsMyM7hqviQBY3OSfS0lzYvRThyk6R7SGD7bS0FtbO5in9b0W3ENrdpYNpDzlCdWNdj/96voNr19Q==
X-Received: by 2002:a63:6742:0:b0:452:59b9:22e with SMTP id b63-20020a636742000000b0045259b9022emr30639524pgc.205.1666674423624;
        Mon, 24 Oct 2022 22:07:03 -0700 (PDT)
Received: from localhost ([122.172.87.26])
        by smtp.gmail.com with ESMTPSA id n13-20020a170902d2cd00b00176ae5c0f38sm512817plc.178.2022.10.24.22.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 22:07:02 -0700 (PDT)
Date:   Tue, 25 Oct 2022 10:37:00 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 04/11] ARM: sa1100: make cpufreq driver build standalone
Message-ID: <20221025050700.3dzdgicrx3hcdhqa@vireshk-i7>
References: <20221021155000.4108406-1-arnd@kernel.org>
 <20221021155000.4108406-5-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221021155000.4108406-5-arnd@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-10-22, 17:49, Arnd Bergmann wrote:
> --- a/drivers/cpufreq/sa1110-cpufreq.c
> +++ b/drivers/cpufreq/sa1110-cpufreq.c
> @@ -29,6 +29,38 @@
>  
>  #undef DEBUG
>  
> +#define NR_FREQS	16
> +
> +/*
> + * This table is setup for a 3.6864MHz Crystal.
> + */
> +static struct cpufreq_frequency_table sa11x0_freq_table[NR_FREQS+1] = {
> +	{ .frequency = 59000,	/*  59.0 MHz */},
> +	{ .frequency = 73700,	/*  73.7 MHz */},
> +	{ .frequency = 88500,	/*  88.5 MHz */},
> +	{ .frequency = 103200,	/* 103.2 MHz */},
> +	{ .frequency = 118000,	/* 118.0 MHz */},
> +	{ .frequency = 132700,	/* 132.7 MHz */},
> +	{ .frequency = 147500,	/* 147.5 MHz */},
> +	{ .frequency = 162200,	/* 162.2 MHz */},
> +	{ .frequency = 176900,	/* 176.9 MHz */},
> +	{ .frequency = 191700,	/* 191.7 MHz */},
> +	{ .frequency = 206400,	/* 206.4 MHz */},
> +	{ .frequency = 221200,	/* 221.2 MHz */},
> +	{ .frequency = 235900,	/* 235.9 MHz */},
> +	{ .frequency = 250700,	/* 250.7 MHz */},
> +	{ .frequency = 265400,	/* 265.4 MHz */},
> +	{ .frequency = 280200,	/* 280.2 MHz */},
> +	{ .frequency = CPUFREQ_TABLE_END, },
> +};
> +
> +static unsigned int sa11x0_getspeed(unsigned int cpu)
> +{
> +	if (cpu)
> +		return 0;
> +	return sa11x0_freq_table[PPCR & 0xf].frequency;
> +}
> +
>  struct sdram_params {
>  	const char name[20];
>  	u_char  rows;		/* bits				 */

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
