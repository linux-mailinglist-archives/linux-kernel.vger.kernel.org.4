Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 769D167869E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 20:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232727AbjAWTma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 14:42:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232149AbjAWTm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 14:42:28 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E45DB769
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 11:42:27 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id z5so11866281wrt.6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 11:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p9ILq3+mwKrh0pefLGbJdcwDb8dIBE8u28kNBwVa/4E=;
        b=AW/XUguALAmXap9iIRkL9wPE1+78JgBdgei1kVXA1aDGHszAL3rWm2zWxD/+2L94qq
         Ai9QVNX5MqQMZf1tNfL/JAzFrqycZRpT2RTS9zNfk0k7t38aFLRSYuDrl1rOf+bKtOhL
         59HIDTTK3pLwO0ooeLDkGqAMCelObQvL82eCLD6p6hOucdd+k162dxnenZtS6XFghKAd
         HpYFMcHO9dgsGMv/PoIRv/phrA051NZUVN1eZ1QsFXFI6RmUyrlqHccHBepyQTMlrztR
         6z/GMXcviz4lZr9ICzPpx621xgV6B/strzNrsuKr6Btq+0OSucGLSsIzHGf9fY1IEe8K
         CmeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p9ILq3+mwKrh0pefLGbJdcwDb8dIBE8u28kNBwVa/4E=;
        b=BTYTG3whkRzawGtt+iReOfvRzmboDBPZjmTNEPPCFPN5D7rRQDqQHlNj7TVEdreJQG
         iO28S8kiwXy+o35nQOKlGEFgcjcI0+A1MQpnt+k/PDCPQOiayPUM8RTir/gMG82WI7Sd
         Bq3fkkrSDaiOrRfY7BsFyj0CCyt+lWnmkOffouOyCodeIWRDhUKHtpjY+Pi+VuL2pI+F
         +m2/4H3kMZMYkysqo0y0LKD8cy4u9Wl3xSYuaKHgyd2ydmnIH2TEcjJXbNrNTG193mks
         HXp0hTbZ1HzjmerxJXKpd/fn0njquYsJ2Ja4TTqSQFqRcuHVKdsH1NmK185+YfXgXrBk
         aocA==
X-Gm-Message-State: AFqh2krOwIYF1WddSX9WnpYxtEpC6h7nmHbkTt/dTwX8/lVM02/PqGP8
        s13sCE6hGpTJYX5VclL6432i5JsiChbFwH89
X-Google-Smtp-Source: AMrXdXsnN/1Z1mhC5MXnr3/Vlg9iTHyDxGzqM1a2JSKGN6e1eHCKTGhbtkzJtZchpKSCwnfztvDLQQ==
X-Received: by 2002:adf:f805:0:b0:2be:2b5:ae87 with SMTP id s5-20020adff805000000b002be02b5ae87mr22137380wrp.24.1674502945664;
        Mon, 23 Jan 2023 11:42:25 -0800 (PST)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id y15-20020a5d470f000000b002bc8130cca7sm175808wrq.23.2023.01.23.11.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 11:42:25 -0800 (PST)
Date:   Mon, 23 Jan 2023 21:42:22 +0200
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v4 08/12] phy: qcom-qmp-pcie: Add support for SM8550 g3x2
 and g4x2 PCIEs
Message-ID: <Y87jHlzAaoGbs0Pu@linaro.org>
References: <20230119140453.3942340-1-abel.vesa@linaro.org>
 <20230119140453.3942340-9-abel.vesa@linaro.org>
 <Y86h1FDuHFu3mImq@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y86h1FDuHFu3mImq@hovoldconsulting.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-01-23 16:03:48, Johan Hovold wrote:
> On Thu, Jan 19, 2023 at 04:04:49PM +0200, Abel Vesa wrote:
> > Add the SM8550 both g4 and g3 configurations. In addition, there is a
> > new "lane shared" table that needs to be configured for g4, along with
> > the No-CSR list of resets.
> > 
> > Co-developed-by: Neil Armstrong <neil.armstrong@linaro.org>
> > Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> > 
> > This patchset relies on the following patchset:
> > https://lore.kernel.org/all/20230117224148.1914627-1-abel.vesa@linaro.org/
> > 
> > The v3 of this patchset is:
> > https://lore.kernel.org/all/20230118005328.2378792-1-abel.vesa@linaro.org/
> > 
> > Changes since v3:
> >  * added Dmitry's R-b tag
> > 
> > Changes since v2:
> >  * none
> > 
> > Changes since v1:
> >  * split all the offsets into separate patches, like Vinod suggested
> > 
> > 
> >  drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 365 +++++++++++++++++++++++
> >  1 file changed, 365 insertions(+)
> > 
> > diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> > index bffb9e138715..48d179d8d8d6 100644
> > --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> > +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c

[...]

> > @@ -2370,6 +2704,14 @@ static int qmp_pcie_power_on(struct phy *phy)
> >  	if (ret)
> >  		return ret;
> >  
> > +	if (qmp->nocsr_resets) {
> > +		ret = reset_control_bulk_deassert(cfg->num_nocsr_resets, qmp->nocsr_resets);
> > +		if (ret) {
> > +			dev_err(qmp->dev, "no-csr reset deassert failed\n");
> > +			goto err_disable_pipe_clk;
> > +		}
> > +	}
> 
> Is this the documented reset sequence? To keep the nocsr reset asserted
> from init() to power_on() and during programming of the PHY registers?
> 
> What if power_on() is never called, etc? (I know we always call
> power_on() after init() currently, but that may change.)
> 
> Could you explain a bit how this reset is supposed work and be used?
> 

The documentation says that the no-CSR reset should be kept asserted until
the clock (PLL) is stable and during configuration. It also says the
no-CSR can be used to reset the PHY without losing the configuration.
It also says pciephy_reset needs to be deasserted before configuration.

So I guess what we need to do here is: deassert the pciephy_reset,
configure the CSR register, then deassert the no-CSR reset.

If power on never gets called, PHY remains in reset, but configured.

> > +
> >  	/* Pull PHY out of reset state */
> >  	qphy_clrbits(pcs, cfg->regs[QPHY_SW_RESET], SW_RESET);
> >  
> > @@ -2503,6 +2845,21 @@ static int qmp_pcie_reset_init(struct qmp_pcie *qmp)
> >  	if (ret)
> >  		return dev_err_probe(dev, ret, "failed to get resets\n");
> >  
> > +	if (cfg->nocsr_reset_list) {
> > +		qmp->nocsr_resets = devm_kcalloc(dev, cfg->num_nocsr_resets,
> > +				   sizeof(*qmp->nocsr_resets), GFP_KERNEL);
> > +		if (!qmp->nocsr_resets)
> > +			return -ENOMEM;
> > +
> > +		for (i = 0; i < cfg->num_nocsr_resets; i++)
> > +			qmp->nocsr_resets[i].id = cfg->nocsr_reset_list[i];
> > +
> > +		ret = devm_reset_control_bulk_get_exclusive(dev, cfg->num_nocsr_resets,
> > +								qmp->nocsr_resets);
> > +		if (ret)
> > +			return dev_err_probe(dev, ret, "failed to get no CSR resets\n");

[...]
