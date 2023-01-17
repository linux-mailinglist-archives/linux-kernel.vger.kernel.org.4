Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6F166D3B5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 01:52:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233784AbjAQAwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 19:52:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232403AbjAQAwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 19:52:33 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF632193E9;
        Mon, 16 Jan 2023 16:52:30 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Nwr2j3Xj3z4xMx;
        Tue, 17 Jan 2023 11:52:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1673916749;
        bh=zwJsN4C7SRt/yNTCaKnKqjiDCGaGl0JOSRHoSJSLim8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dRJHwMFOEd6Odz5KN4TmlmMHwX3cBpGm3oYlfLn3IakD+h0boX4RGQfMQ19dFWybk
         ffjlMCPw+rPm6/1X4bD6bQlQkfRcP0G09Uu2TtzJwWTbSPoCM6GzQOfJugcdPo2UKH
         vzYPBRZK5+vErzBwV8iT/e9IcTZBW+vaeGz8T3nQ3BpHRsrMdovkhBm4RZluVk3lgF
         QnV9s5WhP8KJa5IDUYGjsYnCQOW+02qQPMGQFRRTsd4k//zH6uMW2IpK4HFAuv7DeN
         ISOhrLeAgMPMkrOOcWCtGgHDQ32hcm+2h6Vc00GlwuqIrs0uq7GPWmGMReJ3dKULUm
         1DoOaNYUY6qQg==
Date:   Tue, 17 Jan 2023 11:52:28 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the nfsd tree
Message-ID: <20230117115228.13b55d07@canb.auug.org.au>
In-Reply-To: <F7CFC18D-6AAC-4DAD-AA43-5C718FC1100E@oracle.com>
References: <20230113101326.09b1250e@canb.auug.org.au>
        <53DEC27F-0AAC-4EFA-AB6E-0B5D44AACFB9@oracle.com>
        <F7CFC18D-6AAC-4DAD-AA43-5C718FC1100E@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/QnLLWpFkv.URuGoBoGtZNS8";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/QnLLWpFkv.URuGoBoGtZNS8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Chuck,

On Mon, 16 Jan 2023 14:33:06 +0000 Chuck Lever III <chuck.lever@oracle.com>=
 wrote:
>
> Sorry, I wasn't clear. I need nfsd's for-rc to be picked
> up and merged into linux-next before I send a PR.
>=20
> I've trimmed for-next to temporarily remove the duplicate
> commit, so you should now be able to continue merging both
> into linux-next without an issue.

I am not sure what you mean.  Your for-rc branch has been in linux-next
for a long time and the current version (SHA 7c24fa225081) was merged
last Friday.

For clarity, the cel-fixes tree and the nfsd tree are both branches of
git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux - the for-rc
and for-next branches respectively.

Maybe I should rename cel-fixes to be nfsd-fixes?
--=20
Cheers,
Stephen Rothwell

--Sig_/QnLLWpFkv.URuGoBoGtZNS8
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPF8UwACgkQAVBC80lX
0GwBdQf/XWCEMWBiQMh2H4Ed35fhnVlX887Lr3XE8c3fHNA9hVjlCYdSzPyFI+1L
fjPxJUitovvkXwLm9U7iRYtFBvQKIpWfahVLBxVViFXlWrPzjawEjbRee7OvoAgu
EbaRjTR3YfGfgjEfdQbYQQOu2R3bjgTPuWeWtae1AyrHkCUcrmb2S8RxTfTo+CLm
ULXAor/sQ0qzyuGGAyzHU3vqym4YlvWTD+xGyAn6WkUDdT8fyoT8YgnI2wDHEfhz
EeGXCG+yvoNkEwcPDZJCx8e/bNtJKLWRPuORcd27J8fbgJdT5DENpmiI0jF/Cjy4
xzfH1qRn1BFG+ZNlfpNW8NbAuTl53g==
=No8n
-----END PGP SIGNATURE-----

--Sig_/QnLLWpFkv.URuGoBoGtZNS8--
