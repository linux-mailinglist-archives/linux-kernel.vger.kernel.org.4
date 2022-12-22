Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABD5865417A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 14:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiLVNCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 08:02:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235247AbiLVNCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 08:02:17 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50CC15F07;
        Thu, 22 Dec 2022 05:02:15 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d7so1937129pll.9;
        Thu, 22 Dec 2022 05:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=auxgNS73v4EHqFSgSnnjf0lDLMSqK0khCzQowlCeFIk=;
        b=BMdzmQBOpe7KmciPm+2KUuwQgtEVV1dpMXanzO7UUOc2Gsng7oqIrc0Li84X6s8tep
         t5NkSSe2ygl6n+WiHYVBCZL8SuV6T1o03KDSzA3IP78C1QpX7y3USEoBwb7BJTkOu9Ik
         /e4hfNKOGbMmDr8BFa2lHfNavnfd8v45EIka9pDd+BntriwuXAk2EBqcmDdDlD7F3SlT
         /vGEHPfN4sjc+RkLe33QW8a45sbEBtGsY9qdYJOz2XXgw288em/efq/aIyeH9U/n9iYk
         uHzmzv6QW196LzQDOlIcV6VRN8br1Yq9CzSFUZFxAqBxtBkOLnh1fn9YETBbGSAsKjbz
         83pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=auxgNS73v4EHqFSgSnnjf0lDLMSqK0khCzQowlCeFIk=;
        b=ob907MFj7jhJv1t7zvxDCOI27WvV1kCMD5L+7NHYz242DCij4++0hq0TuVy4DnOj23
         iMumYN6w9bgP7toH24qbzIqL19UfyRVkwJx5/tMrsMCgGW9gIlRjJUcDfkSlPrk8kNyP
         qh8ffbgYHHHjNk3jVeDkP+FjxEPs16ZyZJkQKdnEPJ0SllBZjEPARsIyQIs2P0Tqc5sE
         ISDIsMMx0irMcOy3yN+LrBO5kfMxZ3oQkiTCV4C4S2KYLUJZQTcYjC6mqT2Yd8Bwib6n
         26+QMv7nshNDTCp8k/tBsWymeOSatH/P/VVstaHxMSRfEIN+/J254UvdPy/2mpsu/4pA
         LPgQ==
X-Gm-Message-State: AFqh2kpdKjrTvbkMGg6d3XCmzysn4woD7sHheJW9qneLgYEIOpX1yE1h
        pGzTyHgirjVLoPZgbFK4wcartsngK6U=
X-Google-Smtp-Source: AMrXdXu1RovjbcnuVE1uB57rd8TVUhZ5TL0fh17WdyTJCIb45Cc9FkqebWZvneeedVEEJsAdSbzoGw==
X-Received: by 2002:a17:902:7042:b0:189:6a5a:7289 with SMTP id h2-20020a170902704200b001896a5a7289mr6625556plt.52.1671714135195;
        Thu, 22 Dec 2022 05:02:15 -0800 (PST)
Received: from debian.me (subs03-180-214-233-71.three.co.id. [180.214.233.71])
        by smtp.gmail.com with ESMTPSA id b13-20020a170902650d00b00189667acf15sm473229plk.162.2022.12.22.05.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 05:02:13 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 8B7CC10160E; Thu, 22 Dec 2022 20:02:05 +0700 (WIB)
Date:   Thu, 22 Dec 2022 20:02:05 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: maintainer-pgp-guide: update for latest gnupg
 defaults
Message-ID: <Y6RVTQxhcxDDrvO3@debian.me>
References: <20221220-docs-pgp-guide-v1-1-9b0c0bf974fb@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="E8QBJcnwTpIG3sVd"
Content-Disposition: inline
In-Reply-To: <20221220-docs-pgp-guide-v1-1-9b0c0bf974fb@linuxfoundation.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--E8QBJcnwTpIG3sVd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 20, 2022 at 02:44:17PM -0500, Konstantin Ryabitsev wrote:
> It is finally becoming increasingly rare to find a distribution that
> still ships with gnupg-1.x, so remove the last vestiges of "gpg" vs
> "gpg2" from documentation.
>=20
> Similarly, starting with GnuPG 2.2 and above, the default --gen-key
> operation creates ed25519/cv25519 keypairs, so update all example
> command outputs to use that combination instead of rsa2048.
>=20
> Lastly, add a few wording tweaks and remove links that lead to stale
> information (e.g. hardware tokens overview from 2017).
>=20

