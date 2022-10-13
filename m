Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E953D5FD9BD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 15:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiJMNAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 09:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbiJMNAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 09:00:00 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD956275D1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 05:59:58 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id r13so2676697wrj.11
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 05:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6fGrxMBOLuz/ufum7iLzYyW7+BeCUbMtinCuje5Qnek=;
        b=DDrg6gRNN+qdSFLktuGPe6miLLWo+FuSK7tmXGvcxzwEWl7EOc3azdJ9UyOh6FVCTP
         TWZ6G2PN+tILhovLGjrqwCbPE7iaWPKnBNdJYFB13D7CH/wGS7ZuaVXfV1ngFWozXv2K
         zz8WTWpujszYbJhtDEDk+Oz7PP3dcoMka4qvGpADe9folHcBfkmoJCTuzz6lsAXqBNfT
         7inuvWjNVpbHZ5LP+bMy6YrhzpYc3KtgRLb+RbPToZJpOyJI45oSngd7QHUp/aeDGMSk
         da7DD4PNiGARh+RI85rh85RBiZf8+85ZmGZyKDgd8boOgMlD3HtlacfhdGJv1fshZLB5
         Ascg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6fGrxMBOLuz/ufum7iLzYyW7+BeCUbMtinCuje5Qnek=;
        b=rndqw8ZrtBwwr/S1pyPIESdXc/02UacdMH8nzEGdK4/WF7oI83y/s4Ue4HRZAZlCgF
         mV+NnOz5jS1K0nPZZI1KbySPXkSPSjuLdoWL1OY2kKcbvtFNnE1wJsFuzyhvs+/8IylD
         UiSXax4dQJNQvZ50bPvXEcR1eEdVaZu6ij63un5RJ35vfP6lcsFpcVj2O6k35Yc6HUtX
         GPJdnV2+WEIs5yQEjBBSe+466OUIDMMfrfhYwz76i+i8PNaSTUMObASkQJEgAm024Eth
         +WyPeKEub3OCJ8dtt0cJla+IX/zoaCl06OgQaQis7gbMPbqlcvbjx/AO9eruR+Y/d63c
         SE/w==
X-Gm-Message-State: ACrzQf1aEolEVDrDIS897ggeEep1bjgRzhY+GTTFFH1WC9yNt/pPfd9k
        OPQT02oCCkm5FiZ2Nk35cDRZ9I9JorvK69BN
X-Google-Smtp-Source: AMsMyM4R9UBvK2aOVuodBoSAKW6fTfehJPe8G1obMNxLSJk0gLOU1bkCanq3VMsPRApZPcX2cW1RDg==
X-Received: by 2002:a05:6000:168c:b0:231:7950:1114 with SMTP id y12-20020a056000168c00b0023179501114mr7941495wrd.484.1665665997291;
        Thu, 13 Oct 2022 05:59:57 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id x4-20020adff644000000b0022afbd02c69sm2010424wrp.56.2022.10.13.05.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 05:59:56 -0700 (PDT)
Date:   Thu, 13 Oct 2022 13:59:55 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH 2/7] gpiolib: of: consolidate simple renames into a
 single quirk
Message-ID: <Y0gLy84EvqpOmXdd@maple.lan>
References: <20221011-gpiolib-quirks-v1-0-e01d9d3e7b29@gmail.com>
 <20221011-gpiolib-quirks-v1-2-e01d9d3e7b29@gmail.com>
 <Y0aS80PlA/T3mx2d@maple.lan>
 <Y0cTkubAA4637o5y@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0cTkubAA4637o5y@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2022 at 12:20:50PM -0700, Dmitry Torokhov wrote:
> On Wed, Oct 12, 2022 at 11:12:03AM +0100, Daniel Thompson wrote:
> > On Tue, Oct 11, 2022 at 03:19:30PM -0700, Dmitry Torokhov wrote:
> > > diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
> > > index cef4f6634125..619aae0c5476 100644
> > > @@ -365,127 +365,83 @@ struct gpio_desc *gpiod_get_from_of_node(const struct device_node *node,
> > > +static struct gpio_desc *of_find_gpio_rename(struct device_node *np,
> > >  					     const char *con_id,
> > >  					     unsigned int idx,
> > >  					     enum of_gpio_flags *of_flags)
> > >  {
> > > +	static const struct of_rename_gpio {
> > > +		const char *con_id;
> > > +		const char *legacy_id;	/* NULL - same as con_id */
> > > +		const char *compatible; /* NULL - don't check */
> >
> > "don't check" doesn't seem desirable. It's not too big a deal here
> > because everything affected has a vendor prefix (meaning incorrect
> > matching is unlikely). Should there be a comment about the general care
> > needed for a NULL compatible?

There were certainly a lot of compatibles affected by this translation
and given the structure of the drivers it is a tough code review to be
sure you have picked up *all* of them!


> I'll add the wording that NULL is only acceptable if property has a
> vendor prefi, Will that be OK? Otherwise I'll have to add a lot of
> entries for Arizona and Madera.
>
> >
> >
> > > +	} gpios[] = {
> > > +#if IS_ENABLED(CONFIG_MFD_ARIZONA)
> > > +		{ "wlf,reset",	NULL,		NULL },
> >
> > CONFIG_REGULATOR_ARIZONA_LDO1 is better guard for this con id.
>
> Are you sure? I see reset handling happening in
> drivers/mfd/arizona-core.c independently of regulator code...

Looks like I grepped for the wrong string so I was completely wrong
here... and in two different ways!

Firstly I'm wrong about replacing the guard. Existing guard is correct!

Secondly, I didn't notice until now that wm8804 also uses the
"wlf,reset" and it is a little odd that the wm8804 driver will accept
or refuse a misspelled binding based whether the kernel has enabled the
arizona drivers.

Overall I can live with the code we have today but this makes me wonder
if the comment discussed above should be stronger. Something like:
"the NULL compatible code is used there to support legacy entries in
the table; try to avoid adding new NULL entries".


Daniel.
