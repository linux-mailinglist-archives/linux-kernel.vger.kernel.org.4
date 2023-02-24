Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64FD56A232A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 21:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjBXUhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 15:37:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjBXUhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 15:37:04 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D2886DD87;
        Fri, 24 Feb 2023 12:37:02 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PNhWr3Rdmz4x7s;
        Sat, 25 Feb 2023 07:36:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1677271016;
        bh=Qtahv+9VfX9TdFH4Xt98/MJLI+VJHGXy0MK+YvmkWYU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XMv7H3h0V/b0in1sIH4ekNKfXIWbd+0cbuth1GO3XEg/1LelfW9xUGJn4giobGt3p
         I6thaKZB41PhZe7fLM8QPe7IROICyHgpmimuUmOR2AIIGNEuYPYgT85squ80kdIbO/
         A9FtTwovBqAKEKY0yTrLuaj9ffsFJPvDWzOobXoideNNX3TfAbZTAnghMZoVTuW2Ds
         y26c2M/3Ncyc0lldKBdiqtFADnKyE/oiZdBiT7kGkqjFMIY58LCXgn85K5Qeuldoxm
         5pAhzHEZ6bG1EnVzUshHiW2xB9AhRkR46C5q3q67t5yHM1wfna2X8haPWpEmK7ov1m
         hBhSO76DyabYg==
Date:   Sat, 25 Feb 2023 07:36:54 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jan Kara <jack@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the mm tree
Message-ID: <20230225073654.7f481aa9@canb.auug.org.au>
In-Reply-To: <CAHk-=wiCrVFpwP6h=US7K=T=aYQuHCRc06cy8K8Y5upTQfQsAQ@mail.gmail.com>
References: <20230127165912.0e4a7b66@canb.auug.org.au>
        <20230127131142.yrlel7df3yvp56rx@quack3>
        <20230201084741.0ca1c414@canb.auug.org.au>
        <20230224154010.17a5b949@canb.auug.org.au>
        <CAHk-=wiCrVFpwP6h=US7K=T=aYQuHCRc06cy8K8Y5upTQfQsAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/30c506zbNKrpAL7GezBkGi5";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/30c506zbNKrpAL7GezBkGi5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Linus,

On Thu, 23 Feb 2023 22:01:25 -0800 Linus Torvalds <torvalds@linux-foundatio=
n.org> wrote:
>
> End result: I explicitly left it in its minimal form, because I think
> anything else is a "future endeavor". The udf code only works with
> page-sized folios, and pretending anything else (using
> "folio_unlock()" etc) would be just that - pretending

OK, thanks.

--=20
Cheers,
Stephen Rothwell

--Sig_/30c506zbNKrpAL7GezBkGi5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmP5H+cACgkQAVBC80lX
0Gz2nwf/X43KfdgdU77SCjv98jS82mY6I3iZKI4F33ZRRL3EBehTi5/FwAsQjQaJ
a7Py7sO7veWLVJwT19BFE+WOGwTAWiAwhSirARF8BVGpv1O244AS05s7lPEVu1fw
+sY6/+wzQtGPtNq+IB3J/dSnA5jJWPRAnIPVrzdCpVVI2j1IGlTouCm0yvpabCPG
i09/y8fwLwCJDPwveLaGIZ1TahRWP+9lSH2oc+hXsjVVE49bvYf6Lcjuk/rDr9QR
MxZldloLCAPn1QwqlVTo7RO4SM1siAbVrXPzIODqgIWyh9FhPlUAlCk4ADvNRjBK
WlMDy2zacnjI1mWIm2spQAKoPhB6iA==
=GAO2
-----END PGP SIGNATURE-----

--Sig_/30c506zbNKrpAL7GezBkGi5--
