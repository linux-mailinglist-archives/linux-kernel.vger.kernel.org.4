Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4D7A68C10F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 16:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbjBFPLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 10:11:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjBFPLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 10:11:07 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47DB18A56
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 07:11:05 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id j29-20020a05600c1c1d00b003dc52fed235so9088410wms.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 07:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wsmqt8kIE1pV9yLifDH7YFY8cOiugwYigL4n9E1qUpU=;
        b=nFYl/hg4p7H1jfTK4TwO3Yu9DPxL+DnMFR01XOkVcUrHOucZ3Hrvr01EWJOMh2k7FF
         iVgRXvlnzQZZLfd6KkQvb+yKidfaH1kkX5alW9W4SY/TFQDvPlRj1xsW/kZssZTs/Owo
         R1T2FE3tB96gaBmE6Y28MklSLhrwd95r2px655TwLQJ9/J0AtDnLA7PZCRzJibxJ6y6r
         m70vLYV3BZWRnBeArgLo+f+qNWNO2xt4JC2xU3tm5cbdnUFgW5MzhjNl9nJlIqEYTt5y
         lR9nnDh5TYtcKyQ5o8RaSgEjQsmu8AICaOvOtyTy13weiTU/ihG/plKmaNY6EIqt7PWw
         AbRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wsmqt8kIE1pV9yLifDH7YFY8cOiugwYigL4n9E1qUpU=;
        b=0ATsYbBO9DQZrS8upb+hu3p4UR0bm2NEm/NpXNVaNBwU4DFmfcyvrUOkapyov26BGX
         AhgdjGWErkzhrKuZDKILt1osZNkSK8d2zXjBdFSQQLjIpF2ab5rLSVG4EOmBynWs1qPN
         IY8/HIUWqWdv21LP3hqDAb8tc6u0ArBHtt74AFmYOYZi2MCKlbkRgFciEmPNVHwfMZde
         g6abaAs6JgSZyu81Ai0QkP8jyb0PimHq4pI5iiWfBZdcG/UD0EHAV67XBIwVpu1+RiKf
         QoRmoVx9b+UhOo/k2ON+khDNT+yk5YZahzZlghN6LcOCut0ZMtx0czLfKBI79ihK3NOu
         gG6A==
X-Gm-Message-State: AO0yUKUt/Nf+akF+6ikTPbDhNmzTscH0JLiZAkkbIWjVjLIc4VMPeuJl
        6sM6UpNoyuOT3MyVJN+7IX52QA==
X-Google-Smtp-Source: AK7set+nhWu+5YwsvDv/YaOf4rTRghGKDOHvVvOC7ROvQmFPq2VEHAhuvijJyVtOg2nmHTpdCqXIkQ==
X-Received: by 2002:a05:600c:3485:b0:3db:2df0:f2b8 with SMTP id a5-20020a05600c348500b003db2df0f2b8mr1705148wmq.36.1675696263771;
        Mon, 06 Feb 2023 07:11:03 -0800 (PST)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id k32-20020a05600c1ca000b003ddf2865aeasm17641122wms.41.2023.02.06.07.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 07:11:02 -0800 (PST)
Date:   Mon, 6 Feb 2023 17:11:01 +0200
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 10/12] PCI: qcom: Add SM8550 PCIe support
Message-ID: <Y+EYhe/xYSFpI1Yn@linaro.org>
References: <20230203081807.2248625-1-abel.vesa@linaro.org>
 <20230203081807.2248625-11-abel.vesa@linaro.org>
 <Y9zYpE/GnxUqnIyq@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9zYpE/GnxUqnIyq@hovoldconsulting.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-02-03 10:49:24, Johan Hovold wrote:
> On Fri, Feb 03, 2023 at 10:18:05AM +0200, Abel Vesa wrote:
> > Add compatible for both PCIe found on SM8550.
> > Also add the cnoc_pcie_sf_axi clock needed by the SM8550.
> 
> nit: You're now also adding 'noc_aggr'
> 
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> > Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> > ---
> > 
> > The v6 of this patchset is:
> > https://lore.kernel.org/all/20230202123902.3831491-11-abel.vesa@linaro.org/
> > 
> > Changes since v6:
> >  * none
> > 
> > Changes since v5:
> >  * none
> > 
> > Changes since v4:
> >  * added Mani's R-b tag
> > 
> > Changes since v3:
> >  * renamed cnoc_pcie_sf_axi to cnoc_sf_axi
> > 
> > Changes since v2:
> >  * none
> > 
> > Changes since v1:
> >  * changed the subject line prefix for the patch to match the history,
> >    like Bjorn Helgaas suggested.
> >  * added Konrad's R-b tag
> > 
> >  drivers/pci/controller/dwc/pcie-qcom.c | 25 ++++++++++++++-----------
> >  1 file changed, 14 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > index a232b04af048..6a70c9c6f98d 100644
> > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > @@ -182,10 +182,10 @@ struct qcom_pcie_resources_2_3_3 {
> >  
> >  /* 6 clocks typically, 7 for sm8250 */
> >  struct qcom_pcie_resources_2_7_0 {
> > -	struct clk_bulk_data clks[12];
> > +	struct clk_bulk_data clks[14];
> >  	int num_clks;
> >  	struct regulator_bulk_data supplies[2];
> > -	struct reset_control *pci_reset;
> > +	struct reset_control *rst;
> 
> Please name this one 'reset' or 'resets' (e.g. to avoid hard to parse
> things like res->rst below).

Well, it would then be inconsitent with 2_3_3 and 2_9_0, which both use
rst.

> 
> >  };
> >  
> >  struct qcom_pcie_resources_2_9_0 {
> > @@ -1177,9 +1177,9 @@ static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
> >  	unsigned int idx;
> >  	int ret;
> >  
> > -	res->pci_reset = devm_reset_control_get_exclusive(dev, "pci");
> > -	if (IS_ERR(res->pci_reset))
> > -		return PTR_ERR(res->pci_reset);
> > +	res->rst = devm_reset_control_array_get_exclusive(dev);
> > +	if (IS_ERR(res->rst))
> > +		return PTR_ERR(res->rst);
> 
> So the reset array implementation apparently both asserts and deasserts
> the resets in the order specified in DT (i.e. does not deassert in
> reverse order).
> 
> Is that ok also for the new "pci" and "link_down" resets?

According to the HPG, yes, this is perfectly fine. It specifically says
to assert the pcie reset and then continues saying to assert the
link_down reset.

> 
> >  	res->supplies[0].supply = "vdda";
> >  	res->supplies[1].supply = "vddpe-3v3";
> > @@ -1205,9 +1205,11 @@ static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
> >  	res->clks[idx++].id = "ddrss_sf_tbu";
> >  	res->clks[idx++].id = "aggre0";
> >  	res->clks[idx++].id = "aggre1";
> > +	res->clks[idx++].id = "noc_aggr";
> >  	res->clks[idx++].id = "noc_aggr_4";
> >  	res->clks[idx++].id = "noc_aggr_south_sf";
> >  	res->clks[idx++].id = "cnoc_qx";
> > +	res->clks[idx++].id = "cnoc_sf_axi";
> >  
> >  	num_opt_clks = idx - num_clks;
> >  	res->num_clks = idx;
> > @@ -1237,17 +1239,17 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
> >  	if (ret < 0)
> >  		goto err_disable_regulators;
> >  
> > -	ret = reset_control_assert(res->pci_reset);
> > -	if (ret < 0) {
> > -		dev_err(dev, "cannot assert pci reset\n");
> > +	ret = reset_control_assert(res->rst);
> > +	if (ret) {
> > +		dev_err(dev, "reset assert failed (%d)\n", ret);
> >  		goto err_disable_clocks;
> >  	}
> >  
> >  	usleep_range(1000, 1500);
> >  
> > -	ret = reset_control_deassert(res->pci_reset);
> > -	if (ret < 0) {
> > -		dev_err(dev, "cannot deassert pci reset\n");
> > +	ret = reset_control_deassert(res->rst);
> > +	if (ret) {
> > +		dev_err(dev, "reset deassert failed (%d)\n", ret);
> >  		goto err_disable_clocks;
> >  	}
> 
> Johan
