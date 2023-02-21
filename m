Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9340569DAC2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 07:50:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233314AbjBUGu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 01:50:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232742AbjBUGu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 01:50:26 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF27510421;
        Mon, 20 Feb 2023 22:50:24 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PLVKV4vcJz4x7v;
        Tue, 21 Feb 2023 17:50:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1676962223;
        bh=mXBErY1n3md8yBkd1OQ7xUhEr10TWwyBynDXyCk6IMI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DHaMQBRu/kSIavluDzoT0DxHBY0WOtKwPu3iHZr5p8P1wA0PR+RXN/Xr0FIJyNK2n
         fU0lpWuFbtf8YO2KH4kGrOMJCChefaUn27O13lvH5r3ZljsmndNLclwGiGO6d8Kv4G
         0fxHVpegp7Mysi5tfMSYGIYXFOtHJZi+GsP/vRNCcQVwHqs7/BK69+DMXFUWsjq4pM
         zaQ8EA62+8hwDJ+GAiGykCKC3IyaH3weq/mrSrHSQifxGjkT7OkCAq4uxiCAIIXlZ4
         EpSppnTUUYb9t3SodY1NTQZNQbG8LM+E99aiAX9sC5C41JKkmk5bKfp/72dFP4y/uS
         LEwsyPpoFkyfQ==
Date:   Tue, 21 Feb 2023 17:50:21 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steve French <smfrench@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Steve French <stfrench@microsoft.com>,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: Re: linux-next: manual merge of the mm-stable tree with the cifs
 tree
Message-ID: <20230221175021.76bb2301@canb.auug.org.au>
In-Reply-To: <CAH2r5ms6J_hWmLaLA=pCQz1oez3bO07ahvr6mdCbYzQHrNVNkA@mail.gmail.com>
References: <20230220152933.1ab8fa4a@canb.auug.org.au>
        <Y/N8hVWeR3AjssUC@casper.infradead.org>
        <20230220190157.3b43b9a7@canb.auug.org.au>
        <CAH2r5ms6J_hWmLaLA=pCQz1oez3bO07ahvr6mdCbYzQHrNVNkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/smEwGU=AnBx_Fyplh7lH/A.";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/smEwGU=AnBx_Fyplh7lH/A.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Steve,

On Mon, 20 Feb 2023 15:00:50 -0600 Steve French <smfrench@gmail.com> wrote:
>
> I don't think it was so much that they were added late (most were
> reviewed over multiple week period) - just moved trees to make it
> easier a week ago.  The changes David etc. have been making recently
> to the series seemed fairly small.

But they only turned up in linux-next over the weekend :-(  So we are
only now finding out how they conflict badly with code that has been
published in the mm tree for weeks.  So the combination has not been
tested at all.  So it is really not ready to go into Linus' tree, right?

I am still using the cifs tree from next-20230217 - head commit

  e18f461adf10 ("cifs: Fix uninitialized memory reads for oparms.mode")

because I don't know enough about the folio changes and the cifs
changes to merge them.
--=20
Cheers,
Stephen Rothwell

--Sig_/smEwGU=AnBx_Fyplh7lH/A.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmP0aa0ACgkQAVBC80lX
0GwVKAf/VDbAZrvuL6B4uaQHBuUNR1OPnJWAwAJ/ZKw2EmsDb4nifmeMdyCooU8n
pVoGxR08i3mX71D+QAWakA4zu33rPsuoGsktcXdo48dfIH46PzkUh+/MMipRqTNc
mP2UNsQqF8ppi4pAOnD4wLEx8QOzM1L7xAPiOoMLemqtdJWsIsvN0yCUiwJOZHZt
S1dcT+1ovBNTeUGVflE6eMDhLx5Yo7l44h3CDIM4TU8+sD1YkNwXE8x3DEk6TK9Z
G3JS93JGATN86ueRG0unX2RKA19Ek5FnnALKBZToi4ExQzMgsezeid4t/NsPIwhf
OvEmBzKGvNpkqrGTxalPcLJwmgK1Rw==
=JA4/
-----END PGP SIGNATURE-----

--Sig_/smEwGU=AnBx_Fyplh7lH/A.--
