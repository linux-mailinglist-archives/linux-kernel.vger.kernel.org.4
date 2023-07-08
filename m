Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0417974BC82
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 09:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjGHHLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 03:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGHHLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 03:11:05 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5CE1FF6;
        Sat,  8 Jul 2023 00:11:04 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-992b2249d82so342012566b.1;
        Sat, 08 Jul 2023 00:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688800263; x=1691392263;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GvXK5oEuIY7lWNWkNWObt3ZTrcKC50SIxSS9jwfZwto=;
        b=pQh9ovKmeP5uMdOcC4/2gCZkr5SDhnTm5223+rjPs4zzF1s1c5xpmBjDjgKZB1sWP8
         rLBxmxzTCm8zWxsVoAq9OMyizB3Ykm/r3Tqy7uGY38dUDqcNCig6UscRly3ZlU6tHBgK
         RZaTzvNVXReRQw6y69wwtGA1gRHvAUjl/j8fB4eaoD5FIG4vMSVmS6UKzEtLA+nWLlK5
         jnBYt3TteqGQo7KeDvDK2vZZIO5aO3RFsZf4bNXJnV/4sRyryDb8xEI4hEtib5GHIHXV
         2AR5oaM1KCWI+10AXKzzTkeShApsbTQO4nzZXfv87n46Lkcj6LnhrpFVdzyfsxh7CWLu
         OJsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688800263; x=1691392263;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GvXK5oEuIY7lWNWkNWObt3ZTrcKC50SIxSS9jwfZwto=;
        b=QgxOdkjJ1SEtgnvq8v5KMntFkI1VoF0V1pdKy4ykktqQ/VCLFXwR75KXEbAEtmgd5n
         dLGxx9vkS4kLxJJqbwAk4JlCfFSe6y+jwDzzc4WJI3CzLDskCS3DBDzLat/TTSMV4BRk
         /RoXjSQSND8z8WhNR3Fh2OJfm/dLUv1QbQMIiIRz5JSKY/uM2NA77HK1hKRPH1lbCeS1
         3/SAsiCGZIHUh4hjaH9jMWhLsFgpdtTAJBYsu4H8ACnuvKq1YFDwvlhhJQdBA70Utldv
         gpHBOamwHPFMDUmj+suizTxirEdDfdW3dIqaVo09rC6Ch8pSFrl660TGpFKIl2A9aVa3
         eInQ==
X-Gm-Message-State: ABy/qLYHgFc6HZO47gN2A5mN3332T6UQaCMN6zY0PECO7gYLEfwAMG0W
        e04Zx1XwTAbubp+2QU+GRpk=
X-Google-Smtp-Source: APBJJlGwbtOxDY4lSfhBZMb8VNQ2fXcYzhOJWKt/FjyfC+puXO0xuYEfkiaVOg6NxpvDBYU0sIrNHA==
X-Received: by 2002:a17:907:b020:b0:974:55ea:1ad8 with SMTP id fu32-20020a170907b02000b0097455ea1ad8mr5125794ejc.63.1688800262973;
        Sat, 08 Jul 2023 00:11:02 -0700 (PDT)
Received: from [127.0.0.1] ([95.168.107.25])
        by smtp.gmail.com with ESMTPSA id j17-20020a170906279100b00982a352f078sm3062166ejc.124.2023.07.08.00.11.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Jul 2023 00:11:02 -0700 (PDT)
