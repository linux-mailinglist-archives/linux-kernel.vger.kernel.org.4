Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC5967F7F0
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 14:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234248AbjA1NQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 08:16:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234142AbjA1NQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 08:16:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B8275DC2A
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 05:16:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EE1A6B80968
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 13:16:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21896C433D2;
        Sat, 28 Jan 2023 13:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674911763;
        bh=+X3O+bUUzbN9OCz05vatTFV1QfIzn40p6+AuYTkiYVU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dNWsdKkja1DljZGG5Xrx3fmia+5VjxIv4q2upRoVhjiLYCvqCmD6/0r413+3rcjcl
         6p7CympdSd9jOUsLjrrnSaEJW+CL+N+dh2kEHZ+1ExQQ4FXUocbY51t8/UPs7d2LO5
         7BLJxvjfwWuwBdrQRp0ogomwG4vEbqW1SBoT/YyNciHIkbGDybJLlV9vWK6/2eh31A
         NhnpL4tq9SKEF9P0WrOycfYo6phRPzZWrni/Jl6GBmW+9B2+JJ/f4E2n3DSVEmv6OI
         ZaXxtHg+wTV6ByFPAEXrp6kc8SX2AadQ/bOcmDhvY0gDa9iR7kkWqQsaEnQ6+5mK4Z
         0JMXT5tgQAOKA==
Date:   Sat, 28 Jan 2023 13:16:00 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Francesco Dolcini <francesco@dolcini.it>
Cc:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: fixed-regulator with enable from another regulator
Message-ID: <Y9UgENl4KZT5e/ot@sirena.org.uk>
References: <Y9RDGnZLg6wGJWwn@francesco-nb.int.toradex.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="84BGMxj62L6bv3Wq"
Content-Disposition: inline
In-Reply-To: <Y9RDGnZLg6wGJWwn@francesco-nb.int.toradex.com>
X-Cookie: Serving suggestion.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--84BGMxj62L6bv3Wq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 27, 2023 at 10:33:14PM +0100, Francesco Dolcini wrote:

> I am trying to figure out if it is possible with the current
> regulator-fixed or with any other solution already implemented in Linux
> to have a regulator enabled from another one.

Not really.  You can model the regulators as sharing the same
enable if there's a GPIO enable for the parent regulator,
otherwise it'd need some framework work.

> I am still not 100% sure if describing this specific hardware connection
> would be required on my system, maybe I can just ignore all of that.

It seems like a fairly strange hardware design TBH.

--84BGMxj62L6bv3Wq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPVIA8ACgkQJNaLcl1U
h9AEpAf+M4hshvd/xIrlzJPFELHSO5+EfkKPKog1fEkAPqqNOmS6GhJaaHO0gX73
CfMOwQeGn4+oItSYZlDlFIsAhAeCO9r5ZBCJBwXCDCf3rFbZCZEkvBsOZbfKXoBM
0eJnmwk50mtemqW1OGROwFkQSVbYmh7M/aG4/SDL1FS0IEocec0we4EUDQB3qbNW
x/zjuoZEu54Sy0TL/WbBpr77+M+Z8OoPRXXWdX3MDGTXMmAqOLt+OwDKeAxvY67O
7s3Yi4dchN16tGX3Nu/uJKGik8VjUhrJrRpM52mPh4tlX+N1UqsNZav+GZG6m80A
O6iG375BMjbJbenYX86CNz+WBj+paw==
=VpgF
-----END PGP SIGNATURE-----

--84BGMxj62L6bv3Wq--
