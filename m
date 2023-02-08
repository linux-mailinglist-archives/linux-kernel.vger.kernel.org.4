Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D701C68F407
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 18:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbjBHRK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 12:10:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjBHRKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 12:10:23 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB6148581
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 09:10:21 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id l37-20020a05600c1d2500b003dfe46a9801so2026932wms.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 09:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1D1Ag8MO1IvClr0BjaK5b1WugeUzwnrmVL7oJc6jsA0=;
        b=kAtPIUPgvdziEt7VHoHQ1gs5hP9ESwAb2Hxtv6fJkt7tFShzFKwjfqhkb2X4V3B577
         2QI2hFhGQEV1nGRFXTP4Yt07NwG/1EKzhkqjMTrSEeamPXgcQHtWK+EZAkyuzj9XMpBP
         MhLGa4189VrfJ0t5IT2bS/xsRrGIY+L7JVb3Jp/XO42w4GR0fXdkYUNTJo1/NULt60lQ
         ZGtI5q9bP3kb0gN5asQ6eu48kqyJx7hiIpqu7THOvH+Wzxv+oYtWxOlEeuQz5oe5qFwN
         i1ozjNDwbz9ClcF1JzE8X1amK2uA9c3jF3oy+KogQl8cX6YLFLQealxhPf607nklWEuk
         M6Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1D1Ag8MO1IvClr0BjaK5b1WugeUzwnrmVL7oJc6jsA0=;
        b=1zn4M19TCrqud3SuDLML97HIg1vK4OO8QI9Qrg97nf3TY7Neaa5WnT0Ef9FURn4sCc
         VzmIUys0G/vu/tbrPdMGsdiZbgwJL91GyEljtm4EryOyAQIzQV5W3FolyvJ0iGIXTAtq
         et30F8AEYmb+xauQjFFmg3issX8xLcY6OZINAL4gXQ4Mls1F7T3w7VZRf9LQnYpzWvOG
         qMphyNvn0bREHMX1VMQXrfgSUXkaZRsJLCRJ+xjWx7ZBU0X/LD02VNkTAudgSMPzZf56
         4kK+B+xVdN5xQQBmqQpm94eLzp+x778iWw9v2Kmky0jZrl1s0V9ecS2tpgBT7tq/glV9
         gt1Q==
X-Gm-Message-State: AO0yUKWKrizlNjftvqgDvI20xyIwV2lPwoox6rZPFKlKDGlkebxS6nEB
        hSUDsxwSqMgUg1Tx8vCQfUSnMw==
X-Google-Smtp-Source: AK7set8NZX4/q32/lsqz333FW7EvHSm0qAXd5rLJzsc55ZB27URLnTqIFBn7EamftvRWCRxoP/rpxg==
X-Received: by 2002:a05:600c:992:b0:3df:ed95:d757 with SMTP id w18-20020a05600c099200b003dfed95d757mr7302974wmp.34.1675876220467;
        Wed, 08 Feb 2023 09:10:20 -0800 (PST)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id a3-20020a05600c224300b003db01178b62sm2499300wmm.40.2023.02.08.09.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 09:10:19 -0800 (PST)
Date:   Wed, 8 Feb 2023 19:10:17 +0200
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
Message-ID: <Y+PXeYrBBL3QaznM@linaro.org>
References: <20230203081807.2248625-1-abel.vesa@linaro.org>
 <20230203081807.2248625-11-abel.vesa@linaro.org>
 <Y9zYpE/GnxUqnIyq@hovoldconsulting.com>
 <Y+EYhe/xYSFpI1Yn@linaro.org>
 <Y+PQYxh4t/ytOe3+@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+PQYxh4t/ytOe3+@hovoldconsulting.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-02-08 17:40:03, Johan Hovold wrote:
> On Mon, Feb 06, 2023 at 05:11:01PM +0200, Abel Vesa wrote:
> > On 23-02-03 10:49:24, Johan Hovold wrote:
> > > On Fri, Feb 03, 2023 at 10:18:05AM +0200, Abel Vesa wrote:
> > > > Add compatible for both PCIe found on SM8550.
> > > > Also add the cnoc_pcie_sf_axi clock needed by the SM8550.
> > > 
> > > nit: You're now also adding 'noc_aggr'
> > > 
> > > > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > > > Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> > > > Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> > > > ---
> 
> > > > @@ -182,10 +182,10 @@ struct qcom_pcie_resources_2_3_3 {
> > > >  
> > > >  /* 6 clocks typically, 7 for sm8250 */
> > > >  struct qcom_pcie_resources_2_7_0 {
> > > > -	struct clk_bulk_data clks[12];
> > > > +	struct clk_bulk_data clks[14];
> > > >  	int num_clks;
> > > >  	struct regulator_bulk_data supplies[2];
> > > > -	struct reset_control *pci_reset;
> > > > +	struct reset_control *rst;
> > > 
> > > Please name this one 'reset' or 'resets' (e.g. to avoid hard to parse
> > > things like res->rst below).
> > 
> > Well, it would then be inconsitent with 2_3_3 and 2_9_0, which both use
> > rst.
> 
> Yeah, I saw that. Fortunately these resources are completely
> independent, but whatever.

Will do it in the next version then.

>  
> > > >  };
> > > >  
> > > >  struct qcom_pcie_resources_2_9_0 {
> > > > @@ -1177,9 +1177,9 @@ static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
> > > >  	unsigned int idx;
> > > >  	int ret;
> > > >  
> > > > -	res->pci_reset = devm_reset_control_get_exclusive(dev, "pci");
> > > > -	if (IS_ERR(res->pci_reset))
> > > > -		return PTR_ERR(res->pci_reset);
> > > > +	res->rst = devm_reset_control_array_get_exclusive(dev);
> > > > +	if (IS_ERR(res->rst))
> > > > +		return PTR_ERR(res->rst);
> > > 
> > > So the reset array implementation apparently both asserts and deasserts
> > > the resets in the order specified in DT (i.e. does not deassert in
> > > reverse order).
> > > 
> > > Is that ok also for the new "pci" and "link_down" resets?
> > 
> > According to the HPG, yes, this is perfectly fine. It specifically says
> > to assert the pcie reset and then continues saying to assert the
> > link_down reset.
> 
> Ok, but that doesn't really say anything about whether it's ok to
> *deassert* them in the same order, which was what I asked about.

Actually, what I wanted to say is that the HPG says something like this:

"assert pcie reset, then assert link_down"

and then at the end it literaly repeats the same phrase.





> 
> Johan
