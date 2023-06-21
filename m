Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFA9673888B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 17:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233281AbjFUPNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 11:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232820AbjFUPNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 11:13:20 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0313295D;
        Wed, 21 Jun 2023 08:09:13 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-25ee8d84b4fso3236965a91.0;
        Wed, 21 Jun 2023 08:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687360148; x=1689952148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3pxYvZE9qt2zn4FI6+g2LcNJOhg8u1hzKiWBjeT5xgA=;
        b=jLLq+mRHkzHrwYqjN9UVIXbIqiZoTocAuDQkY5eFDqz84bqMoDaYJvcq4QX/1BNStp
         P5TiEJ5fSyOL//D3/jDBRJz8bxW6qM+OFP2V17Gnf/5hHnpqyRF8SzWp8A6+j3xP+Vj8
         /DaiyEPnNinUC3iPGxWHuHYdN7KMTZ7oA8spFcbTv4COud00lhujxlZeAkmvbrFfxm9p
         j6bUI2z4lB2sUyf+0HVFKMJPTEfrbbO7hilZbFwqLMK9AY6urnmVc3zi1WETKzmb8b+g
         LK2jkxrTL0ulvH3501pSHzpjlW3jDZ8vucO0tRfaLUgULfHmNhrAYTsN9T+0ySD3JQgH
         vdAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687360148; x=1689952148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3pxYvZE9qt2zn4FI6+g2LcNJOhg8u1hzKiWBjeT5xgA=;
        b=CrCmykQRHbX0RMs6bdnAN/1K5RkkpcFPVdihAuGVodRrhl9odiULakl4+EFnyQn2gK
         u/r0yMgqDYuACs7KmWDljGFzljn5mCaNRh/pyKfGjiVQOeojC7y4IS6A5IczE8OjKnFC
         tlvgLJpphYbgbCS7Jxsbofqf5Nn5z40BTsNz4Ogl1AY5bfKgba/MOB3BOSDAtPybRz2k
         r6LmUb4mA2FF5uHQxM7Trq1ZbTD9ggKOQjJ02b+q/G179TBTm6QroK+YMQ9INGs/Axwm
         mTkPs8O1jwznbGyIhNNIIbD1LB7cS29NdaMeC32dyQ84THQQaao9ay1vqkKw6d8IojHq
         cltA==
X-Gm-Message-State: AC+VfDyP5loyRrJoJ6YMHL09A8gZ1bJaeeFjcv0qIoKFNef5EFEanVLG
        T7PUMCBgdoqA8JWm0hmDtyYDNPvk5LaPn61cxQc=
X-Google-Smtp-Source: ACHHUZ7XNoLgOR1r+SBoMmCQ1NX0ViJyRA0eK0+V/MmAoDfiap9j9iqYMS4chfKIcBjthw9/4VmKXdnQC8A6tqyG2oc=
X-Received: by 2002:a17:90b:3e8e:b0:25e:ae28:ea64 with SMTP id
 rj14-20020a17090b3e8e00b0025eae28ea64mr16465969pjb.23.1687360148362; Wed, 21
 Jun 2023 08:09:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230607151127.1542024-1-pavacic.p@gmail.com> <20230607151127.1542024-4-pavacic.p@gmail.com>
 <CACRpkdbrEA54qmfTKSsFRG9ZS4u8hM6P5TXtOjRAiW+TD_v-fQ@mail.gmail.com>
 <CAO9szn00vRFm+iM1m7KgkW0WRuKyJEgVU4tVx4f5tF6KPnE=2w@mail.gmail.com>
 <CACRpkdaw8M3dSkmiV5QDOt3BBB7Jo6NxT0Og=zvA4REMA_7y9g@mail.gmail.com>
 <CAO9szn29A0qCABG0ACni42UGpsGKLwG7OT1y_ho3DgQ0WLvfmw@mail.gmail.com> <CACRpkdYXtQwmZR1u-1fwmyC_8Yq4bMkjDBcUCfuGqSz_UhXWJQ@mail.gmail.com>
In-Reply-To: <CACRpkdYXtQwmZR1u-1fwmyC_8Yq4bMkjDBcUCfuGqSz_UhXWJQ@mail.gmail.com>
From:   Paulo Pavacic <pavacic.p@gmail.com>
Date:   Wed, 21 Jun 2023 17:08:57 +0200
Message-ID: <CAO9szn0OuKW+-JZMs3TPUHiwLCe6cUPcsUq+og64K2utMyZpqQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] drm/panel-fannal-c3004: Add fannal c3004 DSI panel
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     neil.armstrong@linaro.org, sam@ravnborg.org, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
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

pet, 16. lip 2023. u 14:53 Linus Walleij <linus.walleij@linaro.org> napisao=
 je:
>
> On Fri, Jun 16, 2023 at 2:31=E2=80=AFPM Paulo Pavacic <pavacic.p@gmail.co=
m> wrote:
> > pet, 16. lip 2023. u 13:44 Linus Walleij <linus.walleij@linaro.org> nap=
isao je:
> > >
> > > On Fri, Jun 16, 2023 at 11:57=E2=80=AFAM Paulo Pavacic <pavacic.p@gma=
il.com> wrote:
> > > > =C4=8Det, 15. lip 2023. u 21:55 Linus Walleij <linus.walleij@linaro=
.org> napisao je:
> > > > >
> > > > > I doubt that the display controller is actually by Fannal, but I =
guess
> > > > > you tried to find out? We usually try to identify the underlying =
display
> > > > > controller so the driver can be named after it and reused for mor=
e
> > > > > display panels.
> > > >
> > > > Yes, of course, the controller is ST7701S.
> > >
> > > Hm did you try to just refactor
> > > drivers/gpu/drm/panel/panel-sitronix-st7701.c
> > > to support your new panel?
> >
> > Yes I have tried, but there are too many changes needed and I wasn't
> > sure whether I would be breaking compatibility with st7701 based
> > panels.
>
> For the community it creates a problem that now two drivers for similar
> hardware need to be maintained, and that burden will land on the DRM
> maintainers. For this reason it would be better if a joint driver could
> be created.

I will try modifying st7701, but that seems like a big task since
currently st7701 crashes kernel (5.15) for me and I have seen
suggestions to use raydium driver over st7701.
Also I guess I should first read some more documentation and compare
st7701 to st7701s. I currently can't reserve a lot of time for that.

>
> I am sure the users of the old driver will be willing to test patches to
> make sure their devices keep working.

A lot of modifications to st7701 are required. I believe it would
result in a driver that doesn't look or work the same. e.g compare
delays between initialization sequences of panel-fannal-c3004 and
panel-st7701. I think it would be optimal to create st7701s driver and
have special handling for st7701s panels. If there was a flag for
whether panel is st7701 or st7701s it would end up looking like a
mess.

>
> Yours,
> Linus Walleij

Thank you for your time,
Paulo