Shouldn't "Protecting Code Integrity" doc also be updated with recent
situation?

> Signed-off-by: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
> ---
>  Documentation/process/maintainer-pgp-guide.rst | 102 ++++++++-----------=
------
>  1 file changed, 30 insertions(+), 72 deletions(-)
>=20
> diff --git a/Documentation/process/maintainer-pgp-guide.rst b/Documentati=
on/process/maintainer-pgp-guide.rst
> index 40bfbd3b7648..f5277993b195 100644
> --- a/Documentation/process/maintainer-pgp-guide.rst
> +++ b/Documentation/process/maintainer-pgp-guide.rst
> @@ -60,36 +60,18 @@ establish the integrity of the Linux kernel itself.
>  PGP tools
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
> -Use GnuPG v2
> -------------
> +Use GnuPG 2.2 or later
> +----------------------
> =20
>  Your distro should already have GnuPG installed by default, you just
> -need to verify that you are using version 2.x and not the legacy 1.4
> -release -- many distributions still package both, with the default
> -``gpg`` command invoking GnuPG v.1. To check, run::
> +need to verify that you are using a reasonably recent version of it.
> +To check, run::
> =20
>      $ gpg --version | head -n1
> =20
> -If you see ``gpg (GnuPG) 1.4.x``, then you are using GnuPG v.1. Try the
> -``gpg2`` command (if you don't have it, you may need to install the
> -gnupg2 package)::
> -
> -    $ gpg2 --version | head -n1
> -
> -If you see ``gpg (GnuPG) 2.x.x``, then you are good to go. This guide
> -will assume you have the version 2.2 of GnuPG (or later). If you are
> -using version 2.0 of GnuPG, then some of the commands in this guide will
> -not work, and you should consider installing the latest 2.2 version of
> -GnuPG. Versions of gnupg-2.1.11 and later should be compatible for the
> -purposes of this guide as well.
> -
> -If you have both ``gpg`` and ``gpg2`` commands, you should make sure you
> -are always using GnuPG v2, not the legacy version. You can enforce this
> -by setting the appropriate alias::
> -
> -    $ alias gpg=3Dgpg2
> -
> -You can put that in your ``.bashrc`` to make sure it's always the case.
> +If you have version 2.2 or above, then you are good to go. If you have a
> +version that is prior than 2.2, then some commands from this guide may
> +not work.
> =20
>  Configure gpg-agent options
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~
> @@ -150,9 +132,9 @@ PGP defines four capabilities that a key can have:
>  The key with the **[C]** capability is often called the "master" key,
>  but this terminology is misleading because it implies that the Certify
>  key can be used in place of any of other subkey on the same chain (like
> -a physical "master key" can be used to open the locks made for other
> -keys). Since this is not the case, this guide will refer to it as "the
> -Certify key" to avoid any ambiguity.
> +a physical "master key" can be used to open locks made for other keys).
> +Since this is not the case, this guide will refer to it as "the Certify
> +key" to avoid any ambiguity.
> =20
>  It is critical to fully understand the following:
> =20
> @@ -186,10 +168,10 @@ If you used the default parameters when generating =
your key, then that
>  is what you will have. You can verify by running ``gpg --list-secret-key=
s``,
>  for example::
> =20
> -    sec   rsa2048 2018-01-23 [SC] [expires: 2020-01-23]
> +    sec   ed25519 2022-12-20 [SC] [expires: 2024-12-19]
>            000000000000000000000000AAAABBBBCCCCDDDD
>      uid           [ultimate] Alice Dev <adev@kernel.org>
> -    ssb   rsa2048 2018-01-23 [E] [expires: 2020-01-23]
> +    ssb   cv25519 2022-12-20 [E] [expires: 2024-12-19]
> =20
>  The long line under the ``sec`` entry is your key fingerprint --
>  whenever you see ``[fpr]`` in the examples below, that 40-character
> @@ -219,18 +201,9 @@ separate signing subkey::
> =20
>  .. note:: ECC support in GnuPG
> =20
> -    GnuPG 2.1 and later has full support for Elliptic Curve
> -    Cryptography, with ability to combine ECC subkeys with traditional
> -    RSA keys. The main upside of ECC cryptography is that it is much
> -    faster computationally and creates much smaller signatures when
> -    compared byte for byte with 2048+ bit RSA keys. Unless you plan on
> -    using a smartcard device that does not support ECC operations, we
> -    recommend that you create an ECC signing subkey for your kernel
> -    work.
> -
> -    Note, that if you plan to use a hardware device that does not
> +    Note, that if you intend to use a hardware token that does not
>      support ED25519 ECC keys, you should choose "nistp256" instead or
> -    "ed25519."
> +    "ed25519." See the section below on recommended hardware devices.
> =20
> =20
>  Back up your Certify key for disaster recovery
> @@ -336,13 +309,13 @@ First, identify the keygrip of your Certify key::
> =20
>  The output will be something like this::
> =20
> -    pub   rsa2048 2018-01-24 [SC] [expires: 2020-01-24]
> +    pub   ed25519 2022-12-20 [SC] [expires: 2022-12-19]
>            000000000000000000000000AAAABBBBCCCCDDDD
>            Keygrip =3D 1111000000000000000000000000000000000000
>      uid           [ultimate] Alice Dev <adev@kernel.org>
> -    sub   rsa2048 2018-01-24 [E] [expires: 2020-01-24]
> +    sub   cv25519 2022-12-20 [E] [expires: 2022-12-19]
>            Keygrip =3D 2222000000000000000000000000000000000000
> -    sub   ed25519 2018-01-24 [S]
> +    sub   ed25519 2022-12-20 [S]
>            Keygrip =3D 3333000000000000000000000000000000000000
> =20
>  Find the keygrip entry that is beneath the ``pub`` line (right under the
> @@ -365,14 +338,14 @@ Now, if you issue the ``--list-secret-keys`` comman=
d, it will show that
>  the Certify key is missing (the ``#`` indicates it is not available)::
> =20
>      $ gpg --list-secret-keys
> -    sec#  rsa2048 2018-01-24 [SC] [expires: 2020-01-24]
> +    sec#  ed25519 2022-12-20 [SC] [expires: 2024-12-19]
>            000000000000000000000000AAAABBBBCCCCDDDD
>      uid           [ultimate] Alice Dev <adev@kernel.org>
> -    ssb   rsa2048 2018-01-24 [E] [expires: 2020-01-24]
> -    ssb   ed25519 2018-01-24 [S]
> +    ssb   cv25519 2022-12-20 [E] [expires: 2024-12-19]
> +    ssb   ed25519 2022-12-20 [S]
> =20
>  You should also remove any ``secring.gpg`` files in the ``~/.gnupg``
> -directory, which are left over from earlier versions of GnuPG.
> +directory, which may be left over from previous versions of GnuPG.
> =20
>  If you don't have the "private-keys-v1.d" directory
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> @@ -437,8 +410,7 @@ functionality. There are several options available:
>    U2F, among others, and now finally supports NISTP and ED25519 ECC
>    keys.
> =20
> -`LWN has a good review`_ of some of the above models, as well as several
> -others. Your choice will depend on cost, shipping availability in your
> +Your choice will depend on cost, shipping availability in your
>  geographical region, and open/proprietary hardware considerations.
> =20
>  .. note::
> @@ -451,7 +423,6 @@ geographical region, and open/proprietary hardware co=
nsiderations.
>  .. _`Nitrokey Pro 2`: https://shop.nitrokey.com/shop/product/nkpr2-nitro=
key-pro-2-3
>  .. _`Yubikey 5`: https://www.yubico.com/products/yubikey-5-overview/
>  .. _Gnuk: https://www.fsij.org/doc-gnuk/
> -.. _`LWN has a good review`: https://lwn.net/Articles/736231/
>  .. _`qualify for a free Nitrokey Start`: https://www.kernel.org/nitrokey=
-digital-tokens-for-kernel-developers.html
> =20
>  Configure your smartcard device
> @@ -509,11 +480,11 @@ passphrase and the admin PIN of the card for most o=
perations::
> =20
>      Secret subkeys are available.
> =20
> -    pub  rsa2048/AAAABBBBCCCCDDDD
> -         created: 2018-01-23  expires: 2020-01-23  usage: SC
> +    pub  ed25519/AAAABBBBCCCCDDDD
> +         created: 2022-12-20  expires: 2024-12-19  usage: SC
>           trust: ultimate      validity: ultimate
> -    ssb  rsa2048/1111222233334444
> -         created: 2018-01-23  expires: never       usage: E
> +    ssb  cv25519/1111222233334444
> +         created: 2022-12-20  expires: never       usage: E
>      ssb  ed25519/5555666677778888
>           created: 2017-12-07  expires: never       usage: S
>      [ultimate] (1). Alice Dev <adev@kernel.org>
> @@ -577,11 +548,11 @@ If you perform ``--list-secret-keys`` now, you will=
 see a subtle
>  difference in the output::
> =20
>      $ gpg --list-secret-keys
> -    sec#  rsa2048 2018-01-24 [SC] [expires: 2020-01-24]
> +    sec#  ed25519 2022-12-20 [SC] [expires: 2024-12-19]
>            000000000000000000000000AAAABBBBCCCCDDDD
>      uid           [ultimate] Alice Dev <adev@kernel.org>
> -    ssb>  rsa2048 2018-01-24 [E] [expires: 2020-01-24]
> -    ssb>  ed25519 2018-01-24 [S]
> +    ssb>  cv25519 2022-12-20 [E] [expires: 2024-12-19]
> +    ssb>  ed25519 2022-12-20 [S]
> =20
>  The ``>`` in the ``ssb>`` output indicates that the subkey is only
>  available on the smartcard. If you go back into your secret keys
> @@ -644,7 +615,7 @@ run::
>  You can also use a specific date if that is easier to remember (e.g.
>  your birthday, January 1st, or Canada Day)::
> =20
> -    $ gpg --quick-set-expire [fpr] 2020-07-01
> +    $ gpg --quick-set-expire [fpr] 2025-07-01
> =20
>  Remember to send the updated key back to keyservers::
> =20
> @@ -707,12 +678,6 @@ should be used (``[fpr]`` is the fingerprint of your=
 key)::
> =20
>      $ git config --global user.signingKey [fpr]
> =20
> -**IMPORTANT**: If you have a distinct ``gpg2`` command, then you should
> -tell git to always use it instead of the legacy ``gpg`` from version 1::
> -
> -    $ git config --global gpg.program gpg2
> -    $ git config --global gpgv.program gpgv2
> -
>  How to work with signed tags
>  ----------------------------
> =20
> @@ -751,13 +716,6 @@ If you are verifying someone else's git tag, then yo=
u will need to
>  import their PGP key. Please refer to the
>  ":ref:`verify_identities`" section below.
> =20
> -.. note::
> -
> -    If you get "``gpg: Can't check signature: unknown pubkey
> -    algorithm``" error, you need to tell git to use gpgv2 for
> -    verification, so it properly processes signatures made by ECC keys.
> -    See instructions at the start of this section.
> -
>  Configure git to always sign annotated tags
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> =20
>=20

LGTM, thanks.

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--E8QBJcnwTpIG3sVd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY6RVSAAKCRD2uYlJVVFO
o9A2AP9C2bHfZvPdCD/VFq9mgWI7PHOEcqPuR6GuZcRGMI962QEAjioFDtVI+29M
Ce6wKu2iiDfTd9QjCJifQfIzlaDeEgI=
=VBzV
-----END PGP SIGNATURE-----

--E8QBJcnwTpIG3sVd--
