Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 105B4701F99
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 22:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234111AbjENUyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 16:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjENUyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 16:54:07 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C44E7A;
        Sun, 14 May 2023 13:54:06 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-50bd37ca954so105732759a12.0;
        Sun, 14 May 2023 13:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1684097644; x=1686689644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YYXzQGD4CK+PR6VYYUVHfW34nIF3O8YOM3IMJi2QYTs=;
        b=JSTgRl2SmfcWopA251KJrDng3cAoIp4gpXTE6HFK9VY+6/gwM2oVqDfKldQgX8ptxo
         ApgzLBeMR+G9CV6GSQ1WbFQDz4JP11YlBscQtb9vLloHBDuTmjLnfPNHnQqqOhQL2wOR
         D8XEOc1beJW1wZQV228VMaPTxOF8pfC1mTBIfiJkgO9u0SsWl/PMIZ+dJPxvEG26pPxr
         kNi1tn/9CXQAwmp4Zk0wcOAi2qA3/Dte0Vu1JaJye6PjrDi9B6fsFjqAPWW/uDTF2HHG
         Ga/dYwkzcGXFnrm4TTqdpY2EopR2rqmjhwB3DUE+tLcqNPzlwEMylXAYql2Rvv8CFSJ0
         xoBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684097644; x=1686689644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YYXzQGD4CK+PR6VYYUVHfW34nIF3O8YOM3IMJi2QYTs=;
        b=dO3VdFlz3jotZyhalChm4OAc7Bhd70xGrrBkuWD1xg+4VY/h/mEKwsYPfy3LBjP3Eh
         2RuagVArPmHS/hzdYGqoNu8/C0zfOZ0Z0abnWxwdTS2pNVVz0aqnYPhex+amkXvGbAnM
         NExAZdR5UNmQREvEZ1ilwJHI65jfTdGndpB5MACf+Ppt+IKdPUqfRCSdmccrQ9Vekyan
         CBnGCzU5xYpxC9V5iqdthURRQ4HmZhG8hOqTMKm9Caw16jDXJOk9Lx0Zk67gfPmrkzxR
         1a0xa0V6STkp45rjdbaGnQYHelNUhqeWlh5rU8/ZHczrmRtg8oLO0SLRvJd3ax8ORay4
         s8zw==
X-Gm-Message-State: AC+VfDztC+xmh95z5X69RyRG2p+DyKLIbEnWseQW5jDgqiMhQZUcxBo1
        9Z2js7CgRnBvNI4F/+UPMn6TrFenquBYFqTQXoc=
X-Google-Smtp-Source: ACHHUZ6aAc7g+tuqtm7m+Fo4Q/ZkFtq4577x7D2m+gvXW5qmQnJ1rjCVz8GazQhyDuyNmWlvfQcoabyoo8++z0bEXLY=
X-Received: by 2002:a17:907:6e06:b0:969:c354:7d9a with SMTP id
 sd6-20020a1709076e0600b00969c3547d9amr17320894ejc.12.1684097644271; Sun, 14
 May 2023 13:54:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230405195927.13487-1-ddrokosov@sberdevices.ru>
 <20230405195927.13487-5-ddrokosov@sberdevices.ru> <CAFBinCA3uZXzr3RgnWnKV5Qr-CPaZQX5joDg319i_cgzhLJy2g@mail.gmail.com>
 <20230425123304.xjmrkraybp2siwdw@CAB-WSD-L081021> <CAFBinCCqx1oHf+PcXBkeRYHnGQChbTTPRyD8SJU+ait+TG+AjQ@mail.gmail.com>
 <20230511132606.vk52yorf43alwgew@CAB-WSD-L081021>
In-Reply-To: <20230511132606.vk52yorf43alwgew@CAB-WSD-L081021>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 14 May 2023 22:53:53 +0200
Message-ID: <CAFBinCCmNLQF_qV3k4kgDEAsemEsjL-GQtPex7Pmxrc2sHx30A@mail.gmail.com>
Subject: Re: [PATCH v13 4/6] clk: meson: a1: add Amlogic A1 PLL clock
 controller driver
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>
Cc:     neil.armstrong@linaro.org, jbrunet@baylibre.com,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, khilman@baylibre.com,
        jian.hu@amlogic.com, kernel@sberdevices.ru, rockosov@gmail.com,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
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

Hi Dmitry.

On Thu, May 11, 2023 at 3:26=E2=80=AFPM Dmitry Rokosov <ddrokosov@sberdevic=
es.ru> wrote:
[...]
> > If you agree with my statement from above I'll be able to make my
> > original question more specific:
> > Since we know that we have all the required inputs for fixed_pll,
> > sys_pll and hifi_pll - do you know what AUDDDS is and whether it
> > requires any specific clock inputs (other than "fixpll_in" and
> > "hifipll_in")?
> >
>
> To be honest, I have prepared A1 peripherals and A1 PLL drivers based on =
very
> poor Amlogic datasheets and custom 4.19-based vendor drivers.
> The vendor driver has an AUDDDS clock in the PLL clock part, but it is no=
t
> used anywhere. Unfortunately, as usual, the datasheet doesn't provide any
> information or explanation about what it is. However, the driver has a fe=
w
> lines of comments that indicate:
>
>     /*
>      * aud dds clock is not pll clock, not divider clock,
>      * No clock model can describe it.
>      * So we regard it as a gate, and the gate ops
>      * should realize lonely.
>      */
>
> Additionally, the vendor driver states that AUDDDS has a 49Mhz clock,
> but I do not see any relationship with other clocks (including the export=
ed
> GENCLK).
> Jian did not include it in the first version of the PLL driver, and I hav=
e
> decided not to change it either.
>
> I also noticed a few lines of AUDDDS initialization sequences in the vend=
or
> driver, which may affect CPU clock objects (from my point of view).
> However, they are currently under development, and I will try to figure i=
t
> out with Amlogic support.
>
> > > However, I do not believe this to be a significant issue. The clock D=
T
> > > bindings are organized to simplify the process of introducing new bin=
dings,
> > > whether public or private. For instance, we may add new bindings to
> > > include/dt-bindings at the end of the list and increase the overall n=
umber,
> > > without disrupting the DT bindings ABI (the old numbers will remain
> > > unchanged).
> > Yep, this part is clear to me. I should have been more specific that I
> > was asking about the inputs that are described in the .yaml file, not
> > the clock IDs.
>
> Actually, AUDDDS has an xtal2dds parent clock, and if we need to have
> the AUDDDS clock in the PLL driver, we should add one more link between
> peripherals and PLL drivers.
>
> Let me know if you have any questions.
I have no questions - all I can say is that:
- I like your approach of clarifying details of the AUDDDS clock with Amlog=
ic
- and I fully agree with your conclusion that (depending on what
Amlogic says) we need one more link from the PLL driver to the AUDDDS
clock

Thank you for your persistence with this series, I'm sure it will pay
off in the long run!


Best regards,
Martin
