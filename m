Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE212725539
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 09:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238839AbjFGHQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 03:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233989AbjFGHQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 03:16:20 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F371720;
        Wed,  7 Jun 2023 00:16:18 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9745d99cfccso972445366b.1;
        Wed, 07 Jun 2023 00:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686122177; x=1688714177;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e/gwoeHymID/fcT19qADralB09hxkZWntjL9V3Ud4l4=;
        b=StkB3zqSx/OCPwhn0e0d84kDu2x9uw9DzEGwlFCv6f7EkweFgYAegNjEhhyYUh28eI
         L8VOdYVbF326oJYjCXKJXLK505eMfhg2mhqaezMYvtA81427uLlbysTGWOLxUgJct2Cj
         MHsGb4a1jaMn6v+6P50kpkklodoyb5C4eoxMe3HfQ7R1X/F+NWFMI6U57SIminrqYOt8
         zr6ED/5yxcvZVuC8OEPwGx3+PbCFJWpxkgTYzy/lpFH21s6gLo7w9tFtlSVZbyWA6Q9E
         yygo4+WQYFYs1t7llUKsDD7e1XeK5w1zuWt7eBXlIyuwuXooIviSFRWpZBf9lwznxmD5
         3PIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686122177; x=1688714177;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e/gwoeHymID/fcT19qADralB09hxkZWntjL9V3Ud4l4=;
        b=fZDnHDUGYjEIudr5qyln5lSkwNn5f5p6hicBiPJmau3jdvNYgLeAbuqMoTorlzALen
         me6AwhwfKqKdlzQb43JYHKNMebtg8BRbvQt8RAtZHr7QR7aBUJ8Pcv26UZexbirHyndh
         Wqc5XoL9F3NIZ6hbQvuYpgj0zOnWYYDEpFF5AQXKCtqEhdkzbLQMjVe2EtTFn2/OSJaK
         jBoZryEnfSjb+O/AACtyM+ug0VQELquaPjJ0ZdtW7Eo5T/5ja5OQ7Vg2elHrfMnApiEr
         p+E8Sa0N3Gw/4D2BHjNKvFrHVRxa0IYtMabkFHBm3mSfgnvIzR2eFWkVDN9BUUuM3pOo
         q9wg==
X-Gm-Message-State: AC+VfDx7pszcpPneIYPuo6EvO2O3E4QnFyaqUW3qfD+IWwWPuiB7FAQz
        eX/f1BjyvXwjZo0EkQLYMraJui1CaORv1g==
X-Google-Smtp-Source: ACHHUZ6bNpT4RI3A0qNm26XLgzYqjoKDdT3/AiUwJvka5+rvPKtIa+Ji3R7DZtnVWudsnl+8FWC9Lw==
X-Received: by 2002:a17:907:6d8a:b0:973:ae80:a145 with SMTP id sb10-20020a1709076d8a00b00973ae80a145mr6073609ejc.43.1686122177177;
        Wed, 07 Jun 2023 00:16:17 -0700 (PDT)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation (net-188-217-50-121.cust.vodafonedsl.it. [188.217.50.121])
        by smtp.gmail.com with ESMTPSA id s20-20020a170906bc5400b009745b0cb326sm6408617ejv.109.2023.06.07.00.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 00:16:16 -0700 (PDT)
Date:   Wed, 7 Jun 2023 09:16:14 +0200
From:   Tommaso Merciai <tomm.merciai@gmail.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        jacopo.mondi@ideasonboard.com, martin.hecht@avnet.eu,
        michael.roeder@avnet.eu, linuxfancy@googlegroups.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        Mikhail Rudenko <mike.rudenko@gmail.com>,
        Shawn Tu <shawnx.tu@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>,
        Nicholas Roth <nicholas@rothemail.net>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] media: dt-bindings: alvium: add document YAML
 binding
Message-ID: <ZIAuvjmyUpuY/eDk@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
References: <20230606155416.260941-1-tomm.merciai@gmail.com>
 <20230606155416.260941-3-tomm.merciai@gmail.com>
 <20230606163656.GI25679@pendragon.ideasonboard.com>
 <20230606-jaundice-womankind-7e583789fb7a@spud>
 <20230606181752.GC14101@pendragon.ideasonboard.com>
 <20230606-create-catchable-e16113afac82@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606-create-catchable-e16113afac82@spud>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

On Tue, Jun 06, 2023 at 07:23:32PM +0100, Conor Dooley wrote:
> On Tue, Jun 06, 2023 at 09:17:52PM +0300, Laurent Pinchart wrote:
> > On Tue, Jun 06, 2023 at 07:07:42PM +0100, Conor Dooley wrote:
> > > Hey Laurent, Tommaso,
> > > 
> > > On Tue, Jun 06, 2023 at 07:36:56PM +0300, Laurent Pinchart wrote:
> > > > On Tue, Jun 06, 2023 at 05:54:03PM +0200, Tommaso Merciai wrote:
> > > 
> > > > > +  alliedvision,lp2hs-delay-us:
> > > > > +    maxItems: 1
> > > > > +    description:
> > > > > +      Low power to high speed delay time in microseconds.
> > > > 
> > > > You can drop "in microseconds", that's implied by the suffix.
> > > > 
> > > > > +      The purpose of this property is force a DPhy reset for the period
> > > > > +      described by the microseconds on the property, before it starts
> > > > > +      streaming. To be clear, with that value bigger than 0 the Alvium
> > > > > +      forces a dphy-reset on all lanes for that period. That means all
> > > > > +      lanes go up into low power state. This may help a csi2 rx ip to
> > > > > +      reset if that IP can't deal with a continous clock.
> > > > 
> > > > I'd like to propose what I think is a clearer version:
> > > > 
> > > >     description: |
> > > >       Low power to high speed delay time.
> > > > 
> > > >       If the value is larger than 0, the camera forces a reset of all
> > > >       D-PHY lanes for the duration specified by this property. All lanes
> > > >       will transition to the low-power state and back to the high-speed
> > > >       state after the delay. Otherwise the lanes will transition to and
> > > >       remain in the high-speed state immediately after power on.
> > > > 
> > > >       This is meant to help CSI-2 receivers synchronizing their D-PHY
> > > >       RX.
> > > 
> > > Question about the property.
> > > Why not make it have a minimum value of 1 and drop the special-case
> > > behaviour for zero?
> > 
> > The property is optional, so it can indeed be omitted if no delay is
> > desired. I have no strong preference on whether or not to allow 0 as a
> > valid value.
> 
> FWIW, I prefer the semantics of the property if it doesn't have the
> limbo state of being present but doing nothing.
> 
> Cheers,
> Conor.
> 
> BTW, I seem to get bounces from shawnx.tu@intel.com, who is listed in
> MAINTAINERS for several drivers. Do you know if they have a non-intel
> address to replace those entries with, or should they be dropped?

Same here! :)

Thanks,
Tommaso


