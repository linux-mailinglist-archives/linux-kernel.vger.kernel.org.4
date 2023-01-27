Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2D5E67E60C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 14:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234512AbjA0NFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 08:05:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233250AbjA0NEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 08:04:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31917CCAD;
        Fri, 27 Jan 2023 05:04:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 03523B81F21;
        Fri, 27 Jan 2023 13:04:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C603C433EF;
        Fri, 27 Jan 2023 13:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674824678;
        bh=s2Kl2DFTjPfURrm0RC4TBfPUoYKL+iGruFychEwP8JI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BJghCqq5cgDU8pgSAyW0RJujDszQQxmqA3HnnnVs5m3L9NegM1AByLIVMFfiTncv6
         Fm0HqtN9qnv1bMftwkPxidpLn5FuyLBjprgYUpUigPUtLFrMEwoJDjNREKhTy40xCu
         3BakLwyCN/bGXcF7vYp5EAjRAu9ZWTeukbfIE9qguUJptfBzTNjBmKKQaaRi2hC8EL
         J0c3ujHb29vhPyZm4oxQ3hi0LmiAhu+9TgEGyezNnQ/fU1SS0/TxNu5+K9L+2bOn6q
         2gGqzb91/x7eKybEVBg628llCRZKLd/TBKG3XEABgLes0+MSqWLNkmMtSmIyCJlh8y
         HeRFLmuymua3w==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pLOPP-0008L8-Li; Fri, 27 Jan 2023 14:04:47 +0100
Date:   Fri, 27 Jan 2023 14:04:47 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 17/24] rtc: pm8xxx: add copyright notice
Message-ID: <Y9PL73mTJZ3hayur@hovoldconsulting.com>
References: <20230126142057.25715-1-johan+linaro@kernel.org>
 <20230126142057.25715-18-johan+linaro@kernel.org>
 <Y9Kk/AYBUfnoPCcP@mail.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9Kk/AYBUfnoPCcP@mail.local>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 05:06:20PM +0100, Alexandre Belloni wrote:
> On 26/01/2023 15:20:50+0100, Johan Hovold wrote:
> > Add a copyright notice for Linaro and add myself as a (primary) author
> > of this driver.
> > 
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---
> >  drivers/rtc/rtc-pm8xxx.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/rtc/rtc-pm8xxx.c b/drivers/rtc/rtc-pm8xxx.c
> > index 09816b9f6282..25bdd804b4d2 100644
> > --- a/drivers/rtc/rtc-pm8xxx.c
> > +++ b/drivers/rtc/rtc-pm8xxx.c
> > @@ -1,5 +1,9 @@
> >  // SPDX-License-Identifier: GPL-2.0-only
> > -/* Copyright (c) 2010-2011, Code Aurora Forum. All rights reserved.
> > +/*
> > + * pm8xxx RTC driver
> > + *
> > + * Copyright (c) 2010-2011, Code Aurora Forum. All rights reserved.
> > + * Copyright (c) 2023, Linaro Limited
> 
> Is this really useful? The authoritative source is going to be git
> anyway.

Sure, but in this case the driver ended up being almost completely
reworked so I think it is warranted.
 
> >   */
> >  #include <linux/of.h>
> >  #include <linux/module.h>
> > @@ -551,3 +555,4 @@ MODULE_ALIAS("platform:rtc-pm8xxx");
> >  MODULE_DESCRIPTION("PMIC8xxx RTC driver");
> >  MODULE_LICENSE("GPL v2");
> >  MODULE_AUTHOR("Anirudh Ghayal <aghayal@codeaurora.org>");
> > +MODULE_AUTHOR("Johan Hovold <johan@kernel.org>");
> > -- 
> > 2.39.1

Johan
