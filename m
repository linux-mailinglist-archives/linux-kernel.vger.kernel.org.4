Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 922A0726A24
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 21:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbjFGTt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 15:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjFGTtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 15:49:25 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAEBA101;
        Wed,  7 Jun 2023 12:49:23 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-5149b63151aso2126633a12.3;
        Wed, 07 Jun 2023 12:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686167362; x=1688759362;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xinSIPtLD9mwv6iuhS8dp2Mw0+vZbIWYEl17ISiKBzY=;
        b=dOdS7D9mdTOTI4/O6vOazPPGD41iGTYB4VUnC1iqk9W3iU4Lai37jfNsir3uj85PFK
         vstexSTg1M5jq+qrBUu2eeMkikoTpazeSUG+pEchU+pnv/SRFz4QR2qzl/oTKo9m+9Tr
         u47t2VMJwZpqK7vgCa0sQHxuZmS10nfCZ94SAEgrwS83MMMWP8JUxx0uc26+KZI/+uq2
         f1X7LwKjvbeNNxwkgyQYYJXwml6l/GpWZuAdC9z/SUMoiQevRZUjX+wRBWKAUTxdLDJH
         /oto9aD89wCtR8ItJUTgm+DmYAxA7m4v9nEwgtRqKMEbjI2JWnthU+Dd5B7OVoySMKfe
         yyMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686167362; x=1688759362;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xinSIPtLD9mwv6iuhS8dp2Mw0+vZbIWYEl17ISiKBzY=;
        b=hKi4sYGYqezDE/IWd2hWpLv33rbP31fCfMWM2tgta8dCLZk3ts9+FMNviOu0rT0H56
         ROtrLa7cWHlQCxLiRfDqa+t9rWRTsRQwoYE2n5rWEpiEWt2op8MCObr3JDf6wEeHrVb8
         fY2knMUwyrr4+2GDDMYWzFpaw8SKLiqo4P6CQ3fHornfQCyexv1WsNVzTGD5+IXUXt2N
         fOzpTvTkt2rY2RG+c46S1S8NAWwjEpQNYEbmHsLkpw4mslfOjXV+TM+n4PZtIf8iR7FG
         9vD33NxM759Lq8U0zgnCJh3qr7Pv2k8B0GNmG1E234/5oVtPXrQLE97ya8YTADetggcb
         Fo9w==
X-Gm-Message-State: AC+VfDzBo9by3ggCNlr2uBWOODFpt744hi8miixHoV16nzGAQU+VLz3W
        IYS58jbZmEP8t4JO2YMpQUAw2YCxsWbZfQ==
X-Google-Smtp-Source: ACHHUZ71xru/jt2Sphd1hLak19DFHysmp0w/RQj06OtO9JRv9mQmPXBvb8K8imuCSrv7iM4egILckQ==
X-Received: by 2002:aa7:ca4e:0:b0:514:78d4:ec48 with SMTP id j14-20020aa7ca4e000000b0051478d4ec48mr5436642edt.2.1686167361955;
        Wed, 07 Jun 2023 12:49:21 -0700 (PDT)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation (net-188-217-50-121.cust.vodafonedsl.it. [188.217.50.121])
        by smtp.gmail.com with ESMTPSA id n2-20020aa7c682000000b00514b3a2008esm6533877edq.2.2023.06.07.12.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 12:49:21 -0700 (PDT)
Date:   Wed, 7 Jun 2023 21:49:18 +0200
From:   Tommaso Merciai <tomm.merciai@gmail.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     jacopo.mondi@ideasonboard.com, laurent.pinchart@ideasonboard.com,
        martin.hecht@avnet.eu, michael.roeder@avnet.eu,
        linuxfancy@googlegroups.com,
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
        Nicholas Roth <nicholas@rothemail.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>,
        Shawn Tu <shawnx.tu@intel.com>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] media: dt-bindings: alvium: add document YAML
 binding
