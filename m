Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 907E47132EF
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 09:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbjE0HXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 03:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbjE0HXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 03:23:03 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3939CE59;
        Sat, 27 May 2023 00:22:51 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-3f8115ca685so3642651cf.1;
        Sat, 27 May 2023 00:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685172170; x=1687764170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bx/DAb75BmWuNXNDQ1rY8cIudjVwuu30lJjKuSeJlqc=;
        b=npExarejaqJFOfFqRRWCyJ7CrKVUBbdXr3ajIhmZjcIBticCEnAhcvmmODxfgqsRYN
         eKRegheiUnCr62U2YxnPVqxnSWODmTIMxhIj3zUdeyqEKxHfyBSkiqGaiacsIg6I4Aj1
         m+Az0HNwPSFy9bScE3HaUzkemlNcrQeJXiF0HSNJPl8KxNK99ZWjrqeNVVETaYkxF3Rg
         ws54dPWKK6oc3eXyRpJW0eB/VY9jTBEG195EKBZBp5dGRUSCM2bo1vwqQV5MSlGMsAyj
         LLkGikrL2za/jibP1N/tQawUQOve48If+ZP9zKfxxmJDhqnO6QTLQDOH6mcZz0pjXYvX
         QfdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685172170; x=1687764170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bx/DAb75BmWuNXNDQ1rY8cIudjVwuu30lJjKuSeJlqc=;
        b=geFt9e6GjuU2zYhBgwLbZnFV450z9/vhwtdzFpdnRdDmXQJk2zD7Ma7Kg7Q9xpn6Ou
         avl45RrkkCYJC8F99Vm7nUQfEwIA/0LLEnS2hG852QoIHSsIng5l1/YKr+rTZ2LHSSza
         iTN4P95MQrtwoMYtkuGX5sXuhpqYkYOwn/KTp3St7Dvcba49et6O1LXDFnmlOYJ2sI66
         mEi01XxlZrkmvC7HVidMXkLVDJ/7uxRkqKNaia4hR3jUJk9uSmxcN04gUQtUx0z7jYh4
         qwIJesKXUp2ZZcuPG6610/8vAEOEHgGQbxPPxAz4GwI/WLybQOVkXZ/0ieULikVf5Rmj
         NGiQ==
X-Gm-Message-State: AC+VfDwOFiRQs5IVepozdI2okKY6qA1SytfOaHf7qwHX27sPd3pbjDZF
        1lFMLfg4JuJT+aC/akP7WCwxYcRxqY/YStFbWW6Rnz8Q
X-Google-Smtp-Source: ACHHUZ47LC+rnJutHRaHuYMA6YdyCUdF7xHk5jZFfPhaCiQ7KFpnzQ7XGX94UjuzaOIbz3vue29M5PXDKCQBO9u6JJI=
X-Received: by 2002:ac8:5a8e:0:b0:3f6:a6a7:706 with SMTP id
 c14-20020ac85a8e000000b003f6a6a70706mr4173576qtc.7.1685172170448; Sat, 27 May
 2023 00:22:50 -0700 (PDT)
MIME-Version: 1.0
References: <1680076012-10785-1-git-send-email-quic_mojha@quicinc.com>
 <1680076012-10785-6-git-send-email-quic_mojha@quicinc.com>
 <ZHEvWpCqg_oyWyZW@surfacebook> <20230526233604.3eiqbfrkecir3ga5@ripper>
In-Reply-To: <20230526233604.3eiqbfrkecir3ga5@ripper>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 27 May 2023 10:22:13 +0300
Message-ID: <CAHp75VfcvNpdSP_XvbB42ZUxCik3v-jhR7WFjsaJVr3AZR=nJg@mail.gmail.com>
Subject: Re: [PATCH v6 5/5] firmware: qcom_scm: Add multiple download mode support
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Mukesh Ojha <quic_mojha@quicinc.com>, agross@kernel.org,
        konrad.dybcio@linaro.org, linus.walleij@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
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

On Sat, May 27, 2023 at 2:32=E2=80=AFAM Bjorn Andersson <andersson@kernel.o=
rg> wrote:
> On Sat, May 27, 2023 at 01:14:50AM +0300, andy.shevchenko@gmail.com wrote=
:
> > Wed, Mar 29, 2023 at 01:16:52PM +0530, Mukesh Ojha kirjoitti:

...

> > >     if (download_mode =3D=3D QCOM_DOWNLOAD_FULLDUMP)
> > >             len =3D sysfs_emit(buffer, "full\n");
> > > +   else if (download_mode =3D=3D QCOM_DOWNLOAD_MINIDUMP)
> > > +           len =3D sysfs_emit(buffer, "mini\n");
> > > +   else if (download_mode =3D=3D QCOM_DOWNLOAD_BOTHDUMP)
> >
> > > +           len =3D sysfs_emit(buffer, "full,mini\n");
> >
> > Why not "both" ?

> "both" isn't very future proof (and I think we've had additional
> variations in the past already), so I asked for this form.

Okay, so this should be the bit flags and we should parse a list of
the values. In that case I may agree with the approach.

> >       if (mode >=3D ARRAY_SIZE(...))
> >               return sysfs_emit("Oh heh!\n");
> >
> >       return sysfs_emit("%s\n", array[mode]);

...

> > > +   if (sysfs_streq(val, "full,mini") || sysfs_streq(val, "mini,full"=
)) {
> > > +           download_mode =3D QCOM_DOWNLOAD_BOTHDUMP;
> >
> > It's way too hard, esp. taking into account that once user enters wrong=
 order,
> > user can't simply validate this by reading value back.
> >
> > Use "both" and that's it.
> >
> > > +   } else if (sysfs_streq(val, "full")) {
> > >             download_mode =3D QCOM_DOWNLOAD_FULLDUMP;
> > > +   } else if (sysfs_streq(val, "mini")) {
> > > +           download_mode =3D QCOM_DOWNLOAD_MINIDUMP;

As per above.

--=20
With Best Regards,
Andy Shevchenko
