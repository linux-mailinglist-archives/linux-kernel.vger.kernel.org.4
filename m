Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAB79642267
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 05:55:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbiLEEzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 23:55:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231371AbiLEEzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 23:55:11 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22306E0BF;
        Sun,  4 Dec 2022 20:55:09 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NQWSW4THHz4x1V;
        Mon,  5 Dec 2022 15:55:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1670216107;
        bh=zQ8TiCwyeqRDC/ypKGA5ig/pOYTkDt+KNcA+WTAkaF0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=erlp6bxteAHyuXsd3fTeQe4fx3LEkd9QerqnAzLO6ShP+6RIMXMp7Yzxx+jz7Fqoc
         M9hvQ0bdhsF980CuOxzRGryrvJBBViYLva8KcNR2gMGkaE4WEE22gyc7y3qsee5aT3
         g2kJKBlweBzo708eYbXgCHryEnJeBtGJ50uWkgas6hm1M6koohybVerj4J8Nb22L9a
         SPbeCGK4BcFuJI/ktSBAcrqFPSiecUfe28awmkdBHult62RZYvAlrlv1/wZcYYqA2Y
         zVfnbRJMC98pVRifiFUI7CYwKmW2BiwaRS5JpnzVKJVqv/K7P8D60wu9vDD3folC0S
         uRTOX/Z+6xQ4g==
Date:   Mon, 5 Dec 2022 15:55:06 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Christian Schoenebeck <linux_oss@crudebyte.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the v9fs tree
Message-ID: <20221205155506.47ba27fc@canb.auug.org.au>
In-Reply-To: <Y41vKkaH9tvRXCfv@codewreck.org>
References: <20221205150316.6fac25f2@canb.auug.org.au>
        <Y41vKkaH9tvRXCfv@codewreck.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/eiP2cSB.ubD.Cwp6uIjxVIO";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/eiP2cSB.ubD.Cwp6uIjxVIO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Dominique,

On Mon, 5 Dec 2022 13:10:18 +0900 Dominique Martinet <asmadeus@codewreck.or=
g> wrote:
>
> I've amended the bad commit with this and added a note to the patch
> thanking you (not quite sure how to express that with xx-by: like tags,
> it's just words -- if you care and have a suggestion feel free)

Looks good to me.

--=20
Cheers,
Stephen Rothwell

--Sig_/eiP2cSB.ubD.Cwp6uIjxVIO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmONeaoACgkQAVBC80lX
0Gzscwf/WRSzofM+94QqtMzU7LZjLnquZAXjWJl6NuSOetHeVYWMtj1mAI0C6df7
qg6pOo2S/erAwgfFbUeBhZNiyPMf8clAs3xRNiIC+eTlW6i4tzilz0puJAlCjbco
vnGhnPty8UqecCMV6u6R+StbSac2H+h0OB4VgFtIotz0rV7ww1DdbyjXxKBUUh/3
Irs0r2dqTa1+cmkIYyn/U/NK4QfTAzTI7wpGmZ6II4nSDSRymZzWNv+YW3bfoGeS
g/aR0c+cjpLk3/SoQzqMo033iQGhJwc4L48J3bAIisL7JCJiDCp12Wk2k1IP0Hwc
1+QailTMl9UKNZKbCSK76EhkfkXj7g==
=Fpw/
-----END PGP SIGNATURE-----

--Sig_/eiP2cSB.ubD.Cwp6uIjxVIO--
