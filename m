Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5A172FD7A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 13:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244316AbjFNLxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 07:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244313AbjFNLxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 07:53:51 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D189B1FC8;
        Wed, 14 Jun 2023 04:53:49 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-62fd844ad58so6231176d6.2;
        Wed, 14 Jun 2023 04:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686743629; x=1689335629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZS2lMjhS150xsE48ij5XC9WhECD/qOohOc1UU6rm/Rk=;
        b=WL7FLpfO6TThmEhak78A9v7KhNeVnOvvVlVJAREBR+ZmpfNggvvC18CFX3SOjOVGA4
         dB9QPzA2uHNyag5izydIQqM7IxFnAOmAAYNxb+U9RCmHEMRe93BXocan2rIWPghtGRgF
         G9/tx3T3yQOZLw+cdKY3LcBd5l+QOTVN0GAiObr1SIUl4F4VKWW3/TQT5tFFbrQgYwiH
         agRb3Oe1vZQLa/hK4GbfiAbe3wJH281GbQuFoDbpuXdACMUsqHDepBagslSCwPr7nVzC
         Lak9KlNsKXrEpOXeukC1JXiFOV7RFwYPw3QmWGYGIw5iFJ+3ckZn9NNkvyFFDl6sViGA
         v5Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686743629; x=1689335629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZS2lMjhS150xsE48ij5XC9WhECD/qOohOc1UU6rm/Rk=;
        b=NrMXPfSMMee0/t6oLN9qPV8NyM1pbicPBHoBF69C5Sq9KynubMs7xaYsMFUjsfEeYy
         1MCQuC/rrvtbnwd9u1IzekgVufaP8WWMizjIoa+WBUPPjRLel42Me9DsjTUYQ0Xcpc8g
         OoDMKEr90BIht0A8Z/+LYr0LxlTEdfaItool3E9CxXAcsDVE1uYD34lcELXxBCaDrisY
         gBm/bfZHYpfGysZ/IFlxFChfNCjE7R2lU+Xw6izwWBN6Tqzuis0+fJ8Lwk3SqR1Tom4C
         9a3pXj1KB39fTk4Rz2tnVdcxnYJlwkV4VUyVEp7RiLqTDKR/cF91bCcUOMDM14X0MYOt
         gqvA==
X-Gm-Message-State: AC+VfDww3L4/tSJG0nX1qtJoDEQNJtEvYlAL7XgXsFG5Mky8Ox5g+nDz
        Ypmsog2vf8/wssZ42I1yF8R954UXVIvwl3JsCas=
X-Google-Smtp-Source: ACHHUZ4OS60RMC7dAvReRt36J8AbexOy+YxZ6c5xQP8QMAviDB3TBhKZL0DnDWB00NhIjiBPz1VOtkhzdbb+thwJHXI=
X-Received: by 2002:ad4:5f0a:0:b0:626:33bb:3fd3 with SMTP id
 fo10-20020ad45f0a000000b0062633bb3fd3mr19594080qvb.19.1686743628859; Wed, 14
 Jun 2023 04:53:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230614004857.134980-1-kimseer.paller@analog.com>
 <20230614004857.134980-2-kimseer.paller@analog.com> <CAHp75VcTXsZZ4JsKWS0RuccPKRLO9ci+87b538BT9V9ZZ_WACg@mail.gmail.com>
 <a6488485909d40b3810ad15787cd2100@analog.com>
In-Reply-To: <a6488485909d40b3810ad15787cd2100@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 14 Jun 2023 14:53:12 +0300
Message-ID: <CAHp75VdQJ39Uw8bPD+y7GS7W2iJhjs2D4L-=-Fo0Jeb+8Ffn8g@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] iio: adc: max14001: New driver
To:     "Paller, Kim Seer" <KimSeer.Paller@analog.com>
Cc:     "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
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

On Wed, Jun 14, 2023 at 1:43=E2=80=AFPM Paller, Kim Seer
<KimSeer.Paller@analog.com> wrote:
> > From: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Sent: Wednesday, June 14, 2023 5:12 PM

...

> > > +               /* select external voltage reference source for the A=
DC */
> > > +               ret =3D max14001_reg_update(st, MAX14001_CFG,
> > > +                                         MAX14001_CFG_EXRF, 1);
> > > +
> > > +               ret =3D regulator_get_voltage(vref);
> > > +               if (ret < 0)
> > > +                       return dev_err_probe(dev, ret,
> > > +                                            "Failed to get vref\n");
> >
> > Is it important to choose the external reference source _before_ gettin=
g the
> > voltage of the regulator? If not, I would swap these calls, otherwise t=
he
> > comment is needed to explain why the sequence is important in the way i=
t's
> > written.
>
> It is not important. These calls can be swap without any issues.

If you send a new version, please swap, otherwise I hope Jonathan can
do it when applying.

--=20
With Best Regards,
Andy Shevchenko
