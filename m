Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD617624346
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 14:31:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbiKJNbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 08:31:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbiKJNbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 08:31:51 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B8ADC2;
        Thu, 10 Nov 2022 05:31:50 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id bs21so2274857wrb.4;
        Thu, 10 Nov 2022 05:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Exm3X31YbmGeADZoqYxlrtAsh+A0P0If35sTgy29YG8=;
        b=Rcj+XhtyOqr0Fa/DlimnA5Q/w/k0mIGXeYKCjmqDYhH6/R8/o0NAJS6/lC3mJv+Uqf
         uwaTJLJJSsGF4c/5ouiMBKhXK/ZLRctAjaDCr3locKG+5GwSVyimlplOGd6nVGYbqHAY
         diBdE0VaI/rJNTXxis0vD/mQdtIHPi2IBbBV8PPCK51zxR/dULfBV3FqBPJl6OOYSclO
         zkk8R+REs0KfsLPAOXQLdbQMoBGkgp5gT20yyO602nPBevTnefapeD9INinFshfDDuLb
         D/E3or3NOZaShwhVLsjffpqc+j8LWpT9H9bX4iY6EB0zdf50tYk7RXCJiMD1qIyJKIzT
         onBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Exm3X31YbmGeADZoqYxlrtAsh+A0P0If35sTgy29YG8=;
        b=fRAh07HhqBD+k8Eopd4CcrVVHrpfLhvunT5Z/7O8blC4liWLeFMrWs29yoUNN9MORk
         3nciTKJyOn+fwjy1g2/QMYgbeAMEsyGIhWCsjzaK+gwudyc/WmyiMsupaYtx5ixrYUfw
         gDk7+aAT7JS5lTmE5AFLuY1v0NZ1qWck+7UU7xwLAzfx42IWHow5uPluLO0S2NekaM4s
         U+RGzxEBnFq1n+lSti6Iw2UjtoRSLBtFW/Q9KyGhsFMddXptuMmmL8rYPSg8eHkMCZ3o
         XSnriuIhAlZhsGCffBrj2/fWgysKFTrOHzkkibbMWXqJU2whRs/T13TuEuMgar8CTdWh
         IcUg==
X-Gm-Message-State: ACrzQf1rVm92gTRC7ewiFNMOyjt6WyWajFoL4wDZmrHzXgCm2ltThIKt
        A7Dk1K+mZHar89VNV7aeaTI=
X-Google-Smtp-Source: AMsMyM582M9SqtnrX7AZhLq2TOs8eIwTjL2eK2oof4hzlikxlQwv0zvC7o9pFXccAplRA3ZviSp00g==
X-Received: by 2002:adf:e6c3:0:b0:236:acdb:4d9b with SMTP id y3-20020adfe6c3000000b00236acdb4d9bmr40245556wrm.528.1668087108623;
        Thu, 10 Nov 2022 05:31:48 -0800 (PST)
Received: from Ansuel-xps. (93-42-71-18.ip85.fastwebnet.it. [93.42.71.18])
        by smtp.gmail.com with ESMTPSA id j18-20020a056000125200b0023677fd2657sm15455224wrx.52.2022.11.10.05.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 05:31:47 -0800 (PST)
Message-ID: <636cfd43.050a0220.1e5e0.5c67@mx.google.com>
X-Google-Original-Message-ID: <Y2z9QFFz+hEV+Dwg@Ansuel-xps.>
Date:   Thu, 10 Nov 2022 14:31:44 +0100
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Robert Marko <robimarko@gmail.com>, agross@kernel.org,
        konrad.dybcio@somainline.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: qcom: ipq8074: populate fw_name for all parents
References: <20221108194217.553303-1-robimarko@gmail.com>
 <20221110032505.hkdlaad2vb7pqpdu@builder.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221110032505.hkdlaad2vb7pqpdu@builder.lan>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 09:25:05PM -0600, Bjorn Andersson wrote:
> On Tue, Nov 08, 2022 at 08:42:17PM +0100, Robert Marko wrote:
> > It appears that having only .name populated in parent_data for clocks
> > which are only globally searchable currently will not work as the clk core
> > won't copy that name if there is no .fw_name present as well.
> > 
> 
> While we want to migrate users to .fw_name and .index, that sounds like
> a bug. Where does this (not) happen?
> 

While we discover this and decided to send a fix, I also check why this
happen and sent a patch about this [0]. The reason is interesting,
in short clk_core_get hardcode the use of fw_name to get parent name and
if that is empty just fails without checking for .name.

I decided to add a warning and a workaround instead of fixing it in
clk_core_get to push devs to use .fw_name. (also I think this should be
documented somewhere but no idea where)

[0] https://patchwork.kernel.org/project/linux-clk/patch/20221108204918.2805-1-ansuelsmth@gmail.com/

