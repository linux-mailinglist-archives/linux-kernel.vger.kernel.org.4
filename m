Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3246669C2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 04:46:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235283AbjALDqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 22:46:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235969AbjALDqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 22:46:16 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B1163C1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 19:46:12 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id y25so26566360lfa.9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 19:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y8dOW5pRnm76DXQ7mSIq/E9mwEicC9WVIGYw1/nEyxU=;
        b=SrSc7Ok98mcZB4uw0ovIUIL4fPuoVdyZf2xGbEyL2IH18eiFkudK4vuHXjsmQKgCru
         p9lXW/XHlHJill3+Xcuhi3lU87KUyHwx39BRIEMWFPEEzrKcabYbCm2c54u1nJYNLShw
         meFPxMBikDk0rUFWsPVjVbvc1QF5aIbYh7NMME6Tz986tm/cvL4xMyaxoDt6kjqmvRaU
         Ld6MHSAC87CYJfjRLC4V3aLAyqPOKbs8cmkUz0Bak6CdKPZ+BjfwBNy45KzhYrCy3c10
         H3661D3RxFPpdl89OqA06vsNgffRMuAXWYiZqVobv6m6q1P4ei1F+5ri8VE7Pf1jjNZ7
         FyWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y8dOW5pRnm76DXQ7mSIq/E9mwEicC9WVIGYw1/nEyxU=;
        b=ArdwT1ykDwUJkftANV5Qo6U3QGwN1M1U7oJpwCHB1TXsuoQNtVA5r3Sh3DWAbAGwr1
         1B8uviGKMQ7YazuhrdN4EQ/ySkQoiJdIiYaGIp+Y/E0aI+O+qnvRnpSFYHZGczEWBgeL
         ex2vTBTfYA9wvLC/UiDwUZ6Nxt1mqi9m0WajT4I7ZmfJ3hD0Z7sAcb7KOyrpde3YdHzx
         XwNnCw6Oka0Uos0+0YFPbKTVNw202owKlVlwxPW1VyHsybbMERTb2UugsdFB/oTmf7SD
         v9IJffRr1xKUPfSUugbrwjI5+eUphZDZhouqjlEaJZSt51N48DLQ79FrquoAmrdjMTBH
         pE0w==
X-Gm-Message-State: AFqh2kqW1YE/XeREu77GtA6Z2gH04Vf920z09WwyUidu0YsYeTeJCEmi
        7xNVxRG7+gEQp/Aw7VgDcfvzEg==
X-Google-Smtp-Source: AMrXdXtNqgbo3bWwww9N1TTda93aPV9HOIQW7H7jN1UHMm1J5cw89WqUlfXV4ivVrhaDZqubXTKPWA==
X-Received: by 2002:a05:6512:3b99:b0:4a4:68b9:608c with SMTP id g25-20020a0565123b9900b004a468b9608cmr25955520lfv.23.1673495170904;
        Wed, 11 Jan 2023 19:46:10 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id 2-20020ac25f02000000b0048b365176d9sm3052440lfq.286.2023.01.11.19.46.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jan 2023 19:46:10 -0800 (PST)
Message-ID: <00cebe7d-ae3d-8772-c206-cd3ce6a275c1@linaro.org>
Date:   Thu, 12 Jan 2023 05:46:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [RESEND PATCH 1/2] clk: qcom: clk-rcg2: introduce support for
 multiple conf for same freq
Content-Language: en-GB
To:     Christian Marangi <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
References: <20230111194250.15793-1-ansuelsmth@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230111194250.15793-1-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/01/2023 21:42, Christian Marangi wrote:
> Some RCG frequency can be reached by multiple configuration.
> 
> We currently declare multiple configuration for the same frequency but
> that is not supported and always the first configuration will be taken.
> 
> These multiple configuration are needed as based on the current parent
> configuration, it may be needed to use a different configuration to
> reach the same frequency.
> 
> To handle this introduce 2 new macro, FM and C.
> 
> - FM is used to declare an empty freq_tbl with just the frequency and an
>    array of confs to insert all the config for the provided frequency.
> 
> - C is used to declare a fre_conf where src, pre_div, m and n are
>    provided.
> 
> The driver is changed to handle this special freq_tbl and select the
> correct config by calculating the final rate and deciding based on the
> one that is less different than the requested one.

I gave this a thought.

First some generic thought about RCG2 risen by your patch. I'll talk 
about the CEIL functions, but the same applies to FLOOR ones.

