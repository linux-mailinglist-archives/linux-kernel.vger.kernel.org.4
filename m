Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4F5971498E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 14:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbjE2MfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 08:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbjE2MfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 08:35:19 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F442114;
        Mon, 29 May 2023 05:35:02 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-307d58b3efbso1974136f8f.0;
        Mon, 29 May 2023 05:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685363701; x=1687955701;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pVPOX1ZSOyV9Mwnc15tpUCMgaKJSRSoaxmZiy7ixDwk=;
        b=eS5BKpvvfKUXAVueSxHPOSIxgHU0GOC5Oiu+17YNYlIYpz3BHb1YcHVZv6Sv/VKytI
         uDn3S+fGXUBWAEXey+flfTKtZnorejS/HhZKSfAhPGbcwIMXtNHBYoABYzrBrtDDnkos
         61909pmvMy+Tslia++AcUID/T50Gswh28I7IQw0/RdL5asc5ApagPx5gy9mY+DwKKmky
         LqMAnpiZt6vjoUiG8/XWIRyH+iodgTOIy0BGBwxl5leoAbfnmysy9EHCOaYrCv5c1RmW
         SyBgR8ciNRm9fpEo1es0YhE35R8QIEiSV3KY3BJT1HV9CwKmncQE8d5LRyqFQDSFQL8E
         rdpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685363701; x=1687955701;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pVPOX1ZSOyV9Mwnc15tpUCMgaKJSRSoaxmZiy7ixDwk=;
        b=R/AQ4v8SHjcB1xzmBZk8b2pcBF1ta1es7P6fUaQVdyj2qpRk/Yjo1+Ttx6tVD1+qz5
         yk7sdIJQ16Zy8k7apKYYScQiVewC6ylQMMBSOHTJhKawmEtrRoBVN+BW3jVcHeYU5mmx
         lpQyltgLAOu/VtnvaEjz6FnqqdcEp7KLBHwUcidUUwQcwUi1Nc6j8kLvb3fC61keKore
         bw2YEHCvlKEW6zeIrGC9BANrtNLI2H6kKWMHXe96n5yVC8CS8DdEUH8sdg/qvUIhkWwD
         WQEAmwVkjJMl8e9igfaUyassVtLVIP7RQxk6J6jtgqdhKGlIo0Amt9KmUIm+9UKTht6i
         UqbQ==
X-Gm-Message-State: AC+VfDx/E2B6+n4Mdohsv2cfRFkfsAtSWselcdVOJymg4Z/M0rSSR7qg
        4u25WhJna61fUu6aZpdiYIw=
X-Google-Smtp-Source: ACHHUZ7d73t2t9td6jGLO4CsnsAHDpAB78W9VG3Ttn7TlZwIVdRD+SON2kTvpbvY7QCuFM69kDMEnw==
X-Received: by 2002:adf:df0b:0:b0:30a:ab38:3104 with SMTP id y11-20020adfdf0b000000b0030aab383104mr10392208wrl.34.1685363700415;
        Mon, 29 May 2023 05:35:00 -0700 (PDT)
Received: from Ansuel-xps. (93-34-93-173.ip49.fastwebnet.it. [93.34.93.173])
        by smtp.gmail.com with ESMTPSA id e12-20020a5d500c000000b0030ae87bd3e3sm4485906wrt.18.2023.05.29.05.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 05:35:00 -0700 (PDT)
Message-ID: <64749bf4.5d0a0220.325c0.64b5@mx.google.com>
X-Google-Original-Message-ID: <ZHSb8Q5iyGnYJvKH@Ansuel-xps.>
Date:   Mon, 29 May 2023 14:34:57 +0200
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
 <6473e34c.df0a0220.33a79.6c95@mx.google.com>
 <4afbcdd0-a11c-4826-d669-2ffc9488a8b6@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4afbcdd0-a11c-4826-d669-2ffc9488a8b6@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2023 at 02:12:23PM +0200, Konrad Dybcio wrote:
