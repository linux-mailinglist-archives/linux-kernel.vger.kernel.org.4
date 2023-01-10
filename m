Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01B0D664EEF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 23:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234881AbjAJWqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 17:46:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233103AbjAJWqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 17:46:07 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80591E08B
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 14:46:03 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id j15so6857928qtv.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 14:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aTfUTPgGuX0RHUa6XVRlAEmBs0vqhl6kh/VteIYS8rQ=;
        b=as6xycgQg0BTdLCRuuhmbQ9hoNU/SDvpnxINaY0qcPxKYoE4pMgZSXlSQF5sFcH2pS
         v/+si1zV7bRUC1K4J6tSAw892k9lZ5tdJLuwWI+5tNUmMp5AOlrsa9RQh/4a9BSMF+7P
         c/yVwtwyIir6bvUuZmeTBu5LpV2Be/HNGZaZT/funaz9zBidfv2S63oCrL/47AGLO114
         ytD0fTzUQOS8fib4sDKyTeUJfe1Bs9VUHkmwCA5yNHKILRNkDrcR1+H6wqhnrHapcqdo
         +Y6h5eR6bSwU0PNP1N+Vnt223RnBZsHq3tSGeQUyfMuFrN8cEVlnjAKg55eLd0yrZzaK
         +/eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aTfUTPgGuX0RHUa6XVRlAEmBs0vqhl6kh/VteIYS8rQ=;
        b=KBstmOeGNvEMKl1+nHE4uPew3r1LSzkuenpBlcyxc/8AHOznRKMj0G2F4in/GLEQe3
         RKMwDaO+fSq0mmnn4G4/37JAkOBk7RS77pb6zCitrkt4yhDKYUkobqSU+OI0T7h0p5pw
         Ohw8LqzJZSvqg3FrMR9o1mKihyBgqWdX6b1MwQuSVUlHOP5zyiqhau151zCGzRE2hDev
         qWQVphveisFxYdesYGW0EqND2DAhCSdo9g0QeeqgY5CIUlRnKV2Z4aQ+DlKa9UJrnK2a
         ngSvcTUykUCRK8VVIqAB2b3e7sdta8MAMHl6AzfeYGlRweSoiC9tq/O3dlPVw7BX2v4D
         TE5g==
X-Gm-Message-State: AFqh2kpwh3UBJXtSIHOpwsuKRYozBIQqZWYxG8Ea1ASb+47EoAX2eheg
        lmMDZcOkWedWkHrCwGR2ohHM0uK9fEeXiQ==
X-Google-Smtp-Source: AMrXdXvNkAWO+hywwxsgkKKvXwf8Tn/5IEbcEZxaNbFhy7/nRFUNJ4jcS0uX0lKYN4rh5wBrnvR0gw==
X-Received: by 2002:a05:622a:1e06:b0:3a8:28a4:c4bc with SMTP id br6-20020a05622a1e0600b003a828a4c4bcmr96446034qtb.11.1673390762575;
        Tue, 10 Jan 2023 14:46:02 -0800 (PST)
Received: from Gentoo ([37.19.198.68])
        by smtp.gmail.com with ESMTPSA id g5-20020ac84b65000000b00398ed306034sm6669379qts.81.2023.01.10.14.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 14:46:01 -0800 (PST)
