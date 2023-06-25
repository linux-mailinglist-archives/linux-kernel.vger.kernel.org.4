Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE2473D535
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 01:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbjFYXQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 19:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjFYXQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 19:16:11 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B16A1E42;
        Sun, 25 Jun 2023 16:16:09 -0700 (PDT)
X-GND-Sasl: alexandre.belloni@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1687734968;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5XpQHhqOpTdjSqtbgzxz/kI6g40uHrtHh+waKeupz4k=;
        b=Az9VAGKD0MdNI9gJVhZs7udIzFIbw3PINYb7Sa5pG2d1A+VUaiYsQg3ywhsJj+qjVdoYRv
        dqHd3f6ZYg4OxODk9B0YK1FwyAV4GEScPBAVRGU5r6ulzcIyPPPzsN8ZpM4SroKCDNrlu/
        yhIPIvHMrZl+IHPkPXhpsQxWSswKgbDzkWCSEPoA0KuIapLpiqs948mcKaiN8ZUveZp0ve
        GNtCAVJGhH4WQRwDCLX04DAditSvFNlTrIcWGL+hfBo9E6+xzYze9CvmdS5z1PrbR9c8Tn
        APzLL5yQQu0ewmdXSBX/GUlHjvt+7lTfQJh+RNzdlQL6k9UGyLBr46PuNAN02A==
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 198241C0004;
        Sun, 25 Jun 2023 23:16:06 +0000 (UTC)
Date:   Mon, 26 Jun 2023 01:16:06 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Valentin Caron <valentin.caron@foss.st.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Antonio Borneo <antonio.borneo@foss.st.com>,
        Christophe Guibout <christophe.guibout@foss.st.com>,
        Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
        linux-rtc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] rtc: stm32: fix unnecessary parentheses
Message-ID: <202306252316063d08f43c@mail.local>
References: <20230615092753.323844-1-valentin.caron@foss.st.com>
 <20230615092753.323844-7-valentin.caron@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615092753.323844-7-valentin.caron@foss.st.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 15/06/2023 11:27:52+0200, Valentin Caron wrote:
> Fix a few style issues reported by checkpatch.pl:
> - Unnecessary parentheses
> - Lines should not end with a '('
> 
> Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>
> ---
>  drivers/rtc/rtc-stm32.c | 29 ++++++++++++++---------------
>  1 file changed, 14 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-stm32.c b/drivers/rtc/rtc-stm32.c
> index 17e549806784..30c5004d6902 100644
> --- a/drivers/rtc/rtc-stm32.c
> +++ b/drivers/rtc/rtc-stm32.c
> @@ -160,10 +160,9 @@ static int stm32_rtc_enter_init_mode(struct stm32_rtc *rtc)
>  		 * slowest rtc_ck frequency may be 32kHz and highest should be
>  		 * 1MHz, we poll every 10 us with a timeout of 100ms.
>  		 */
> -		return readl_relaxed_poll_timeout_atomic(
> -					rtc->base + regs->isr,
> -					isr, (isr & STM32_RTC_ISR_INITF),
> -					10, 100000);
> +		return readl_relaxed_poll_timeout_atomic(rtc->base + regs->isr, isr,
> +							 (isr & STM32_RTC_ISR_INITF),
> +							 10, 100000);
>  	}
>  
>  	return 0;
> @@ -448,16 +447,16 @@ static int stm32_rtc_valid_alrm(struct stm32_rtc *rtc, struct rtc_time *tm)
>  	 *	M-D-Y H:M:S < alarm <= (M+1)-D-Y H:M:S
>  	 * with a specific case for December...
>  	 */
> -	if ((((tm->tm_year > cur_year) &&
> -	      (tm->tm_mon == 0x1) && (cur_mon == 0x12)) ||
> -	     ((tm->tm_year == cur_year) &&
> -	      (tm->tm_mon <= cur_mon + 1))) &&
> -	    ((tm->tm_mday > cur_day) ||
> -	     ((tm->tm_mday == cur_day) &&
> -	     ((tm->tm_hour > cur_hour) ||
> -	      ((tm->tm_hour == cur_hour) && (tm->tm_min > cur_min)) ||
> -	      ((tm->tm_hour == cur_hour) && (tm->tm_min == cur_min) &&
> -	       (tm->tm_sec >= cur_sec))))))
> +	if (((tm->tm_year > cur_year &&
> +	      tm->tm_mon == 0x1 && cur_mon == 0x12) ||
> +	     (tm->tm_year == cur_year &&
> +	      tm->tm_mon <= cur_mon + 1)) &&
> +	    (tm->tm_mday > cur_day ||
> +	     (tm->tm_mday == cur_day &&
> +	     (tm->tm_hour > cur_hour ||
> +	      (tm->tm_hour == cur_hour && tm->tm_min > cur_min) ||
> +	      (tm->tm_hour == cur_hour && tm->tm_min == cur_min &&
> +	       tm->tm_sec >= cur_sec)))))

This change is dropped in the following patch. I guess you can remove
the unnecessary churn.


>  		return 0;
>  
>  	return -EINVAL;
> @@ -666,7 +665,7 @@ static int stm32_rtc_init(struct platform_device *pdev,
>  	 * Can't find a 1Hz, so give priority to RTC power consumption
>  	 * by choosing the higher possible value for prediv_a
>  	 */
> -	if ((pred_s > pred_s_max) || (pred_a > pred_a_max)) {
> +	if (pred_s > pred_s_max || pred_a > pred_a_max) {
>  		pred_a = pred_a_max;
>  		pred_s = (rate / (pred_a + 1)) - 1;
>  
> -- 
> 2.25.1
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
