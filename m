Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 885D76C522E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 18:18:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbjCVRSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 13:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjCVRSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 13:18:22 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6391FED;
        Wed, 22 Mar 2023 10:17:56 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5447d217bc6so350189147b3.7;
        Wed, 22 Mar 2023 10:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679505474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j5tMxhkK7/onZqHgDaus9SFQGKXbQnfJIdwaT4ESxh4=;
        b=MadEXjfxnjXCj+JSL/K/pEjoIyPc3C84IfmY8l0vEbdmXFfpbfcptH/luEo+V5puYm
         eENaGjwre8b1MAnAncA5/Q4N9FcvYng5tMedWCpPhjg0RScj2Cz5OyJuGg2EFuQ72F6e
         T/mLVpbXxyRG5o2E2qo4PeeW1dD5eyLmUzT3bB9WW4dC6K7v0mgCT8cY9qzJY+SXGL4B
         bA/nXgTTGa17Bs3dRWlfhJhX6EpC838T+q+lmWsEnUgEEnjtNDuHIgNMJhkerXi8HLgb
         U73n2lVb3Z/6xHTWJW+iKHMVe/BzNySR904OgAz6JkJOuh/yu9RMWd2sZW+wkiXf77l5
         8fbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679505474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j5tMxhkK7/onZqHgDaus9SFQGKXbQnfJIdwaT4ESxh4=;
        b=RqiMsLUK0lgAUe2fABiee3dEzWN/VKxCthH8hFr1yr+hjHEkKT7Ddwpr3E0R+JN6i6
         Ofd+u2J/skXM7rNuluJ/3Fe+kFxVaCCmQfW9eomBFejLRN21cX/LAJA4ZEhBWfXoVb5C
         5TG11SorMMcKT2xakXclWc+PjGQ7QX8qTht8dux0qRuf6xcOdHCZdVp/b/kUWTqJyPtn
         QgyEwS48Xjfgss8oeeTw4ZvWA5d63SJpIymzB63W3hPBHYlm38JoBY3KiJodo92F4Ln/
         uWvUZrCZgdi52tEEYpLUJjWkDSuet5eHpDdr84P7QVySl5My0QEC/SAdg4/lQtZMGb0+
         YPyA==
X-Gm-Message-State: AAQBX9dcWmHBbo0RTkqHIKz9F4W7Xk3kSGtdhk9BqpauBtXSHpE6LLnA
        kDf4c4/xyCBDsiy6iKuIAfM8Aq9CKdhMMO9gNxI=
X-Google-Smtp-Source: AKy350asapBJHu6okwF5wE1Lx7zZX6w7nbBWANZAOOFJv/JFYZEqi84vJXBRugx5gAQAZ0j/4EQItVyOkG5rtSnCAVw=
X-Received: by 2002:a81:4505:0:b0:545:62c0:621d with SMTP id
 s5-20020a814505000000b0054562c0621dmr331750ywa.2.1679505474408; Wed, 22 Mar
 2023 10:17:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210315122605.28437-1-noltari@gmail.com> <20230321201022.1052743-1-noltari@gmail.com>
 <20230321201022.1052743-5-noltari@gmail.com> <3a1d7b271a42324c056d983e1943b386.sboyd@kernel.org>
 <0071fdc1-fa53-e096-19c7-ecd1a9d56e86@gmail.com> <d06781c905adb23089a85a8d54b94461.sboyd@kernel.org>
 <302bb0c4-a31e-7025-26d6-21c8d473f370@gmail.com> <896d16997cf3d308eff0cb8ce8596fc3.sboyd@kernel.org>
In-Reply-To: <896d16997cf3d308eff0cb8ce8596fc3.sboyd@kernel.org>
From:   =?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6IFJvamFz?= <noltari@gmail.com>
Date:   Wed, 22 Mar 2023 18:17:43 +0100
Message-ID: <CAKR-sGdwRXTg5Yy6Xy6iSv+f9Ccv=pcfa4LoMSMmgOocWPCa4Q@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] clk: bcm: Add BCM63268 timer clock and reset driver
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        devicetree@vger.kernel.org, jonas.gorski@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        p.zabel@pengutronix.de, robh+dt@kernel.org,
        william.zhang@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

El mi=C3=A9, 22 mar 2023 a las 0:23, Stephen Boyd (<sboyd@kernel.org>) escr=
ibi=C3=B3:
>
> Quoting Florian Fainelli (2023-03-21 16:09:54)
> > On 3/21/23 16:06, Stephen Boyd wrote:
> > > Quoting Florian Fainelli (2023-03-21 16:00:29)
> > >>
> > >> These SoCs are big-endian, require native endian register access and
> > >> have no posted writes within their bus logic (UBUS) and require no
> > >> barriers, hence the use of __raw_readl() and __raw_writel() is adequ=
ate.
> > >>
> > >
> > > Use ioread32be() then?
> >
> > BCM63xx drivers tend to use __raw_{read,write}l for consistency and to
> > make it clear that no barriers, no endian swapping is necessary, I woul=
d
> > prefer to remain consistent with that convention.
>
> Ok.
>
> Is the clk device big-endian? Or the CPU is big-endian? SoC being
> big-endian sounds like the devices in the SoC are big-endian. I hope we
> never plop this device down with a CPU that's litle-endian.

The SoC is big-endian. I've only worked with MIPS big-endian devices
from Broadcom, so I'm not really sure, but this seems to be very
BCM63268-specific...
Other BCM63xx devices I know have separate clock and reset
controllers, but not this kind of timer, clock and reset controller...

--
=C3=81lvaro
