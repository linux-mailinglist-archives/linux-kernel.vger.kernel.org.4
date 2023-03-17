Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A258A6BEFCD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 18:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbjCQRhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 13:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjCQRha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 13:37:30 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82341C1BD3;
        Fri, 17 Mar 2023 10:37:09 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id bl39so1989129qkb.10;
        Fri, 17 Mar 2023 10:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679074628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nkw7xFKCGQ8y3ihDSwQaifjRjfGYpBRwz6O/9EShW4w=;
        b=pUhvf+kdQ2fX9RNLZ9hiJXhimJItMrtY20tl+OKvdUEpAtCU1mmzPAXVlCGRz9Rv6i
         tMhVIkUMpgTlTRDoVaOrHpFDTiISiRWAfjcs9g0rSWK/PNKlWNbzIQQq5FQ/WskZXmdi
         8aAZpWNXa3XAPWmaSV5dqBAppsRm5iqddobUsIZGMAKTUmlH7mu/+4IVHgSd2ryEq/A9
         3eaP/FbiN//2vViinJTQ8BI2KGQkxPp+c2J87kZ+sQfgerGVLsdRn9ADkcNjqthEygeV
         FS8Qedt896kUQphTKiEN2Jt+T/NW6CULmYux+TuIUGACOt4hQ+mXGRoXL2q7gIkUZT8B
         M1gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679074628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nkw7xFKCGQ8y3ihDSwQaifjRjfGYpBRwz6O/9EShW4w=;
        b=e0+ucX/qnpws3LEPiAB1ytHvvOugxlwQn50WDTUyVZEIWXHs0YTxgtFqPdcPDB5sj3
         MHMeYmOA/aixZGHXL84oEIVoOQJ/nPwhpNDTY5/zc5s0c9bQQ65L0VIuHozYsCJd1i+D
         /Ci5951d4eefdmZMdcwt3XlfrXkO4y+dkT3sFZXBhcVA5q89TozBPDCBcMUJiiAxvCHH
         F/UWcabRh/uGIFTFiDlfpXhYbVVhwx5b7M40HbCNzb4+qsDn8CqABvy2cNWA6eBHIl70
         q9RstgHaeWhAilhRdUsF8KQmFuIW4pk63huVrv7iKVbstYnd3wLfBH6crLqjBZQ3U9Bb
         0n8g==
X-Gm-Message-State: AO0yUKW0yXoNt+1zTYCQrkohSkYLu4j7+FnztmvtPsjIqa1TNzNHj6aL
        d7/0QXo74tOl+n4MnOOV3eGKSI9/y65BngFBIME=
X-Google-Smtp-Source: AK7set8hC6XZO9a9uhHE+dJ/fifDkD8AmIT3Wmrg0k48frLIgXxh+o4TnKjKmLQZ2jxVu9L8hIXrW037ynmF6qIV5gk=
X-Received: by 2002:a05:620a:22d5:b0:745:bd3d:51df with SMTP id
 o21-20020a05620a22d500b00745bd3d51dfmr833838qki.3.1679074628076; Fri, 17 Mar
 2023 10:37:08 -0700 (PDT)
MIME-Version: 1.0
References: <20221205085351.27566-1-tmaimon77@gmail.com> <20221205085351.27566-3-tmaimon77@gmail.com>
 <f28c7c34-077c-4c7e-afd8-c4180718d403@roeck-us.net>
In-Reply-To: <f28c7c34-077c-4c7e-afd8-c4180718d403@roeck-us.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 17 Mar 2023 19:36:31 +0200
Message-ID: <CAHp75Vegm=jmuJ6q5qofuLKm_LggKmtQZWcVgQN=MG3kMMCTRA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mmc: sdhci-npcm: Add NPCM SDHCI driver
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Tomer Maimon <tmaimon77@gmail.com>, ulf.hansson@linaro.org,
        avifishman70@gmail.com, tali.perry1@gmail.com, joel@jms.id.au,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        adrian.hunter@intel.com, skhan@linuxfoundation.org,
        davidgow@google.com, pbrobinson@gmail.com, gsomlo@gmail.com,
        briannorris@chromium.org, arnd@arndb.de, krakoczy@antmicro.com,
        openbmc@lists.ozlabs.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Fri, Mar 17, 2023 at 4:16=E2=80=AFPM Guenter Roeck <linux@roeck-us.net> =
wrote:
>
> On Mon, Dec 05, 2022 at 10:53:51AM +0200, Tomer Maimon wrote:
> > Add Nuvoton NPCM BMC sdhci-pltfm controller driver.
> >
> > Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
>
> I still don't see this driver in the upstream kernel, or in linux-next.
>
> Couple of comments:
>
> - devm ordering does not really matter here. The devm resource
>   is the clock, it does not depend on local data, and it will be
>   released last, so that is ok.

Not sure. Strictly speaking this is the problem. If you leave a clock
going on in a wrong period of time it (theoretically) might break your
hardware once and forever. Similar discussion about power, clock and
reset signals has been held for camera sensors.

--=20
With Best Regards,
Andy Shevchenko
