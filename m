Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59C5E70B917
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 11:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbjEVJga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 05:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbjEVJgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 05:36:25 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1BEAF;
        Mon, 22 May 2023 02:36:21 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-75b01271ad4so69002785a.1;
        Mon, 22 May 2023 02:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684748180; x=1687340180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d9Oe3JzlKOGa3OCOVe5WMHjkmFODDVPns8CvaJ6iWdo=;
        b=hWzF1HaAtm0QjNZFXXjL0fVWKuVK6L98JPTxiTG3kVdcZ8f4p0+J1GWH+L6tpgDj4S
         dpW8KR+Hm4o3LeCdi7DIT5KCyr2U2V9r0A3N+x1U44FVmtX+tarYZm9IBJEA7s0n+JqO
         lystv3ny08oLj9WHZatCg9GxzHsQdoilwfkRaqaDcutAb5a1C2Kt0uPa0ZjL0oMHHkzx
         8S5DTgPuL7DVhaNjYRpk9nXmKSO02DYjWMnAetbaWEz6JIHJaxsJ2F8eyVvZWaTBqKK7
         xiJZuMczE7mMjm8YjzZlOrxnK9oBJ2O7rOYZigku1UEAWNoaNLapAlzXkHNQwyY1Mrh8
         yhTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684748180; x=1687340180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d9Oe3JzlKOGa3OCOVe5WMHjkmFODDVPns8CvaJ6iWdo=;
        b=HjEeI4mK69HnMODfx6MHAvEM+SqvF6p2D/Ppy/kqmhRezjPScQf1goJqTFmg/0kLxS
         oAfD+StADMf8DOM/dO6YOwluz0heuOmSRCbUbSzvM5QTXhqtoa+3gNYffx6ZI3ayMEbX
         xLertloS2IHiucMIRiv6NzEYog0YFMh37Fy80ADO8juuQ7PdobXQQt89JovPlaugXqTK
         vKH9Da2zcfwwybs5mRkXUXERpodoIludF5XVgre0yUwOhY+URlrxcA6bis44O/Rq2zSp
         v3YEZL558GVSIgWKY2VNJGF+PrX9BJY20/Rxj2d3v3Peg2GgtWaGPMFX+OVOyAhqwWmN
         f+kQ==
X-Gm-Message-State: AC+VfDxfHzZGqe/yUYSSvzU34xviWkj9UiLgyl2QxfVCQhlKfgc81FNh
        LvXMOpYOdkBYNrpAxjDOWy+s8nDfLRcgxowBXiM=
X-Google-Smtp-Source: ACHHUZ6Ic9mUxJxsy5J2XGAMXk6T323SArTc57X1rK6YhxbylJY1JKrbIllzXN098oi1nwrfT4axs0HHoR64YfFNS6s=
X-Received: by 2002:ad4:5f0a:0:b0:625:87e4:1689 with SMTP id
 fo10-20020ad45f0a000000b0062587e41689mr1911620qvb.20.1684748180069; Mon, 22
 May 2023 02:36:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230517195238.34069-1-mmkurbanov@sberdevices.ru>
 <20230517195238.34069-3-mmkurbanov@sberdevices.ru> <CAHp75VdEc9x=v-NU4wqrg-S0vEjqc27JPqZAK0TJsNUc37ZTmg@mail.gmail.com>
 <20230522071426.GP404509@google.com>
In-Reply-To: <20230522071426.GP404509@google.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 22 May 2023 12:35:44 +0300
Message-ID: <CAHp75VdG6nSHgzmp9yA2aAwvzWuaYf2Q71tz2ruDPnwb=h=hiQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] leds: add aw20xx driver
To:     Lee Jones <lee@kernel.org>
Cc:     Martin Kurbanov <mmkurbanov@sberdevices.ru>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@sberdevices.ru
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

On Mon, May 22, 2023 at 10:14=E2=80=AFAM Lee Jones <lee@kernel.org> wrote:
> On Thu, 18 May 2023, Andy Shevchenko wrote:
> > On Wed, May 17, 2023 at 10:52=E2=80=AFPM Martin Kurbanov
> > <mmkurbanov@sberdevices.ru> wrote:

...

> > I would do
> >
> >   i =3D 0;
> >
> > here and drop the assignment in the definition block to be more robust
>
> "here" where?

> You've removed all context.

That's not true. The below line exclusively defines the location in
the code that I'm talking about. Note, Martin understood that AFAICT
and addressed in the new version.

> > against sudden reuse of i in between.
> >
> > > +       device_for_each_child_node(dev, child) {
> >
> > > +               i++;
> > > +       }


--=20
With Best Regards,
Andy Shevchenk
