Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF04D678C01
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 00:25:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbjAWXZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 18:25:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231724AbjAWXZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 18:25:43 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60788DBF2;
        Mon, 23 Jan 2023 15:25:38 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P15nD4BF3z4y0R;
        Tue, 24 Jan 2023 10:25:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1674516337;
        bh=CztlpSEuNlVjlCk03pfAhw2cdMuMnKsr+faxoIuwDEg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rcWWkGABYcr9x06yRENx+ISZqlYo3O2NHykOEDyw6sfZCtl79KKFeHvjwUTP4zZV+
         0BUx+0zC0ROZptmMMIlA6GLmBY3lBtH5nmxSCi0QgPuuGQ2ilEkUhvgmIGyL+33jht
         8/SEqUA2+jchBzF7rmYfNaBkO7vP+sPAO4EonuRHcdLSR8NpFX+1QDsWssf1BTb62n
         wosve77B04qHbH/OKvq950sHVRrN692pNHm6P59gZM9RHZpTYPjgi5roIqfAPpn6we
         r0NTZzBeJ0cSm99UHHoOh01wzHbKE8cmtoiv9JgZn/RvRTE+TstduqCf0nJTiRa1nt
         dBnkBtWvUNoVg==
Date:   Tue, 24 Jan 2023 10:25:35 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Christian Brauner <christian@brauner.io>,
        Seth Forshee <sforshee@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the zonefs tree with the
 vfs-idmapping tree
Message-ID: <20230124102535.1e21a533@canb.auug.org.au>
In-Reply-To: <1631b427-9efd-cd26-5dbc-0143097f859b@opensource.wdc.com>
References: <20230124085951.59eb8da3@canb.auug.org.au>
        <1631b427-9efd-cd26-5dbc-0143097f859b@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/GtDDnJowhG8fN4yNaXopEnV";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/GtDDnJowhG8fN4yNaXopEnV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Damien,

On Tue, 24 Jan 2023 07:31:18 +0900 Damien Le Moal <damien.lemoal@opensource=
.wdc.com> wrote:
>
> Thanks for that. Do you want me to rebase my for-6.3/for-next branch on
> these patches ? I need to retest everything anyway, so I might as well do
> that.

You can only rebase on top of the vfs-idmapping tree if you get a
guarantee that it is immutable.  In any case, it may be better to merge
(an immutable subset) of the vfs-idmapping tree (and fix up the
conflicts) rather than rebasing on top of it.

Alternatively, just leave the fix up to Linus (but mention it to him
when you send your pull requests).
--=20
Cheers,
Stephen Rothwell

--Sig_/GtDDnJowhG8fN4yNaXopEnV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPPF28ACgkQAVBC80lX
0GyZvAf/ZS2Lytc34PCFjjD1bOjOsR40tOvDtk8J3JwYqczH/+HiK0YqLy2ByjVO
FB4sPFRU4+w8ROmyX/nUKYQAiVg/MIrOMSPaKu+kXiCSY3CaDz1Fhu8HQ0o1a+Lh
+z3TEe/c/MFywoaevk6u9OrmqwDj/BHxLlw0fLJcQYv0aWFbmn6MvQJ/G0SDGNSK
AAsy12faGicP7G4V2exrHXeY1W7BLYAuT4qy0SkbZxPrUiPZhWECYCIe0QQ+XC/w
dGJrRcQ+CEw7dAR93gLttJJWVOMdXR8yerpdKL1gNsUbq3ePtS8OnhyrtO9DlXsi
3WBxlyPYLUlGnBKeSJsVIv9rAGSgWw==
=ONWF
-----END PGP SIGNATURE-----

--Sig_/GtDDnJowhG8fN4yNaXopEnV--
