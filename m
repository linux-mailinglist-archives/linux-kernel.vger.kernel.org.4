Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53A44669927
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 14:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234274AbjAMNx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 08:53:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241899AbjAMNx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 08:53:28 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14F91903A;
        Fri, 13 Jan 2023 05:50:22 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id h16so21120429wrz.12;
        Fri, 13 Jan 2023 05:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=w5ge1HoAOSGvKDWdqSB2297lLpq0G/qQASQVrgOsDIw=;
        b=GU8VY1MzwEvEg/LM6HO99UpJRhfOVDaKQBxBG9ozjICjKFXI4ZtCyZryPGkWnZv8Pu
         QgUkWiLYLKjIbJNcz7QTX0+h4QZIMo0Ktn4rAFLYHMqiP10Q+/4sUNnDXPWhi9fdzNbR
         8Oo9IB1lgjVr2ijCu4JInit+BK2+mNPdPXiMAKf194981IoejQJjDnevGzVFhv2bfE67
         D4CjrLjDc3VCuPta+CcRNw+TIuy7HLQzStJh6u36C+MRhYt0hoF46YNshwXYJa1ag2iQ
         QnyidOFqLbXubXDupggVXb3uyaI/9Kdx+bQg80TB2P7NC+/0NnAPfvAWHR8gRp2rlg/H
         BE4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w5ge1HoAOSGvKDWdqSB2297lLpq0G/qQASQVrgOsDIw=;
        b=TkbnNC60vBi6sKE+NezQhPbUxrOVTnYs8OPV4VIMa5DGGHpp6MQKI4hAzRNfRE3Xsl
         7CMXCprastJoNPbYcv5/Va3e0wLqEHmOIueD+xgxAUqN3GH7WO4tqrUm6EuaPFGDm764
         /Wq/F1WcPlAYgiMitdM1AW7fqecVHh577L1hTdk58Btk8agwlw7rhz1n+Mt7+vedefxL
         /fG4tbMHTgSnddCFpzF79Fc7Jf8rdJH2GYxa94K+nc+tcRrQTDXZthjcw4Q40YY2OWEs
         hhsciC4UsF00hChGd+ihnRwSlUOzYTyjMYDdEYypbIqxV624Rv2zH8aJxGkWapqVnFbW
         3juw==
X-Gm-Message-State: AFqh2krnywfg5IBaBvteLIzxIZK6IjEXM/KzKaC6vew+XuNPQozSbfAD
        66TAcpNuhU/sRctimL+iWbI=
X-Google-Smtp-Source: AMrXdXshexR+Ps4Mp2UrVCu8BTB8SefGRw7+8mTbREtVbT2TWBcouYtxi//VC90xVmnKaPGHzlYcLQ==
X-Received: by 2002:adf:e19d:0:b0:28f:29b3:1a7f with SMTP id az29-20020adfe19d000000b0028f29b31a7fmr38539267wrb.36.1673617821126;
        Fri, 13 Jan 2023 05:50:21 -0800 (PST)
Received: from Ansuel-xps. (93-34-92-88.ip49.fastwebnet.it. [93.34.92.88])
        by smtp.gmail.com with ESMTPSA id f2-20020adfdb42000000b0024274a5db0asm19181933wrj.2.2023.01.13.05.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 05:50:20 -0800 (PST)
Message-ID: <63c1619c.df0a0220.225ea.edb1@mx.google.com>
X-Google-Original-Message-ID: <Y8FhnE1qOTc6p2GT@Ansuel-xps.>
Date:   Fri, 13 Jan 2023 14:50:20 +0100
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Robert Marko <robimarko@gmail.com>
Subject: Re: [RESEND PATCH 1/2] clk: qcom: clk-rcg2: introduce support for
 multiple conf for same freq
References: <20230111194250.15793-1-ansuelsmth@gmail.com>
 <00cebe7d-ae3d-8772-c206-cd3ce6a275c1@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00cebe7d-ae3d-8772-c206-cd3ce6a275c1@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 05:46:09AM +0200, Dmitry Baryshkov wrote:
