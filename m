Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F348A5FD9BE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 15:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiJMNAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 09:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbiJMNAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 09:00:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56E9326F0;
        Thu, 13 Oct 2022 05:59:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5AD2B61791;
        Thu, 13 Oct 2022 12:59:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4942C433D6;
        Thu, 13 Oct 2022 12:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665665998;
        bh=ty4DVOvK4AGDUGTtZoOUbJX9Ux5kvrzSPuUsAB0rHC0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JAJebx8Ie/kcBEpP4FPEtyz2oh2jGF//ZUn0k/4310cOiSsdTyE0Nl0ieQcmcSK9W
         JdqYCDYZYDNybmxiiKFBQyHwM2AJIuQtUy7VVO6P2wpcVGnWiZf/2G7zSXZW+D6nt+
         dNG8r/u4IfbBRuNt0QPQlk3lFUMRSCDWCRnN3JBk+jO002WNW4okR9W8lpYrc3iuJb
         zZSdANS/Y1rsaUbh9fR32Ty8uQ/slVhtxf7KVsxbLkew9geodPdFQIcHUmIITlCS6a
         e61Gof24sdGMtsLl2Z93L9ZB5eE5zH8OKv5YrtRPNtv2W3bo7nzYzV3nmx4rcrZ9m3
         O2FyJhphl8a4w==
Date:   Thu, 13 Oct 2022 13:59:52 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-toolchains@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: gcc 5 & 6 & others already out of date?
Message-ID: <Y0gLyLbdOCetX5LN@sirena.org.uk>
References: <CAHmME9prBJHmo9Bw6aobuGLjtxLsjxKJ9wopOv5+BY6ZtuKaNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="48OdjAggKb0Ho9wZ"
Content-Disposition: inline
In-Reply-To: <CAHmME9prBJHmo9Bw6aobuGLjtxLsjxKJ9wopOv5+BY6ZtuKaNg@mail.gmail.com>
X-Cookie: Do you like "TENDER VITTLES"?
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--48OdjAggKb0Ho9wZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 12, 2022 at 07:36:40PM -0600, Jason A. Donenfeld wrote:

> But also, it's not just Rust. Clang support has been an incremental
> thing, and the kernel has dropped old Clang versions as they no longer
> make sense. Heck, the new KCFI implementation requires bleeding edge

I suspect that if clang starts being the default system compiler for one
of the distros with longer support windows we'll start treating it more
like GCC, right now clang is in the position where for the most part
people using clang are actively seeking it out and explicitly picking a
clang version rather than just trying to build the kernel with whatever
compiler they got by default.

> And then there's old trusty gcc. Gcc also improves according to a nice
> cadence, and we know people are using later gccs because nobody is
> catching the build errors from old gccs. So let's stop pretending we
> support old compilers. We clearly don't. Maybe some subset of code
> does, but by and large, I doubt many developers are actually daily
> driving gcc 5.1 and doing allyesconfig builds with it. Yes, many are
> rightfully cautious of gcc 12 and stick with gcc 11 still, and that's
> reasonable, but 11 or even 10 is still way larger than 5.1.

> The truth is, people tend to use more recent toolchains. And if Clang
> hasn't broken the will of the stranglers, then surely Rust will.

The expected users for old toolchains was always users doing something
like building a newer kernel on an old enterprise distro rather than
people actually developing anything AIUI.

> So, what are your thoughts on just abandoning this charade all
> together, and saying that we support the last 2 or 3 releases of a
> compiler (and related toolchain - binutils and such) at the time of

Two or three releases seems a bit ambitious, I'm sitting here in front
of a Debian stable system which probably has another year or so of being
the latest release left and it's sitting at GCC 10.2 with the latest
release of GCC being 12.2.  Probably also worth noting that GCC did a
9.5 release in May this year as it went out of their support window.

> the kernel's release, and admit that our C is a moving target, just as
> our Rust inevitably will be. Then we don't have to have these tortured
> conversations every few years about 4.9 or 5.1 or 6.3 or whatever
> enterprise [il-]logic has tended to dictate how things have worked
> until now.

> As usual, feel free to chase me off with pitchforks. I'm sure some
> RHEL folks hate this. But I think it's at least worth consideration.

I do think it would be helpful to track where the choices of baseline
versions are coming from, if nothing else that'd probably make the
conversations about upgrading them easier even if we don't actually bump
them until we run into trouble.

A quick look suggests that RHEL 7 is at GCC 4.8 (so running into trouble
anyway), RHEL 8 at 8.x, SLES looks like it makes newer compilers
available even for the old releases (eg, there's GCCs up to 10 available
for SLES 12 AFAICT).  Ubuntu 16.04 does seem to use GCC 5 but it's on
extended security support at this point, their 18.04 is at GCC 7.4 from
the looks of it.

--48OdjAggKb0Ho9wZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNIC8cACgkQJNaLcl1U
h9BCgAf6A/5E2Ut+JiGZPdR9DndRFlci8g8GrHdWfZDlttljHH5HSNF7ilQOpsCC
Bm39Np/tfXRXbu4dfoiF7hRNj2zPj2gV2hkWCWjZ/G9OznYMo1QgQDdyi+2LPsnR
LDkXm5x4glf85lCvNGZZNaHoIg+8kePe6el9EavPTa+PUemZ2fAcG1p5va6IM8sR
JiJarlReyfYIeeUukbDlm4jCt+cjLZjCr9sDtnBpLPorABOH84Nb2lTAmmFYcwAs
ECQt/lJPlZnus15TmNPAadU3jVJHzE3HDlwRJq6a14PRT2hevExVTUUErBGz0bh5
yKiP+H4wEoCTgdyjQnvSs0aq+pPyxw==
=6G3B
-----END PGP SIGNATURE-----

--48OdjAggKb0Ho9wZ--