> > So, populate .fw_name for all parent clocks in parent_data.
> > 
> > Fixes: ae55ad32e273 ("clk: qcom: ipq8074: convert to parent data")
> > 
> > Co-developed-by: Christian Marangi <ansuelsmth@gmail.com>
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > Signed-off-by: Robert Marko <robimarko@gmail.com>
> > ---
> >  drivers/clk/qcom/gcc-ipq8074.c | 48 +++++++++++++++++-----------------
> >  1 file changed, 24 insertions(+), 24 deletions(-)
> > 
> > diff --git a/drivers/clk/qcom/gcc-ipq8074.c b/drivers/clk/qcom/gcc-ipq8074.c
> > index d231866804f6..bf64aa683605 100644
> > --- a/drivers/clk/qcom/gcc-ipq8074.c
> > +++ b/drivers/clk/qcom/gcc-ipq8074.c
> > @@ -1137,7 +1137,7 @@ static const struct freq_tbl ftbl_nss_noc_bfdcd_clk_src[] = {
> >  
> >  static const struct clk_parent_data gcc_xo_bias_pll_nss_noc_clk_gpll0_gpll2[] = {
> >  	{ .fw_name = "xo", .name = "xo" },
> > -	{ .name = "bias_pll_nss_noc_clk" },
> > +	{ .fw_name = "bias_pll_nss_noc_clk", .name = "bias_pll_nss_noc_clk" },
> >  	{ .hw = &gpll0.clkr.hw },
> >  	{ .hw = &gpll2.clkr.hw },
> >  };
> > @@ -1362,7 +1362,7 @@ static const struct freq_tbl ftbl_nss_ppe_clk_src[] = {
> >  
> >  static const struct clk_parent_data gcc_xo_bias_gpll0_gpll4_nss_ubi32[] = {
> >  	{ .fw_name = "xo", .name = "xo" },
> > -	{ .name = "bias_pll_cc_clk" },
> > +	{ .fw_name = "bias_pll_cc_clk", .name = "bias_pll_cc_clk" },
> >  	{ .hw = &gpll0.clkr.hw },
> >  	{ .hw = &gpll4.clkr.hw },
> >  	{ .hw = &nss_crypto_pll.clkr.hw },
> > @@ -1413,10 +1413,10 @@ static const struct freq_tbl ftbl_nss_port1_rx_clk_src[] = {
> >  
> >  static const struct clk_parent_data gcc_xo_uniphy0_rx_tx_ubi32_bias[] = {
> >  	{ .fw_name = "xo", .name = "xo" },
> > -	{ .name = "uniphy0_gcc_rx_clk" },
> > -	{ .name = "uniphy0_gcc_tx_clk" },
> > +	{ .fw_name = "uniphy0_gcc_rx_clk", .name = "uniphy0_gcc_rx_clk" },
> > +	{ .fw_name = "uniphy0_gcc_tx_clk", .name = "uniphy0_gcc_tx_clk" },
> >  	{ .hw = &ubi32_pll.clkr.hw },
> > -	{ .name = "bias_pll_cc_clk" },
> > +	{ .fw_name = "bias_pll_cc_clk", .name = "bias_pll_cc_clk" },
> >  };
> >  
> >  static const struct parent_map gcc_xo_uniphy0_rx_tx_ubi32_bias_map[] = {
> > @@ -1465,10 +1465,10 @@ static const struct freq_tbl ftbl_nss_port1_tx_clk_src[] = {
> >  
> >  static const struct clk_parent_data gcc_xo_uniphy0_tx_rx_ubi32_bias[] = {
> >  	{ .fw_name = "xo", .name = "xo" },
> > -	{ .name = "uniphy0_gcc_tx_clk" },
> > -	{ .name = "uniphy0_gcc_rx_clk" },
> > +	{ .fw_name = "uniphy0_gcc_tx_clk", .name = "uniphy0_gcc_tx_clk" },
> > +	{ .fw_name = "uniphy0_gcc_rx_clk", .name = "uniphy0_gcc_rx_clk" },
> >  	{ .hw = &ubi32_pll.clkr.hw },
> > -	{ .name = "bias_pll_cc_clk" },
> > +	{ .fw_name = "bias_pll_cc_clk", .name = "bias_pll_cc_clk" },
> >  };
> >  
> >  static const struct parent_map gcc_xo_uniphy0_tx_rx_ubi32_bias_map[] = {
> > @@ -1696,12 +1696,12 @@ static const struct freq_tbl ftbl_nss_port5_rx_clk_src[] = {
> >  
> >  static const struct clk_parent_data gcc_xo_uniphy0_rx_tx_uniphy1_rx_tx_ubi32_bias[] = {
> >  	{ .fw_name = "xo", .name = "xo" },
> > -	{ .name = "uniphy0_gcc_rx_clk" },
> > -	{ .name = "uniphy0_gcc_tx_clk" },
> > -	{ .name = "uniphy1_gcc_rx_clk" },
> > -	{ .name = "uniphy1_gcc_tx_clk" },
> > +	{ .fw_name = "uniphy0_gcc_rx_clk", .name = "uniphy0_gcc_rx_clk" },
> > +	{ .fw_name = "uniphy0_gcc_tx_clk", .name = "uniphy0_gcc_tx_clk" },
> > +	{ .fw_name = "uniphy1_gcc_rx_clk", .name = "uniphy1_gcc_rx_clk" },
> > +	{ .fw_name = "uniphy1_gcc_tx_clk", .name = "uniphy1_gcc_tx_clk" },
> >  	{ .hw = &ubi32_pll.clkr.hw },
> > -	{ .name = "bias_pll_cc_clk" },
> > +	{ .fw_name = "bias_pll_cc_clk", .name = "bias_pll_cc_clk" },
> >  };
> >  
> >  static const struct parent_map
> > @@ -1758,12 +1758,12 @@ static const struct freq_tbl ftbl_nss_port5_tx_clk_src[] = {
> >  
> >  static const struct clk_parent_data gcc_xo_uniphy0_tx_rx_uniphy1_tx_rx_ubi32_bias[] = {
> >  	{ .fw_name = "xo", .name = "xo" },
> > -	{ .name = "uniphy0_gcc_tx_clk" },
> > -	{ .name = "uniphy0_gcc_rx_clk" },
> > -	{ .name = "uniphy1_gcc_tx_clk" },
> > -	{ .name = "uniphy1_gcc_rx_clk" },
> > +	{ .fw_name = "uniphy0_gcc_tx_clk", .name = "uniphy0_gcc_tx_clk" },
> > +	{ .fw_name = "uniphy0_gcc_rx_clk", .name = "uniphy0_gcc_rx_clk" },
> > +	{ .fw_name = "uniphy1_gcc_tx_clk", .name = "uniphy1_gcc_tx_clk" },
> > +	{ .fw_name = "uniphy1_gcc_rx_clk", .name = "uniphy1_gcc_rx_clk" },
> >  	{ .hw = &ubi32_pll.clkr.hw },
> > -	{ .name = "bias_pll_cc_clk" },
> > +	{ .fw_name = "bias_pll_cc_clk", .name = "bias_pll_cc_clk" },
> >  };
> >  
> >  static const struct parent_map
> > @@ -1820,10 +1820,10 @@ static const struct freq_tbl ftbl_nss_port6_rx_clk_src[] = {
> >  
> >  static const struct clk_parent_data gcc_xo_uniphy2_rx_tx_ubi32_bias[] = {
> >  	{ .fw_name = "xo", .name = "xo" },
> > -	{ .name = "uniphy2_gcc_rx_clk" },
> > -	{ .name = "uniphy2_gcc_tx_clk" },
> > +	{ .fw_name = "uniphy2_gcc_rx_clk", .name = "uniphy2_gcc_rx_clk" },
> > +	{ .fw_name = "uniphy2_gcc_tx_clk", .name = "uniphy2_gcc_tx_clk" },
> >  	{ .hw = &ubi32_pll.clkr.hw },
> > -	{ .name = "bias_pll_cc_clk" },
> > +	{ .fw_name = "bias_pll_cc_clk", .name = "bias_pll_cc_clk" },
> >  };
> >  
> >  static const struct parent_map gcc_xo_uniphy2_rx_tx_ubi32_bias_map[] = {
> > @@ -1877,10 +1877,10 @@ static const struct freq_tbl ftbl_nss_port6_tx_clk_src[] = {
> >  
> >  static const struct clk_parent_data gcc_xo_uniphy2_tx_rx_ubi32_bias[] = {
> >  	{ .fw_name = "xo", .name = "xo" },
> > -	{ .name = "uniphy2_gcc_tx_clk" },
> > -	{ .name = "uniphy2_gcc_rx_clk" },
> > +	{ .fw_name = "uniphy2_gcc_tx_clk", .name = "uniphy2_gcc_tx_clk" },
> > +	{ .fw_name = "uniphy2_gcc_rx_clk", .name = "uniphy2_gcc_rx_clk" },
> >  	{ .hw = &ubi32_pll.clkr.hw },
> > -	{ .name = "bias_pll_cc_clk" },
> > +	{ .fw_name = "bias_pll_cc_clk", .name = "bias_pll_cc_clk" },
> >  };
> >  
> >  static const struct parent_map gcc_xo_uniphy2_tx_rx_ubi32_bias_map[] = {
> > -- 
> > 2.38.1
> > 

-- 
	Ansuel
