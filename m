Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE33741CDC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 02:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbjF2AUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 20:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232174AbjF2AT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 20:19:57 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680F51FFA
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 17:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1687997990;
        bh=UAvBoHJxAhhI6VZL1p6GQ890uUwi0Zaws3oDsYlxk0U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rkd/gQbSGO3o/VS8Tf0o5tjHTjK3MwpQzKuTjOFMzbGk1FjNt6IV4oXCFu16wEVmM
         AuMJnUMQaqnQUYG22n8JE+SIvepPtJwoZlEaOKekqtmrGbIWj0gzGcBInV9PkrITxz
         zCQ7V69gzpYc4IP1AJ3OctTK+mJAN4hSJrXq6poCAyDDrR6fRDZcGPae86cHwiZRCO
         Sk0LBxgdV3YHo29BIbyVvXeZdn4Zkp6VWahkUI3exljy363Y7l6MXma/paqlmnE4K8
         GEvDULwo4cWtYW5vcTBLruDRfKd/HgYDB8+WV5ovF3UOAbHIuVrFrBT0ZIJWXrj8Hk
         AktZHn0Ke6NQw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Qrzbn5zTpz4wbP;
        Thu, 29 Jun 2023 10:19:49 +1000 (AEST)
Date:   Thu, 29 Jun 2023 10:19:48 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: Reunbreak the MEM_ENCRYPT build
Message-ID: <20230629101948.2bc3fa84@canb.auug.org.au>
In-Reply-To: <CAHk-=wghER2OsCc+H2USU+nmh72QJ-kqTmaHq=YFd=0xaivubw@mail.gmail.com>
References: <ZJyECvfrOWhKJj4t@casper.infradead.org>
        <CAHk-=wghER2OsCc+H2USU+nmh72QJ-kqTmaHq=YFd=0xaivubw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/AvObYWVibh_dVuUE25CaKLe";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/AvObYWVibh_dVuUE25CaKLe
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Linus,

On Wed, 28 Jun 2023 12:52:24 -0700 Linus Torvalds <torvalds@linux-foundatio=
n.org> wrote:
>
> On Wed, 28 Jun 2023 at 12:03, Matthew Wilcox <willy@infradead.org> wrote:
> >
> > Probably this is the wrong fix. =20
>=20
> No, that looks like the obviously correct fix, I just don't see how we
> all missed that stale declaration.
>=20
> I guess we all had X86_MEM_ENCRYPT enabled, which hides the problem.
> And other architectures wouldn't have had the issue.

https://lore.kernel.org/all/20230620145357.12d6b23f@canb.auug.org.au/

:-(
--=20
Cheers,
Stephen Rothwell

--Sig_/AvObYWVibh_dVuUE25CaKLe
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmScziQACgkQAVBC80lX
0GzW2wf9HZ7cINm6fG1xSFAVpjJqLeTSrLlWQwGY/N7f1mdSmm0unWjssI11K9Mp
5JetVQFc+miiU8jT+GHi1JeJDzFp7TIzT+DF0VWlIor0iGxUNzC0RM3FqhLBgmMM
jstzmsStzFrgRI9sgRT38NrOnkSIXQiYvnO5i7845iizbo5UmlU0e+/CAFj6+JEC
/HDWBK8qEolwkCGsjvak1EMo0QvXwBlIC0OrloroCuTiQQ91lUXCIPj1IiN/SKRt
NR3UcJx+44oliNhiY3iZE1p8icCvkq2oMdyKyleeNczUW9IuAlHUKZBdif5+Dz2v
3/IV7jUET0/hvCKnKGGOn54iDOZIdw==
=JSwi
-----END PGP SIGNATURE-----

--Sig_/AvObYWVibh_dVuUE25CaKLe--
