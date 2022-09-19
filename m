Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1F305BC363
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 09:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbiISHLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 03:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiISHLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 03:11:15 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4841E3C6
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 00:11:14 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id ay36so10677312wmb.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 00:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=ZiQM3+Sh2bFW5DQ3ITDJpGDiOAUw0yEVtVDVMfdc7Ak=;
        b=U3q6wnHhpb2vhDShtHy1OTIbsHMWCetx0yAfP8y0MXxvZM0k+kdU7ydWOm1r7fPoJx
         HhZVvQLJd270MpJ4sBiZ4QJR64nqlETC3k6v66MFhjeae0Oxmvoq+M4KHTlUhN3p+dUS
         8VnGha3dKQFx0xsnxzsI3d321x8OjCouIg3QE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=ZiQM3+Sh2bFW5DQ3ITDJpGDiOAUw0yEVtVDVMfdc7Ak=;
        b=Vwe7ZCQmFGHKyOAEZHVpREacKhUSSOydm9jN8/uqrIDlm4/FAEEngyUKm6GzH/w4nX
         uaqjqgkWY7+lzUKDSwdZqndqpm5xL2LPDiooy6aMhX7Aq68j01wm0L/i2QDRxMo3/boK
         CTS0UXMgOOAJwnyfHdMpTvV0iymRq9eon1kAKU3srqJb8dvshcdH3oEq7onpUiOii5yd
         /7PkrMtksu7wFpKJ8YxtFUnLtCaZKaqi5I3yRmOTODTmkCI2CwcSLIegouH21ClVX2by
         K3dU2d12LdYPx7ahmQigyLTppUXuw4expncmYsNYRXFeBjvLDP0hP+h1y602ek4kfgfM
         Rh6g==
X-Gm-Message-State: ACgBeo1NobCTtJFWxx4jrHzcYoaaSWP7u+dtALmb5iMHFUMGz0iT3TDB
        vSP71ZFGKe74hb5cM9Q7BwNL0Xi2bX0psA==
X-Google-Smtp-Source: AA6agR4GK6jrqGd0b3TRGifakx9josXJ/skrsAb+lA5rd0gWdYb6bEJnkCUQS9FUMML+zBTeF+zlyQ==
X-Received: by 2002:a05:600c:6015:b0:3b4:a4cb:72f7 with SMTP id az21-20020a05600c601500b003b4a4cb72f7mr16406247wmb.14.1663571473349;
        Mon, 19 Sep 2022 00:11:13 -0700 (PDT)
Received: from tom-ThinkPad-T14s-Gen-2i (net-188-217-56-12.cust.vodafonedsl.it. [188.217.56.12])
        by smtp.gmail.com with ESMTPSA id i67-20020a1c3b46000000b003b492753826sm12485057wma.43.2022.09.19.00.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 00:11:12 -0700 (PDT)
Date:   Mon, 19 Sep 2022 09:11:10 +0200
From:   Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Mikhail Rudenko <mike.rudenko@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Shawn Tu <shawnx.tu@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Daniel Scally <djrscally@gmail.com>,
        Christian Hemp <c.hemp@phytec.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Marek Vasut <marex@denx.de>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] media: i2c: add support for ov4689
Message-ID: <20220919071110.GB3958@tom-ThinkPad-T14s-Gen-2i>
References: <20220911200147.375198-1-mike.rudenko@gmail.com>
 <20220911200147.375198-3-mike.rudenko@gmail.com>
 <20220914155122.GA9874@tom-ThinkPad-T14s-Gen-2i>
 <87k064pa2v.fsf@gmail.com>
 <20220916133401.GB2701@tom-ThinkPad-T14s-Gen-2i>
 <YygNKE7LLtpwfnz+@paasikivi.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YygNKE7LLtpwfnz+@paasikivi.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari,

On Mon, Sep 19, 2022 at 06:33:12AM +0000, Sakari Ailus wrote:
> Hi Tommaso,
> 
> On Fri, Sep 16, 2022 at 03:34:01PM +0200, Tommaso Merciai wrote:
> > > >> +	ret = clk_set_rate(ov4689->xvclk, OV4689_XVCLK_FREQ);
> > > >> +	if (ret < 0) {
> > > >> +		dev_err(dev, "Failed to set xvclk rate (24MHz)\n");
> > > >> +		return ret;
> > > >> +	}
> > > >> +	if (clk_get_rate(ov4689->xvclk) != OV4689_XVCLK_FREQ)
> > > >> +		dev_warn(dev, "xvclk mismatched, modes are based on 24MHz\n");
> > > >
> > > >
> > > > What do you think about?
> > > > Thanks.
> > > 
> > > Unfortunately, I have no experience with ACPI-based devices. :(
> > > 
> > > Do you mean that in the case of an ACPI device and devm_clk_get_optional
> > > returning NULL we should assume that the clock is already enabled and
> > > will stay enabled during sensor operation? How should we distinguish it
> > > from the case of an OF-based system and clock just missing from device
> > > tree?
> > 
> > Not exaclty :)
> > 
> > I copy comment from [1]
> > 
> > if you use ov5693->xvclk to identify the ACPI vs OF use case shouldn't
> > you use the get_optionl() version ? Otherwise in the ACPI case you will have
> > -ENOENT if there's not 'xvclk' property and bail out.
> > 
> > Unless my understanding is wrong on ACPI we have "clock-frequency" and
> > on OF "xvclk" with an "assigned-clock-rates",
> 
> Generally yes. It's also possible to have a clock in ACPI based system
> although those clocks do not come from ACPI. See e.g.
> drivers/platform/x86/intel/int3472/clk_and_regulator.c .

I save this :)
Thanks for sharing.

Regards,
Tommaso

> 
> -- 
> Sakari Ailus

-- 
Tommaso Merciai
Embedded Linux Engineer
tommaso.merciai@amarulasolutions.com
__________________________________

Amarula Solutions SRL
Via Le Canevare 30, 31100 Treviso, Veneto, IT
T. +39 042 243 5310
info@amarulasolutions.com
www.amarulasolutions.com
