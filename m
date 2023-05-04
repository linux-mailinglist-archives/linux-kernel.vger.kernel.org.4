Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 577666F65AE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 09:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjEDH0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 03:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbjEDH0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 03:26:17 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59BFC2D40;
        Thu,  4 May 2023 00:26:13 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-7516d97a63aso9965685a.1;
        Thu, 04 May 2023 00:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683185172; x=1685777172;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1wlxzUfbfZ06DVEocDvamXCK0fAlaBMqjKg87R5vU0U=;
        b=G5pUj4Rc0Tu5uUWmt+Q/F/ah7RAuuUZx7wYrhELbudqg4gh0xYhiT6nzKjuEXPO87s
         rJDBzaseP2eLClBBJ8bRISnC2Hy7j48S+vpKN1R75BcS5TU1xi72PzFt0pjYfT/VvUDb
         Ili3Jiu6S767QkTrJaYHPVdD5uigo9B35Jn+Jp7Hg4UKsylH0HD4Ak7N7I664Uuglvgy
         gIKtQIo4BS2zUoXWptSbQhMX9rlgSVXO3pky+FImlh+fFde9vwl/oCWjKJ2eXfCXeF0/
         NeVGN+ua+mXj4xwXmUPeuqZg0OCW1QwsKCmFVJe0N6oouuQu2oc/YNR4H1IgI79skDaG
         xDyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683185172; x=1685777172;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1wlxzUfbfZ06DVEocDvamXCK0fAlaBMqjKg87R5vU0U=;
        b=iU3zFO7lP0eYSeZVtt+HyqTawZx6dPpkDMJlBI6A3u2Qsxp8qrHLon9ikmjfNANM/p
         Iw8aP7ctQiVZLZFKEIHQyZN07MwxeLLbLktU4pMsQH2CXACfJQ2hb3NrgbiI5v1Ftrp/
         ovSWSGXw0oSan4Xj7Q5R5bS7DAtjbY9VYNChTuHCJjPBesoJkeEVw/NnnNBjG701eYK0
         2bOWHIPzqJi3kKBw9H1l2u6AlUhrAl74026bfoZD9ccXb0l8XzVsw7oaUnQyhFm6tnnr
         ifm3bNboAK3IcWgCDu0U+36rwqmU5SWoPttj3JZOx6De+TMfmE6iBival8X3/C7F80d8
         dQhA==
X-Gm-Message-State: AC+VfDzcHL3EP3K7jwki+Dpwnuqa9wphhYyDSzT7wxRbCadzCfr/G09F
        hPXNYthBfkNixBMaheaak2s=
X-Google-Smtp-Source: ACHHUZ5+F3aKC9nBcl3PysRQC8Yv4gqWUi2Vzui2vwKHC0e3VrQcLC1ZVwbFH1KFRRTBHJq1gSLCqA==
X-Received: by 2002:ad4:5b84:0:b0:5b4:1d9a:75e7 with SMTP id 4-20020ad45b84000000b005b41d9a75e7mr12182199qvp.13.1683185172298;
        Thu, 04 May 2023 00:26:12 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef05:8700:c599:e44a:8287:c91c? (p200300f6ef058700c599e44a8287c91c.dip0.t-ipconnect.de. [2003:f6:ef05:8700:c599:e44a:8287:c91c])
        by smtp.gmail.com with ESMTPSA id d125-20020a376883000000b0074fafbea974sm8670986qkc.2.2023.05.04.00.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 00:26:11 -0700 (PDT)
Message-ID: <27fe41e402ea0d6ef42aa0ac80aa3d1488862cd8.camel@gmail.com>
Subject: Re: [PATCH] iio: addac: ad74413: don't set DIN_SINK for functions
 other than digital input
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 04 May 2023 09:28:23 +0200
In-Reply-To: <20230503105042.453755-1-linux@rasmusvillemoes.dk>
References: <20230503105042.453755-1-linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rasmus,

Thanks for your patch... Just one comment below

On Wed, 2023-05-03 at 12:50 +0200, Rasmus Villemoes wrote:
> Apparently, despite the name Digital Input Configuration Register, the
> settings in the DIN_CONFIGx registers also affect other channel
> functions. In particular, setting a non-zero value in the DIN_SINK
> field breaks the resistance measurement function.
>=20
> Now, one can of course argue that specifying a drive-strength-microamp
> property along with a adi,ch-func which is not one of the digital
> input functions is a bug in the device tree. However, we have a rather
> complicated setup with instances of ad74412r on external hardware
> modules, and have set a default drive-strength-microamp in our DT
> fragments describing those, merely modifying the adi,ch-func settings
> to reflect however the modules have been wired up. And restricting
> this setting to just being done for digital input doesn't make the
> driver any more complex.
>=20
> Fixes: 504eb485589d1 (iio: ad74413r: wire up support for drive-strength-
> microamp property)
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
> =C2=A0drivers/iio/addac/ad74413r.c | 11 ++++++-----
> =C2=A01 file changed, 6 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/iio/addac/ad74413r.c b/drivers/iio/addac/ad74413r.c
> index e3366cf5eb31..6b0e8218f150 100644
> --- a/drivers/iio/addac/ad74413r.c
> +++ b/drivers/iio/addac/ad74413r.c
> @@ -1317,13 +1317,14 @@ static int ad74413r_setup_gpios(struct ad74413r_s=
tate
> *st)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0}
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0if (config->func =3D=3D CH_FUNC_DIGITAL_INPUT_LOGIC=
 ||
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 config->func =3D=3D CH_FUNC_DIGITAL_IN=
PUT_LOOP_POWER)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 config->func =3D=3D CH_FUNC_DIGITAL_IN=
PUT_LOOP_POWER) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0st-=
>comp_gpio_offsets[comp_gpio_i++] =3D i;
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0strength =3D config->drive_strength;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0ret =3D ad74413r_set_comp_drive_strength(st, i, strength)=
;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0if (ret)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return re=
t;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0strength =
=3D config->drive_strength;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D a=
d74413r_set_comp_drive_strength(st, i,
> strength);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ret)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return ret;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0}


So, I'm not really that familiar with this part and, at this stage, I'm bei=
ng
lazy to check the datasheet. My concern is about breaking some other users.=
..
So, does it make any sense for having drive-strength-microamp in a non digi=
tal
input at all? Can anyone have a working device by specifying that dt parame=
ter
on a non digital channel (or expect something from having that parameter se=
t)?
Or the only effect is to actually have some functions misbehaving?

It feels to me (from your description) that this property is something that
makes sense to be restricted and should also have that dependency stated in=
 the
bindings but it might be to late for that (as some users might have validat=
ed
their devicetrees already). On the driver side, if it's never right to have
these settings together, then the patch is valid since if someone has this,=
 his
configuration is broken anyways (maybe that's also a valid point for the
bindings)...

- Nuno S=C3=A1

