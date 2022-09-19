Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D57C5BC35C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 09:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbiISHIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 03:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbiISHIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 03:08:20 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 335CC1CB28
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 00:08:18 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id r7so4928217wrm.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 00:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=wEdLDJgFEyr3Rx0kdQrhspWlZowoghD3V/H8ktxN3TY=;
        b=OgBqv3IZzdUFqvuLhn6EFV4R9bDvxhESon8U4vW40j+TSLmigg9qsdpoGxMi5BPLLg
         0unGK3NEoyGanilR3J1V/VKvExTq6SrFYMDXmYaiIPnSEozEMMSwmhzdYDM+gIrOaaMg
         Ji3IDXFgdCSA73EiM4w021yuoCXfNAJVAHRUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=wEdLDJgFEyr3Rx0kdQrhspWlZowoghD3V/H8ktxN3TY=;
        b=Xx6yq9vTkzZiBqPqL6JRCyFrTpB4igHeGidiPTqccACrlHzCCpPaVVExa8Sz4vRlrg
         of4TV4LDJmSGy9RnGeyaFvXUmXFh2iHfRUyhUbedSTypuHUAoxu2cwGnYB/CDejnYsC5
         cC+9i6Hs1UJRVGpBkwgiCeA5w9aWp1UMl17m5YaslCcDgtHUNpEq0GG68NhHkI588WEH
         n1jX9DLe+aUK+9lJ5y61ezv5LuwuPGosX5fpZndnBvRWYVUUFZ/O9YZNL0gtrCigSF/N
         UmBB66Xmd3eBaoEmsoTVnW7nGOmpQtWEGwItAz1hxGNYZWJjHnUAbefMlw2F26+QQWR6
         aVKQ==
X-Gm-Message-State: ACrzQf3+PRQDsY/bXSikRmxG7U9OsbI3GVJFsQl4ulQtY6Mpp5LOs/3r
        stux+uMQOnn7yJs1ykIP7/J3KQ==
X-Google-Smtp-Source: AMsMyM5WuE0u/PpMDPiqFT5hqYfJFSqTAYnpfKtBn+3NHLlEFItVukIyZebdE5bJbyYXtyGz31yIfg==
X-Received: by 2002:adf:f3d2:0:b0:22a:e5d2:5c with SMTP id g18-20020adff3d2000000b0022ae5d2005cmr6872977wrp.131.1663571296615;
        Mon, 19 Sep 2022 00:08:16 -0700 (PDT)
Received: from tom-ThinkPad-T14s-Gen-2i (net-188-217-56-12.cust.vodafonedsl.it. [188.217.56.12])
        by smtp.gmail.com with ESMTPSA id bk23-20020a0560001d9700b0022b014fb0b7sm2088897wrb.110.2022.09.19.00.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 00:08:16 -0700 (PDT)
Date:   Mon, 19 Sep 2022 09:08:13 +0200
From:   Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
To:     Mikhail Rudenko <mike.rudenko@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
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
Message-ID: <20220919070813.GA3958@tom-ThinkPad-T14s-Gen-2i>
References: <20220911200147.375198-1-mike.rudenko@gmail.com>
 <20220911200147.375198-3-mike.rudenko@gmail.com>
 <20220914155122.GA9874@tom-ThinkPad-T14s-Gen-2i>
 <87k064pa2v.fsf@gmail.com>
 <20220916133401.GB2701@tom-ThinkPad-T14s-Gen-2i>
 <87r10bo1k5.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r10bo1k5.fsf@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mikhail,

On Fri, Sep 16, 2022 at 04:44:31PM +0300, Mikhail Rudenko wrote:
> 
> On 2022-09-16 at 15:34 +02, Tommaso Merciai <tommaso.merciai@amarulasolutions.com> wrote:
> > Hi Mikhail,
> >
> > On Thu, Sep 15, 2022 at 11:50:23PM +0300, Mikhail Rudenko wrote:
> >>
> >> Hi Tommaso,
> >>
> >> On 2022-09-14 at 17:51 +02, Tommaso Merciai <tommaso.merciai@amarulasolutions.com> wrote:
> >> > Hi Mikhail,
> >> > I do a first round on reviewing your driver :)
> >> >
> >> > On Sun, Sep 11, 2022 at 11:01:35PM +0300, Mikhail Rudenko wrote:
> 
> <snip>
> 
> >> >> +
> >> >> +	ov4689->xvclk = devm_clk_get(dev, "xvclk");
> >> >> +	if (IS_ERR(ov4689->xvclk)) {
> >> >> +		dev_err(dev, "Failed to get xvclk\n");
> >> >> +		return -EINVAL;
> >> >> +	}
> >> >
> >> > ^ I think is better to use devm_clk_get_optional instead of clck_get.
> >> > clck_get can fail in CPU's that use ACPI
> >> >
> >> >> +
> >> >> +	ret = clk_set_rate(ov4689->xvclk, OV4689_XVCLK_FREQ);
> >> >> +	if (ret < 0) {
> >> >> +		dev_err(dev, "Failed to set xvclk rate (24MHz)\n");
> >> >> +		return ret;
> >> >> +	}
> >> >> +	if (clk_get_rate(ov4689->xvclk) != OV4689_XVCLK_FREQ)
> >> >> +		dev_warn(dev, "xvclk mismatched, modes are based on 24MHz\n");
> >> >
> >> >
> >> > What do you think about?
> >> > Thanks.
> >>
> >> Unfortunately, I have no experience with ACPI-based devices. :(
> >>
> >> Do you mean that in the case of an ACPI device and devm_clk_get_optional
> >> returning NULL we should assume that the clock is already enabled and
> >> will stay enabled during sensor operation? How should we distinguish it
> >> from the case of an OF-based system and clock just missing from device
> >> tree?
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
> >
> > [1] https://patchwork.linuxtv.org/project/linux-media/patch/20220627150453.220292-5-tommaso.merciai@amarulasolutions.com/
> >
> > Let me know if you need more details.
> 
> Thanks for the pointer! I'll try to implement something along the lines
> of your ov5693 series.
> 
> But I'm not sure that will be enough to support ACPI systems
> correctly. What about lanes number and link frequency checks? Should
> they be made conditional on CONFIG_OF? Anything else I don't know?

In my opinion, lanes number and link frequency checks are ok :)
We don't need conditional CONFIG_OF.

fwnode* function support both ACPI and dts.

Thanks,
Tommaso

> 
> >
> > Regards,
> > Tommaso
> >
> --
> Best regards,
> Mikhail Rudenko

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
