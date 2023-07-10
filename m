Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9D7A74E1A0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 01:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbjGJXAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 19:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjGJXAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 19:00:13 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B8DE5;
        Mon, 10 Jul 2023 16:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1689030004;
        bh=rrskI+q7R9a0pNB+HSclMU73QhH+3YqzYp6kWphE1ik=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JnKoUUWzsgMaZ6pcHdm56iUmTEtOTjOd+FKt7RnzF7fdbYpO+y2zipsSPlw30ARRi
         UcgIdpWxQh9cB5w2Mnsg2KUzZBCbxOgytTuSSxcE61Q099wSDaVuhEm+8bZ0E/OaR0
         FbcQdTzp0jyQYxjH8eKlQ0fn/jdpU9Sn1NZyh5xDg73fJdWJJaNzLtuH+aR+i3Yz0i
         QZo4p46O5DeL+WgS9Q5BP8HPcxgLSf69a7qzXPx+YkBk2wXGRztTKAKCbCMS6FhDbp
         IUBXCZGBGaFKS4swVUYn5ZokvYMwxviZAmFMZzLITPSlhE0Uk3eZK59BGjix6aghFK
         W+aCqtcnK5eMg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4R0KGB2fDpz4wbP;
        Tue, 11 Jul 2023 09:00:02 +1000 (AEST)
Date:   Tue, 11 Jul 2023 08:59:49 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Gabriel Krisman Bertazi <krisman@suse.de>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Leo Li <leoyang.li@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Miguel Ojeda <ojeda@kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Vineet Gupta <vgupta@kernel.org>,
        NetFilter <netfilter-devel@vger.kernel.org>
Subject: Re: linux-next: branches to be removed
Message-ID: <20230711085949.609305ef@canb.auug.org.au>
In-Reply-To: <87wmz7rej3.fsf@suse.de>
References: <20230710172602.05d32c03@canb.auug.org.au>
        <87wmz7rej3.fsf@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Tin3KwabZpDiyIGKKbVOCwG";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Tin3KwabZpDiyIGKKbVOCwG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Gabriel,

On Mon, 10 Jul 2023 11:07:28 -0400 Gabriel Krisman Bertazi <krisman@suse.de=
> wrote:
>
> Stephen Rothwell <sfr@canb.auug.org.au> writes:
>=20
> > unicode			2022-04-28 18:19:09 -0400
> >   git://git.kernel.org/pub/scm/linux/kernel/git/krisman/unicode.git    =
   for-next
> >
> > These branches are all empty except the last which just contains a
> > commit that is the same patch of a commit in Linus' tree. =20
>=20
> Please, keep it.  It is not a busy area for development, but we I'm
> looking into a unicode version update soon that will go through
> this tree.

I have added it back.  You might consider rebasing it onto v6.5-rc1 and
I think you will find that its only commit will disappear.

--=20
Cheers,
Stephen Rothwell

--Sig_/Tin3KwabZpDiyIGKKbVOCwG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSsjWUACgkQAVBC80lX
0Gyypwf/awP9ZYx0yIhigLEMkjiUinM3v5ZG9Q5lTIamXfL2qrWE7BlI38C6Gjl/
dX/gfR/aCBIBQOB+eTmtX2fhTJhe0SlhPJHzIdwDToPGzkCBoCS62pP3zSEKZYLO
NkehE1xdGYmtjiKUd4Zvx3yTvYIkAnnE9D1t7MmWj2C0EsQmmetNYzUvE0RtGdG7
Ak5DFBVO7q50ifgH9wLbpUSHtcSJHYdxpF30SQBjKBUDjCXip5ET62v3ZUhovFrN
pyl3gckjS1PyXjVrsAL2olIsU1HzlRKnZYFfBTDNJv/cvzbooxteHK2eVXzxKEKJ
yTYr6O7qpU8s29aqnlLg+umu7+Btdw==
=Zyb6
-----END PGP SIGNATURE-----

--Sig_/Tin3KwabZpDiyIGKKbVOCwG--
