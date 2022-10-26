Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5A160DBD2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 09:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233132AbiJZHFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 03:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233239AbiJZHFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 03:05:15 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6865BCAE
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 00:05:11 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id n14so5326642wmq.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 00:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zQUyYnkfD/QphPAhvZx7MKv0769amG9itPpYbqF4pAg=;
        b=qWl7iB7LmbYBsmiX/9/8KvoCoJKf1FBBDgoMyja/yFA/2kloeRbdOx+lTsehp+1xE/
         JjW4RdhwYefgJ30e7ZNhJYflZDRgkBtMFEqItkbKfvWOPSkCnaZhS0ZjJ6glzS/to6M6
         3TfsfLPB53AJrNDOm2gBL04x1qu2IHJJT/AIVP4pGx7Y3xULtbwHFE3B3d1pwgdtDsS3
         ILAB8k2YLQoILmJPqrDeNZNk0O1op4H1u7NsZ7QZy0tIGk5tnxLJWAL+m551aLxu1PWc
         /Ky4ak4ThxXs5SyOGK57yu94EgeYfIpbsQ3JeVzG57ZLorCPk2lXUw9BwxisJJPYfCLS
         XzGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zQUyYnkfD/QphPAhvZx7MKv0769amG9itPpYbqF4pAg=;
        b=1c0um7AKXTOdCQj6d2y+PjO2WABu7QRbG3BZqhGVwNXrHNEgpjdT6trGXiyc60Yj9r
         z0aR8mqBWebp3mHRGW/4fludMO8R8YavwHLewLcFt5Ugj8HqqV2oFd0xF6ft59SP/mU1
         LVKSuvHFTfoHzzz99I3T8X24Ye09e8cUmZKDQfepmR4LWR8fG9TaGFxkKVoZ1lWav9oW
         dBH/KXFTyMh4zUFyg6l8pOUXMtPSj0CpYeVnTeYGTkDfjuhWdygvPV+Bp6J32k0tWHGw
         CjncWVM/gqUFaqsWPcCr785a2B5oCwuDBbTzNrLj6v3SzI0+7UT/VGODJLIZvPdI2mGr
         RgmQ==
X-Gm-Message-State: ACrzQf1zIl+mIrbmkg7DcNhF6DYD2/IJPeIZ34r9TdCSQDqnERh6OAIO
        mjIWpMU2NFt7J8R53Dsev8jF91No8vsd6EYDmJf0M22xB+MEHg==
X-Google-Smtp-Source: AMsMyM5C9NLr2Kz1+vKkOOJ10yx17T4xwIKTzoLig0Zw9Z44q8yI20nka6ZVPN9VHFsB21O4aWfFUz+j7o/G73EyP7U=
X-Received: by 2002:a05:600c:1990:b0:3c9:a5e8:addb with SMTP id
 t16-20020a05600c199000b003c9a5e8addbmr1273615wmq.140.1666767909354; Wed, 26
 Oct 2022 00:05:09 -0700 (PDT)
MIME-Version: 1.0
References: <1666318661-11777-1-git-send-email-u0084500@gmail.com>
 <CAHp75VeMvWycVsNPHb1cvMbtVSCiX3m9wUsZk7HkPU+e=VTb3A@mail.gmail.com>
 <CADiBU3_m1gDgZxyo53UNvDP8P5LpFgpV+mBbw9+_epYuXimqWA@mail.gmail.com>
 <CAHp75VeWMSeZiq6vUo25hRdueMbeEEQuzPqR=-ROsOufK+27LQ@mail.gmail.com>
 <CADiBU39UF3Ez-80Xauy8qaO0iSyh-n-ZxScH+aZt3m=s3qkOjA@mail.gmail.com> <CAHp75VevGHnZKJvsdJ6QpWbHdhWP0VW0G71QLqRDvgk8MFeNUg@mail.gmail.com>
In-Reply-To: <CAHp75VevGHnZKJvsdJ6QpWbHdhWP0VW0G71QLqRDvgk8MFeNUg@mail.gmail.com>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Wed, 26 Oct 2022 15:04:57 +0800
Message-ID: <CADiBU39pRnrTuCM4OEFpLwEP9c86aJz2L6+G7yFm22i+7Gt8pw@mail.gmail.com>
Subject: Re: [PATCH v2] mfd: mt6370: Add the out-of-bound check to prevent the
 null pointer
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     lee@kernel.org, matthias.bgg@gmail.com, chiaen_wu@richtek.com,
        cy_huang@richtek.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Shevchenko <andy.shevchenko@gmail.com> =E6=96=BC 2022=E5=B9=B410=E6=9C=
=8821=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=886:35=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> On Fri, Oct 21, 2022 at 12:58 PM ChiYuan Huang <u0084500@gmail.com> wrote=
:
> > Andy Shevchenko <andy.shevchenko@gmail.com> =E6=96=BC 2022=E5=B9=B410=
=E6=9C=8821=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=885:14=E5=AF=AB=E9=
=81=93=EF=BC=9A
> > > On Fri, Oct 21, 2022 at 12:02 PM ChiYuan Huang <u0084500@gmail.com> w=
rote:
> > > > Andy Shevchenko <andy.shevchenko@gmail.com> =E6=96=BC 2022=E5=B9=B4=
10=E6=9C=8821=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=884:34=E5=AF=AB=
=E9=81=93=EF=BC=9A
> > > > > On Fri, Oct 21, 2022 at 5:17 AM cy_huang <u0084500@gmail.com> wro=
te:
>
> ...
>
> > > > > https://www.kernel.org/doc/html/latest/process/submitting-patches=
.html#backtraces-in-commit-messages
> > >
> > > Have you had a chance to read this section of the document?
> > >
> > OK, get it.
> > Is the below text enough to express this problem?
>
> It is you who decides, because I don't know what exact problem this
> will represent.
>
> > Ex. Testing as below (mt6370 register range from 0 to 0x1ff)
> >    rg_bound_show()
> >         regmap_raw_read(regmap, 0x200, &val, sizeof(val));
>
> > pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
>
> For example, why is this line here?
>
> > pc : i2c_smbus_xfer+0x58/0x120
> > lr : i2c_smbus_read_i2c_block_data+0x74/0xc0
> > Call trace:
> >  i2c_smbus_xfer+0x58/0x120
> >  i2c_smbus_read_i2c_block_data+0x74/0xc0
> >  mt6370_regmap_read+0x40/0x60
> >  _regmap_raw_read+0xe4/0x278
> >  regmap_raw_read+0xec/0x240
> >  rg_bound_show+0xb0/0x120
>
> The rule of thumb is that it's okay to shrink to ~4-5 lines (in most case=
s).
>

At first, I start this thread due to  the original thread seems stopped
Since it already restarted, please forget this one.
Just follow the restaed thread for the discussion.
https://lore.kernel.org/all/Y1aCiReTZDbPp%2FrS@kadam/

> --
> With Best Regards,
> Andy Shevchenko
