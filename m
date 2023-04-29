Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED9E6F240B
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 11:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbjD2Jyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 05:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjD2Jyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 05:54:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73FA01998;
        Sat, 29 Apr 2023 02:54:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 033D760ACE;
        Sat, 29 Apr 2023 09:54:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45C56C433EF;
        Sat, 29 Apr 2023 09:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682762071;
        bh=vaxpR7H74V+N78gGIrsRxB+pNJ87XdM1mZbhAvHC2AA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qyfqN6/tmEBvLQPWJ4TKyxc37myIE5Y/INgrYDkiv7iLScdZDZd/tGU52oTZQB1SG
         7MlXAvq0kRDXNQKAic+mgIVyg9b3BmY9hiqxeOxWK+sKxJRpmK/QTxs186DGYe4EFt
         CrzqzG+pbd19E30fxNsA65N21wjcztMUqJI6u3qtD5A76JhI7p1dAfEgo6Enebt51S
         kuDvhcF/gNZjYp/MhMk8WaHWrx66DKgt3qirPJbVCxZ9p7HxY59UQ/ZR8FdwFuoLk5
         e1TertCv3sFCjY3VHpy3UY6DVGYQDK1nb92zelXsZQFwuE7CyESvfSmI/ep9vPH4Rv
         SAQm+5MCRhVYQ==
Date:   Sat, 29 Apr 2023 10:54:25 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 6.1 00/16] 6.1.27-rc1 review
Message-ID: <20230429-skintight-civic-5ef6d671d7bc@spud>
References: <20230428112040.063291126@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="AEoJaTRgMrgwcG5o"
Content-Disposition: inline
In-Reply-To: <20230428112040.063291126@linuxfoundation.org>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AEoJaTRgMrgwcG5o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 28, 2023 at 01:27:52PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.27 release.
> There are 16 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

LGTM in terms of what my CI is testing.
I didn't test the niche configurations that the fixmap stuff was
introduced for specifically here, but you won't be too long hearing from
me next week if it goes awry there.

Tested-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--AEoJaTRgMrgwcG5o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZEzpUQAKCRB4tDGHoIJi
0oEwAQDAUib6WDOwQv3NFrQevj4Ljjv/aK2xzVbYnjfloRPa7gEA8arhIRedOXFV
X163AsK4al88Xo9ulLQq+MhDuTDF7AY=
=sYy6
-----END PGP SIGNATURE-----

--AEoJaTRgMrgwcG5o--
