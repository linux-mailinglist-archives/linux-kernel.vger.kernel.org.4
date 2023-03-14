Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3FE36B99CA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 16:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjCNPhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 11:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbjCNPhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 11:37:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F33BA6BF7;
        Tue, 14 Mar 2023 08:36:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE5B7617ED;
        Tue, 14 Mar 2023 15:35:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E9B1C433EF;
        Tue, 14 Mar 2023 15:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678808120;
        bh=lDxTSgsnXum9DYPXFxbGHFuMeuz70JNgYVKghxXniaQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PCbHWZWFAJlaHmd0FT7vhDiC4wqizF5BpL3ect84f8v0e1UNTESM3LvnrzbhI2reT
         7nxR3gTkrhTS2uMmYZLDo7/oAbLUwrU+I6ajJIoot/l5bJRZabCymLbKPUgAY8qeSN
         9UWTeXhHicJV7fU/KCy8hxbBX3ULT1Mn9sPrCy9et4dcxWt604vKEMljxZeNPOpalB
         BvwLY0rIbr+cdaHOqr4D4Bs3512/5bn/mu0WNJMZp4QbA+QxwUp22TDWAlRnxWaEg1
         6gRU4p6ofq61DtVttGeFblrTs6dUFeGEeXbUzlCsdTeZb0U8z1wyje3Ia5Lqg6/jVN
         E+p+tHrGHwFcw==
Date:   Tue, 14 Mar 2023 15:35:15 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Sakari Ailus <sakari.ailus@iki.fi>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Cc:     Eugen Hristev <eugen.hristev@microchip.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        luis.oliveira@synopsys.com,
        Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v5 3/4] media: platform: dwc: Add MIPI CSI-2 controller
 driver
Message-ID: <97746427-c373-4e49-be8d-31a22ece30c7@spud>
References: <20221216143717.1002015-1-eugen.hristev@microchip.com>
 <20221216143717.1002015-4-eugen.hristev@microchip.com>
 <ZBCCmWQ8lM/wfexr@valkosipuli.retiisi.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="8J/HusImJ6ezRElp"
Content-Disposition: inline
In-Reply-To: <ZBCCmWQ8lM/wfexr@valkosipuli.retiisi.eu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8J/HusImJ6ezRElp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 14, 2023 at 04:20:09PM +0200, Sakari Ailus wrote:
> Hi Eugen,
>=20
> On Fri, Dec 16, 2022 at 04:37:16PM +0200, Eugen Hristev wrote:
> > From: Luis Oliveira <Luis.Oliveira@synopsys.com>
> >=20
> > Add the Synopsys MIPI CSI-2 controller driver. This
> > controller driver is divided in platform functions and core functions.
> > This way it serves as platform for future DesignWare drivers.
> >=20
> > Signed-off-by: Luis Oliveira <luis.oliveira@synopsys.com>
> > Co-developed-by: Eugen Hristev <eugen.hristev@microchip.com>
> > [eugen.hristev@microchip.com:
> > Add format SRGGB10 to supported format list.
> > Write the data type to the correct register DATA_IDS_1.
> > Changed dev_info to dev_dbg to remove extra chatty messages
> > Avoid overwriting static array of formats]
> > Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> > [luis.oliveira@synopsys.com: Add MIPI CSI-2 platform data]
> > Signed-off-by: Luis Oliveira <luis.oliveira@synopsys.com>
> > [eugen.hristev@microchip.com:
> > Add support for periph clock and phy clock
> > Fix enum_mbus function
> > Implement get_mbus_config
> > Implement media controller
> > Update to use fwnode API
> > In s_stream, first start/stop the sensor
> > remove chatty 'number of lanes' message]
> > Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> > [conor.dooley@microchip.com: fix potential uninitialized variable use]
> > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> > [eugen.hristev@microchip.com: port to kernel 5.16, 5.17]
> > Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
>=20
> Same comment than on the 4th patch, this isn't very readable or relevant.

I'd imagine it can just be collapsed into a Co-developed-by & a signoff
as we hardly need multiple w/ the same names & companies involved each
time.
My "contribution" here (initialising some variables) doesn't warrant
inclusion IMO.

Eugen doesn't work for Microchip anymore though, and I don't know what
the plan for continuing the upstreaming of this driver is.

@Nicolas, do you have a plan here?

Cheers,
Conor.

--8J/HusImJ6ezRElp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZBCULgAKCRB4tDGHoIJi
0iXuAP43K8ntq9hXNbCfFEVPAXip9/lwYTQwOWcfU6wbxAHrcwD/TZa0zkYCap0q
qTYag3lIixUkXWo4nH8aVLD7SH3EngQ=
=e0GH
-----END PGP SIGNATURE-----

--8J/HusImJ6ezRElp--
