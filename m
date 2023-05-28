Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60CBA714137
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 01:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjE1X1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 19:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjE1X1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 19:27:12 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062819E;
        Sun, 28 May 2023 16:27:11 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-30ae5f2ac94so1044039f8f.1;
        Sun, 28 May 2023 16:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685316429; x=1687908429;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fmWkLfh/pINE4f3LXfsQzdk5y0tPlTxJr1z7LqH2sKo=;
        b=RMWr4oyzMgHYNiOgKrY8wnr7S9WMH/5JccxgfWsoUhx4XE7Emkj/Xifh1rSNdXZF2d
         2y+g+MbQlS98z23FslKyCQwI1/fhUTS7FH94wwFz72CWyMNKwO82gmeBgtoOdZHQnhLc
         C843ffAVlI9vp6JpEK4W/doCWt8NPu9TK1uT09oTKkq5Hj1qNIohxGa7GVLppIkOsTSh
         5OuzQlHvJOXUY4c1K/hwJ/wVEzHu19cxioMFBMQsD7tR+0tXWEDkvsqXEEVVX2ElleQJ
         /8DUnq3LBwHXbZup3igL1t5Fx6xRVHTXBc7xCdjgUTElJoKL1ISLBW0D8g1JPRHmZlPg
         /ygQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685316429; x=1687908429;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fmWkLfh/pINE4f3LXfsQzdk5y0tPlTxJr1z7LqH2sKo=;
        b=CxL2K3Y/oR9if6kv3WPT/JALj6lJE2Cfnor6b+ghuwMfBW73hHMva5G4tJcGvcQ2BQ
         GI2X5xBmiSP51+wq0XwsbOaimCj5jZI7NQn15wkYixtCdDMfMPsZ+7BvkIzA2bMq0re6
         0i18ZBYquDwzQN/rZ8hfYAi7Ryjb+MYTJKYmh8qD49pbo1w/smZmOPEJ9YvWUHlLb3Aq
         kQFRCuCeQMXTHXmqY1MJkhkv/JvIfUSMwri7EKBW2Cw+p+Q7AQTHdOn94YRnzmQGA8SJ
         GpXa9AEht3PPMTuJevgJrAc0aRP3VPuoFnj4Iz6jNtv3wVeL/O7jFz0xG3MuyBK5GJaV
         Jmzw==
X-Gm-Message-State: AC+VfDw1zmwye9lcgZYvzSRisCuFWnN/DHP89sh1b9k/nw26hIHNTJwY
        DimkNH9QMgoNuVOjWobWmHU=
X-Google-Smtp-Source: ACHHUZ5nXUjrkHJJqZubtc4QIx+lUpo9lpetj+xJnjsSbOOPwPGl3DLmwZ/4eyGZitvMdpnXO1gDng==
X-Received: by 2002:a5d:640c:0:b0:301:8551:446a with SMTP id z12-20020a5d640c000000b003018551446amr8855533wru.2.1685316429065;
        Sun, 28 May 2023 16:27:09 -0700 (PDT)
Received: from Ansuel-xps. (93-34-93-173.ip49.fastwebnet.it. [93.34.93.173])
        by smtp.gmail.com with ESMTPSA id e2-20020adffc42000000b002ff2c39d072sm11877937wrs.104.2023.05.28.16.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 16:27:08 -0700 (PDT)
Message-ID: <6473e34c.df0a0220.33a79.6c95@mx.google.com>
X-Google-Original-Message-ID: <ZHNLBp9skiowFgxL@Ansuel-xps.>
Date:   Sun, 28 May 2023 14:37:26 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] clk: qcom: clk-rcg2: add support for rcg2 freq
 multi ops
References: <20230427150717.20860-1-ansuelsmth@gmail.com>
 <20230427150717.20860-3-ansuelsmth@gmail.com>
 <82072c2b-8483-6fb6-a9d1-c9882825c9cb@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82072c2b-8483-6fb6-a9d1-c9882825c9cb@linaro.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 27, 2023 at 06:11:16PM +0200, Konrad Dybcio wrote:
