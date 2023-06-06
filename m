Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D43BF724AD6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 20:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237853AbjFFSIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 14:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238897AbjFFSHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 14:07:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3B31702;
        Tue,  6 Jun 2023 11:07:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 604CD63677;
        Tue,  6 Jun 2023 18:07:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17E34C433EF;
        Tue,  6 Jun 2023 18:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686074869;
        bh=+g7AH2Cprbi9FFx9hvRKBw23s6nCP3oe6Nu3HsJbAdw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jF9Ece+gc3Z3hCwaxXvycaYKX1a8RvkNq2LwhQK8lXeuwErIWMoSjRfZLELHNYUnn
         rhtfPvPPGdjwz32yX1WDCR2+YFjPqKYQXxgP8ckTudg86unWuRJLv3lVONtMkgU2Jg
         FDyYjKb2vKMwhTFv2RpAJxtzInCaUNkbturfD/FJ5q1i78vqsl0ECB57VW2VpSPAQS
         pRTBlCdu80t6krhiwYulgYYo1cJU+CTqzgJuOzb0z4nQ6GIw/fk0RZKBn0d/fKNkk1
         FvVvy3M9SVo1XBfp0fcGuoe57ZJCa5zFKsa7kte/hT5hDCqde5PLQ+qaw8gJzX5LQs
         rLcuvJBkmI9ew==
Date:   Tue, 6 Jun 2023 19:07:42 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Tommaso Merciai <tomm.merciai@gmail.com>,
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
Message-ID: <20230606-jaundice-womankind-7e583789fb7a@spud>
References: <20230606155416.260941-1-tomm.merciai@gmail.com>
 <20230606155416.260941-3-tomm.merciai@gmail.com>
 <20230606163656.GI25679@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+RoPVQsdZoEGL6As"
Content-Disposition: inline
In-Reply-To: <20230606163656.GI25679@pendragon.ideasonboard.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+RoPVQsdZoEGL6As
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Laurent, Tommaso,

On Tue, Jun 06, 2023 at 07:36:56PM +0300, Laurent Pinchart wrote:
> On Tue, Jun 06, 2023 at 05:54:03PM +0200, Tommaso Merciai wrote:

> > +  alliedvision,lp2hs-delay-us:
> > +    maxItems: 1
> > +    description:
> > +      Low power to high speed delay time in microseconds.
>=20
> You can drop "in microseconds", that's implied by the suffix.
>=20
> > +      The purpose of this property is force a DPhy reset for the period
> > +      described by the microseconds on the property, before it starts
> > +      streaming. To be clear, with that value bigger than 0 the Alvium
> > +      forces a dphy-reset on all lanes for that period. That means all
> > +      lanes go up into low power state. This may help a csi2 rx ip to
> > +      reset if that IP can't deal with a continous clock.
>=20
> I'd like to propose what I think is a clearer version:
>=20
>     description: |
>       Low power to high speed delay time.
>=20
>       If the value is larger than 0, the camera forces a reset of all
>       D-PHY lanes for the duration specified by this property. All lanes
>       will transition to the low-power state and back to the high-speed
>       state after the delay. Otherwise the lanes will transition to and
>       remain in the high-speed state immediately after power on.
>=20
>       This is meant to help CSI-2 receivers synchronizing their D-PHY
>       RX.

Question about the property.
Why not make it have a minimum value of 1 and drop the special-case
behaviour for zero?

Cheers,
Conor.

--+RoPVQsdZoEGL6As
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZH917gAKCRB4tDGHoIJi
0ihzAQCALlESrN9lQINq5At4m8i/cKUpv33zVdz16wSfgQJyrAD/ffwmWbpPLax3
TT8InwBknLiZT8TQTt34eMlSoorRlAA=
=0a/j
-----END PGP SIGNATURE-----

--+RoPVQsdZoEGL6As--