Message-ID: <ZIDfPigYN5CgW65L@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
References: <20230607131936.382406-1-tomm.merciai@gmail.com>
 <20230607131936.382406-3-tomm.merciai@gmail.com>
 <20230607-pyromania-germinate-b5e3dbd54632@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230607-pyromania-germinate-b5e3dbd54632@spud>
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

On Wed, Jun 07, 2023 at 06:16:19PM +0100, Conor Dooley wrote:
> Hey Tommaso,
> 
> On Wed, Jun 07, 2023 at 03:19:24PM +0200, Tommaso Merciai wrote:
> 
> > +  alliedvision,lp2hs-delay-us:
> > +    maximum: 150000
> > +    description: |
> > +      Low power to high speed delay time.
> > +
> > +      If the value is larger than 0, the camera forces a reset of all
> > +      D-PHY lanes for the duration specified by this property. All lanes
> > +      will transition to the low-power state and back to the high-speed
> > +      state after the delay. Otherwise the lanes will transition to and
> > +      remain in the high-speed state immediately after power on.
> > +
> > +      This is meant to help CSI-2 receivers synchronizing their D-PHY
> > +      RX.
> 
> Since this new version was posted before I got a chance to reply, I
> still don't think it makes sense to allow 0 & then special case it,
> when testing for the presence of a property is trivial.

My bad, sry.
My keyboard is too quick :P

> The property should describe some behaviour/property of the hardware,
> not be a mechanism to convey what you want to write into registers.
> 
> I don't really get why you'd not do:
> 	If present, the camera forces a reset of all D-PHY lanes, for the
> 	duration specified by this property. All lanes will transition to
> 	the low-power state and back to the high-speed state after the
> 	delay.
> 	Otherwise the lanes will transition to and remain in the high-speed
> 	state immediately after power on.
> 

You are suggesting the following solution:

minimum: 1
maximum: 150000

Right?

Personally I prefer to keep also 0 but never mind
is ok also this solution. :)

Let me know if I have understood correctly pls.
Thanks in advance :)

> > +static int alvium_get_dt_data(struct alvium_dev *alvium)
> > +{
> > +	struct device *dev = &alvium->i2c_client->dev;
> > +	struct device_node *node = dev->of_node;
> > +	struct fwnode_handle *endpoint;
> > +	int ret = 0;
> > +
> > +	if (!node)
> > +		return -EINVAL;
> > +
> > +	ret = fwnode_property_read_u32(dev_fwnode(dev),
> > +			  "alliedvision,lp2hs-delay-us",
> > +			  &alvium->lp2hs_delay);
> > +	if (ret)
> > +		dev_info(dev, "lp2hs-delay-us not found\n");
> 
> And this print, which I also don't understand the presence of as
> well behaving driver should be quiet, goes away.

Then you are suggesting to drop this print right?

Thanks for your review!

Regards,
Tommaso

> 
> Cheers,
> Conor.
> 
> > +
> > +	endpoint = fwnode_graph_get_next_endpoint(dev_fwnode(dev), NULL);
> > +	if (!endpoint) {
> > +		dev_err(dev, "endpoint node not found\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (v4l2_fwnode_endpoint_alloc_parse(endpoint, &alvium->ep)) {
> > +		dev_err(dev, "could not parse endpoint\n");
> > +		return 0;
> > +	}
> > +
> > +	if (alvium->ep.bus_type != V4L2_MBUS_CSI2_DPHY) {
> > +		dev_err(dev, "unsupported bus type\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (!alvium->ep.nr_of_link_frequencies) {
> > +		dev_err(dev, "no link frequencies defined");
> > +		return -EINVAL;
> > +	}
> > +
> > +	dev_info(dev, "freq: %llu\n",
> > +				    alvium->ep.link_frequencies[0]);
> > +	dev_info(dev, "lanes: %d\n",
> > +				    alvium->ep.bus.mipi_csi2.num_data_lanes);
> > +
> > +	return 0;
> > +}


