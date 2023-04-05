Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0216D722A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 03:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236706AbjDEBsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 21:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjDEBsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 21:48:13 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E953AA4;
        Tue,  4 Apr 2023 18:48:11 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PrnZx1DHzz4xD8;
        Wed,  5 Apr 2023 11:48:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1680659289;
        bh=HtCJVZlsRz3boECnbqp+FJ8f4M1pyjbQcdvtBiFysuc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Y5+ja68+vhf8a13nthJFwDS7MCBhAXRQeiUyqii3nUG7mKAdX5L/HpdWv+nifArQO
         9aP6Saf7f+3Kmz082U6AU/G7K7GF33d+lfM+Xq12i0Vbm/lP8lvuBO5edY97dnuvC2
         v+UEYmc3WyiffPqfZ5I+C+GpXywQ+uH7Te+yJpmVizjc1VdoEqnCftzCcDkVmQuiWZ
         uT3Z6Ty0oyTZxLyHPI0VxVEd3BdZdMeca+gDWSlaJY1pqHxI5+nGdeTDKPCAUqLqIL
         uF/DO7BNRAlCwTYtxwLtlCkVrSIJM2DYqZow5jDu/jeQJ+B6EKPoGiGZuVTnXkMseF
         wzdUHpfTxBXWg==
Date:   Wed, 5 Apr 2023 11:48:07 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Bastien Nocera <hadess@hadess.net>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the hid tree
Message-ID: <20230405114807.5a57bf46@canb.auug.org.au>
In-Reply-To: <366ab6c4d488645aee5cbf49fb2e9b39d9bb1e22.camel@hadess.net>
References: <20230404154005.449800c3@canb.auug.org.au>
        <20230404154254.6c3be26b@canb.auug.org.au>
        <e1eb90db85ed7adad08bb99054f5cda3cb626794.camel@hadess.net>
        <20230404185500.7953d9d2@canb.auug.org.au>
        <366ab6c4d488645aee5cbf49fb2e9b39d9bb1e22.camel@hadess.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/NTmVx3rhRGf2PCqGL/9kBmg";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/NTmVx3rhRGf2PCqGL/9kBmg
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Bastien,

On Tue, 04 Apr 2023 11:18:35 +0200 Bastien Nocera <hadess@hadess.net> wrote:
>
> Before I send patches, does this look correct to you?
>=20
> diff --git a/drivers/usb/core/message.c b/drivers/usb/core/message.c
> index 7930dca84616..7c7f88ca4f62 100644
> --- a/drivers/usb/core/message.c
> +++ b/drivers/usb/core/message.c
> @@ -1926,7 +1926,7 @@ static void __usb_wireless_status_intf(struct work_=
struct *ws)
> 1926=E2=8B=AE1926=E2=94=82=20
> 1927=E2=8B=AE1927=E2=94=82 /**
> 1928=E2=8B=AE1928=E2=94=82  * usb_set_wireless_status - sets the wireless=
_status struct member
> 1929=E2=8B=AE    =E2=94=82- * @dev: the device to modify
>     =E2=8B=AE1929=E2=94=82+ * @iface: the interface to modify
> 1930=E2=8B=AE1930=E2=94=82  * @status: the new wireless status
> 1931=E2=8B=AE1931=E2=94=82  *
> 1932=E2=8B=AE1932=E2=94=82  * Set the wireless_status struct member to th=
e new value, and emit

That looks good.

> diff --git a/include/linux/usb.h b/include/linux/usb.h
> index a48eeec62a66..3d523ebf0c09 100644
> --- a/include/linux/usb.h
> +++ b/include/linux/usb.h
> @@ -261,7 +261,8 @@ struct usb_interface {
>  261=E2=8B=AE 261=E2=94=82      unsigned needs_binding:1;       /* needs =
delayed unbind/rebind */
>  262=E2=8B=AE 262=E2=94=82      unsigned resetting_device:1;    /* true: =
bandwidth alloc after reset */
>  263=E2=8B=AE 263=E2=94=82      unsigned authorized:1;          /* used f=
or interface authorization */
>  264=E2=8B=AE    =E2=94=82-     enum usb_wireless_status wireless_status;
>     =E2=8B=AE 264=E2=94=82+     enum usb_wireless_status wireless_status;=
 /* whether the emitter is
>     =E2=8B=AE 265=E2=94=82+                                              =
  * connected to this receiver */
>  265=E2=8B=AE 266=E2=94=82      struct work_struct wireless_status_work;
>  266=E2=8B=AE 267=E2=94=82=20
>  267=E2=8B=AE 268=E2=94=82      struct device dev;              /* interf=
ace specific device info */
>=20

This is not right, though.  The warning was about
"wireless_status_work" not "wireless_status", so I think you need a
description of wireless_status_work in the block comment above the
struct definition.

--=20
Cheers,
Stephen Rothwell

--Sig_/NTmVx3rhRGf2PCqGL/9kBmg
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQs01cACgkQAVBC80lX
0Gy4gAgAm8jakAMnjG8YvTuuQ5jMmRVMy29Vlqg5yNQK4+OAFV6NXaNuPb2pdKK9
7a04gaR/prutPTyjjZVvn57dLDEYrN1bk4e0dkZorUkQwb6dM6BtqSStsudRBndk
/ZfuGXxEG6N3k+8NKH8mvsN2+7JoLYSyHB3kADOgr6XwslGbhW7B1vZ7u1Fj1Wr8
An6ExY31g4lwdv8PzuWyUpu8nqD7eBQuNFIwHkCgFiFt5n9JoO70oFbNkn3cyipI
3zuHvaHQ9F+pZUCbqIKV5/aWIBJmbvKR/4dBokNEuTu/W/Z6uR+S7rOsb7infiuI
oPXy/vQyrmEcu788yNVrvLiadHg17g==
=TfKY
-----END PGP SIGNATURE-----

--Sig_/NTmVx3rhRGf2PCqGL/9kBmg--
