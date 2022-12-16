Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1309864ED61
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 16:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbiLPPEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 10:04:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbiLPPEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 10:04:47 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1C55E0AE
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 07:04:46 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id 1so3869234lfz.4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 07:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fYt8yQmWEkkfiXC18EdcPZvvPMXhKB/s0QVrRDkPUq0=;
        b=Dv7r7ur3mIGZ8WSb5+26m6LZ8hvkxBVMnoAfBRwe6dZ53JG2T4T3NtfH1NY9RmvDBB
         C2lgbtfdJ1veMQY6fmOYE3xQYfgVNzoeRuwx3orBrXOwvLN4C2aAWp4wGYchVL37wu/W
         ZvoXEncJGYPx4pO48yADcM7fYhBvOW1KiDcG5eKINseBTKQ09BHNghvRqyEPScMvJV0+
         I3QzmpVGrisU/n5nX4Xnf0pdXQ7K7WdiU0XmXjmiupGWI0ytQPZHGBsKHdJVBSr5Co0I
         55xpTbJ9lmQB4soAFRVOUPhUTrK/IVpWlLgaCQqCxiRhJCuO0rpxd3UGnhNGpwR3GU9m
         3Dpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fYt8yQmWEkkfiXC18EdcPZvvPMXhKB/s0QVrRDkPUq0=;
        b=t4QTiZ63aD21BiaRrSekpurHEECu0wpRuMDbj2TzYzpUIgCQDN4KLDV+xjodGeegKH
         7JHPu3Sfq5hAsLBcGfU1KekOQeoV9hbMVinIc8BYnyAt1+SH9+HvIj9+r+IXQ13k9GlP
         Wsl/sqf509Bh77bp858rAAQqFUONA5WvzBOxx94NboWT5JdjikRCUoQDKy5G37eXS+PW
         QAGgC38CRtWgFdyGgCeeFpNd/nOQseFRrfacDPnEn9l3on6kRnosnaau3wAUj8hgB19V
         zxU2JjMMZOzjt6kRQVQvrNV1qyovC7y87NRWqlMIRZJVLbSgj38ohrOZPd8Ewo2HlS+e
         0XDA==
X-Gm-Message-State: ANoB5pkkwlXJw0Z52dulj8stwCIUX6KomIrFqHvx9dDWfFAp1y2IBf4c
        B6vhtRoAUwDIm3pJO2uG+YYIzQ==
X-Google-Smtp-Source: AA0mqf5EQrvZpoQYNhgW50GamOKbPGlFrNpJssjsHPguXDunmyV2QocY6tQrmfTyDK+tftMzcJZl3A==
X-Received: by 2002:a05:6512:32cd:b0:4b1:862b:5e71 with SMTP id f13-20020a05651232cd00b004b1862b5e71mr10310036lfg.33.1671203084614;
        Fri, 16 Dec 2022 07:04:44 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id c2-20020a056512074200b0048aee825e2esm235495lfs.282.2022.12.16.07.04.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Dec 2022 07:04:44 -0800 (PST)
Message-ID: <a1433373-20c5-91a4-bc94-1583b103bd58@linaro.org>
Date:   Fri, 16 Dec 2022 16:04:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH RFC 1/2] PM: domains: Add GENPD_FLAG_RT_SAFE for
 PREEMPT_RT
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Adrien Thierry <athierry@redhat.com>,
        Brian Masney <bmasney@redhat.com>
