Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A525169326C
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 17:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjBKQbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 11:31:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjBKQa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 11:30:59 -0500
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697782365C;
        Sat, 11 Feb 2023 08:30:58 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 2BC901C0AB3; Sat, 11 Feb 2023 17:30:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1676133057;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ay7b2vQKX1wm/ZcEtVJzIi54lH+BaC/HQeDiHTWPvWI=;
        b=sEkb8Kd5bfgM7zuJToquqC/scPRB/km85Ng22OlOgsbPbvPDWpUtw/1HERbec4texOTtbn
        MDDesFICacUzvIPZyg5ijtNQwIm+ZGQLi3yCGWG/0V9RFLZLIWAM//THHebG1+i3KGF+Wc
        1TyXKt46fnSkcgN6Fd10P3E+BcYIWMw=
Date:   Sat, 11 Feb 2023 17:30:53 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Gergo Koteles <soyer@irl.hu>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Caleb Connolly <caleb@connolly.tech>
Subject: Re: [PATCH v2 2/3] Input: add ABS_SND_PROFILE
Message-ID: <Y+fCvaGTkddwNGP6@duo.ucw.cz>
References: <20230209232539.91500-1-soyer@irl.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="g2w79Pe1No+u8GQT"
Content-Disposition: inline
In-Reply-To: <20230209232539.91500-1-soyer@irl.hu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--g2w79Pe1No+u8GQT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> ABS_SND_PROFILE used to describe the state of a multi-value sound profile
> switch. This will be used for the tri-state key on OnePlus phones or other
> phones.

Looks like ABS_PROFILE would be fine to use there, no need to create
new one, no?

Best regards,
								Pavel

> Signed-off-by: Gergo Koteles <soyer@irl.hu>
> ---
>  Documentation/input/event-codes.rst    | 6 ++++++
>  drivers/hid/hid-debug.c                | 1 +
>  include/uapi/linux/input-event-codes.h | 1 +
>  3 files changed, 8 insertions(+)
>=20
> diff --git a/Documentation/input/event-codes.rst b/Documentation/input/ev=
ent-codes.rst
> index b4557462edd7..d43336e64d6a 100644
> --- a/Documentation/input/event-codes.rst
> +++ b/Documentation/input/event-codes.rst
> @@ -241,6 +241,12 @@ A few EV_ABS codes have special meanings:
>      emitted only when the selected profile changes, indicating the newly
>      selected profile value.
> =20
> +* ABS_SND_PROFILE:
> +
> +  - Used to describe the state of a multi-value sound profile switch.
> +    An event is emitted only when the selected profile changes,
> +    indicating the newly selected profile value.
> +
>  * ABS_MT_<name>:
> =20
>    - Used to describe multitouch input events. Please see
> diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c

--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--g2w79Pe1No+u8GQT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY+fCvQAKCRAw5/Bqldv6
8sM+AJ0VMGsWfvGF+uNYRZ5LzwdYOOkh4ACePA+D30SLyJMWQB2QAguPec2fUzU=
=lel6
-----END PGP SIGNATURE-----

--g2w79Pe1No+u8GQT--
