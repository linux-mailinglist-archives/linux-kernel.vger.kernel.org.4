Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1420E607493
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 11:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbiJUJ7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 05:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbiJUJ64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 05:58:56 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B55722591F0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 02:58:54 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id m29-20020a05600c3b1d00b003c6bf423c71so4670927wms.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 02:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NU2NbgcaNv69sQDmmdXSiV8oJ0c/tR30K48SfUDQxJQ=;
        b=YVz15Tj2qWM18F2xMT4saIjsnFSqycvVeautXKJ88W8tCdkV8fyielO/OAmoPwhFB4
         lndnlfABDK4D2BDMk989azO044wpQHfJmL2wCqOx3aSytvWA45kuC2aNbmYXaz9gxF5X
         FEx+Sis43KL28RjQPqS25t/zwCjDaBnJmAVjbu/9cHyFpbs0/1gpomyIhy/UoUmDgLql
         miFdS7R1iJeH2lTWMkfLyvCFzTODF3+kNFE5ekLV+xpyU6dAsN4vVOUMHApG8SCA+3ov
         8GEEoWcPZifkxYlFHNJ39rqFYsFuQbVn+tuagCet0f/j755Il4b8z67S5Y4fcbjLFEHX
         0yPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NU2NbgcaNv69sQDmmdXSiV8oJ0c/tR30K48SfUDQxJQ=;
        b=QswnlMQHZg+Bts97oEiF3Bhy5dNYdgnnu35rOVpeYMoLP9TTMBs+nRzvblnl8VcDVp
         lZ0YTzLi8xUTZNThmzCfXMpSav3qyYXDCOtBSlMfhuhBIEfxsxv6WL1lTwHg8qiGquL0
         xqjqE/7aIhrB9RJMGqxt55xMqaIp/sRXMZ3wnCuDE6+eauImrEWGTiEJSm9Va6rHz6PJ
         d/X2KdYL9cAiUbK0Xi8EHm2XmCV2Z9J4HJEjLi47+k81N6+dbFaMW3dEubluIa5KUfze
         72a7bXJsaszxC7E+XToPkWOlYLTfT6FFvcZ5bsbjJxzolDqKfk4as8QcGepbiRNWSbKe
         sD7Q==
X-Gm-Message-State: ACrzQf3kQkzWXDHQy9MK1uEfK89ZI+i8ubQWIWMC9OHLh01uiHZy8pG9
        9py8EAsSV+HzbdyTmieYPTAj5UPLxqa5vvuDaQfO/bfLQi8gbg==
X-Google-Smtp-Source: AMsMyM6pGZ/KuWewpKay2Z4t7ome5Jos7xxu92d7020CUOBbNh4uXFe7dtOgDbgkJWAGNCGvSJe+2KJ7GAte93SZRx4=
X-Received: by 2002:a05:600c:5c4:b0:3c5:9a14:e5f6 with SMTP id
 p4-20020a05600c05c400b003c59a14e5f6mr12875523wmd.153.1666346332225; Fri, 21
 Oct 2022 02:58:52 -0700 (PDT)
MIME-Version: 1.0
References: <1666318661-11777-1-git-send-email-u0084500@gmail.com>
 <CAHp75VeMvWycVsNPHb1cvMbtVSCiX3m9wUsZk7HkPU+e=VTb3A@mail.gmail.com>
 <CADiBU3_m1gDgZxyo53UNvDP8P5LpFgpV+mBbw9+_epYuXimqWA@mail.gmail.com> <CAHp75VeWMSeZiq6vUo25hRdueMbeEEQuzPqR=-ROsOufK+27LQ@mail.gmail.com>
In-Reply-To: <CAHp75VeWMSeZiq6vUo25hRdueMbeEEQuzPqR=-ROsOufK+27LQ@mail.gmail.com>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Fri, 21 Oct 2022 17:58:40 +0800
Message-ID: <CADiBU39UF3Ez-80Xauy8qaO0iSyh-n-ZxScH+aZt3m=s3qkOjA@mail.gmail.com>
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
=8821=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=885:14=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> On Fri, Oct 21, 2022 at 12:02 PM ChiYuan Huang <u0084500@gmail.com> wrote=
:
> > Andy Shevchenko <andy.shevchenko@gmail.com> =E6=96=BC 2022=E5=B9=B410=
=E6=9C=8821=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=884:34=E5=AF=AB=E9=
=81=93=EF=BC=9A
> > > On Fri, Oct 21, 2022 at 5:17 AM cy_huang <u0084500@gmail.com> wrote:
>
> > > It looks like you randomly cut the trace.
> > > It's not what I meant and documentation suggests.
> > >
> > I checked the submitting-patch.rst.
> > To satisfy the requirement for 70-75 chars per line, I only keep the
> > important log.
> >
> > May I ask what you mean for the 'trim'?
> > Is it 'Still keep 70-75 per line and cut the characters that's over
> > the limit to the next line"?
>
> > > https://www.kernel.org/doc/html/latest/process/submitting-patches.htm=
l#backtraces-in-commit-messages
>
> Have you had a chance to read this section of the document?
>
OK, get it.
Is the below text enough to express this problem?

Ex. Testing as below (mt6370 register range from 0 to 0x1ff)
   rg_bound_show()
        regmap_raw_read(regmap, 0x200, &val, sizeof(val));

pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
pc : i2c_smbus_xfer+0x58/0x120
lr : i2c_smbus_read_i2c_block_data+0x74/0xc0
Call trace:
 i2c_smbus_xfer+0x58/0x120
 i2c_smbus_read_i2c_block_data+0x74/0xc0
 mt6370_regmap_read+0x40/0x60
 _regmap_raw_read+0xe4/0x278
 regmap_raw_read+0xec/0x240
 rg_bound_show+0xb0/0x120
> --
> With Best Regards,
> Andy Shevchenko