Date:   Wed, 11 Jan 2023 04:15:38 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ver_linux: add missing software to checklist
Message-ID: <Y73qkkf0MZAvJCNN@Gentoo>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
References: <20230110204225.35503-1-skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="njgvF1plAGMbCVg3"
Content-Disposition: inline
In-Reply-To: <20230110204225.35503-1-skhan@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--njgvF1plAGMbCVg3
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On 13:42 Tue 10 Jan 2023, Shuah Khan wrote:
>Update to add missing software checks to bring it in sync with the
>Documentation/Changes list. Make improvements to the output with
>separator between different sections.
>
>Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
>---
> scripts/ver_linux | 29 ++++++++++++++++++++++++++---
> 1 file changed, 26 insertions(+), 3 deletions(-)
>
>diff --git a/scripts/ver_linux b/scripts/ver_linux
>index 1a8ee4ff0e32..6131f6f1b35b 100755
>--- a/scripts/ver_linux
>+++ b/scripts/ver_linux
>@@ -6,10 +6,14 @@
> # differ on your system.
>
> BEGIN {
>-	usage = "If some fields are empty or look unusual you may have an old version.\n"
>-	usage = usage "Compare to the current minimal requirements in Documentation/Changes.\n"
>+	usage = "Minimum required software versions to build and run current kernel version.\n"
>+	usage = usage "If some fields are empty or look unusual you may have an old version.\n"
>+	usage = usage "Compare with the current minimal requirements in Documentation/Changes.\n"
> 	print usage
>
>+	separator = "===================================================\n"
>+
>+	print separator
> 	system("uname -a")
> 	printf("\n")
>
>@@ -17,9 +21,15 @@ BEGIN {
> 	libc = "libc[.]so[.][0-9]+$"
> 	libcpp = "(libg|stdc)[+]+[.]so([.][0-9]+)+$"
>
>+	print separator
> 	printversion("GNU C", version("gcc -dumpversion"))
>+	printversion("Clang/LLVM (optional)", version("clang --version"))
>+	printversion("Rust (optional)", version("rustc --version"))
>+	printversion("bindgen (optional)", version("bindgen --version"))
> 	printversion("GNU Make", version("make --version"))
>+	printversion("bash", version("bash --version"))
> 	printversion("Binutils", version("ld -v"))
>+	printversion("pahole", version("pahole --version"))
> 	printversion("Util-linux", version("mount --version"))
> 	printversion("Mount", version("mount --version"))
> 	printversion("Module-init-tools", version("depmod -V"))
>@@ -28,6 +38,8 @@ BEGIN {
> 	printversion("Reiserfsprogs", version("reiserfsck -V"))
> 	printversion("Reiser4fsprogs", version("fsck.reiser4 -V"))
> 	printversion("Xfsprogs", version("xfs_db -V"))
>+	printversion("squashfs-tools", version("mksquashfs -version"))
>+	printversion("btrfs-progs", version("mkfs.btrfs --version"))
> 	printversion("Pcmciautils", version("pccardctl -V"))
> 	printversion("Pcmcia-cs", version("cardmgr -V"))
> 	printversion("Quota-tools", version("quota -V"))
>@@ -36,7 +48,16 @@ BEGIN {
> 	printversion("Nfs-utils", version("showmount --version"))
> 	printversion("Bison", version("bison --version"))
> 	printversion("Flex", version("flex --version"))
>+	printversion("Grub", version("grub-install --version"))
>+	printversion("mcelog", version("mcelog --version"))
>+	printversion("iptables", version("iptables --version"))
>+	printversion("openssl & libcrypto", version("openssl version"))
>+	printversion("bc", version("bc --version"))
>+	printversion("Sphinx (for doc builds)", version("sphinx-build --version"))
>+	printversion("cpio", version("cpio --version"))
>+	printf("\n")
>
>+	print separator
> 	while ("ldconfig -p 2>/dev/null" | getline > 0)
> 		if ($NF ~ libc || $NF ~ libcpp)
> 			if (!seen[ver = version("readlink " $NF)]++)
>@@ -50,12 +71,14 @@ BEGIN {
> 	printversion("Sh-utils", version("expr --v"))
> 	printversion("Udev", version("udevadm --version"))
> 	printversion("Wireless-tools", version("iwconfig --version"))
>+	printf("\n")
>
>+	print separator
> 	while ("sort /proc/modules" | getline > 0) {
> 		mods = mods sep $1
> 		sep = " "
> 	}
>-	printversion("Modules Loaded", mods)
>+	printversion("Modules Loaded:\n", mods)
> }
>
> function version(cmd,    ver) {
>--
>2.34.1
>
Hunch....

One, is grub required to compile kernel?

Second, can we please stick to " absolutely required software" than showing optional??

Separator adding is good one.

--
Thanks,
Bhaskar

"Here's looking at you kid"-- Casablanca
https://about.me/unixbhaskar

--njgvF1plAGMbCVg3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmO96pIACgkQsjqdtxFL
KRVoewgAlPo+RIzbPwPElvilRNQlXpLvJuPVG700pAqVCcRZVLIWLz2tv/J+6QHJ
xp+fLTzR+H8FrgecMNcDyKGG4GkoQwVxQotNij1C31oFSvNjm4Csv13aPm0Bru87
tayrdUxga63QPv2OJ3fjk8Zrjq3nXoOQHJNiO62kHRqpGdwV1+MaS6L7e8RyJo4b
nsKwWuEVIzHfVs/U0iAJIGyL5h8M4bBkvdf/sfC4eSYsr1k+lpE15V9vsbR7fsKL
N+gvuzibry2jf2+CTBrq1+pITL1m0PA6XxyYp7roE/FkbA1QCzeEH5bmdzGZ5sec
InFWcbY10RWsqqv7McKcbMqV6Oi2/Q==
=D9JT
-----END PGP SIGNATURE-----

--njgvF1plAGMbCVg3--
