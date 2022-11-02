Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27352615EC5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 10:03:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbiKBJDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 05:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbiKBJCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 05:02:33 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD0F1286CF
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 02:02:31 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id m6-20020a17090a5a4600b00212f8dffec9so1365803pji.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 02:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3lW+SEAwaQj22Ep5QkmznnP/cF5sNnG1Gxo6Sa2AZ74=;
        b=zMACeZbTZl8Q3wbIi8TRiige4VbN1aGqtrYun5aTANcuZZe+p7qmASVXONqOc8BnjO
         EXUpfbpmLT4aldBZy+mhaQUupoCUeZZt6VqjUbjTA9X4Zx3bRl3erk2FCZAgbGp7SbmI
         1xnzVLkngnIJP+qZvFQ1rW/oLf4sRdaTM8kS6enQOg0wRQ215McLO0h9oGWZPvVnsl9D
         FerDzddgYMI4QPktFlJyuv7L6Q54iEHyS7k5k2aX6/fOVvEu2UapwdObqqF0mf9Zw2yc
         VBsphQ7BS33X/JO7bmpx6UWnuCfJXDYNgtfzX7OKuD7AyX9aWhXpBzu03Pc+GrnrujDL
         YNTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3lW+SEAwaQj22Ep5QkmznnP/cF5sNnG1Gxo6Sa2AZ74=;
        b=M2LqfOrXLiBo5YMmlXlL3WZnnmcszgzzohpTyO/bQwlWtwPOGiuFWMJWMTu1CUtScP
         eTDjklJ7EKXY9Ma/26kT89svtkIBUa+12UdespwMf7JNoBv9b3yN0USkZGtDSG88jHUV
         VQz6pBy/KYrXkThY81cZ4kJTGYr5Rki23hbooiD3ApRwC6uf9zN5VZ4w5/fqLjxkVBjk
         yed0oZ4mjj7FIr1UC6wxXIPxcoqdRytgZqKaVQ6myB2BcCT8BDJbUA+zCk3GQJOnGtve
         2pyrZPpsBs3yvVQnApEvPEBIk0CHWqmmglznJzvTWqf7yq0ZoSO2m47BxN5pFkyhBLyU
         ey5A==
X-Gm-Message-State: ACrzQf2Kaz5LKbJcNhqIXcUkMsBCYYZpBn1fc7MRdI9KKSgr0pGnDN70
        qjSToKhOAxx4V/vrFC+zBPSy8eu5bBMyrA==
X-Google-Smtp-Source: AMsMyM6PALNUlom1rlSsoWaB+9NYnSm8AiAITHIXsiK1BSybVbtqKeCAusR4sDxJ3wdLnUx7GI0NlQ==
X-Received: by 2002:a17:902:8e88:b0:185:3cea:6335 with SMTP id bg8-20020a1709028e8800b001853cea6335mr23860226plb.96.1667379751258;
        Wed, 02 Nov 2022 02:02:31 -0700 (PDT)
Received: from localhost ([122.172.84.80])
        by smtp.gmail.com with ESMTPSA id a3-20020a170902ecc300b001868ed86a95sm7830304plh.174.2022.11.02.02.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 02:02:30 -0700 (PDT)
Date:   Wed, 2 Nov 2022 14:32:28 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     James Calligeros <jcalligeros99@gmail.com>
Cc:     vireshk@kernel.org, sboyd@kernel.org, nm@ti.com,
        linux-pm@vger.kernel.org, asahi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] OPP: decouple dt properties in opp_parse_supplies()
Message-ID: <20221102090228.odyt7ykdkcbdx4lw@vireshk-i7>
References: <20221030101546.29306-1-jcalligeros99@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221030101546.29306-1-jcalligeros99@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-10-22, 20:15, James Calligeros wrote:
> The opp-microwatt property was added with the intention of providing
> platforms a way to specify a precise value for the power consumption
> of a device at a given OPP to enable better energy-aware scheduling
> decisions by informing the kernel of the total static and dynamic
> power of a device at a given OPP, removing the reliance on the EM
> subsystem's often flawed estimations. This property is parsed by
> opp_parse_supplies(), which creates a hard dependency on the
> opp-microvolt property.
> 
> Some platforms, such as Apple Silicon, do not describe their devices'
> voltage regulators in the DT as they cannot be controlled by the kernel
> and/or rely on opaque firmware algorithms to control their voltage and
> current characteristics at runtime. We can, however, experimentally
> determine the power consumption of a given device at a given OPP, taking
> advantage of opp-microwatt to provide EAS on such devices as was initially
> intended.