Date:   Sat, 8 Jul 2023 09:11:02 +0200 (GMT+02:00)
From:   =?UTF-8?Q?Paulo_Pava=C4=8Di=C4=87?= <pavacic.p@gmail.com>
To:     Marek Vasut <marex@denx.de>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        neil.armstrong@linaro.org, sam@ravnborg.org, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Message-ID: <85d0e75d-146d-496e-a22d-3aea5298c61a@gmail.com>
In-Reply-To: <0d43e653-32cd-b25e-40fa-6f0571048467@denx.de>
References: <20230607151127.1542024-1-pavacic.p@gmail.com> <20230607151127.1542024-4-pavacic.p@gmail.com> <CACRpkdbrEA54qmfTKSsFRG9ZS4u8hM6P5TXtOjRAiW+TD_v-fQ@mail.gmail.com> <CAO9szn00vRFm+iM1m7KgkW0WRuKyJEgVU4tVx4f5tF6KPnE=2w@mail.gmail.com> <CACRpkdaw8M3dSkmiV5QDOt3BBB7Jo6NxT0Og=zvA4REMA_7y9g@mail.gmail.com> <CAO9szn29A0qCABG0ACni42UGpsGKLwG7OT1y_ho3DgQ0WLvfmw@mail.gmail.com> <CACRpkdYXtQwmZR1u-1fwmyC_8Yq4bMkjDBcUCfuGqSz_UhXWJQ@mail.gmail.com> <CAO9szn0OuKW+-JZMs3TPUHiwLCe6cUPcsUq+og64K2utMyZpqQ@mail.gmail.com> <CACRpkdb5stXKb7FNk_FC-PKduCngRX3sZTbzcxN+kRskz78fuQ@mail.gmail.com> <CAO9szn3oTzrrwiyr91H14ep7OPUkA-SDST3CSQAQHvFFnkJWfA@mail.gmail.com> <0d43e653-32cd-b25e-40fa-6f0571048467@denx.de>
Subject: Re: [PATCH v4 3/3] drm/panel-fannal-c3004: Add fannal c3004 DSI
 panel
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <85d0e75d-146d-496e-a22d-3aea5298c61a@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Marek,


Jul 6, 2023 5:26:15 PM Marek Vasut <marex@denx.de>:

> On 7/6/23 17:18, Paulo Pavacic wrote:
>> Hello Linus,
>> =C4=8Det, 22. lip 2023. u 10:22 Linus Walleij <linus.walleij@linaro.org>=
 napisao je:
>>>
>>> On Wed, Jun 21, 2023 at 5:09=E2=80=AFPM Paulo Pavacic <pavacic.p@gmail.=
com> wrote:
>>>
>>>> A lot of modifications to st7701 are required. I believe it would
>>>> result in a driver that doesn't look or work the same. e.g compare
>>>> delays between initialization sequences of panel-fannal-c3004 and
>>>> panel-st7701. I think it would be optimal to create st7701s driver and
>>>> have special handling for st7701s panels. If there was a flag for
>>>> whether panel is st7701 or st7701s it would end up looking like a
>>>> mess.
>>>
>>> What matters is if the original authors of the old st7701 driver are
>>> around and reviewing and testing patches at all. What we need is
>>> active maintainers. (Added Jagan, Marek & Maya).
>>>
>>> I buy the reasoning that the st7701s is perhaps substantially different
>>> from st7701.
>>>
>>> If st7701s is very different then I suppose it needs a separate driver,
>>> then all we need to to name the driver properly, i.e.
>>> panel-sitronix-st7701s.c.
>> I had in person talk with Paul Kocialkowski and I have concluded that
>> this is the best solution.
>> I believe I should rename it to st7701s due to the hardware changes. I
>> would like to create V5 patch with driver renamed to st7701s.
>> Please let me know if you agree / disagree.
>
> If I recall it right, the ST7701 and ST7701S are basically the same chip,=
 aren't they ?

I'm currently exploring all the differences. There aren't a lot of them, bu=
t there are some.

So far I can see that default register values are different, previously unu=
sed registers are now used and there has been some reordering of how info i=
s placed in registers [1] (return value for some commands is different). E.=
g AJ1N[1:0] has been moved from B102h to B101h [1]

Moreover, instructions to some commands have been changed as well as meanin=
g of what data bits mean [2][3]. Also, new features have been added [2]; th=
ere is now PCLKS 3 for example.
You can see few differences in following images:
[1]=C2=A0https://ibb.co/NmgbZmy=C2=A0- GAMACTRL_st7701.png
[2]=C2=A0https://ibb.co/G79y235=C2=A0- PCLKS2.png

P.S. this is second time I'm trying to send this e-mail so some of you migh=
t have received e-mail with the same text twice


Thank you for your time,
Paulo
