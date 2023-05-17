Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 268D0707657
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 01:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbjEQXU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 19:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjEQXU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 19:20:28 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B186A2D76;
        Wed, 17 May 2023 16:20:26 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1ae51b07338so9272245ad.0;
        Wed, 17 May 2023 16:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684365626; x=1686957626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0FGTT8QnCRYYOWleyT4irBH5JIyvwsw53gKLlMTCAtQ=;
        b=aULJWNAMgfDlK62yhEWh0LWjt81wS7PYKGheaRXWRwVdbgfQz+Q9NpHOCIIZI/hpQp
         16qrIGkDmWNV7fe/zVMR3IL3vstgjv/98yi6dSu7BGgKhsttgzgn/fiP1EAhhhkjKUVA
         lH3CZH6D4KoCY0B1F1+o/MMxx4Osk9FOnxjTqCUUumQ4k9RgUyuJu7+yJYEjUkPIp3a8
         ENo2q/zZ0XiRh59nFvvdNmZ2C9jpAxPJW3LGYNH1ByW/nedMzTMslZORY4Zvj5ZeL8Sw
         1IvCaiPOM4aeqSD52oI6Kd1xaBCdKJhqF5fXCfmiU4OYHZKNnYq3UyJfkvwolqYxyg/J
         bjKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684365626; x=1686957626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0FGTT8QnCRYYOWleyT4irBH5JIyvwsw53gKLlMTCAtQ=;
        b=JqrnEFUyIWyjK4a4Rr41LwLRmJQsaX+LxZ2bhSvtJDCiCnxbHvl7sY1sHhYcDkUDiO
         0HJCV0sA+XQZ1xVpBGujoEIrQ2axbAJPhD5N5uHjPAJ4cobE2uGs1Qr0nKsnl/slFEct
         xJ+O4f6yBjsZEytKI5zUquqoe+q7o/XWuGMgoowodyw+3dyhGtZSbuzeaNJseUqTu6hh
         nhZVRFUk7iW+UHs+0PW+saM05gAPkliZBoct7oqk/Hp3VH4FwbEWMmEdZyci3ohCuszr
         4GFm9oKco4Ldq0qjwv5RO7KCs3Fp0vJAeEZNLxR0r9kYB5J3YACo3G3gvIcbwrQDb68l
         AWsQ==
X-Gm-Message-State: AC+VfDwKUYQSq8TalNLCk6RWY9V5JTwaiXKvqRy3bvPE69YGVeuSwEQ7
        EqLFe72In9PoGn+n2lwrItNyLsenLc66ORv5eaw=
X-Google-Smtp-Source: ACHHUZ7DVMIpDP0wVFvhPmg32T37MXUYBQVHIbryPEsZqhKGHHq+QWaLxPQUnrkWMUmfEn1oOMPAem/FTp/OAbNB3gA=
X-Received: by 2002:a17:903:2287:b0:1a6:77b8:23e0 with SMTP id
 b7-20020a170903228700b001a677b823e0mr483539plh.60.1684365625988; Wed, 17 May
 2023 16:20:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230517223007.178432-1-boerge.struempfel@gmail.com> <CAOMZO5CqMMCCOsAB3YgJUUampE=iZru57d=qoX13-GkSaaC5gg@mail.gmail.com>
In-Reply-To: <CAOMZO5CqMMCCOsAB3YgJUUampE=iZru57d=qoX13-GkSaaC5gg@mail.gmail.com>
From:   =?UTF-8?B?QsO2cmdlIFN0csO8bXBmZWw=?= <boerge.struempfel@gmail.com>
Date:   Thu, 18 May 2023 01:20:14 +0200
Message-ID: <CAEktqcuMrqiwDfGM=SAoHiKPY-hupS+jipt=6Tasr1q8VUvRQQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] spi: add SPI_MOSI_IDLE_LOW mode bit
To:     Fabio Estevam <festevam@gmail.com>
Cc:     bstruempfel@ultratronik.de, andy.shevchenko@gmail.com,
        amit.kumar-mahapatra@amd.com, broonie@kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
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

Thank you for your prompt feedback

Am Do., 18. Mai 2023 um 00:43 Uhr schrieb Fabio Estevam <festevam@gmail.com=
>:
>
> On Wed, May 17, 2023 at 7:30=E2=80=AFPM Boerge Struempfel
> <boerge.struempfel@gmail.com> wrote:
> >
> > Some spi controller switch the mosi line to high, whenever they are
> > idle. This may not be desired in all use cases. For example neopixel
> > leds can get confused and flicker due to misinterpreting the idle state=
.
> > Therefore, we introduce a new spi-mode bit, with which the idle behavio=
ur
> > can be overwritten on a per device basis.
> >
> > Signed-off-by: Boerge Struempfel <boerge.struempfel@gmail.com>
> >
> >
> > Link for versions:
> >   v1 and v2: https://lore.kernel.org/linux-spi/20230511135632.78344-1-b=
struempfel@ultratronik.de/
> >   v3: https://lore.kernel.org/linux-spi/20230517103007.26287-1-boerge.s=
truempfel@gmail.com/T/#t
> >
> > Changes from V3:
> >   - Added missing paranthesis which caused builderrors
> >
> > Changes from V2:
> >   - Removed the device-tree binding since this should not be managed by
> >     the DT but by the device itself.
> >   - Replaced all occurences of spi->chip_select with the corresponding
> >     macro spi_get_chipselect(spi,0)
> >
> > Changes from V1:
> >   - Added patch, introducing the new devicetree binding flag
> >   - Split the generic spi part of the patch from the imx-spi specific
> >     part
> >   - Replaced SPI_CPOL and SPI_CPHA by the combined SPI_MODE_X_MASK bit
> >     in the imx-spi.c modebits.
> >   - Added the SPI_MOSI_IDLE_LOW bit to spidev
>
> The change log should be placed below the --- line.
>

My bad. Thanks for letting me know. Just to clarify: I put the
changelog directly below
the first ---? And do I then put another --- between the changelog and
the following
include/uapi/linux/spi/spi.h | 3 ++- line?  or is there just a
new-line seperating them.

And if you don't mind my trivial questions, am I supposed to write a
cover letter for
the patch-stack? I seem to find contradictory answers to this question onli=
ne.

> > ---
> >  include/uapi/linux/spi/spi.h | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/uapi/linux/spi/spi.h b/include/uapi/linux/spi/spi.=
h
> > index 9d5f58059703..ca56e477d161 100644
> > --- a/include/uapi/linux/spi/spi.h
> > +++ b/include/uapi/linux/spi/spi.h
> > @@ -28,6 +28,7 @@
> >  #define        SPI_RX_OCTAL            _BITUL(14)      /* receive with=
 8 wires */
> >  #define        SPI_3WIRE_HIZ           _BITUL(15)      /* high impedan=
ce turnaround */
> >  #define        SPI_RX_CPHA_FLIP        _BITUL(16)      /* flip CPHA on=
 Rx only xfer */
> > +#define SPI_MOSI_IDLE_LOW      _BITUL(17)      /* leave mosi line low =
when idle */
>
> Should tools/spi/spidev_test.c be changed to include this new
> mosi-idle-low option?

Until now I actually wasn't aware of this tool. However on first
glance, it seems
reasonable to add this mode bit. I can certainly add this mode bit to
the spidev_test
if desired.

While looking through the code, I noticed, that the latest two
additions to the spi->mode
(SPI_3WIRE_HIZ and SPI_RX_CPHA_FLIP) are also missing from this tool. Is th=
is
by design, or should they then be included as well?
