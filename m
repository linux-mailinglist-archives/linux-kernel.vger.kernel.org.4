Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A14C9687A10
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 11:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232110AbjBBKWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 05:22:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232646AbjBBKVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 05:21:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B876988991;
        Thu,  2 Feb 2023 02:21:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 45AD8B8258E;
        Thu,  2 Feb 2023 10:21:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8EEDC433D2;
        Thu,  2 Feb 2023 10:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675333300;
        bh=t2QWbka6v7vkNVodGFBJPfO8m9esNG/StESQ91OzWDY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WVvHV5iL8E3fvp4rq2PuesKawvlmbTmxUaK+116vTxU8BLo4jCqt43C5xHhsoFAg3
         V91VwIKuhTWQGrWKs2nFHjaj3Aiy4koCHi0+x5X8oykQTUMonKHbARTJq1HaRYt//C
         tEE9Tf7L5Mca7Lhb3nIpgZZacsGL9RYyxCeqNgjGLTiA1Xf1D5acw0pB5bPuJaZLEc
         GGHQg0q3Lr3VXU0IQrvue45jddooWWXvMrVIENluqirXPfnFflaO/pFKeK2xrLfwn5
         WYzZqiM8wo7pn94WDnPe5gJ1jV1iBQwOZYe4uJIQyQsd9wAa2i4RTCeEfcd/D19jj/
         CsWnifHhCzO1w==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pNWjD-0006WZ-Cj; Thu, 02 Feb 2023 11:22:03 +0100
Date:   Thu, 2 Feb 2023 11:22:03 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Johan Hovold <johan+linaro@kernel.org>,
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
Message-ID: <Y9uOy6F9ZHhZtWPI@hovoldconsulting.com>
References: <20230126142057.25715-1-johan+linaro@kernel.org>
 <20230126142057.25715-18-johan+linaro@kernel.org>
 <Y9Kk/AYBUfnoPCcP@mail.local>
 <Y9PL73mTJZ3hayur@hovoldconsulting.com>
 <f52c832f-0522-5b3e-8267-cb3dc8da5374@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f52c832f-0522-5b3e-8267-cb3dc8da5374@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 03:14:48PM +0100, Krzysztof Kozlowski wrote:
> On 27/01/2023 14:04, Johan Hovold wrote:
> > On Thu, Jan 26, 2023 at 05:06:20PM +0100, Alexandre Belloni wrote:
> >> On 26/01/2023 15:20:50+0100, Johan Hovold wrote:
> >>> Add a copyright notice for Linaro and add myself as a (primary) author
> >>> of this driver.
> >>>
> >>> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> >>> ---
> >>>  drivers/rtc/rtc-pm8xxx.c | 7 ++++++-
> >>>  1 file changed, 6 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/rtc/rtc-pm8xxx.c b/drivers/rtc/rtc-pm8xxx.c
> >>> index 09816b9f6282..25bdd804b4d2 100644
> >>> --- a/drivers/rtc/rtc-pm8xxx.c
> >>> +++ b/drivers/rtc/rtc-pm8xxx.c
> >>> @@ -1,5 +1,9 @@
> >>>  // SPDX-License-Identifier: GPL-2.0-only
> >>> -/* Copyright (c) 2010-2011, Code Aurora Forum. All rights reserved.
> >>> +/*
> >>> + * pm8xxx RTC driver
> >>> + *
> >>> + * Copyright (c) 2010-2011, Code Aurora Forum. All rights reserved.
> >>> + * Copyright (c) 2023, Linaro Limited
> >>
> >> Is this really useful? The authoritative source is going to be git
> >> anyway.
> > 
> > Sure, but in this case the driver ended up being almost completely
> > reworked so I think it is warranted.
> 
> Copyright update is an effect of rework, not independent, thus it should
> be squashed with the code doing the rework. Copyright updates on their
> own do not make sense.

I tend to agree, but there can be reasons for adding it separately as in
this case where I wanted to highlight that I was adding a new entry. And
it is still added along with the changes (i.e. as part of the series).

But I'll squash it with the previous patch for v2.

Johan
