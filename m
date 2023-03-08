Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBFA76B1474
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 22:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjCHVsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 16:48:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjCHVsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 16:48:10 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E1324118;
        Wed,  8 Mar 2023 13:48:06 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PX5XK6GZCz4xD5;
        Thu,  9 Mar 2023 08:48:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1678312082;
        bh=96oXFZtdv5Ea+7TMA2QhUHPOMdIA3XHD6bbDCtrW9wk=;
        h=Date:From:To:Cc:Subject:From;
        b=KzgoLwoaA4X/ezQ7hKHtNQAbqvNYC2o7j/ik905GJUolZRmBAvY6ozzS1OJMsCqie
         qGkV0UdeMZSMaI+MQH1UEJN9tJZw2zMYRtsT4C0MwnfIMvGyJDaiO9tU3HIxkxFty2
         Wua87O1n2ACZ7mJ5nW1eCzIVZryx4hhrXxqI2rliQDgqtenvIcAZRAGZTU8Fd/2eC/
         S2CF2u2YE2wN5FVv/CiAUaYkpT0KthSjumoH1lowLzWmNqEpx+Z8OUdmyPeqNU1aM3
         OBgZJ9IeNSSKNaP9aJQosZZjjJqpHpz/kZrmWagD9TqHIvWRsdHYaxgoylsElnB8q9
         +HWiKulDgirPA==
Date:   Thu, 9 Mar 2023 08:48:00 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the file-locks tree
Message-ID: <20230309084800.58ec0343@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/OXDO3ixPnH/OUu0MpCCc/FU";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/OXDO3ixPnH/OUu0MpCCc/FU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  4cbb75d0fdc9 ("fs/locks: Remove redundant assignment to cmd")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/OXDO3ixPnH/OUu0MpCCc/FU
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQJApAACgkQAVBC80lX
0GwBnAf/Qzj3OBRGpWjnSAi91wjIh28FUF5BnvJRpie0p2K2YQrfF/feCLwxHgPs
LNUFV5gXhfhV2vH+0JAOEIK8HlZ7GphU93OgD37mYs1Jxab/mQ2HSIs1jOsVlPTB
Oz6TD+mMLbK9yfo3Dzn7LNvnbzhI8ua5HWsSHSed3OuHVVoRZFy6Gi1KFQqjquq3
lfF7XIJQqo2jiBdGjRW1ZO1BJFGy9Lkmpat+nB2qfOk+AqEdkPFvu2GESRR+5FFb
kDzgSFRWqBSXESTEpM0/Ev2bPJhJvtUT28TQv2qj45tlfJ89ObFvkhdnOu0ueRc5
0cAEYMP2H24jTecAH+cynIYsbhVWgg==
=xnp3
-----END PGP SIGNATURE-----

--Sig_/OXDO3ixPnH/OUu0MpCCc/FU--