> Hi,
> 
> On 11/01/2023 21:42, Christian Marangi wrote:
> > Some RCG frequency can be reached by multiple configuration.
> > 
> > We currently declare multiple configuration for the same frequency but
> > that is not supported and always the first configuration will be taken.
> > 
> > These multiple configuration are needed as based on the current parent
> > configuration, it may be needed to use a different configuration to
> > reach the same frequency.
> > 
> > To handle this introduce 2 new macro, FM and C.
> > 
> > - FM is used to declare an empty freq_tbl with just the frequency and an
> >    array of confs to insert all the config for the provided frequency.
> > 
> > - C is used to declare a fre_conf where src, pre_div, m and n are
> >    provided.
> > 
> > The driver is changed to handle this special freq_tbl and select the
> > correct config by calculating the final rate and deciding based on the
> > one that is less different than the requested one.
> 
> I gave this a thought.
> 
> First some generic thought about RCG2 risen by your patch. I'll talk about
> the CEIL functions, but the same applies to FLOOR ones.
> 
> The clk_rcg2_determine_rate() / freq_tbl_determine_rate() determines the
> best supported rate and and selects a best parent. Good. Then CCF will pass
> the determined target rate, parent index and parent rate either to
> clk_rcg2_set_rate() or to the clk_rcg2_set_rate_and_parent() depending on
> whether it determines that the parent should be switched or not. So far so
> good.
> 
> However then the __clk_rcg2_set_rate() will perform the same search again,
> taking care of FLOOR or CEIL, completely ignoring the fact that rate passed
> is already known to be the supported rate, so we can just look for it and
> ignoring the provided parent (or a note from CCF that the parent should
> remain the same).
>

Interesting analysis and looks to be something to fix and improve for
sure. Will take some time but happy to fix. Also in theory on a system
we should have all kind of clk variant due to the amount of clocks
modern so a simple clk_summary diff should catch regression quite
easily.

> This worked correctly in the single-possible-configuration case, however it
> IMHO becames fragile in the multiple-possible-configuration case. Consider
> CCF switching the parent rate during the clk_set_rate() call. Then the
> second lookup might end up selecting _different_ parent/mnd configuration.
> 
> Thus said, I'd suggest first changing clk_rcg2_set_rate/and_parent(). Make
> it look up the exact configuration without the rounding (it is unnecessary
> anyway). This would require something like qcom_find_freq_exact(). Or just
> loop over the table in __clk_rcg2_set_rate().

Just to make sure I understood the logic. Since it's all driven by
determine_rate, in theory we should never do searching on the set rate
and just execute what it's said... With the following idea why the
set_floor_rate needed a __clk_rcg2_set_rate variant with the FLOOR
policy? If everything is decided by determine_rate then the set_rate
function should be able to just use a TO-IMPLEMENT find_freq_exact
function. Am I missing something?

> 
> Then for your case make it actually use the provided parent index (or the
> current parent in the .set_rate() case). This will make sure that we follow
> CCF decisions instead of making them on our own.
> 
> Finally for your usecase to work correcly you need to select correct
> rate+parent in the .determine_rate callback.
> 
> We know that the freq_table is sorted already. Add a loop to
> _freq_tbl_determine_rate() policy switchcase to check next table entries
> determing if their parent rate is better than the parent rate of the
> selected entry.

With this you mean that we should continue putting duplicate entry in
the freq table and always check the next element for alternative conf?

This was the qcom way and honestly I find it pretty confusing than a
well organized table with only unique entry and a way to directly check
if we are in a multi-conf scenario. (also lets not trust devs with
having the freq table sorted)

