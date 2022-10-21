Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D621C60750F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 12:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiJUKgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 06:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiJUKfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 06:35:48 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C5BE4C03
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 03:35:45 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id o22so1707764qkl.8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 03:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Za+SONx9FuqbfM12ClF5Cp/+gi925kNZnyxgujZpLSI=;
        b=DyZpQ0C+jrknGd6nJ/f/iHuWj77lfftkQHQiuwxEiibZXV6aHOp4T/fv5lqJijDm4+
         aJvslSn2xq6g9Pc0vQaibGyyQJMXVi3Bul3byrf6mUMcQfFvrLgosbpWSXTR+ZsNecPV
         3vGvroDOVBc4cv9FINmGhOvDHTWlQA8AEd81rKjCB22jwKOGfppepRYDPmaBu9R1Dc99
         LZ+o7Wc5rC/EyEbBbZUZ45AaNB3rTnrxCLWHK1Yv/n8ZP5CVJdsSRDhlRc4t1LMikJGL
         7Fnj7Srmr0IQFvQNnCGG7cF+hE4DL4LMpmxsEJx2cgev0Dlv4i6S2JbmvvezAE7HQHGr
         W8xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Za+SONx9FuqbfM12ClF5Cp/+gi925kNZnyxgujZpLSI=;
        b=V2jyKuFJVN0OREb7c9NrZaidIpooRIok+L3FNVK0WYDXig7GYE/wHeTBEqjxE2woQR
         kaT6yI4qFaNDnzArRNp1lVKFHy+X8QmBtRNlDPULtRmK0ePU2oy1/lScDeEsxCk87Rq8
         +YRvzxB1U63wUn0vHMArl4fmJA91hFLaFqOtWSmZ2UOoXZ9ezoq8DQ60btnr/yyvypvt
         mu5FlNvcHA2YIUMC6sUDLsE3QD7Z7RyvzhBBZs5lj2pFeiRNayfqAM/GH3XPBLlTvW/2
         mraaVwIro+yoZdkp5UA3LwoIV++QzUzZp3A9HHujaQ18/MmeTqqQC2jTNS7R/EaTRtxy
         cw3w==
X-Gm-Message-State: ACrzQf31sWJdHOrjDZ7/8Ye1or0s1TSGoUKxIA3I+qy0PH1bQNPqDI8O
        oAadKX/fPJAm+POAM/kQkFDxbLJmJJggJSUrkQc=
X-Google-Smtp-Source: AMsMyM7+9bv0iDWdZKvVgQQO7F2TQHEZWWq8TGVAyroaBe2isT7nLForkwXnBFmQTJ9upc9nFC93UZW1bX4N/b3Ozf0=
X-Received: by 2002:a05:620a:410e:b0:6ee:b96b:a831 with SMTP id
 j14-20020a05620a410e00b006eeb96ba831mr13512410qko.734.1666348544126; Fri, 21
 Oct 2022 03:35:44 -0700 (PDT)
MIME-Version: 1.0
References: <1666318661-11777-1-git-send-email-u0084500@gmail.com>
 <CAHp75VeMvWycVsNPHb1cvMbtVSCiX3m9wUsZk7HkPU+e=VTb3A@mail.gmail.com>
 <CADiBU3_m1gDgZxyo53UNvDP8P5LpFgpV+mBbw9+_epYuXimqWA@mail.gmail.com>
 <CAHp75VeWMSeZiq6vUo25hRdueMbeEEQuzPqR=-ROsOufK+27LQ@mail.gmail.com> <CADiBU39UF3Ez-80Xauy8qaO0iSyh-n-ZxScH+aZt3m=s3qkOjA@mail.gmail.com>
In-Reply-To: <CADiBU39UF3Ez-80Xauy8qaO0iSyh-n-ZxScH+aZt3m=s3qkOjA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 21 Oct 2022 13:35:07 +0300
Message-ID: <CAHp75VevGHnZKJvsdJ6QpWbHdhWP0VW0G71QLqRDvgk8MFeNUg@mail.gmail.com>
Subject: Re: [PATCH v2] mfd: mt6370: Add the out-of-bound check to prevent the
 null pointer
To:     ChiYuan Huang <u0084500@gmail.com>
Cc:     lee@kernel.org, matthias.bgg@gmail.com, chiaen_wu@richtek.com,
        cy_huang@richtek.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 12:58 PM ChiYuan Huang <u0084500@gmail.com> wrote:
> Andy Shevchenko <andy.shevchenko@gmail.com> =E6=96=BC 2022=E5=B9=B410=E6=
=9C=8821=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=885:14=E5=AF=AB=E9=81=
=93=EF=BC=9A
> > On Fri, Oct 21, 2022 at 12:02 PM ChiYuan Huang <u0084500@gmail.com> wro=
te:
> > > Andy Shevchenko <andy.shevchenko@gmail.com> =E6=96=BC 2022=E5=B9=B410=
=E6=9C=8821=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=884:34=E5=AF=AB=E9=
=81=93=EF=BC=9A
> > > > On Fri, Oct 21, 2022 at 5:17 AM cy_huang <u0084500@gmail.com> wrote=
:

...

> > > > https://www.kernel.org/doc/html/latest/process/submitting-patches.h=
tml#backtraces-in-commit-messages
> >
> > Have you had a chance to read this section of the document?
> >
> OK, get it.
> Is the below text enough to express this problem?

It is you who decides, because I don't know what exact problem this
will represent.

> Ex. Testing as below (mt6370 register range from 0 to 0x1ff)
>    rg_bound_show()
>         regmap_raw_read(regmap, 0x200, &val, sizeof(val));

> pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)

For example, why is this line here?

> pc : i2c_smbus_xfer+0x58/0x120
> lr : i2c_smbus_read_i2c_block_data+0x74/0xc0
> Call trace:
>  i2c_smbus_xfer+0x58/0x120
>  i2c_smbus_read_i2c_block_data+0x74/0xc0
>  mt6370_regmap_read+0x40/0x60
>  _regmap_raw_read+0xe4/0x278
>  regmap_raw_read+0xec/0x240
>  rg_bound_show+0xb0/0x120

The rule of thumb is that it's okay to shrink to ~4-5 lines (in most cases)=
.

--=20
With Best Regards,
Andy Shevchenko
