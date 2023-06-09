Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A362729791
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 12:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238709AbjFIKxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 06:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjFIKxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 06:53:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D19E83
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 03:53:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 261E4656D0
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 10:53:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88C5CC433D2;
        Fri,  9 Jun 2023 10:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686308009;
        bh=defKlFYq4qk5TY8DNFvgXgdYeoY5vXhX3sDVEAMBSf8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A9Gm15pgCGz3oayFmuV4WrwHFlwCOBxa3/AHYHb/AoeumPalqI3fOYTO5GlR7k+Kq
         NzZ00yfP/EQFls2j2R/hz5AtO6EUUNXchz9FdqZhDhITm3ypQZVGPLScdABySzLsZ/
         r9OauYwJ3Dbd9mTMEjpTq27r/pmtTZ/vOOBYmt05CfBRHjxfFka7kWevKMzOoS2SGC
         zgU0qWtyCejjcTVO96aCYa3v/yd7Qh1ig9qEqKoSfLPor4+0CG+KiM4FCxQSLtN6BF
         GNPKF9qu1FjyCdti23NIRA4W03wQzik7cn1i7g1WZ0rOAr/ytxOV+33o1mYbafFtSC
         tSKctA+/mbH2g==
Date:   Fri, 9 Jun 2023 11:53:24 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Cristian Ciocaltea <cristian.ciocaltea@gmail.com>,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] regulator: Use bitfield values for range selectors
Message-ID: <e78127b2-4c00-4fcd-b829-7a9d465ad2e9@sirena.org.uk>
References: <20230608075651.3214540-1-wenst@chromium.org>
 <c9947378-419b-cd35-73fe-aa1564340d2b@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="STdPkXn5eBBeGzoF"
Content-Disposition: inline
In-Reply-To: <c9947378-419b-cd35-73fe-aa1564340d2b@gmail.com>
X-Cookie: Tom's hungry, time to eat lunch.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--STdPkXn5eBBeGzoF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 09, 2023 at 01:45:15PM +0300, Matti Vaittinen wrote:

> For the helpers.c and bd718x7
> Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

There's a v2: https://lore.kernel.org/r/20230609075032.2804554-1-wenst@chromium.org

--STdPkXn5eBBeGzoF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSDBKMACgkQJNaLcl1U
h9DOpAf+PkJ/QuzLn8aNnGKCJxAp3SWGKrGCl0yGeON2PRjAwYfaeAkLpflRvSCv
EB3U3AmUkWCBq2LVX5Tlm66uL1h3Saps2O2DosVH81gLilRWuZNXrqmKdnJdZlGH
T/u7KgzCF1oCHGC+Igkhzn4yYmnmWOvi2Uq2IXsM89at55M3LXOh4c3t7stG5UN3
gRkXi1cJiAD0l6RQgusfg359lX1mQNmVNx8udp5ExBc4hPKcJMQAYW1kwoheTp/O
Z65YsFCzjH5AHGQh6hF16ySy7uE4mRCU6L+78fi240Qmg0/UAhtAozAG42/ZQrvv
ddms+6rhpwLjte9WfZshoxcl+IX+PQ==
=Fgdk
-----END PGP SIGNATURE-----

--STdPkXn5eBBeGzoF--
