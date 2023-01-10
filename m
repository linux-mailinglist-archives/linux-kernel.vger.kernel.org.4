Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40D8766439B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 15:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238687AbjAJOso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 09:48:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238702AbjAJOsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 09:48:25 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A724FCF2;
        Tue, 10 Jan 2023 06:48:24 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id p25so6524944ljn.12;
        Tue, 10 Jan 2023 06:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v5WsDUKqWc4u2jJZSjpZXWIATqF3Ue62OEMi4UxyJJ0=;
        b=oc2q/yf7Mk3QIlXAJYeunlc0xCzF2jvNa+OlXsTXr8lFDtVjeEoCiol1ouFQbJZ1B/
         DVduttuoKizppvkqtLxYQMTN1QKiOES3NgF5UoqkbILX/9nFbBsNVPPoS/kJBTtUDqQc
         Ik8CVMr+t/u/sRvPOc1FGAoLlVDF5BbKylVDYae3TcaZwzoGO9F8VhJUtQ5Y6X0Z36Ta
         36QV6jghOZeBndrBoq15x2Sjvk+jMdZovO0HHTsV281PKgjZOJwrbIwxn5ocyhEI5FLU
         8ax3oiWPUPJ9jSZ1wFRrDypucm2G1ZtJvrPVSdzNQ6o7UPBE6qtodw3i1TYsypPXfi6a
         aqAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v5WsDUKqWc4u2jJZSjpZXWIATqF3Ue62OEMi4UxyJJ0=;
        b=0JVdiHa+KxICLADOT3e2rcItXgVvuVGZhxd9stmLuk2GkMTHVq+WDlsm4JO/2Lc5aA
         nc6AVzpLKEJjOSIf+IVYL3/skTExZF0+0M7QVlbVCR92mVUo1UCg5un7+VOtD6sTP5+h
         JegD69BaSNH6nMTywo0zBdgaTpgWXpwj9Gi1iPmkByuACzJvY83v9J5D5+WBKgpZjyep
         qIvBo0ma77YY39VG0TG7xUbmnlWHGBmekB9TqhQW0IoKIXXya+7UotGzchO7H/78Me68
         /+7jJhnk1+7BK8JA8E73oCsz4+RJjMwuv4U/TaMXpQjh6MnssY2ltgcwknToxz6JRBoP
         6KWQ==
X-Gm-Message-State: AFqh2kpO0qJNKImfr4vBONVdM8EioK5MSl8V1vZxqw2UkVBl0JVY5Rvx
        9qIItHe2wcAxNtq3w5wT5nU=
X-Google-Smtp-Source: AMrXdXsgTVvxwQgYkltkVwEjosBkKDYfG19UHkSooATESFBmQ4jCcULgczuaRd9ZB3b5tLhmA/IqUQ==
X-Received: by 2002:a2e:95c6:0:b0:285:74d8:fd15 with SMTP id y6-20020a2e95c6000000b0028574d8fd15mr1698704ljh.9.1673362102984;
        Tue, 10 Jan 2023 06:48:22 -0800 (PST)
Received: from gmail.com (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id t21-20020a2e8e75000000b0027b54ff90c0sm1323531ljk.139.2023.01.10.06.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 06:48:21 -0800 (PST)
Date:   Tue, 10 Jan 2023 15:48:33 +0100
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, Jiri Kosina <jikos@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>
Subject: Re: [RESEND PATCH 1/2] HID: Add driver for RC Simulator Controllers
Message-ID: <Y716wUFVm+PvkMqv@gmail.com>
References: <20220822060936.769855-1-marcus.folkesson@gmail.com>
 <CAO-hwJ+3Yrr--cr=r5+jvs4A=A-cmDtrKQETo=YOYDC3nXTMBg@mail.gmail.com>
 <YwTvrNuulKx0SB6H@gmail.com>
 <CAO-hwJKiq50fWwXNUGcXeWtWcUXb65ZmJMsADfrsUTac_Xj2dw@mail.gmail.com>
 <YwcbVJswrL1Doi4s@gmail.com>
 <CAO-hwJJ86oAuaFD+uX7Rwv7cASO=4mchRJ1UBTxz9gYs6M1rUg@mail.gmail.com>
 <YyLVblZkIPCvNd/2@gmail.com>
 <CAO-hwJJ5dRrgxrae-RasYXuu7C9xjw6RmPaPfmO=YU3StMaQ3A@mail.gmail.com>
 <d4b420a0-23da-6ab6-886a-7342f7e63651@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="CYuxnQgK2200QJ9N"
Content-Disposition: inline
In-Reply-To: <d4b420a0-23da-6ab6-886a-7342f7e63651@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CYuxnQgK2200QJ9N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Benjamin,

On Mon, Sep 19, 2022 at 03:32:37PM +0200, Benjamin Tissoires wrote:
>=20
>=20

[...]

>=20
> I am back home, and I just tested that. I had a doubt, and it is indeed
> failing. You need the following change for this to be working (I need to
> send it as a proper patch after assessing it hasn't side effects)

Did it come up with any side effects? :-)

>=20
> ---
>=20
> diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
> index 13cce286247e..f37ffe2bd488 100644
> --- a/drivers/hid/usbhid/hid-core.c
> +++ b/drivers/hid/usbhid/hid-core.c
> @@ -275,6 +275,7 @@ static void hid_irq_in(struct urb *urb)
>         int                     status;
>         switch (urb->status) {
> +       case -EOVERFLOW:        /* happens with modified report descripto=
rs */
>         case 0:                 /* success */
>                 usbhid->retry_delay =3D 0;
>                 if (!test_bit(HID_OPENED, &usbhid->iofl))
> ---
>=20
> Cheers,
> Benjamin
>=20

Best regards,
Marcus Folkesson


--CYuxnQgK2200QJ9N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmO9erwACgkQiIBOb1ld
UjIKFA//chEo/4qumcU+/1AFw44iiyHLU7hw3sANpAQkevMeFkzQUrE25/7/Oul9
PRzga+rowCyIFQMWqlj5qrr3ns5tOXUFZaCZmcK0az0sKIFhPnSgR8fBHEAmgUiK
mPyMuOQ6DMTkO6wvv4tstNw2SzA4xjaxRsVKsb/B4NFjJOefLTxWKQPWcPMkJNtn
+GOsdDBwj+r1pd9xse0d6VHpZklV5tGw0nONclTisQ8WvtQS+PQVWkAFoJoj0kF6
wLu2059i2T4sxZr8vpJiqZzM4DVAG2z3lvdp5j5SxoUDxp+TA+m8J/xMRMElhIpK
iO8QWlvOWS9q1PKzN6rJHqffhGPeoHt11zoKeHD67mYE/s+C0SX3tiXefobRjkFf
/bl+kve2AgJBAMBbQdUEHt1v4uoczj2oqljKQxkOwY1Uu7a1QxuWUfaVWHuklVsq
tUffwME//mjn/liJsALqJA7k75ZmlApHJiCv0+LOq4LWdC0LIHWN5Z4/oRmClLpp
o/mpTlUA3G+pEw0Gkv4ypMmDLoj5S7ljIdH08wmB4lhe2l38Fq5m6Y7Q/iXm1TXX
XkTOo6a2185ExqVk+MPAkRhr/v95ZFHLnYM56oyERMW2zEgBvWSnQrL49xcOVzDb
mE4ubjD7WygIVPc558GpEiwAGiPk1sMH+k4Exuj5fptk9kHviAU=
=JxWA
-----END PGP SIGNATURE-----

--CYuxnQgK2200QJ9N--
