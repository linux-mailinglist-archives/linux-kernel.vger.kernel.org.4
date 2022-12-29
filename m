Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E29E4658D07
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 14:12:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbiL2NMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 08:12:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiL2NMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 08:12:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A211B1C9;
        Thu, 29 Dec 2022 05:12:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C33FC6173E;
        Thu, 29 Dec 2022 13:12:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B072AC433EF;
        Thu, 29 Dec 2022 13:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672319548;
        bh=SOp23ONE2ZS2Rwu9m1lYp6HK4zU0C88MNMwFM+Hhi14=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O4Y/ldkVSy4v8cK97cQWNnrWFPne4n6oRjzjryZAR1e07QBAbtgW/bc1tDIwBwCyj
         bYKa9urmBNddHNzuXcL5jIkqsLKvtU8Tgl2KFM5hT0nbPtnT5vtgwId/1jjlbYxV37
         nhHtMdU7uw9k7ud+xoeGgmZJWLak2rQRlR1spA5UOjucjtRnLQNvW2Bi/m29A2Cve2
         pKpxUBL5itg0jPn0LW/4INV3ViQfEiAJU6bsp5hbJ6ar3HySbEduxyuthrQZyf9JCR
         UiJHN5F3MQ0vtQEwUSrbvB+p9hu9XWQWt3K0Yk3NnPISy0jLc3oryZK2YfmXl9xdkH
         i0cOzkaQ9fDBQ==
Date:   Thu, 29 Dec 2022 13:13:04 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Conor Dooley <conor@kernel.org>
Cc:     corbet@lwn.net, Conor Dooley <conor.dooley@microchip.com>,
        konstantin@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] Documentation: process: Document suitability of
 Proton Mail for kernel development
Message-ID: <Y62SYKyhE+hPX5b9@sirena.org.uk>
References: <20221228000330.3971104-1-conor@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mVQiF8DEATNhfjPe"
Content-Disposition: inline
In-Reply-To: <20221228000330.3971104-1-conor@kernel.org>
X-Cookie: Ego sum ens omnipotens.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mVQiF8DEATNhfjPe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 28, 2022 at 12:03:31AM +0000, Conor Dooley wrote:

> +Proton Mail has a "feature" where it looks up keys using Web Key Directory
> +(WKD) and encrypts mail to any email recipients for which it finds a key.
> +Kernel.org publishes the WKD for all developers who have kernel.org accounts.
> +As a result, emails sent using Proton Mail to kernel.org addresses will be
> +encrypted.
> +Unfortunately, Proton Mail does not provide a mechanism to disable the
> +automatic encryption, viewing it as a privacy feature.

I'd perhaps add a note here that the reason the encryption is a
problem is that developers may not have their mail client set up
for easy and fluid operation with encrypted mail, making the
process of reading the mail needlessly difficult, or it may cause
some mail clients to encrypt replies to everyone including the
list which obviously won't work well.  But that's not essential,
either way

Reviewed-by: Mark Brown <broonie@kernel.org>

--mVQiF8DEATNhfjPe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmOtkl0ACgkQJNaLcl1U
h9C/Mgf9HWBv9oSmF0btC9VmOlYBKv0fDFxP2g1iH1GI0AK0Is7zsACbQM79cDzM
FwqELSmo76/2LmKILPKEQ9YDNZk3ooacH5Lrt8aVyv1SbNc/2q0QK+MZl19+onLq
YX265KhTyDRh2bkJrsETubT2OKWqCUI3AlDn4QzL/raerOVvY1QXCabeVL3TyhaL
HRP4I01mp3fG+kj5NzA2CUuP424wBENdvvtYmJaDK8s5CwQXfXQZA8aNKB8lVq3q
3vQWWKbh/7Yg1RRVibcAjVGFERaHU1AaUUYjHq+083I6qn8Xkc2lWr3LZE5QOpgg
SbU2VCzdWuAgoARcVIAIGTtM5cY4zA==
=/UTQ
-----END PGP SIGNATURE-----

--mVQiF8DEATNhfjPe--