> 
> > 
> > Tested-by: Robert Marko <robimarko@gmail.com>
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >   drivers/clk/qcom/clk-rcg.h  | 14 ++++++-
> >   drivers/clk/qcom/clk-rcg2.c | 84 +++++++++++++++++++++++++++++++++----
> >   2 files changed, 88 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/clk/qcom/clk-rcg.h b/drivers/clk/qcom/clk-rcg.h
> > index 01581f4d2c39..18f4f7b59f36 100644
> > --- a/drivers/clk/qcom/clk-rcg.h
> > +++ b/drivers/clk/qcom/clk-rcg.h
> > @@ -7,7 +7,17 @@
> >   #include <linux/clk-provider.h>
> >   #include "clk-regmap.h"
> > -#define F(f, s, h, m, n) { (f), (s), (2 * (h) - 1), (m), (n) }
> > +#define F(f, s, h, m, n) { (f), (s), (2 * (h) - 1), (m), (n), 0, NULL }
> > +
> > +#define FM(_f, _confs) { .freq = (_f), .confs_num = ARRAY_SIZE(_confs), .confs = (_confs) }
> > +#define C(s, h, m, n) { (s), (2 * (h) - 1), (m), (n) }
> > +
> > +struct freq_conf {
> > +	u8 src;
> > +	u8 pre_div;
> > +	u16 m;
> > +	u16 n;
> > +};
> >   struct freq_tbl {
> >   	unsigned long freq;
> > @@ -15,6 +25,8 @@ struct freq_tbl {
> >   	u8 pre_div;
> >   	u16 m;
> >   	u16 n;
> > +	int confs_num;
> > +	const struct freq_conf *confs;
> >   };
> >   /**
> > diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
> > index 76551534f10d..7d3b59ec2b50 100644
> > --- a/drivers/clk/qcom/clk-rcg2.c
> > +++ b/drivers/clk/qcom/clk-rcg2.c
> > @@ -209,11 +209,60 @@ clk_rcg2_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
> >   	return __clk_rcg2_recalc_rate(hw, parent_rate, cfg);
> >   }
> > +static void
> > +clk_rcg2_select_conf(struct clk_hw *hw, struct freq_tbl *f_tbl,
> > +		     const struct freq_tbl *f, unsigned long req_rate)
> > +{
> > +	unsigned long best_rate = 0, parent_rate, rate;
> > +	const struct freq_conf *conf, *best_conf;
> > +	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
> > +	struct clk_hw *p;
> > +	int index, i;
> > +
> > +	/* Search in each provided config the one that is near the wanted rate */
> > +	for (i = 0, conf = f->confs; i < f->confs_num; i++, conf++) {
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
> > +			best_rate = rate;
> > +			best_conf = conf;
> > +		}
> > +	}
> > +
> > +	/*
> > +	 * Very unlikely.
> > +	 * Force the first conf if we can't find a correct config.
> > +	 */
> > +	if (unlikely(i == f->confs_num))
> > +		best_conf = f->confs;
> > +
> > +	/* Apply the config */
> > +	f_tbl->src = best_conf->src;
> > +	f_tbl->pre_div = best_conf->pre_div;
> > +	f_tbl->m = best_conf->m;
> > +	f_tbl->n = best_conf->n;
> > +}
> > +
> >   static int _freq_tbl_determine_rate(struct clk_hw *hw, const struct freq_tbl *f,
> >   				    struct clk_rate_request *req,
> >   				    enum freq_policy policy)
> >   {
> >   	unsigned long clk_flags, rate = req->rate;
> > +	struct freq_tbl f_tbl;
> >   	struct clk_hw *p;
> >   	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
> >   	int index;
> > @@ -232,7 +281,15 @@ static int _freq_tbl_determine_rate(struct clk_hw *hw, const struct freq_tbl *f,
> >   	if (!f)
> >   		return -EINVAL;
> > -	index = qcom_find_src_index(hw, rcg->parent_map, f->src);
> > +	f_tbl = *f;
> > +	/*
> > +	 * A single freq may be reached by multiple configuration.
> > +	 * Try to find the bast one if we have this kind of freq_table.
> > +	 */
> > +	if (f->confs)
> > +		clk_rcg2_select_conf(hw, &f_tbl, f, rate);
> > +
> > +	index = qcom_find_src_index(hw, rcg->parent_map, f_tbl.src);
> >   	if (index < 0)
> >   		return index;
> > @@ -242,18 +299,18 @@ static int _freq_tbl_determine_rate(struct clk_hw *hw, const struct freq_tbl *f,
> >   		return -EINVAL;
> >   	if (clk_flags & CLK_SET_RATE_PARENT) {
> > -		rate = f->freq;
> > -		if (f->pre_div) {
> > +		rate = f_tbl.freq;
> > +		if (f_tbl.pre_div) {
> >   			if (!rate)
> >   				rate = req->rate;
> >   			rate /= 2;
> > -			rate *= f->pre_div + 1;
> > +			rate *= f_tbl.pre_div + 1;
> >   		}
> > -		if (f->n) {
> > +		if (f_tbl.n) {
> >   			u64 tmp = rate;
> > -			tmp = tmp * f->n;
> > -			do_div(tmp, f->m);
> > +			tmp = tmp * f_tbl.n;
> > +			do_div(tmp, f_tbl.m);
> >   			rate = tmp;
> >   		}
> >   	} else {
> > @@ -261,7 +318,7 @@ static int _freq_tbl_determine_rate(struct clk_hw *hw, const struct freq_tbl *f,
> >   	}
> >   	req->best_parent_hw = p;
> >   	req->best_parent_rate = rate;
> > -	req->rate = f->freq;
> > +	req->rate = f_tbl.freq;
> >   	return 0;
> >   }
> > @@ -357,6 +414,7 @@ static int __clk_rcg2_set_rate(struct clk_hw *hw, unsigned long rate,
> >   {
> >   	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
> >   	const struct freq_tbl *f;
> > +	struct freq_tbl f_tbl;
> >   	switch (policy) {
> >   	case FLOOR:
> > @@ -372,7 +430,15 @@ static int __clk_rcg2_set_rate(struct clk_hw *hw, unsigned long rate,
> >   	if (!f)
> >   		return -EINVAL;
> > -	return clk_rcg2_configure(rcg, f);
> > +	f_tbl = *f;
> > +	/*
> > +	 * A single freq may be reached by multiple configuration.
> > +	 * Try to find the best one if we have this kind of freq_table.
> > +	 */
> > +	if (f->confs)
> > +		clk_rcg2_select_conf(hw, &f_tbl, f, rate);
> > +
> > +	return clk_rcg2_configure(rcg, &f_tbl);
> >   }
> >   static int clk_rcg2_set_rate(struct clk_hw *hw, unsigned long rate,
> 
> -- 
> With best wishes
> Dmitry
> 

-- 
	Ansuel
