Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFB1374BCCB
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 10:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjGHIXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 04:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbjGHIXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 04:23:11 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE321FE1
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jul 2023 01:23:09 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-c4dfe2a95fbso2978684276.3
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jul 2023 01:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edgeble-ai.20221208.gappssmtp.com; s=20221208; t=1688804589; x=1691396589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uRa64IiPsuM6VDFvcCCrH9MgHZysL/mfECR9wPwska8=;
        b=Inco7shYWGwCbmGRzf9fmjkb4dyXh3+Pj0EhFpbSy0hbTaN9H/D91fZ+cHgA1l+N2M
         nQbvEuGhuCnW/bf+Myx12mHc4zq+K9mPUfkkpNiFV03SfZeNXT0+GkPSfkgBmK2RrXxh
         14Bh+cVOuZeFMpRNNTontYrl+K3H6fCHf0CaCX4eJi7z/d1peN0xtlrCK02WhcAk4820
         w5Mr3LPYVhCLOedGw9/FDIUSsiOnvzUenR406zN1c2wp9PvT/uNkrN73TiObF15xdrKh
         ZX/yxFnoeFBRdvxx6/emxyM7KvV+BFECcftHbsWGy3RthlZt6qe0BtmgRfzd3+yfnwuS
         GQTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688804589; x=1691396589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uRa64IiPsuM6VDFvcCCrH9MgHZysL/mfECR9wPwska8=;
        b=hI2xuKPbk/+0Or24lZZkuMVAw5qDXCAXwWHIfDABjilFEjHBNsfAhvaPJYrmA6PO14
         u/SMJxUIc8fgtk2Bw5L9p/ymJRyh5qKfWM0fHNCprcZknbPDPOz+ZEuL2a5EwlGHQkp+
         tT0h6jnW9dT21mmOqJoFN+kn9/VBpYljDBHignc6NmeaZvWTWU54TWspnD4Rc1dxuOSi
         ah/D4wfrmiXaS6mub7pv6gAV/s+SWV49w/678WgkgHZi2ClvNyTF0R5fgLlEP1nGjIOz
         clW75afJ81vCHnBM1TB1ByPBC6edLNym4TFQTfVnsawSnS8CPoj7seywFRZ9Rydk2cxZ
         0qvA==
X-Gm-Message-State: ABy/qLZk5T1K5wdtdTonO+f/ZwN8qF5G7+9Pz57UpBaHKgBIUPrilk/p
        NalhagOj/nglYrrAbdNT/PIHCE/QiNwZPl7yBAtPiQ==
X-Google-Smtp-Source: APBJJlHV4fQNxortWcxW7ePLIgEI078Rdoj5n5kWWZvlBctClxZotj2w9tR+0lOLRwp+gme8FrDJ6Tc8RYIVhRTp8k0=
X-Received: by 2002:a0d:dc83:0:b0:56c:f090:36eb with SMTP id
 f125-20020a0ddc83000000b0056cf09036ebmr7620028ywe.36.1688804588831; Sat, 08
 Jul 2023 01:23:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230607151127.1542024-1-pavacic.p@gmail.com> <20230607151127.1542024-4-pavacic.p@gmail.com>
 <CACRpkdbrEA54qmfTKSsFRG9ZS4u8hM6P5TXtOjRAiW+TD_v-fQ@mail.gmail.com>
 <CAO9szn00vRFm+iM1m7KgkW0WRuKyJEgVU4tVx4f5tF6KPnE=2w@mail.gmail.com>
 <CACRpkdaw8M3dSkmiV5QDOt3BBB7Jo6NxT0Og=zvA4REMA_7y9g@mail.gmail.com>
 <CAO9szn29A0qCABG0ACni42UGpsGKLwG7OT1y_ho3DgQ0WLvfmw@mail.gmail.com>
 <CACRpkdYXtQwmZR1u-1fwmyC_8Yq4bMkjDBcUCfuGqSz_UhXWJQ@mail.gmail.com>
 <CAO9szn0OuKW+-JZMs3TPUHiwLCe6cUPcsUq+og64K2utMyZpqQ@mail.gmail.com> <CACRpkdb5stXKb7FNk_FC-PKduCngRX3sZTbzcxN+kRskz78fuQ@mail.gmail.com>
In-Reply-To: <CACRpkdb5stXKb7FNk_FC-PKduCngRX3sZTbzcxN+kRskz78fuQ@mail.gmail.com>
From:   Jagan Teki <jagan@edgeble.ai>
Date:   Sat, 8 Jul 2023 13:52:57 +0530
Message-ID: <CA+VMnFyaCWFPWszxen92qKBMX6N9g34+aMA4UCnai9KQzzuf9Q@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] drm/panel-fannal-c3004: Add fannal c3004 DSI panel
To:     Linus Walleij <linus.walleij@linaro.org>,
        Paulo Pavacic <pavacic.p@gmail.com>
Cc:     Jagan Teki <jagan@amarulasolutions.com>,
        Marek Vasut <marex@denx.de>,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        neil.armstrong@linaro.org, sam@ravnborg.org, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2023 at 13:52, Linus Walleij <linus.walleij@linaro.org> wrot=
e:
>
> On Wed, Jun 21, 2023 at 5:09=E2=80=AFPM Paulo Pavacic <pavacic.p@gmail.co=
m> wrote:
>
> > A lot of modifications to st7701 are required. I believe it would
> > result in a driver that doesn't look or work the same. e.g compare
> > delays between initialization sequences of panel-fannal-c3004 and
> > panel-st7701. I think it would be optimal to create st7701s driver and
> > have special handling for st7701s panels. If there was a flag for
> > whether panel is st7701 or st7701s it would end up looking like a
> > mess.
>
> What matters is if the original authors of the old st7701 driver are
> around and reviewing and testing patches at all. What we need is
> active maintainers. (Added Jagan, Marek & Maya).
>
> I buy the reasoning that the st7701s is perhaps substantially different
> from st7701.
>
> If st7701s is very different then I suppose it needs a separate driver,
> then all we need to to name the driver properly, i.e.
> panel-sitronix-st7701s.c.

I agree with what Linus mentioned.

1. If the panel is designed on top of ST7701 then add driver data on
the existing panel-st7701 driver with this panel.

2. If the panel is designed on top of ST7701S - ST7701 and ST7701S are
completely different in terms of the command set and init sequence
then add panel-sitronix-st7701s.c

3. If the panel is designed on top ST7701S and if the commands set is
the same as ST7701 but the init sequence is different then it is
possible to use the existing st7701 driver with the init sequence as
in driver data.

Thanks,
Jagan.
