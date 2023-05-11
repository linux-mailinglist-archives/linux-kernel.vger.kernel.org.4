Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E88516FED20
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 09:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237660AbjEKHug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 03:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231625AbjEKHuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 03:50:32 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0674E469F;
        Thu, 11 May 2023 00:50:31 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-61b5a6865dfso66000836d6.3;
        Thu, 11 May 2023 00:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683791430; x=1686383430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H7WMuVCgOkbuhGC7m2MG5PQvTB0YoiyPQB7UrE0k3Fc=;
        b=CEFjlzJKSM1hdKrGSd1YWdxYQtJjNJZUgp0Hpwo+48YtiR13q+SlCC26ynEHHDp2t9
         8BKtQsh0PXmwtMJvPJ8KN/SB3hQ9ZiXhdYCP4bi4rkFhC/2T6/NSq0uV4RjWv0vadZ9x
         +nGhvoUUBJpIJ5Z+PQujwVzZTEuM/IF24cYu26yL93Qe93efI0pEmI63b0nHXIMDp9oG
         D64Uzz6AmTRMBvDwqI9UdcQKgcpNYbdlJL15vAmze2b3E8/uNi9CS8AB4jfHYcEhXxcZ
         8JOjhpYgazGbyqHW8i2XLar5ZtyzZcwq2DQ35ltRwowLCunSFQZiAyD0/L1KWKLh32y6
         sQtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683791430; x=1686383430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H7WMuVCgOkbuhGC7m2MG5PQvTB0YoiyPQB7UrE0k3Fc=;
        b=V1al4H5kSX+GBwI/u/41M3Qo5ZQePWzMbVvfpFB+tWYuH5A3ekqk6XlP0V1lIwT6Q3
         EtrteMMn3bkRUqgp+eX+7mqfwpN6MD0CsoJk9NU4Te8C354c38yl1m7y8SbOoJ+vjBOD
         xtQrdnjjsidw+yu9wSZvak6CCakhsypMMsb105JLxiHsxgAHD/cYZw1yUJG4X+AG2H84
         2siJ3wyASIU11zXnoROsTVY50gkQTH6eaqV1Z03QVCLdUkCaSFCx1xm1Ug50M0/Dr5pf
         1rTlyxzyQ1c0axyEGSSQxgtsglwt8/YQvGbvGlVLvGiIX98VwDSykgy3MQEpuDfmnoz/
         hDAQ==
X-Gm-Message-State: AC+VfDx6n7x8DDCCSFGWOPiR0HlYj+iU8ntoL86xYKOfMxD6wxp06kPa
        mO87eFpaHWtkfAMlGsGWVXX/xzfYZRf7Lh0Z9O+rARhb4CnLvA==
X-Google-Smtp-Source: ACHHUZ6zuzpuizwBFMWuTu3XPGD4XZW9WJPgQChSNY0dB9AMuJlvz+wNMJOijEDmuj4y2YAWZucpS/oc03EGAUYcipc=
X-Received: by 2002:a05:6214:48b:b0:5ef:486a:505e with SMTP id
 pt11-20020a056214048b00b005ef486a505emr32434740qvb.41.1683791430102; Thu, 11
 May 2023 00:50:30 -0700 (PDT)
MIME-Version: 1.0
References: <0b3a257a-f1e5-ad86-4c69-93e038a33ce9@yoseli.org>
 <ZFvTi3tQGUq2OCHi@surfacebook> <32ecb9f3-1443-210c-0fc9-40891629e25a@yoseli.org>
In-Reply-To: <32ecb9f3-1443-210c-0fc9-40891629e25a@yoseli.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 11 May 2023 10:49:53 +0300
Message-ID: <CAHp75Vcsieiab8ks7yLwJvhjHTPv2qeCBJYjMOVYBJXmNhbTYQ@mail.gmail.com>
Subject: Re: pca953x issue when driving a DSI bridge
To:     Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        brgl@bgdev.pl, linus.walleij@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023 at 11:18=E2=80=AFPM Jean-Michel Hautbois
<jeanmichel.hautbois@yoseli.org> wrote:
> On 10/05/2023 19:25, andy.shevchenko@gmail.com wrote:
> > Wed, May 10, 2023 at 06:12:19PM +0200, Jean-Michel Hautbois kirjoitti:

...

> >> [   11.273968]  gpiod_set_value+0x5c/0xcc
> >> [   11.277722]  ti_sn65dsi86_resume+0x4c/0x94 [ti_sn65dsi86]
> >
> > Your problem even worse, i.e. ->resume() might sleep.
>
> Indeed it is worse ;-).
>
> >> [   11.283131]  __rpm_callback+0x48/0x19c
> >> [   11.286885]  rpm_callback+0x6c/0x80
> >> [   11.290375]  rpm_resume+0x3b0/0x660
> >> [   11.293864]  __pm_runtime_resume+0x4c/0x90
> >> [   11.297960]  __device_attach+0x90/0x1e4
> >> [   11.301797]  device_initial_probe+0x14/0x20
> >> [   11.305980]  bus_probe_device+0x9c/0xa4
> >> [   11.309817]  device_add+0x3d8/0x820
> >> [   11.313308]  __auxiliary_device_add+0x40/0xa0
> >> [   11.317668]  ti_sn65dsi86_add_aux_device.isra.0+0xb0/0xe0 [ti_sn65d=
si86]
> >> [   11.324381]  ti_sn65dsi86_probe+0x20c/0x2ec [ti_sn65dsi86]
> >> [   11.329876]  i2c_device_probe+0x3b8/0x3f0
> >> [   11.333889]  really_probe+0xc0/0x3dc

...

> >> I suppose this is not a corner case and we may have other drivers and =
other
> >> boards connecting a GPIO which can sleep in a context where it should =
not ?
> >>
> >> I would like to add one thing: on this board, the expander is routed i=
n a
> >> way that makes it impossible to "sleep" as the reset is forced pulled-=
up and
> >> the power regulators are fixed and can't be stopped.
> >
> > Can you elaborate why you think there is a problem?
>
> I didn't know if it could be an issue or not, so I mentioned it but
> sounds like a nonsense :-).

Maybe not. I don't know that hardware, schematics and more information
is needed to understand. But I leave it to you.

> >> I don't know how to address this issue nicely and any thoughts is
> >> appreciated !
> >
> > As a workaround you can consider the code around i2c_in_atomic_xfer_mod=
e()
> > but since I have heard about i.MX8 so many negative remarks which makes=
 me
> > think that hardware is a train wreck and shouldn't be used at all.

> Not sure to get the workaround proposal right...

There are possibilities to have atomic I2C transfers, but as comment
says (on top of the above mentioned function) that is only for PMIC
communications at the system shutdown.

In your case I would try the easiest way (taking into account that
hardware connection is not preventing us from sleeping context), i.e.
check if the function that has GPIO call may sleep on its own and
simply replace gpiod_set_value() by gpiod_set_value_cansleep().

> I won't argue about i.MX8 ;-).


--=20
With Best Regards,
Andy Shevchenko