References: <20221216145802.102374-1-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221216145802.102374-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/12/2022 15:58, Krzysztof Kozlowski wrote:
> Realtime kernels with PREEMPT_RT must use raw_spinlock_t, so add a flag
> allowing a power domain provider to indicate it is RT safe.  The flag is
> supposed to be used with existing GENPD_FLAG_IRQ_SAFE.
> 
> Cc: Adrien Thierry <athierry@redhat.com>
> Cc: Brian Masney <bmasney@redhat.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Independently from Adrien, I encountered the same problem around genpd
> when using PREEMPT_RT kernel.
> 
> Previous patch by Adrien:
> https://lore.kernel.org/all/20220615203605.1068453-1-athierry@redhat.com/
> ---
>  drivers/base/power/domain.c | 51 +++++++++++++++++++++++++++++++++++--
>  include/linux/pm_domain.h   | 13 ++++++++++
>  2 files changed, 62 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index a539d6bc6fe0..478862ae478a 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -119,6 +119,48 @@ static const struct genpd_lock_ops genpd_spin_ops = {
>  	.unlock = genpd_unlock_spin,
>  };
>  
> +static void genpd_lock_rawspin(struct generic_pm_domain *genpd)
> +	__acquires(&genpd->rslock)
> +{
> +	unsigned long flags;
> +
> +	raw_spin_lock_irqsave(&genpd->rslock, flags);
> +	genpd->rlock_flags = flags;
> +}
> +
> +static void genpd_lock_nested_rawspin(struct generic_pm_domain *genpd,
> +					int depth)
> +	__acquires(&genpd->rslock)
> +{
> +	unsigned long flags;
> +
> +	raw_spin_lock_irqsave_nested(&genpd->rslock, flags, depth);
> +	genpd->rlock_flags = flags;
> +}
> +
> +static int genpd_lock_interruptible_rawspin(struct generic_pm_domain *genpd)
> +	__acquires(&genpd->rslock)
> +{
> +	unsigned long flags;
> +
> +	raw_spin_lock_irqsave(&genpd->rslock, flags);
> +	genpd->rlock_flags = flags;
> +	return 0;
> +}
> +
> +static void genpd_unlock_rawspin(struct generic_pm_domain *genpd)
> +	__releases(&genpd->rslock)
> +{
> +	raw_spin_unlock_irqrestore(&genpd->rslock, genpd->rlock_flags);
> +}
> +
> +static const struct genpd_lock_ops genpd_rawspin_ops = {
> +	.lock = genpd_lock_rawspin,
> +	.lock_nested = genpd_lock_nested_rawspin,
> +	.lock_interruptible = genpd_lock_interruptible_rawspin,
> +	.unlock = genpd_unlock_rawspin,
> +};
> +
>  #define genpd_lock(p)			p->lock_ops->lock(p)
>  #define genpd_lock_nested(p, d)		p->lock_ops->lock_nested(p, d)
>  #define genpd_lock_interruptible(p)	p->lock_ops->lock_interruptible(p)
> @@ -2048,8 +2090,13 @@ static void genpd_free_data(struct generic_pm_domain *genpd)
>  static void genpd_lock_init(struct generic_pm_domain *genpd)
>  {
>  	if (genpd->flags & GENPD_FLAG_IRQ_SAFE) {
> -		spin_lock_init(&genpd->slock);
> -		genpd->lock_ops = &genpd_spin_ops;
> +		if (genpd->flags & GENPD_FLAG_RT_SAFE) {
> +			raw_spin_lock_init(&genpd->rslock);
> +			genpd->lock_ops = &genpd_rawspin_ops;
> +		} else {
> +			spin_lock_init(&genpd->slock);
> +			genpd->lock_ops = &genpd_spin_ops;
> +		}
>  	} else {
>  		mutex_init(&genpd->mlock);
>  		genpd->lock_ops = &genpd_mtx_ops;
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index c6cda024ff99..6b0f9de2be1c 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -61,6 +61,14 @@
>   * GENPD_FLAG_MIN_RESIDENCY:	Enable the genpd governor to consider its
>   *				components' next wakeup when determining the
>   *				optimal idle state.
> + *
> + * GENPD_FLAG_RT_SAFE:		When used with GENPD_FLAG_IRQ_SAFE, this informs
> + *				genpd that its backend callbacks, ->power_on|off(),
> + *				do not use other spinlocks. They might use
> + *				raw_spinlocks or other pre-emption-disable
> + *				methods, all of which are PREEMPT_RT safe. Note
> + *				that, a genpd having this flag set, requires its
> + *				masterdomains to also have it set.

Now I see I might be missing such check in genpd_add_subdomain().

Best regards,
Krzysztof

