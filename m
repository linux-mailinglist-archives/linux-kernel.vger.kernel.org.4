Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFBA6C9D98
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 10:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232764AbjC0IWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 04:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232734AbjC0IWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 04:22:24 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A042D6B;
        Mon, 27 Mar 2023 01:22:22 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PlQls3RYZz4x5c;
        Mon, 27 Mar 2023 19:22:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1679905337;
        bh=QZ92Xq2MTXb8l3wKYWLZgOARkQSr76EtRktGEwyrqcU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dAleufuXj0aPeyeMYGi6lhfVY3b1qrn0jGo14l8Fokfrm7GslXdggUPW6bWWAdBKB
         5eu6NIo7thTbg+r3JUZhXH8pb5jePr+Z6NQSLWCnK8zxSeq0zw2oXTp4LTSHSSJd/+
         dFRG+9PzG/lIsQB3u+qfdANUE0oVIbGSR2l0JJIkjPJMWXiLZUpvuBjHsPRPY1AinH
         JLK3Zs6HublIUlFqB1JCIKFBsZaQefZuQ5pwoqqYc9DlZDqWFAke2jV9eFYkH8o0Vk
         udRYjcfNY4QThveClIPPNrcJ15OVE0fZD39OI3gED+a+DdDh1VFza0LXRIylThlJK6
         w9D0joYZZkmzA==
Date:   Mon, 27 Mar 2023 19:22:15 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the driver-core tree
Message-ID: <20230327192215.060fd858@canb.auug.org.au>
In-Reply-To: <ZCFG1hUpsoB9acpi@kroah.com>
References: <20230327154655.58dd627d@canb.auug.org.au>
        <ZCFG1hUpsoB9acpi@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/O1aJsqeruCAH7a+/OaeWd2u";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/O1aJsqeruCAH7a+/OaeWd2u
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi All,

On Mon, 27 Mar 2023 09:33:42 +0200 Greg KH <greg@kroah.com> wrote:
>
> Patch is correct, thank you.

Thanks for checking.

> s390 developers, if you have a persistent tag/branch, I can suck this
> into the driver core tree and apply this fixup there so that you don't
> have to deal with any merge issues for 6.4-rc1 if you want.  Or I can
> provide one for you if you need/want that instead.  Or we can just leave
> it alone and deal with it during the 6.4-rc1 merge window, your choice.

Or (it being pretty trivial) you could both just let Linus know when
you send your merge requests ...

--=20
Cheers,
Stephen Rothwell

--Sig_/O1aJsqeruCAH7a+/OaeWd2u
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQhUjcACgkQAVBC80lX
0Gw37ggAmLC1R7WwOUGTwsn3b6N+vPYmT5zSmi1ZjPMHwKTGJdzbCeAvC/SwDY7v
hsQp+QZIX4KqGgcGEHQNK0KHwiO1C826iMprhSdbgy3oZsUirgNcapjAfNSUvTaQ
gQEEyIvDhyVSU5mAw74h16qBQWtr2MOepKa8xihzAkH4EX01PlFqJhaWm+oZdQxq
bobxJh60EOXitl5bfkzL048muiYm1B9+m3Vfpty82K1YyX1VD+prnqe1jsqKGVB1
46A3d1o3jeLGzFvT6MmUF1X3114Rw6eiAU+6K56Y/KIhPEheHwb0yH9zlxMe2okb
v/kRlPA+a6n0VbbRwUySpLbj7ddm+Q==
=jorR
-----END PGP SIGNATURE-----

--Sig_/O1aJsqeruCAH7a+/OaeWd2u--
