Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D908C6F35E9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 20:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbjEASjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 14:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjEASji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 14:39:38 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920D319B0;
        Mon,  1 May 2023 11:39:33 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-958bb7731a9so581784166b.0;
        Mon, 01 May 2023 11:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1682966372; x=1685558372;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vy8LMgK7nlj8Hadd9P4DNIqtoF7V1DAnGwP0/fa2hB8=;
        b=U5D7cxNQTURT8xwkIm3G1FjwzyMGG5dzHJMisO4ldoGpHCh2i4+CzU5YRAlZCAKUGD
         Xn6lbly6fyylDsFJy7yJgxXVXxkji8ExeXlGf6txh4V/hW7XCBVIKBxy5q71Bivb2V2c
         uIgmKUQHOAA0WMq1LxPtFAvSwnlWRx2YBULmIgt+592UWgpHwxO75jhDHOoB4H82COlr
         yy1R9sUHSAI2/hJ6oWc4RqgrpbJv+uy9qVnZ5qo62qEQ5zgJMIrAASjE+RcYdFefYVw3
         JNfCACRGxcC0WO5XEoqMtPKgw6j3KM5b4jUV2TgDyTT4trKxdU2Pwl0XeAcsxa+mW/xZ
         q4Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682966372; x=1685558372;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vy8LMgK7nlj8Hadd9P4DNIqtoF7V1DAnGwP0/fa2hB8=;
        b=GTht1OR/nC15lh+sV/bB5WPtgJG6yqyQnFByLd0WILfwMG7+Jvl9GzHCI/MErrzThv
         p++csaxonEZ0kdA4P08KckwtaSYKhKFhP4pOQKLhVyyxzEjunZUsj1VFUBEElaCpk/5y
         5T8oN1BD+2LT+obINAvt6fvz359iCiKeEzJ3Ae5ay+AwnJ/bzD6NqFTxtSKrgzVBOmuL
         t8KEir4O7LJp+CGE8Vm1xqpoWvj1sYbOXHi+lwpQdDMeXPVJ9MMECMP4CNkgxbAvNX1q
         YrSfuJ8uJAAkIvBAnRFCIGo5WGzgTqZryUDNKggyBLAYbA6af9gxJpU6rF7OwBR1Y6vQ
         WJfw==
X-Gm-Message-State: AC+VfDwJnqq0SCEh+eOViKA/kePQSpvDpABm3ndbq7vofJzJke0KbS+W
        tpcWLG1pW5bkTxxeNh6dMvyOMp8JKSrwUGDqFs0=
X-Google-Smtp-Source: ACHHUZ7XYkmDWh6C7QrAP5IrIgIh54a4MMgW7FDGV1Ipa9leHn0ud1zf0ChP3eFCS4Yg4qGriQmF6zeP4UR5ar4Bb4U=
X-Received: by 2002:a17:907:160a:b0:94f:21cf:86c6 with SMTP id
 hb10-20020a170907160a00b0094f21cf86c6mr14226257ejc.51.1682966371921; Mon, 01
 May 2023 11:39:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230405195927.13487-1-ddrokosov@sberdevices.ru>
 <20230405195927.13487-5-ddrokosov@sberdevices.ru> <CAFBinCA3uZXzr3RgnWnKV5Qr-CPaZQX5joDg319i_cgzhLJy2g@mail.gmail.com>
 <20230425123304.xjmrkraybp2siwdw@CAB-WSD-L081021>
In-Reply-To: <20230425123304.xjmrkraybp2siwdw@CAB-WSD-L081021>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 1 May 2023 20:39:20 +0200
Message-ID: <CAFBinCCqx1oHf+PcXBkeRYHnGQChbTTPRyD8SJU+ait+TG+AjQ@mail.gmail.com>
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

Hello Dmitry,

(I'm aware you already posted a v14 - but I'm still replying here to
continue the discussion on one question I had to keep the context)

On Tue, Apr 25, 2023 at 2:33=E2=80=AFPM Dmitry Rokosov <ddrokosov@sberdevic=
es.ru> wrote:
[...]
> > > +/* PLL register offset */
> > > +#define ANACTRL_FIXPLL_CTRL0   0x0
> > > +#define ANACTRL_FIXPLL_CTRL1   0x4
> > > +#define ANACTRL_FIXPLL_STS     0x14
> > > +#define ANACTRL_HIFIPLL_CTRL0  0xc0
> > > +#define ANACTRL_HIFIPLL_CTRL1  0xc4
> > > +#define ANACTRL_HIFIPLL_CTRL2  0xc8
> > > +#define ANACTRL_HIFIPLL_CTRL3  0xcc
> > > +#define ANACTRL_HIFIPLL_CTRL4  0xd0
> > > +#define ANACTRL_HIFIPLL_STS    0xd4
> > Here I have a question that will potentially affect patch 3/6
> > ("dt-bindings: clock: meson: add A1 PLL clock controller bindings").
> > In the cover-letter you mentioned that quite a few clocks have been omi=
tted.
> > Any dt-bindings that we create need to be stable going forward. That
> > means: the dt-bindings will always need to describe what the hardware
> > is capable of, not what the driver implements.
> > So my question is: do we have all needed inputs described in the
> > dt-bindings (even though we're omitting quite a few registers here
> > that will only be added/used in the future)?
> > Older SoCs require (temporarily) using the XTAL clock for CPU clock
> > tree changes. To make a long story short: I'm wondering if - at least
> > - the XTAL clock input is missing.
>
> The Amlogic A1 clock engine comprises four clock controllers for
> peripherals, PLL, CPU, and audio. While the first two have been
> introduced in the current patch series, the last two will be sent in the
> next iteration.
I (think that I) understand this part.

> Presently, the PLL controller driver includes all the required bindings,
> and the peripherals controller driver has all bindings except for the
> CPU-related clock.
Let's stick to the PLL controller bindings for the next part.
My understanding is that the PLL clock controller registers
(ANACTRL_*) are managing the following clocks:
- fixed_pll
- sys_pll
- hifi_pll
- whatever "AUDDDS" is
- and some miscellaneous registers like ANACTRL_POR_CNTL and
ANACTRL_MISCTOP_CTRL0

I *think* you got the dt-bindings correct:
Even though the driver part does not support the hifi_pll yet, this IP
block seems to have a "hifipll_in" clock input.
Since the dt-bindings describes the hardware it may describe (for
example) clock inputs that are not used by the driver yet.

If you agree with my statement from above I'll be able to make my
original question more specific:
Since we know that we have all the required inputs for fixed_pll,
sys_pll and hifi_pll - do you know what AUDDDS is and whether it
requires any specific clock inputs (other than "fixpll_in" and
"hifipll_in")?

> However, I do not believe this to be a significant issue. The clock DT
> bindings are organized to simplify the process of introducing new binding=
s,
> whether public or private. For instance, we may add new bindings to
> include/dt-bindings at the end of the list and increase the overall numbe=
r,
> without disrupting the DT bindings ABI (the old numbers will remain
> unchanged).
Yep, this part is clear to me. I should have been more specific that I
was asking about the inputs that are described in the .yaml file, not
the clock IDs.


Best regards,
Martin
