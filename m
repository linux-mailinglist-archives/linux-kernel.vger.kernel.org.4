Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 509D567EA92
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 17:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234702AbjA0QPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 11:15:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234068AbjA0QPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 11:15:36 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699DD7D2A6
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 08:15:25 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id m16-20020a05600c3b1000b003dc4050c94aso1023290wms.4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 08:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DPjHEyov1hE02QP/IWcle2+g2W2JIKUquq/K/wU0SWA=;
        b=qOoFMXb1cKR3k/N+SPlBH1PaUaJT3I7mQzzcvKr1UZShX0hiUB/1qY2MoSNmuhZ7Y+
         w+7bRv+zFfehEe9NnClsvIwCykjjnpf5l6wqCrzN4eAf1qi895ASC6Ex0E+obvHagJMi
         Bamm+EH3nlxOSI19g/x1qgCvsEJHpcfQYi3X82XT237VSqzmGAn28zFkFDVAGnC/trcb
         jEOv2+/Yzhi852IB/S2Y4ahULhYBwzUTtTGemHM8qW21JkASI2CjRGbuTs+zkOT2B7A0
         THUm5in/tt1em2JMi+KPkF2C0ObzJt36DkkeKhEwNdtz6baP5S9/NhVNohBeJx1ZSjsy
         dM5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DPjHEyov1hE02QP/IWcle2+g2W2JIKUquq/K/wU0SWA=;
        b=ui3SI2okFi2132W9kC9IrnBjC0p+lirxKcl5IfPJxhDOImECNDYMBE2x8TwbJidMQE
         tnQleTmEUyGn6m46yeTIX4/+uyk3j0eP3WG/fv3V0qcA8A6+e4iEDc4dc//Y3bfKpis1
         Kmh7BPp2uoeJku0+BfcLQouXn54HOhyU6mWyqefd8G6wMJdMFIyayANzQCqLXYUd+37D
         IRSczSFwloxT8FijNni5o5Q4ZR6XB9wZBxNMCCCDButYun9uDg7dC97bxN9966/uvc4D
         sfHqijSKe6EzUAFMKWuvAzMHPmEbWHpkmRenLT1zF0vu+7X3xk+gLEEnv9R53C1UqIhl
         Em4A==
X-Gm-Message-State: AFqh2kpH8lhWInDqE7OL0K6dNw3SgDgqVp8KhkI+9xFdodbTB6wM8ZhW
        5J7fH52fnKDEJQthZDSUfiaZ7g==
X-Google-Smtp-Source: AMrXdXsHZMrsOuFl/Ku+TEw4XWa+mKf4Dw63rhhK2821jnvwFWV6eidUT6wJEEuGAnWn8Qk2hM4PGw==
X-Received: by 2002:a05:600c:3296:b0:3cf:82b9:2fe6 with SMTP id t22-20020a05600c329600b003cf82b92fe6mr42347426wmp.8.1674836123961;
        Fri, 27 Jan 2023 08:15:23 -0800 (PST)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id v10-20020a05600c12ca00b003d9df9e59c4sm7826593wmd.37.2023.01.27.08.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 08:15:23 -0800 (PST)
Date:   Fri, 27 Jan 2023 18:15:22 +0200
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: qcom: gdsc: Disable HW control until supported
Message-ID: <Y9P4mhSIK1BvZ38k@linaro.org>
References: <20230112135224.3837820-1-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230112135224.3837820-1-quic_bjorande@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-01-12 05:52:24, Bjorn Andersson wrote:
> Software normally uses the SW_COLLAPSE bit to collapse a GDSC, but in
> some scenarios it's beneficial to let the hardware perform this without
> software intervention.
> 
> This is done by configuring the GDSC in "hardware control" state, in
> which case the SW_COLLAPSE bit is ignored and some hardware signal is
> relies upon instead.
> 
> The GDSCs are modelled as power-domains in Linux and as such it's
> reasonable to assume that the device drivers intend for the hardware
> block to be accessible when their power domain is active.
> 
> But in the current implementation, any GDSC that is marked to support
> hardware control, gets hardware control unconditionally while the
> client driver requests it to be active. It's therefor conceivable that
> the hardware collapses a GDSC while Linux is accessing resources
> depending on it.
> 
> There are ongoing discussions about how to properly expose this control
> to the client drivers, but until conclusion in that discussion is
> reached, the safer option would be to keep the GDSC in software control
> mode.
> 
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

> ---
>  drivers/clk/qcom/gdsc.c | 48 ++++++-----------------------------------
>  1 file changed, 7 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
> index 9e4d6ce891aa..6d3b36a52a48 100644
> --- a/drivers/clk/qcom/gdsc.c
> +++ b/drivers/clk/qcom/gdsc.c
> @@ -291,22 +291,6 @@ static int gdsc_enable(struct generic_pm_domain *domain)
>  	 */
>  	udelay(1);
>  
> -	/* Turn on HW trigger mode if supported */
> -	if (sc->flags & HW_CTRL) {
> -		ret = gdsc_hwctrl(sc, true);
> -		if (ret)
> -			return ret;
> -		/*
> -		 * Wait for the GDSC to go through a power down and
> -		 * up cycle.  In case a firmware ends up polling status
> -		 * bits for the gdsc, it might read an 'on' status before
> -		 * the GDSC can finish the power cycle.
> -		 * We wait 1us before returning to ensure the firmware
> -		 * can't immediately poll the status bits.
> -		 */
> -		udelay(1);
> -	}
> -
>  	if (sc->flags & RETAIN_FF_ENABLE)
>  		gdsc_retain_ff_on(sc);
>  
> @@ -321,24 +305,6 @@ static int gdsc_disable(struct generic_pm_domain *domain)
>  	if (sc->pwrsts == PWRSTS_ON)
>  		return gdsc_assert_reset(sc);
>  
> -	/* Turn off HW trigger mode if supported */
> -	if (sc->flags & HW_CTRL) {
> -		ret = gdsc_hwctrl(sc, false);
> -		if (ret < 0)
> -			return ret;
> -		/*
> -		 * Wait for the GDSC to go through a power down and
> -		 * up cycle.  In case we end up polling status
> -		 * bits for the gdsc before the power cycle is completed
> -		 * it might read an 'on' status wrongly.
> -		 */
> -		udelay(1);
> -
> -		ret = gdsc_poll_status(sc, GDSC_ON);
> -		if (ret)
> -			return ret;
> -	}
> -
>  	if (sc->pwrsts & PWRSTS_OFF)
>  		gdsc_clear_mem_on(sc);
>  
> @@ -419,13 +385,6 @@ static int gdsc_init(struct gdsc *sc)
>  				goto err_disable_supply;
>  		}
>  
> -		/* Turn on HW trigger mode if supported */
> -		if (sc->flags & HW_CTRL) {
> -			ret = gdsc_hwctrl(sc, true);
> -			if (ret < 0)
> -				goto err_disable_supply;
> -		}
> -
>  		/*
>  		 * Make sure the retain bit is set if the GDSC is already on,
>  		 * otherwise we end up turning off the GDSC and destroying all
> @@ -439,6 +398,13 @@ static int gdsc_init(struct gdsc *sc)
>  		on = true;
>  	}
>  
> +	/* Disable HW trigger mode until propertly supported */
> +	if (sc->flags & HW_CTRL) {
> +		ret = gdsc_hwctrl(sc, false);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
>  	if (on || (sc->pwrsts & PWRSTS_RET))
>  		gdsc_force_mem_on(sc);
>  	else
> -- 
> 2.37.3
> 
