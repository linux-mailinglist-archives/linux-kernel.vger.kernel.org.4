Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13439695400
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 23:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbjBMWoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 17:44:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjBMWoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 17:44:03 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3441D91C;
        Mon, 13 Feb 2023 14:44:02 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id l21-20020a05600c1d1500b003dfe462b7e4so208722wms.0;
        Mon, 13 Feb 2023 14:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WK3CCMhTv1GBa53IQokrxcydq2BCBlwEvGGs6eZBnZQ=;
        b=guDzE+zf9N3feKFCNFoXyN6ujn6wcUusuHUjZV1LJdznmyIGxpjCXSiDaYVilNLTdS
         RrV8AtBcYgbKAtRt7dmrFNv0ehSqEKQkBWWnc6viUeGYKJ3wacKRF4f5k4ErLANRaYGg
         rrQEjOFpL2jaDgLt4Km/l7IL1CH2VIKvxSjuZPRd3xAO7xb273A16Cm9R2VeXg9PNl1J
         712+auMWnqzGDF1DlQlurkHAtC01JdWP/xzY0PNJ9Hiuf5FEHEq0HGuXxI4tYW2DhWua
         qJHh8/NBBUCl1rsguR2slNzpMVs3Fppu/LBmR8Y/MDrIQq7TK8mY/F1qlXYIqXgISy8G
         3E0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WK3CCMhTv1GBa53IQokrxcydq2BCBlwEvGGs6eZBnZQ=;
        b=2Lfr8FkAv4NvcUyDv0YJZU/7DtzB52r2iwhQqTFusLZGdlaGqB9xObbLn8qXQ71+6e
         3MzOx4YHXlNpWo7qs0Ay+dzPPJWJUPDur/qbSAngT3CJmSANWZW6dPg+eRy5CMcZnvzS
         b98fyi8MVdZurduRE5irVm7nz5AlnLMNCdslGY+jodwq8Y1IDN+WRAvcuIgd89fu9DH+
         CpQIBNzYnKSZfjeQ0sWtwFJMJ1rEYVI9U9rGQoOFuRIGqXr2dB6MFFR20DAdQd71Gv/Y
         cdYJV+1PBkeqmDTuSWIDYPrqnVkMkJjd+MQ35yPEwXk4TxxSbu3zS+sONQ1AYYs3G15a
         7uxg==
X-Gm-Message-State: AO0yUKVcu3ILmNpFGuP95ODk9os4ly2Fs2iAJWw+jk7uDOvzCLFOLqNh
        d8LSrUmAIL8FKdU8D+wWp2o=
X-Google-Smtp-Source: AK7set+DTUTNOO5Ndml0G+wORfDkXiSCJ7KOkP7cHwxjKz1l+ukW479vuLVMZrDaJPBCgsSReuEJTQ==
X-Received: by 2002:a05:600c:4d15:b0:3dc:443e:420e with SMTP id u21-20020a05600c4d1500b003dc443e420emr230589wmp.2.1676328240975;
        Mon, 13 Feb 2023 14:44:00 -0800 (PST)
Received: from Ansuel-xps. (93-34-91-73.ip49.fastwebnet.it. [93.34.91.73])
        by smtp.gmail.com with ESMTPSA id h28-20020a05600c2cbc00b003dc3f3d77e3sm15872602wmc.7.2023.02.13.14.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 14:44:00 -0800 (PST)
Message-ID: <63eabd30.050a0220.7ac8f.d6d2@mx.google.com>
X-Google-Original-Message-ID: <Y+isyb4DFabVmzBk@Ansuel-xps.>
Date:   Sun, 12 Feb 2023 10:09:29 +0100
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] clk: qcom: clk-krait: switch to .determine_rate
References: <20230212-clk-qcom-determine_rate-v1-0-b4e447d4926e@z3ntu.xyz>
 <20230212-clk-qcom-determine_rate-v1-1-b4e447d4926e@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230212-clk-qcom-determine_rate-v1-1-b4e447d4926e@z3ntu.xyz>
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_24_48,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 12, 2023 at 03:11:08PM +0100, Luca Weiss wrote:
> .determine_rate is meant to replace .round_rate. The former comes with a
> benefit which is especially relevant on 32-bit systems: since
> .determine_rate uses an "unsigned long" (compared to a "signed long"
> which is used by .round_rate) the maximum value on 32-bit systems
> increases from 2^31 (or approx. 2.14GHz) to 2^32 (or approx. 4.29GHz).
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>

Hi, found time to test this on ipq806x and seems to work correctly by
scaling to each freq and checking the hfpll reported freq.

Tested-by: Christian Marangi <ansuelsmth@gmail.com>

> ---
>  drivers/clk/qcom/clk-krait.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/clk/qcom/clk-krait.c b/drivers/clk/qcom/clk-krait.c
> index 293a9dfa7151..f5ce403e1e27 100644
> --- a/drivers/clk/qcom/clk-krait.c
> +++ b/drivers/clk/qcom/clk-krait.c
> @@ -97,11 +97,11 @@ const struct clk_ops krait_mux_clk_ops = {
>  EXPORT_SYMBOL_GPL(krait_mux_clk_ops);
>  
>  /* The divider can divide by 2, 4, 6 and 8. But we only really need div-2. */
> -static long krait_div2_round_rate(struct clk_hw *hw, unsigned long rate,
> -				  unsigned long *parent_rate)
> +static int krait_div2_determine_rate(struct clk_hw *hw, struct clk_rate_request *req)
>  {
> -	*parent_rate = clk_hw_round_rate(clk_hw_get_parent(hw), rate * 2);
> -	return DIV_ROUND_UP(*parent_rate, 2);
> +	req->best_parent_rate = clk_hw_round_rate(clk_hw_get_parent(hw), req->rate * 2);
> +	req->rate = DIV_ROUND_UP(req->best_parent_rate, 2);
> +	return 0;
>  }
>  
>  static int krait_div2_set_rate(struct clk_hw *hw, unsigned long rate,
> @@ -142,7 +142,7 @@ krait_div2_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
>  }
>  
>  const struct clk_ops krait_div2_clk_ops = {
> -	.round_rate = krait_div2_round_rate,
> +	.determine_rate = krait_div2_determine_rate,
>  	.set_rate = krait_div2_set_rate,
>  	.recalc_rate = krait_div2_recalc_rate,
>  };
> 
> -- 
> 2.39.1
> 

-- 
	Ansuel
