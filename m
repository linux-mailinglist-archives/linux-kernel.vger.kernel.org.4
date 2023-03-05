Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6E1B6AB394
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 00:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjCEXvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 18:51:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjCEXvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 18:51:31 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B67612BF7;
        Sun,  5 Mar 2023 15:51:29 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PVJQ44cNSz4whh;
        Mon,  6 Mar 2023 10:51:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1678060284;
        bh=4Ubvfc+N2WszvIxBH/o9AtdMacnaJ6vKoMlGg/A1NOA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Z6sRDkcNixC8v/i5nilfhbWnjT1sGapaPTDWm/jPhMRx8rqduD97I/CPrv3r40tPZ
         Y+TPKbnZwinbD69vBjjOSvbuQ2TXwKYBpt9EELfxuEYwwkdl2eVzEfsimCo5VuyGT7
         CzYG+SETF7/4uLayUfnufGYaT4fwFEJCgaVodcNIvSj4h2iOJtw4xM3qA+dH5bnA/I
         sIdtrQph/4XmwEIPp39Ag8tSlvLiZwfoVN/pT4qtn4LltmkHPBrh6QyAC2lOSvWD7T
         UySU5mryXUhd7hE75/HGEnl2ikTkSBU62lHm1aak65SqkKEVPfx7jdyu6aZmG3+VZu
         4gLSDjmVq4U5w==
Date:   Mon, 6 Mar 2023 10:51:23 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patches in the nvmem tree
Message-ID: <20230306105123.5ea1acc0@canb.auug.org.au>
In-Reply-To: <20230206083215.723e7f72@canb.auug.org.au>
References: <20230206083215.723e7f72@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/_z=4luYuA4bXw1eBvX61LwO";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/_z=4luYuA4bXw1eBvX61LwO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, 6 Feb 2023 08:32:15 +1100 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> The following commits are also in Linus Torvalds' tree as different
> commits (but the same patches):
>=20
>   03b6f71ceeb1 ("nvmem: core: fix cleanup after dev_set_name()")
>   6b868c1a2ec0 ("nvmem: sunxi_sid: Always use 32-bit MMIO reads")
>   957b1f840ce0 ("nvmem: brcm_nvram: Add check for kzalloc")
>   9afef75ce71c ("nvmem: core: remove nvmem_config wp_gpio")
>   a895af2746e3 ("nvmem: core: fix return value")
>   b02c75889942 ("nvmem: core: fix registration vs use race")
>   b3a9be9040b7 ("nvmem: core: initialise nvmem->id early")
>   ba716d020bc8 ("nvmem: qcom-spmi-sdam: fix module autoloading")
>   c976fd0b6970 ("nvmem: core: fix device node refcounting")
>   ee29286033ef ("nvmem: core: fix cell removal on error")

This duplication has now started causing conflicts ... please clean up
your tree now that v6.3-rc1 is out.

--=20
Cheers,
Stephen Rothwell

--Sig_/_z=4luYuA4bXw1eBvX61LwO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQFKvsACgkQAVBC80lX
0GwsCgf8DbV0wJYYtLEfVR3zPOBfb9wmFs4Ns8Pnz2kKV99Pi2foXEx5vlM5vAc/
895SIiswHjaY5AKY6mRtQo1UeW6lTFyid/+y4f3QJ0y+GkkV2f+5v/JIxECjGmaZ
fXrLMUWQT8I2usmMuf03BZcYsCTJxZWdq4yTA1lLKZB/ibU776MhbPK3jTgT5/nM
VpTeZmcbPbHcCtvKNfSpJ1zY3CybVTWyji2Nz8hozPqfftRVQSvvb5MVFp/FrNm7
L8k9bsfSgWUh5Wofo0zBZReAB1qQVNH98QHK6GxraedMcMMI/AxZAaB9DFB8KvJI
FOJmicLuUX/TOkjPAvcM3MrqX1Qo4A==
=XLgs
-----END PGP SIGNATURE-----

--Sig_/_z=4luYuA4bXw1eBvX61LwO--
