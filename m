Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C096A7266F6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 19:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbjFGRQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 13:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjFGRQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 13:16:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0119192;
        Wed,  7 Jun 2023 10:16:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 81724641D5;
        Wed,  7 Jun 2023 17:16:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07570C433EF;
        Wed,  7 Jun 2023 17:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686158186;
        bh=DonjpALs+BmLvhlpatYFzSlwxhizEwTjKrcgzlGnnhQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=prFu2mvYQaF0e3n0dZ9A4nONDu1Bqp0N8rVanwV9B4nnLBPzOMSiYM9Hj4ZGGtRtl
         tsGtg2nDIvoL8+h15+bWdkW5ppzrqAM9/2NsdjjfWyOziox5keAjG64B+chKsIglqk
         3+jg+SGGfUBmYY2G6i56C3UEYd71sBHroNZIXLLNkQl3OS8s5l4MBSqfHn+mGvLu+x
         9r0kyV/rNw+EESo3nZp7rs+g5cq3E9e2/J0oG71Vw7LQpGx5ZNPvf0rlXY1FMP8ZOO
         I/0Tk6yKD6us7RnAWB+rUpYongTIEAO5qa8XeBn1uzLQRJInIoWBnPLh50N59vjFta
         aGzuH+BxspqWQ==
Date:   Wed, 7 Jun 2023 18:16:19 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Tommaso Merciai <tomm.merciai@gmail.com>
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
Message-ID: <20230607-pyromania-germinate-b5e3dbd54632@spud>
References: <20230607131936.382406-1-tomm.merciai@gmail.com>
 <20230607131936.382406-3-tomm.merciai@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ld8OWH6vGquOMZTs"
Content-Disposition: inline
In-Reply-To: <20230607131936.382406-3-tomm.merciai@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ld8OWH6vGquOMZTs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hey Tommaso,

On Wed, Jun 07, 2023 at 03:19:24PM +0200, Tommaso Merciai wrote:

> +  alliedvision,lp2hs-delay-us:
> +    maximum: 150000
> +    description: |
> +      Low power to high speed delay time.
> +
> +      If the value is larger than 0, the camera forces a reset of all
> +      D-PHY lanes for the duration specified by this property. All lanes
> +      will transition to the low-power state and back to the high-speed
> +      state after the delay. Otherwise the lanes will transition to and
> +      remain in the high-speed state immediately after power on.
> +
> +      This is meant to help CSI-2 receivers synchronizing their D-PHY
> +      RX.

Since this new version was posted before I got a chance to reply, I
still don't think it makes sense to allow 0 & then special case it,
when testing for the presence of a property is trivial.
The property should describe some behaviour/property of the hardware,
not be a mechanism to convey what you want to write into registers.

I don't really get why you'd not do:
	If present, the camera forces a reset of all D-PHY lanes, for the
	duration specified by this property. All lanes will transition to
	the low-power state and back to the high-speed state after the
	delay.
	Otherwise the lanes will transition to and remain in the high-speed
	state immediately after power on.

> +static int alvium_get_dt_data(struct alvium_dev *alvium)
> +{
> +	struct device *dev = &alvium->i2c_client->dev;
> +	struct device_node *node = dev->of_node;
> +	struct fwnode_handle *endpoint;
> +	int ret = 0;
> +
> +	if (!node)
> +		return -EINVAL;
> +
> +	ret = fwnode_property_read_u32(dev_fwnode(dev),
> +			  "alliedvision,lp2hs-delay-us",
> +			  &alvium->lp2hs_delay);
> +	if (ret)
> +		dev_info(dev, "lp2hs-delay-us not found\n");

And this print, which I also don't understand the presence of as
well behaving driver should be quiet, goes away.

Cheers,
Conor.

> +
> +	endpoint = fwnode_graph_get_next_endpoint(dev_fwnode(dev), NULL);
> +	if (!endpoint) {
> +		dev_err(dev, "endpoint node not found\n");
> +		return -EINVAL;
> +	}
> +
> +	if (v4l2_fwnode_endpoint_alloc_parse(endpoint, &alvium->ep)) {
> +		dev_err(dev, "could not parse endpoint\n");
> +		return 0;
> +	}
> +
> +	if (alvium->ep.bus_type != V4L2_MBUS_CSI2_DPHY) {
> +		dev_err(dev, "unsupported bus type\n");
> +		return -EINVAL;
> +	}
> +
> +	if (!alvium->ep.nr_of_link_frequencies) {
> +		dev_err(dev, "no link frequencies defined");
> +		return -EINVAL;
> +	}
> +
> +	dev_info(dev, "freq: %llu\n",
> +				    alvium->ep.link_frequencies[0]);
> +	dev_info(dev, "lanes: %d\n",
> +				    alvium->ep.bus.mipi_csi2.num_data_lanes);
> +
> +	return 0;
> +}

--ld8OWH6vGquOMZTs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZIC7YwAKCRB4tDGHoIJi
0twwAQCpR1pdYb6oE6B9OxPvbNpQ4rolh8veEmj0xSM3IbmboAD/U2uBgBIVJ9n/
SuqJRIhyCNXNwYYHFbO/atVV1TSjJAo=
=hjLR
-----END PGP SIGNATURE-----

--ld8OWH6vGquOMZTs--
