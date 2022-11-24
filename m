Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6474E637DC0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 17:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiKXQwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 11:52:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiKXQwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 11:52:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A6E630D
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 08:52:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 99006620AB
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 16:52:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 094DCC433D6;
        Thu, 24 Nov 2022 16:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669308748;
        bh=/IkJEUKLdbCL1Y1Z1hYCwg+75j0bww9RnjQ0VSAWCmE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VBAoXCoUygVhuyqjFYgUEZ4Go2kHhbMzsjQYyWvjquGoWKdGnz7Zvoqp6JaoD5cfh
         VlsACioyHOSxyljk7au4DGJoTSoykJsOf3wAxYF1ji/RBhLcypGpuJZRdCRuHc60pz
         u72lBEVs9Tm90rHobdZiKSScDZc3+LvxWCLdwcBTtwcJZinnf5OBj2ujaN1T/AYBUD
         pf9BVnDn4Cw7R0iwfJkKaouGGoJCQTIYj4PR3tMuBSqFL1xaTjVvkf3itGTK+ds7WW
         APyVw6ROvndGqCfHJ8dxVFXLs7tqCn94UO7WLLvU5nUguCzDVHWOqed2ENbzDcY5d5
         nY3c7oIMUPnhQ==
Date:   Thu, 24 Nov 2022 16:52:23 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jean Delvare <jdelvare@suse.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Icenowy Zheng <icenowy@aosc.io>
Subject: Re: [PATCH] regulator: Drop obsolete dependencies on COMPILE_TEST
Message-ID: <Y3+hR9MYueN1FNZd@sirena.org.uk>
References: <20221124144708.64371b98@endymion.delvare>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="P2buFR/aLvLe+Bcv"
Content-Disposition: inline
In-Reply-To: <20221124144708.64371b98@endymion.delvare>
X-Cookie: Apply only to affected area.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--P2buFR/aLvLe+Bcv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 24, 2022 at 02:47:08PM +0100, Jean Delvare wrote:

> It is actually better to always build such drivers with OF enabled,
> so that the test builds are closer to how each driver will actually be
> built on its intended target. Building them without OF may not test
> much as the compiler will optimize out potentially large parts of the
> code. In the worst case, this could even pop false positive warnings.

Having the ability to build without OF doesn't preclude testing with OF
of course.

--P2buFR/aLvLe+Bcv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmN/oUYACgkQJNaLcl1U
h9CUdwf/U1WUYubBKwSm6Z3fJX/fKEBM8GUUseGkdZS6rHE/VlAqO8yezgmLrw9C
BIUhFUJba0uZlWDTdYrBfG/UqKN5iFentA1HUlU1Ku+kMfOLb/5b5c77Oc8niIRA
k0TtoOC9mpdavlvZRQObJtNoC6ol1UkSnR9EbYHSM0vBKiyeRZ28lnGftHOsdm94
ryGVGIxapIQxYNrtXptas1sUWvyyYnGHxrQtWayUEqWrfh42C1bDipgCCig9Nnk7
s17uh/5eF1w4+pWTK+IxPu6Ve8ViZwZus4dL/rFSZqFAVTDgKlsXsDR1Kt5OMqva
kGoLrT+h7O72pj/VFqz6TJZqgsOcAg==
=qqBt
-----END PGP SIGNATURE-----

--P2buFR/aLvLe+Bcv--
