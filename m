Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3A163786F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 13:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbiKXMDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 07:03:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbiKXMDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 07:03:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5205C766;
        Thu, 24 Nov 2022 04:03:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0900B62113;
        Thu, 24 Nov 2022 12:03:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6DD9C433D6;
        Thu, 24 Nov 2022 12:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669291380;
        bh=gbD+gwaWELI1psMNav8kNexZAyrqnAE9FQIf70UWePw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rr0r+/u1NBk/sOQMdFN8wcDOa/jwuOcPDeKx5yCI1cEIedd+AkLTnSYa9adB9O90+
         n8u+W1RwbhKiaTJDB7nqJcH1SAfuoK/7o40EKvXlter1PkES4WIYp/Ty7cUk95xQ+r
         aN27ywGjSGeDEWDyEiu6CbxImwbZHZCeG1GDA12NFP2XTxVfytjsoraTLjjRDo4SfN
         gPnQQnhv9EqTJvG6SmQQq7ZrosYSphbZLkWqKJ2ez3tyNJ+IjxLZuZvVaOJjVVIGsh
         8A1aXVzD1kcO71Jj5aFuhB0fNdJMJ2GPpnU6oa1KWHsAACj0QKG0MpN7gP1Gb08Aol
         7AxVc7Y+ezNsg==
Date:   Thu, 24 Nov 2022 12:02:55 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Cc:     greg.malysa@timesys.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: cadence-quadspi: Add upper limit safety check to
 baudrate divisor
Message-ID: <Y39db5XIGm8xBaWK@sirena.org.uk>
References: <Y39YJL02jFbkEMqw@sirena.org.uk>
 <20221124115354.132832-1-nathan.morrison@timesys.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="a5yZmZ0pobTLGZ9G"
Content-Disposition: inline
In-Reply-To: <20221124115354.132832-1-nathan.morrison@timesys.com>
X-Cookie: Apply only to affected area.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--a5yZmZ0pobTLGZ9G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 24, 2022 at 06:53:54AM -0500, Nathan Barrett-Morrison wrote:

> Would you like me to add a dev_err (or such) bailout error condition and resubmit?

Yes, please.  A bit of rewording to clarify the commit log might help as
well.

--a5yZmZ0pobTLGZ9G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmN/XW4ACgkQJNaLcl1U
h9Bsowf+KsLdfbJN4X9p4Qcs6DVVPq+l0/knHJmXfpHMqwF0dF7ZVYaUCSpZoz64
hiz4L5rEolEDjEyVicWYgvkOGatcg2xyAWB2tWtv/KzMOkQB3Xm3NefM8G/UVd65
8kJysB82VA9q3YQ39vrq8ARQaVRvAzOG4i8nlo2BXk4Xtk2iMZ0dt4wRAsu6fT1F
2GVnST/CMR9upEfZ7A9ZEg3gzhm2cldIwfr+8q6j9y28xrE0F/owIlkTiz7slcXN
nEMI03dpmS/ZYpSpznZVWcRoUSgUsUu9ibuRUSbivZS6JMpp+g44o9pKDvBrujRF
gR9PcFWTlmMmzk/R2didsgjzcyCFTQ==
=HM3F
-----END PGP SIGNATURE-----

--a5yZmZ0pobTLGZ9G--
