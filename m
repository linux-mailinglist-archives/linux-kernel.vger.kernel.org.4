Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE32B7341F2
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 17:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235450AbjFQPfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 11:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjFQPfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 11:35:41 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E64AE173A;
        Sat, 17 Jun 2023 08:35:39 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-39c84863e34so1483518b6e.2;
        Sat, 17 Jun 2023 08:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687016139; x=1689608139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9LsEwokw1RqEKZThhah+qwmax8s2N9qlAKLA8t0MbTo=;
        b=S6FGMApHw9Vgq3mutjv8VSrqTjETlRoFW4a+jgDqh3wgrc0HJP8BfCpGiz5gTagf2G
         ClBwcNlH3MG7YQDf263ugoR3FzRdpYna40qph/Ktam06M18njFPFDfyILgxWx7w03lRE
         QceSssh7NbSNKs+9drU9NtogQWGPBnrdS885oBUWOYZuYH7N8CtY1KWW+XkEvvR6TiJb
         9JUDyjx5Z7/NqGD9cFeo9ndgxBP0ABKu32OShs2P9ngRHiBWxVujFd5ydcR1BZVwOrfn
         Zzvq9hBf81o0yyWllEK/v9m+U89txQGTdDpae0qNY9vGRmTQs3DygEHXlOjSb3XgJV1Z
         4G8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687016139; x=1689608139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9LsEwokw1RqEKZThhah+qwmax8s2N9qlAKLA8t0MbTo=;
        b=R4TfNbnSITjWKicbwKCZZenxCdBUVSF0BDCvtigzPlboEta5RkS0QVZzNdPAitcVG6
         r3i3xICuzvmMTEZMWDdnCV3Y3A2Q8YiYMgj0i90fCRFuoypqlBpP7wDPI60sdBcoxofp
         hznXgEuxSs63N0n4Fnys1X2TB+8a63CYTazJVPLJm3PCfDic7TCniuI9w52Y9krao0Oj
         E6rwDjmf7LIRgDSxeWoLpdQTMUC6UiWEm60amW7Cr6bMuu9Cg1VY+nWkACdtGQ/chzEC
         SiLBbCjidN8UOol3bwTMv6Xj/d7T4Go7fpdeAnfM56SiFOp+mDrk+ITvEsqgikOZPWg2
         H6IQ==
X-Gm-Message-State: AC+VfDxhdxjFJiyKpR2AW/YyE5pP5VAvECsJ38BYfkqHrKr9r+R3m1hE
        NQSdaIn6nGDXxJ4fH4Srvps/7UqMU2HOgI6XfNsyk0Zj
X-Google-Smtp-Source: ACHHUZ6uLV4QOe4yd5BzkR1MsYfF6TODFpnMKp9sWOtVu9rALIgr8ZcwycfrB+iEX1NjSWwHzNeJoyV+UJ9+dmrdKGk=
X-Received: by 2002:a05:6808:57:b0:39a:bef9:72cd with SMTP id
 v23-20020a056808005700b0039abef972cdmr5114300oic.47.1687016139119; Sat, 17
 Jun 2023 08:35:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230617052435.359177-1-sergio.paracuellos@gmail.com>
 <20230617052435.359177-9-sergio.paracuellos@gmail.com> <c1a69db7-96c2-f3ad-3ef2-9a655b10bfb5@linaro.org>
In-Reply-To: <c1a69db7-96c2-f3ad-3ef2-9a655b10bfb5@linaro.org>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Sat, 17 Jun 2023 17:35:28 +0200
Message-ID: <CAMhs-H_HjsT2om2CZpMmVDYao=M5FoZwyy0Te1QB9MLj6mAxnw@mail.gmail.com>
Subject: Re: [PATCH v4 8/9] mips: ralink: get cpu rate from new driver code
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-clk@vger.kernel.org, linux-mips@vger.kernel.org,
        tsbogend@alpha.franken.de, john@phrozen.org,
        linux-kernel@vger.kernel.org, p.zabel@pengutronix.de,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        devicetree@vger.kernel.org, arinc.unal@arinc9.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 17, 2023 at 4:48=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 17/06/2023 07:24, Sergio Paracuellos wrote:
> > At very early stage on boot, there is a need to set 'mips_hpt_frequency=
'.
> > This timer frequency is a half of the CPU frequency. To get clocks prop=
erly
> > set we need to call to 'of_clk_init()' and properly get cpu clock frequ=
ency
> > afterwards. Depending on the SoC, CPU clock index in the clock provider=
 is
> > different being two for MT7620 SoC and one for the rest. Hence, adapt c=
ode
> > to be aligned with new clock driver.
>
>
> >  void __init plat_time_init(void)
> >  {
> > +     struct of_phandle_args clkspec;
> >       struct clk *clk;
> > +     int cpu_clk_idx;
> >
> >       ralink_of_remap();
> >
> > -     ralink_clk_init();
> > -     clk =3D clk_get_sys("cpu", NULL);
> > +     cpu_clk_idx =3D clk_cpu_index();
> > +     if (cpu_clk_idx =3D=3D -1)
> > +             panic("unable to get CPU clock index");
> > +
> > +     of_clk_init(NULL);
> > +     clkspec.np =3D of_find_node_by_name(NULL, "sysc");
> > +     clkspec.args_count =3D 1;
> > +     clkspec.args[0] =3D cpu_clk_idx;
> > +     clk =3D of_clk_get_from_provider(&clkspec);
>
> This is very obfuscated way of getting clock. Why can't you get it from
> "clocks" property of "cpu", like every other recent platform?

I did not find any other approach that works for me. So I ended up in this =
one.
Can you point me out in a sample of code doing the same so I can check
if it works for me then?

>
> Anyway, NAK for of_find_node_by_name(), because you now create ABI for
> node name. It's broken approach.

I will change whatever is needed to provide a valid approach. Please,
point me out in the right direction.

>
> Best regards,
> Krzysztof
>

Thanks in advance for your time.

Best regards,
    Sergio Paracuellos