The clk_rcg2_determine_rate() / freq_tbl_determine_rate() determines the 
best supported rate and and selects a best parent. Good. Then CCF will 
pass the determined target rate, parent index and parent rate either to 
clk_rcg2_set_rate() or to the clk_rcg2_set_rate_and_parent() depending 
on whether it determines that the parent should be switched or not. So 
far so good.

However then the __clk_rcg2_set_rate() will perform the same search 
again, taking care of FLOOR or CEIL, completely ignoring the fact that 
rate passed is already known to be the supported rate, so we can just 
look for it and ignoring the provided parent (or a note from CCF that 
the parent should remain the same).

This worked correctly in the single-possible-configuration case, however 
it IMHO becames fragile in the multiple-possible-configuration case. 
Consider CCF switching the parent rate during the clk_set_rate() call. 
Then the second lookup might end up selecting _different_ parent/mnd 
configuration.

Thus said, I'd suggest first changing clk_rcg2_set_rate/and_parent(). 
Make it look up the exact configuration without the rounding (it is 
unnecessary anyway). This would require something like 
qcom_find_freq_exact(). Or just loop over the table in 
__clk_rcg2_set_rate().

Then for your case make it actually use the provided parent index (or 
the current parent in the .set_rate() case). This will make sure that we 
follow CCF decisions instead of making them on our own.

Finally for your usecase to work correcly you need to select correct 
rate+parent in the .determine_rate callback.

We know that the freq_table is sorted already. Add a loop to 
_freq_tbl_determine_rate() policy switchcase to check next table entries 
determing if their parent rate is better than the parent rate of the 
selected entry.