> 
> 
> On 28.05.2023 14:37, Christian Marangi wrote:
> > On Sat, May 27, 2023 at 06:11:16PM +0200, Konrad Dybcio wrote:
> >>
> >>
> >> On 27.04.2023 17:07, Christian Marangi wrote:
> >>> Some RCG frequency can be reached by multiple configuration.
> >>>
> >>> Add clk_rcg2_fm_ops ops to support these special RCG configurations.
> >>>
> >>> These alternative ops will select the frequency using a CEIL policy.
> >>>
> >>> When the correct frequency is found, the correct config is selected by
> >>> calculating the final rate (by checking the defined parent and values
> >>> in the config that is being checked) and deciding based on the one that
> >>> is less different than the requested one.
> >>>
> >>> These check are skipped if there is just on config for the requested
> >>> freq.
> >>>
> >>> qcom_find_freq_multi is added to search the freq with the new struct
> >>> freq_multi_tbl.
> >>> __clk_rcg2_select_conf is used to select the correct conf by simulating
> >>> the final clock.
> >>>
> >>> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> >>> ---
> >>>  drivers/clk/qcom/clk-rcg.h  |   1 +
> >>>  drivers/clk/qcom/clk-rcg2.c | 152 ++++++++++++++++++++++++++++++++++++
> >>>  drivers/clk/qcom/common.c   |  18 +++++
> >>>  drivers/clk/qcom/common.h   |   2 +
> >>>  4 files changed, 173 insertions(+)
> >>>
> >>> diff --git a/drivers/clk/qcom/clk-rcg.h b/drivers/clk/qcom/clk-rcg.h
> >>> index dc85b46b0d79..f8ec989ed3d9 100644
> >>> --- a/drivers/clk/qcom/clk-rcg.h
> >>> +++ b/drivers/clk/qcom/clk-rcg.h
> >>> @@ -188,6 +188,7 @@ struct clk_rcg2_gfx3d {
> >>>  
> >>>  extern const struct clk_ops clk_rcg2_ops;
> >>>  extern const struct clk_ops clk_rcg2_floor_ops;
> >>> +extern const struct clk_ops clk_rcg2_fm_ops;
> >>>  extern const struct clk_ops clk_rcg2_mux_closest_ops;
> >>>  extern const struct clk_ops clk_edp_pixel_ops;
> >>>  extern const struct clk_ops clk_byte_ops;
> >>> diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
> >>> index 76551534f10d..4f2fe012ef5f 100644
> >>> --- a/drivers/clk/qcom/clk-rcg2.c
> >>> +++ b/drivers/clk/qcom/clk-rcg2.c
> >>> @@ -266,6 +266,104 @@ static int _freq_tbl_determine_rate(struct clk_hw *hw, const struct freq_tbl *f,
> >>>  	return 0;
> >>>  }
> >>>  
> >>> +static const struct freq_conf *
> >>> +__clk_rcg2_select_conf(struct clk_hw *hw, const struct freq_multi_tbl *f,
> >>> +		       unsigned long req_rate)
> >>> +{
> >>> +	unsigned long best_rate = 0, parent_rate, rate;
> >>> +	const struct freq_conf *conf, *best_conf;
> >>> +	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
> >>> +	struct clk_hw *p;
> >>> +	int index, i;
> >>> +
> >>> +	/* Exit early if only one config is defined */
> >>> +	if (f->num_confs == 1)
> >>> +		return f->confs;
> >>> +
> >>> +	/* Search in each provided config the one that is near the wanted rate */
> >>> +	for (i = 0, conf = f->confs; i < f->num_confs; i++, conf++) {
> >>> +		index = qcom_find_src_index(hw, rcg->parent_map, conf->src);
> >>> +		if (index < 0)
> >>> +			continue;
> >>> +
> >>> +		p = clk_hw_get_parent_by_index(hw, index);
> >>> +		if (!p)
> >>> +			continue;
> >>> +
> >>> +		parent_rate =  clk_hw_get_rate(p);
> >>> +		rate = calc_rate(parent_rate, conf->n, conf->m, conf->n, conf->pre_div);
> >>> +
> >>> +		if (rate == req_rate) {
> >>> +			best_conf = conf;
> >>> +			break;
> >>> +		}
> >>> +
> >>> +		if (abs(req_rate - rate) < abs(best_rate - rate)) {
> >> Shouldn't this be:
> >>
> >> if (abs(req_rate - rate) < abs(best_rate - req_rate)
> >>
> >> ?
> >>
> >> this way it'd say
> >>
> >> "if this iteration's rate is closer to the requested one than the
> >> best one we've found yet, it's better"
> >>
> > 
> > Hi, thanks for the review!
> > 
> > I wonder if even better would be something where we save the best rate
> > diff and just compare that.
> > 
> > rate_diff = abs(req_rate - rate)
> > if (rate_diff < best_rate_diff) {
> > 	best_rate_diff = rate_diff;
> > 	best_conf = conf;
> > }
> > 
> > And best_rate_diff init to ULONG_MAX?
> Yeah that would be more readable!
> 
> > 
> >>> +			best_rate = rate;
> >>> +			best_conf = conf;
> >>> +		}
> >>> +	}
> >>> +
> >>> +	/*
> >>> +	 * Very unlikely.
> >>> +	 * Force the first conf if we can't find a correct config.
> >>> +	 */
> >>> +	if (unlikely(i == f->num_confs))
> >>> +		best_conf = f->confs;
> >> Is that a supported scenario or would it be a device driver / clock
> >> driver error?
> >>
> > 
> > It's to handle case for the 2 continue in the loop and arriving in a
> > situation where best_conf was never set?
> > 
> > Should we return a warning and an ERR_PTR? Idea was to provide a best
> > effort selection.
> Hm.. I'm not sure what's the expected behavior here.. Stephen?
> 

I have this implementation rady, if you want I can send this revision
and discuss that in v5 directly. It's WARN and returning -EINVAL.

> > 
> >>> +
> >>> +	return best_conf;
> >>> +}
> >>> +
> >>> +static int _freq_tbl_fm_determine_rate(struct clk_hw *hw, const struct freq_multi_tbl *f,
> >>> +				       struct clk_rate_request *req)
> >>> +{
> >>> +	unsigned long clk_flags, rate = req->rate;
> >>> +	const struct freq_conf *conf;
> >>> +	struct clk_hw *p;
> >>> +	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
> >> swap lines 2, 3, 4 to 4, 2, 3 and you'll get a revers-Christmas-tree!
> >>
> > 
> > Thanks, didn't notice this. Will do in v5.
> > 

-- 
	Ansuel