Do you supply a regulator to the OPP core for your platform ?

> Allow platforms to specify and consume any subset of opp-microvolt,
> opp-microamp, or opp-microwatt without a hard dependency on opp-microvolt
> to enable this functionality on such platforms.
> 
> Fixes: 4f9a7a1dc2a2 ("OPP: Add "opp-microwatt" supporting code")

I won't call it a fix, we are trying to use this information in a
different way here, that's all.

> Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
> ---
> Changes since v1:
> Fixed bad reference (opp to opp_table)
> 
>  drivers/opp/of.c | 198 +++++++++++++++++++++++++----------------------
>  1 file changed, 104 insertions(+), 94 deletions(-)
> 
> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> index 605d68673f92..0fa25c3a959e 100644
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -581,166 +581,176 @@ static bool _opp_is_supported(struct device *dev, struct opp_table *opp_table,
>  static int opp_parse_supplies(struct dev_pm_opp *opp, struct device *dev,
>  			      struct opp_table *opp_table)
>  {
> -	u32 *microvolt, *microamp = NULL, *microwatt = NULL;
> +	u32 *microvolt = NULL, *microamp = NULL, *microwatt = NULL;
>  	int supplies = opp_table->regulator_count;
>  	int vcount, icount, pcount, ret, i, j;
> -	struct property *prop = NULL;
> +	struct property *prop_mv = NULL, *prop_ma = NULL, *prop_mw = NULL;
>  	char name[NAME_MAX];
>  
>  	/* Search for "opp-microvolt-<name>" */
>  	if (opp_table->prop_name) {
>  		snprintf(name, sizeof(name), "opp-microvolt-%s",
>  			 opp_table->prop_name);
> -		prop = of_find_property(opp->np, name, NULL);
> +		prop_mv = of_find_property(opp->np, name, NULL);
>  	}
>  
> -	if (!prop) {
> +	if (!prop_mv) {
>  		/* Search for "opp-microvolt" */
>  		sprintf(name, "opp-microvolt");
> -		prop = of_find_property(opp->np, name, NULL);
> -
> -		/* Missing property isn't a problem, but an invalid entry is */
> -		if (!prop) {
> -			if (unlikely(supplies == -1)) {
> -				/* Initialize regulator_count */
> -				opp_table->regulator_count = 0;
> -				return 0;
> -			}
> +		prop_mv = of_find_property(opp->np, name, NULL);
>  
> -			if (!supplies)
> -				return 0;
> -
> -			dev_err(dev, "%s: opp-microvolt missing although OPP managing regulators\n",
> -				__func__);

Catching such errors are important and so the opp-microvolt property
was made compulsory earlier.

If there is a regulator, then we must have microvolt property.
amps/watts are optional.

> -			return -EINVAL;
> -		}
>  	}
>  
> -	if (unlikely(supplies == -1)) {
> -		/* Initialize regulator_count */
> -		supplies = opp_table->regulator_count = 1;
> -	} else if (unlikely(!supplies)) {
> -		dev_err(dev, "%s: opp-microvolt wasn't expected\n", __func__);
> -		return -EINVAL;
> +	if (prop_mv) {
> +		vcount = of_property_count_u32_elems(opp->np, name);
> +		if (unlikely(supplies == -1))
> +			supplies = opp_table->regulator_count = vcount;

This is wrong. There can be one or three entries per regulator here.
Target or min/max/target. If the supplies value is -1, we can only
support one regulator, i.e. one or three entries total.

I didn't look at rest of the patch yet. Lets discuss this a bit first.

-- 
viresh
