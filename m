Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1D0E6225DE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 09:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbiKIIww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 03:52:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiKIIwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 03:52:47 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FFA81DA47
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 00:52:46 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 21so26212221edv.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 00:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=frOnrhJ74ppM6hXWocdjxv2r1BiSDtd6GcT/Z6n8wU0=;
        b=QqXkk+3nUml+G502STHHAN2GsPWmmPxtKwXnGZes8WLiR/2gjZyYZKlmPHMMfHQDXp
         GKlL7wYAdEXE2VKKjxlVyvTkrRH2tgz5WmcYGq+4IkktZ8d8LsKUAcqOz2nh5GqQWvDG
         rRWw/zZitD2c6ZbGHmb2uCfodKlc3nM0vBzBqHoeBNNXi+F5mS+PEOuerJR4dzs6lDbH
         h15pFgXn/LOBsspiiyC5QGTwlkIjoxiiP3WAZ3+0VKEl+8fcrXaKp/d4fdNgOFVPtxIS
         GGCm3XhJjrLIq0HokX9HqdAqLHmR+U7JzZ6NdTBcN2PxQSGY47S/vWWe6PRzGWyZsRHK
         OsKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=frOnrhJ74ppM6hXWocdjxv2r1BiSDtd6GcT/Z6n8wU0=;
        b=GbjNb9+T74eAodnWD6gocwDkToz3U7XUiq5Y8VoWWSMDb4tO+4qFTfftsGTGYDjFRi
         c/D8HwT8QnwBQYpRQORT7D3y5UrMEpj9cTEHBpbM+NZGQPrIPNTukCflNM3hGAH5sh8i
         4nBx8V1lXA8DuSp5iBwbeY7L/9z7vBUkVhHOsYt8hhlG3lhDWeXtPBtd9WpaOWIvo9De
         k8VFl8DsCSfoR74DY281WofDjTp4+YO8dx5in8+hQqFn5dwx2SHt1Qa5ISsk9GyvzVe3
         xDY63tD9juLlyRuwLPR4I7FnFhY13iIHlE8kRtQ+MrqYw49KSHdohKT729w6kBR5Yf38
         amhw==
X-Gm-Message-State: ACrzQf3sGSDWsWstsoP+d5Mty6fLUOteeSaOx7fCaV9MNmnW55gJP0ek
        LpyEUWY3quN/v504RuXGlFgTpDYZWNJZcV9ch5TcEg==
X-Google-Smtp-Source: AMsMyM5olyoqt3HWysASRfmTw7EcpeES+nNZCfFVFJlLHvy4TBh7/6VbG+eA4kRXDUCwMcUpQ9LDpvaixauVJCY7Eaw=
X-Received: by 2002:aa7:c718:0:b0:462:ff35:95dc with SMTP id
 i24-20020aa7c718000000b00462ff3595dcmr57926907edq.32.1667983965031; Wed, 09
 Nov 2022 00:52:45 -0800 (PST)
MIME-Version: 1.0
References: <20221107071511.2764628-1-Mr.Bossman075@gmail.com>
In-Reply-To: <20221107071511.2764628-1-Mr.Bossman075@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 9 Nov 2022 09:52:33 +0100
Message-ID: <CACRpkdZj=DqLQye9Cm3xCdo68tMqK8HAuNfOpCSRv9rSbSir4g@mail.gmail.com>
Subject: Re: [PATCH v1 0/7] Clean-up and documentation for i.MXRT1050
To:     Jesse Taube <mr.bossman075@gmail.com>
Cc:     linux-imx@nxp.com, robh+dt@kernel.org, sboyd@kernel.org,
        shawnguo@kernel.org, kernel@pengutronix.de, festevam@gmail.com,
        aisheng.dong@nxp.com, stefan@agner.ch, gregkh@linuxfoundation.org,
        arnd@arndb.de, linux@armlinux.org.uk, abel.vesa@nxp.com,
        dev@lynxeye.de, marcel.ziswiler@toradex.com, tharvey@gateworks.com,
        leoyang.li@nxp.com, fugang.duan@nxp.com,
        giulio.benetti@benettiengineering.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 7, 2022 at 8:15 AM Jesse Taube <mr.bossman075@gmail.com> wrote:

> During the initial commit of i.MXRT1050
> many of the DT docs were missing; this patch adds them.
> The commit also adds docs for i.MXRT1170.
> Clean up dtsi.
> fix all the naming of pins in pinctrl,
> wrong due to a miscommunication.
>
> Jesse Taube (7):
>   dt-bindings: arm: imx: Add i.MXRT compatible Documentation
>   dt-bindings: pinctrl: Fix file path for pinfunc include
>   dt-bindings: timer: gpt: Add i.MXRT compatible Documentation
>   dt-bindings: serial: fsl-lpuart: add i.MXRT1170 compatible
>   dt-bindings: mmc: fsl-imx-esdhc: add i.MXRT1170 compatible
>   pinctrl: freescale: Fix i.MXRT1050 pad names

I applied patches 1-6 to the pinctrl tree.

>   ARM: dts: imx: Update i.MXRT1050.dtsi compatibles

Please apply this patch 7/7 to the i.MX SoC tree.

Yours,
Linus Walleij