> 
> 
> On 27.04.2023 17:07, Christian Marangi wrote:
> > Some RCG frequency can be reached by multiple configuration.
> > 
> > Add clk_rcg2_fm_ops ops to support these special RCG configurations.
> > 
> > These alternative ops will select the frequency using a CEIL policy.
> > 
> > When the correct frequency is found, the correct config is selected by
> > calculating the final rate (by checking the defined parent and values
> > in the config that is being checked) and deciding based on the one that
> > is less different than the requested one.
> > 
> > These check are skipped if there is just on config for the requested
> > freq.
> > 
> > qcom_find_freq_multi is added to search the freq with the new struct
> > freq_multi_tbl.
> > __clk_rcg2_select_conf is used to select the correct conf by simulating
> > the final clock.
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >  drivers/clk/qcom/clk-rcg.h  |   1 +
> >  drivers/clk/qcom/clk-rcg2.c | 152 ++++++++++++++++++++++++++++++++++++
> >  drivers/clk/qcom/common.c   |  18 +++++
> >  drivers/clk/qcom/common.h   |   2 +
> >  4 files changed, 173 insertions(+)
> > 
> > diff --git a/drivers/clk/qcom/clk-rcg.h b/drivers/clk/qcom/clk-rcg.h
> > index dc85b46b0d79..f8ec989ed3d9 100644
> > --- a/drivers/clk/qcom/clk-rcg.h
> > +++ b/drivers/clk/qcom/clk-rcg.h
> > @@ -188,6 +188,7 @@ struct clk_rcg2_gfx3d {
> >  
> >  extern const struct clk_ops clk_rcg2_ops;
> >  extern const struct clk_ops clk_rcg2_floor_ops;
> > +extern const struct clk_ops clk_rcg2_fm_ops;
> >  extern const struct clk_ops clk_rcg2_mux_closest_ops;
> >  extern const struct clk_ops clk_edp_pixel_ops;
> >  extern const struct clk_ops clk_byte_ops;
> > diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
> > index 76551534f10d..4f2fe012ef5f 100644
> > --- a/drivers/clk/qcom/clk-rcg2.c
> > +++ b/drivers/clk/qcom/clk-rcg2.c
> > @@ -266,6 +266,104 @@ static int _freq_tbl_determine_rate(struct clk_hw *hw, const struct freq_tbl *f,
> >  	return 0;
> >  }
> >  
> > +static const struct freq_conf *
> > +__clk_rcg2_select_conf(struct clk_hw *hw, const struct freq_multi_tbl *f,
> > +		       unsigned long req_rate)
> > +{
> > +	unsigned long best_rate = 0, parent_rate, rate;
> > +	const struct freq_conf *conf, *best_conf;
> > +	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
> > +	struct clk_hw *p;
> > +	int index, i;
> > +
> > +	/* Exit early if only one config is defined */
> > +	if (f->num_confs == 1)
> > +		return f->confs;
> > +
> > +	/* Search in each provided config the one that is near the wanted rate */
> > +	for (i = 0, conf = f->confs; i < f->num_confs; i++, conf++) {
> > +		index = qcom_find_src_index(hw, rcg->parent_map, conf->src);
> > +		if (index < 0)
> > +			continue;
> > +
> > +		p = clk_hw_get_parent_by_index(hw, index);
> > +		if (!p)
> > +			continue;
> > +
> > +		parent_rate =  clk_hw_get_rate(p);
> > +		rate = calc_rate(parent_rate, conf->n, conf->m, conf->n, conf->pre_div);
> > +
> > +		if (rate == req_rate) {
> > +			best_conf = conf;
> > +			break;
> > +		}
> > +
> > +		if (abs(req_rate - rate) < abs(best_rate - rate)) {
> Shouldn't this be:
> 
> if (abs(req_rate - rate) < abs(best_rate - req_rate)
> 
> ?
> 
> this way it'd say
> 
> "if this iteration's rate is closer to the requested one than the
> best one we've found yet, it's better"
>

Hi, thanks for the review!

I wonder if even better would be something where we save the best rate
diff and just compare that.

rate_diff = abs(req_rate - rate)
if (rate_diff < best_rate_diff) {
	best_rate_diff = rate_diff;
	best_conf = conf;
}

And best_rate_diff init to ULONG_MAX?

> > +			best_rate = rate;
> > +			best_conf = conf;
> > +		}
> > +	}
> > +
> > +	/*
> > +	 * Very unlikely.
> > +	 * Force the first conf if we can't find a correct config.
> > +	 */
> > +	if (unlikely(i == f->num_confs))
> > +		best_conf = f->confs;
> Is that a supported scenario or would it be a device driver / clock
> driver error?
> 

It's to handle case for the 2 continue in the loop and arriving in a
situation where best_conf was never set?

Should we return a warning and an ERR_PTR? Idea was to provide a best
effort selection.

> > +
> > +	return best_conf;
> > +}
> > +
> > +static int _freq_tbl_fm_determine_rate(struct clk_hw *hw, const struct freq_multi_tbl *f,
> > +				       struct clk_rate_request *req)
> > +{
> > +	unsigned long clk_flags, rate = req->rate;
> > +	const struct freq_conf *conf;
> > +	struct clk_hw *p;
> > +	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
> swap lines 2, 3, 4 to 4, 2, 3 and you'll get a revers-Christmas-tree!
> 

Thanks, didn't notice this. Will do in v5.

-- 
	Ansuel
