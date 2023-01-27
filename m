Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BAB767DD1E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 06:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbjA0F3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 00:29:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjA0F3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 00:29:10 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D086D5F0;
        Thu, 26 Jan 2023 21:29:08 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P35jH1rnkz4xG5;
        Fri, 27 Jan 2023 16:29:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1674797347;
        bh=KJ9MHTMV2KKQDgHaczlwRKAmAdScjCQWAXlWKFy/CB4=;
        h=Date:From:To:Cc:Subject:From;
        b=XRE8LGyqUzLV7S+DZD0hDEexE/r9+3ZzkOcBppjREbDiyHJqzoe6AvwGd/u21n5Gw
         0IFPVNl8eJhijIkwrUjECH125ACuuBv2BR2UgpYzqgp5dk3RIvEn+T7OmvSSfZDz6k
         m0bZzDdv6KQa7ehQHXH2kTVTq+LYGT+N4F0jkKPyTL+1OszoG9jIEJUfETC9/2o+MR
         2KRxUzglzj1dcAnGSAz2DTTrG8ZSj19QY3SeReFdvsJUtb1/52Kl5PjOYqIkWabUBz
         +z+IJ04pCQe1uaVky1ughXQgvcMcAEUSjL9eLs4HznVpor2KgBRw5rsPA2ZgVV2L5a
         veEX3l27xYiEw==
Date:   Fri, 27 Jan 2023 16:29:06 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Suren Baghdasaryan <surenb@google.com>
Subject: linux-next: manual merge of the mm tree with the v4l-dvb-next tree
Message-ID: <20230127162906.77e540fa@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/2op68/E0gMuC7lTtwZMBh3E";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/2op68/E0gMuC7lTtwZMBh3E
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the mm tree got a conflict in:

  drivers/staging/media/deprecated/stkwebcam/stk-webcam.c

between commit:

  aa68bf90a628 ("media: stkwebcam: remove deprecated driver")

from the v4l-dvb-next tree and commit:

  6fe0afd07701 ("mm: replace vma->vm_flags direct modifications with modifi=
er calls")

from the mm tree.

I fixed it up (I just removed the file) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.



--=20
Cheers,
Stephen Rothwell

--Sig_/2op68/E0gMuC7lTtwZMBh3E
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPTYSIACgkQAVBC80lX
0GzhpAf+OXwHJRHbzWUs1qQyeIgdG+RFUeP8jsKyckcmk9qA1cW6qvonLaC5/mPp
VGYpa1uM8yVTW66aXzztXOgz869WuCrgCSICOF6VeTvqw42Fg/ylg/D4uNcXb5al
rc82KikR+PnZIDVlfJtM2ONC7ytYfOnguENDy00j9Szy48fIv9Stia2onm4d3ihE
KNj7EAnr2wmkaFpbNjdmeyb185dcgWpEAKuJpq6I59DlFnNs0qvGWzH9cQGYBOkd
1/HW04hqHsXh1IHEBEswZFl57XV1dC66xLV4ezcoih6lJ062P0iN/9RnP7I+hUTV
qp8+4ArHVP59MrZAExN3l/b54IgdRA==
=IVG9
-----END PGP SIGNATURE-----

--Sig_/2op68/E0gMuC7lTtwZMBh3E--