> 
> Tested-by: Robert Marko <robimarko@gmail.com>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>   drivers/clk/qcom/clk-rcg.h  | 14 ++++++-
>   drivers/clk/qcom/clk-rcg2.c | 84 +++++++++++++++++++++++++++++++++----
>   2 files changed, 88 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/clk/qcom/clk-rcg.h b/drivers/clk/qcom/clk-rcg.h
> index 01581f4d2c39..18f4f7b59f36 100644
> --- a/drivers/clk/qcom/clk-rcg.h
> +++ b/drivers/clk/qcom/clk-rcg.h
> @@ -7,7 +7,17 @@
>   #include <linux/clk-provider.h>
>   #include "clk-regmap.h"
>   
> -#define F(f, s, h, m, n) { (f), (s), (2 * (h) - 1), (m), (n) }
> +#define F(f, s, h, m, n) { (f), (s), (2 * (h) - 1), (m), (n), 0, NULL }
> +
> +#define FM(_f, _confs) { .freq = (_f), .confs_num = ARRAY_SIZE(_confs), .confs = (_confs) }
> +#define C(s, h, m, n) { (s), (2 * (h) - 1), (m), (n) }
> +
> +struct freq_conf {
> +	u8 src;
> +	u8 pre_div;
> +	u16 m;
> +	u16 n;
> +};
>   
>   struct freq_tbl {
>   	unsigned long freq;
> @@ -15,6 +25,8 @@ struct freq_tbl {
>   	u8 pre_div;
>   	u16 m;
>   	u16 n;
> +	int confs_num;
> +	const struct freq_conf *confs;
>   };
>   
>   /**
> diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
> index 76551534f10d..7d3b59ec2b50 100644
> --- a/drivers/clk/qcom/clk-rcg2.c
> +++ b/drivers/clk/qcom/clk-rcg2.c
> @@ -209,11 +209,60 @@ clk_rcg2_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
>   	return __clk_rcg2_recalc_rate(hw, parent_rate, cfg);
>   }
>   
> +static void
> +clk_rcg2_select_conf(struct clk_hw *hw, struct freq_tbl *f_tbl,
> +		     const struct freq_tbl *f, unsigned long req_rate)
> +{
> +	unsigned long best_rate = 0, parent_rate, rate;
> +	const struct freq_conf *conf, *best_conf;
> +	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
> +	struct clk_hw *p;
> +	int index, i;
> +
> +	/* Search in each provided config the one that is near the wanted rate */
> +	for (i = 0, conf = f->confs; i < f->confs_num; i++, conf++) {
> +		index = qcom_find_src_index(hw, rcg->parent_map, conf->src);
> +		if (index < 0)
> +			continue;
> +
> +		p = clk_hw_get_parent_by_index(hw, index);
> +		if (!p)
> +			continue;
> +
> +		parent_rate =  clk_hw_get_rate(p);
> +		rate = calc_rate(parent_rate, conf->n, conf->m, conf->n, conf->pre_div);
> +
> +		if (rate == req_rate) {
> +			best_conf = conf;
> +			break;
> +		}
> +
> +		if (abs(req_rate - rate) < abs(best_rate - rate)) {
> +			best_rate = rate;
> +			best_conf = conf;
> +		}
> +	}
> +
> +	/*
> +	 * Very unlikely.
> +	 * Force the first conf if we can't find a correct config.
> +	 */
> +	if (unlikely(i == f->confs_num))
> +		best_conf = f->confs;
> +
> +	/* Apply the config */
> +	f_tbl->src = best_conf->src;
> +	f_tbl->pre_div = best_conf->pre_div;
> +	f_tbl->m = best_conf->m;
> +	f_tbl->n = best_conf->n;
> +}
> +
>   static int _freq_tbl_determine_rate(struct clk_hw *hw, const struct freq_tbl *f,
>   				    struct clk_rate_request *req,
>   				    enum freq_policy policy)
>   {
>   	unsigned long clk_flags, rate = req->rate;
> +	struct freq_tbl f_tbl;
>   	struct clk_hw *p;
>   	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
>   	int index;
> @@ -232,7 +281,15 @@ static int _freq_tbl_determine_rate(struct clk_hw *hw, const struct freq_tbl *f,
>   	if (!f)
>   		return -EINVAL;
>   
> -	index = qcom_find_src_index(hw, rcg->parent_map, f->src);
> +	f_tbl = *f;
> +	/*
> +	 * A single freq may be reached by multiple configuration.
> +	 * Try to find the bast one if we have this kind of freq_table.
> +	 */
> +	if (f->confs)
> +		clk_rcg2_select_conf(hw, &f_tbl, f, rate);
> +
> +	index = qcom_find_src_index(hw, rcg->parent_map, f_tbl.src);
>   	if (index < 0)
>   		return index;
>   
> @@ -242,18 +299,18 @@ static int _freq_tbl_determine_rate(struct clk_hw *hw, const struct freq_tbl *f,
>   		return -EINVAL;
>   
>   	if (clk_flags & CLK_SET_RATE_PARENT) {
> -		rate = f->freq;
> -		if (f->pre_div) {
> +		rate = f_tbl.freq;
> +		if (f_tbl.pre_div) {
>   			if (!rate)
>   				rate = req->rate;
>   			rate /= 2;
> -			rate *= f->pre_div + 1;
> +			rate *= f_tbl.pre_div + 1;
>   		}
>   
> -		if (f->n) {
> +		if (f_tbl.n) {
>   			u64 tmp = rate;
> -			tmp = tmp * f->n;
> -			do_div(tmp, f->m);
> +			tmp = tmp * f_tbl.n;
> +			do_div(tmp, f_tbl.m);
>   			rate = tmp;
>   		}
>   	} else {
> @@ -261,7 +318,7 @@ static int _freq_tbl_determine_rate(struct clk_hw *hw, const struct freq_tbl *f,
>   	}
>   	req->best_parent_hw = p;
>   	req->best_parent_rate = rate;
> -	req->rate = f->freq;
> +	req->rate = f_tbl.freq;
>   
>   	return 0;
>   }
> @@ -357,6 +414,7 @@ static int __clk_rcg2_set_rate(struct clk_hw *hw, unsigned long rate,
>   {
>   	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
>   	const struct freq_tbl *f;
> +	struct freq_tbl f_tbl;
>   
>   	switch (policy) {
>   	case FLOOR:
> @@ -372,7 +430,15 @@ static int __clk_rcg2_set_rate(struct clk_hw *hw, unsigned long rate,
>   	if (!f)
>   		return -EINVAL;
>   
> -	return clk_rcg2_configure(rcg, f);
> +	f_tbl = *f;
> +	/*
> +	 * A single freq may be reached by multiple configuration.
> +	 * Try to find the best one if we have this kind of freq_table.
> +	 */
> +	if (f->confs)
> +		clk_rcg2_select_conf(hw, &f_tbl, f, rate);
> +
> +	return clk_rcg2_configure(rcg, &f_tbl);
>   }
>   
>   static int clk_rcg2_set_rate(struct clk_hw *hw, unsigned long rate,

-- 
With best wishes
Dmitry

