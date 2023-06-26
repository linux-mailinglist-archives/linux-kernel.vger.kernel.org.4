Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E969373E608
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 19:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbjFZRNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 13:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjFZRNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 13:13:31 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8874E10C0;
        Mon, 26 Jun 2023 10:13:30 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b69e6d324aso23042611fa.0;
        Mon, 26 Jun 2023 10:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687799609; x=1690391609;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Oc7x/uNZcuI9+aQUxJoFoxo0ij8lVVR/Lt9mbAHnYU=;
        b=o8kwWefw7213vmURmXJ4lUkIXOgjAABFy5AEQLU4hV4CCpbW5/LDJr9qBIG8HsL/ZN
         cdujWgmSCvI9td4KVaLYwvHR7LeZaX0MOHAQ2dFEPs05jpPCU/8Y2UVlDUt7XZ39+pWc
         TkKvIPw8YGj/eV0WZhlVcBh3+ZN6i9LYruMH0S3ZNbIZm9LA78OAvqFU8gJ/468Y85pZ
         X204/S8s41JVz/lmkq1+YpSyNDefB0C8Qujrl8XbuR4ISb4DomKR20h+L2Kb+7h1utwB
         8ee1DsbaWGYnjeU4nc5u3APMdLMP6Wcq3cu3IRPGaD4FTl5tOjVvnI89o9xm2jr93+Fu
         DYsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687799609; x=1690391609;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Oc7x/uNZcuI9+aQUxJoFoxo0ij8lVVR/Lt9mbAHnYU=;
        b=eUX/G6NWVMbBJLmQ9fnABO/P74xTl2dNkTEGeABZi72S5gMKUpu1zA3JR2vOFU7WOd
         F4gghXuT0O0nLueFnhf96lgzBCQKxpzrwhSlyubU0D4cW/jKDtlZbQiGQ655zcuJTCKm
         nSIqnxkbkUtBCHeIBAvpDN1Rh8J59Et2Dm9gXu4MIGs4SWqLqnvi24ID6rHtBy/mgOwu
         5X+j8viGk7FmKd+yOgkK65TuPjSBH6Z4judPRB1t1eGCu/ie4KZ+CcDML8TB6JfAw7nP
         yELj+vglc9cHdhHXGs8LWw6WsmLZwpv5EohbJJ6tCMov5ngmPIGDvJ++HGXJcfQzrnfC
         5u1Q==
X-Gm-Message-State: AC+VfDyxNUryUro0S7T63A1ZJhPSynXXq1fICzEcXTIlhH9HYzUOI22m
        9JiEQ25OSjueeceWSxEV+/YBQProFdX92QecCm0=
X-Google-Smtp-Source: ACHHUZ4nMybg+ZdPRO18PgwmDjwvDhQf2f8JyIxYrIkKQfOXGrkouPrGJcgofEqRy8aQN+8GIIZ6mBYRPImyhCFRR9U=
X-Received: by 2002:a05:6512:2316:b0:4fb:761c:7c18 with SMTP id
 o22-20020a056512231600b004fb761c7c18mr2073498lfu.61.1687799608269; Mon, 26
 Jun 2023 10:13:28 -0700 (PDT)
MIME-Version: 1.0
References: <1680076012-10785-1-git-send-email-quic_mojha@quicinc.com>
 <1680076012-10785-5-git-send-email-quic_mojha@quicinc.com>
 <ZHEt2mrYpSMKBuIX@surfacebook> <6d9f251e-2c1a-ed50-638e-a052404ffc64@quicinc.com>
In-Reply-To: <6d9f251e-2c1a-ed50-638e-a052404ffc64@quicinc.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 26 Jun 2023 20:12:52 +0300
Message-ID: <CAHp75VdU+ee8_UveZp3SD2UKYYg4Jm0cYUpcXfVwMEVC1d0Bdw@mail.gmail.com>
Subject: Re: [PATCH v6 4/5] firmware: qcom_scm: Refactor code to support
 multiple download mode
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linus.walleij@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
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

On Mon, Jun 26, 2023 at 7:28=E2=80=AFPM Mukesh Ojha <quic_mojha@quicinc.com=
> wrote:
> On 5/27/2023 3:38 AM, andy.shevchenko@gmail.com wrote:
> > Wed, Mar 29, 2023 at 01:16:51PM +0530, Mukesh Ojha kirjoitti:

...

> >>              ret =3D qcom_scm_io_update_field(__scm->dload_mode_addr,
> >> -                            QCOM_DOWNLOAD_MODE_MASK,
> >> -                            enable ? QCOM_DOWNLOAD_FULLDUMP : 0);
> >> +                            QCOM_DOWNLOAD_MODE_MASK, download_mode);
> >
> > Can ping-pong style be avoided? I.e. do the right thing in the previous=
 patch,
> > so you won't change lines that were introduced just before.
>
> If you notice, I have just converted download mode data type from bool
> to int in this patch and hence the changing the line here. Last patch
> was about just using the exported API, so i hope you would be fine here.

Thank you for elaboration. I'm fine with that.

...

> >  > Also, what about download_mode that doesn't fit to the above two?
>
> return sysfs_emit(buffer, "unknown\n"); ?

For example, yes.

...

> >> +static int set_download_mode(const char *val, const struct kernel_par=
am *kp)
> >> +{
> >> +    u32 old =3D download_mode;
> >> +
> >> +    if (sysfs_streq(val, "full")) {
> >> +            download_mode =3D QCOM_DOWNLOAD_FULLDUMP;
> >> +    } else if (sysfs_streq(val, "off")) {
> >> +            download_mode =3D QCOM_DOWNLOAD_NODUMP;
> >
> > NIH sysfs_match_string().
>
> NIH ?

Not Invented Here

> My apology, if i did not get this..
> Do you want me to use sysfs_match_string()

Yes.

> and how would that help compare to what is present now ?

This will make your ABi gathered in one place (all strings and all
values) and less code will be used esp. if it's going to be expanded
in the future (isn't it in the next patches?).


> >> +    }
> >> +
> >> +    if (__scm)
> >> +            qcom_scm_set_download_mode(download_mode);
> >> +
> >> +    return 0;
> >> +}

...

> > Have you updated corresponding documentation about this parameter?
> > Or there is none?
>
> There is none as of yet outside this file; should that be good what i
> have added in 5/5..

It was a long time ago when I reviewed this. Just a note that all ABI
must be documented, debugfs is highly recommended to be documented.

--=20
With Best Regards,
Andy Shevchenko
