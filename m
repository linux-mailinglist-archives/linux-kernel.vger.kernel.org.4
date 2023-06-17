Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3FBC73433D
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 21:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233891AbjFQTB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 15:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjFQTBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 15:01:24 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6305319BE;
        Sat, 17 Jun 2023 12:01:22 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-55b3b3e2928so1453359eaf.2;
        Sat, 17 Jun 2023 12:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687028481; x=1689620481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o9zYN1s6aJ0LEi8KHBtKqVNpKfhxjbsJ2S0b8cW5gUk=;
        b=ei2g1Tda9xPPuzWdfE0kdTxLxyTjEePRpmC8O3phoxF/ad5eJ/QhfYkNEpUDn1AUNj
         ii2rkio3ptUDSI/JVwKh/+PnQqUD1y2yStkw6UOVY6vyYQUZW6119MGZ34ivdUB4qs0V
         1Kn2koCXwLVOWxW5xC1a0c0M/Yo85i2nNQjT1NEvax6fGz22GV4sZTLo+z8R3vFUumyJ
         vKOl322oqVvMU4yp7rOidil04c1kiuBxIpCmt88M6IBHiwIqpxOiRa89AieTjOjXNwzx
         4j7A5hxEEnWs5gXdGeH7YF4TeVkdJO9g+yxIvtOk1kuQfszGMj6mHFSAPDLlsh4o12fo
         C65w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687028481; x=1689620481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o9zYN1s6aJ0LEi8KHBtKqVNpKfhxjbsJ2S0b8cW5gUk=;
        b=WW6uRgXK6aEzLryT3KQOJdw5COj3vlENLtoroaSWPiV4N1e0cibT1pzwjj0lyKZ9sq
         3A8X12DZ5BRaWZ2Ed24IcHJol8+fOLM1ZFl9xB53h7LziytJugBqH43IcyLPGrC3E6dy
         igwDI77Kf8KvrSfcyqNq6JmcnZPtb9vLjvR6ldWpH9SGWPKxiRI+9gQeCTQ6B3PbNJFM
         qatlSLvwCXa0EAKasG877j8AXfSDcA7t/hZg9PRrVlvYrElzw7vv7464JMDoAWGjbIKz
         sIG3YORGFHpNIwDOQfKy7NuNX+iykYhBR7bKdk6FO7NPwyDIESsjhrV2NKdATakcWjDt
         lqYQ==
X-Gm-Message-State: AC+VfDyAkP3ohcrRFIPPOBKsr8b4ZId9fHbfupihGJJo1hc5KZWXfPQx
        xaW6jQvWiA2u42Ty+eEpcrLBsQ847ZqwyLX09wvwi1dKdRI=
X-Google-Smtp-Source: ACHHUZ6TIudfqAPWfTKVZSw+J8QK7VO2DFBdsk8l64XrzvemQpn/a5hCexUP0R16WaBfoM+iR+ufRszT0q/+tnNC70Y=
X-Received: by 2002:a4a:de82:0:b0:55c:6812:27c5 with SMTP id
 v2-20020a4ade82000000b0055c681227c5mr2920690oou.9.1687028481556; Sat, 17 Jun
 2023 12:01:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230617052435.359177-1-sergio.paracuellos@gmail.com>
 <20230617052435.359177-9-sergio.paracuellos@gmail.com> <c1a69db7-96c2-f3ad-3ef2-9a655b10bfb5@linaro.org>
 <CAMhs-H_HjsT2om2CZpMmVDYao=M5FoZwyy0Te1QB9MLj6mAxnw@mail.gmail.com> <b995dead-5cca-de05-5840-bed882d2c4ff@linaro.org>
In-Reply-To: <b995dead-5cca-de05-5840-bed882d2c4ff@linaro.org>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Sat, 17 Jun 2023 21:01:09 +0200
Message-ID: <CAMhs-H-kBNKLQMgAPgt7M7wO+hcHqRiYsgqnuJYkK1NFk1jYGw@mail.gmail.com>
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

On Sat, Jun 17, 2023 at 7:27=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 17/06/2023 17:35, Sergio Paracuellos wrote:
> > On Sat, Jun 17, 2023 at 4:48=E2=80=AFPM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 17/06/2023 07:24, Sergio Paracuellos wrote:
> >>> At very early stage on boot, there is a need to set 'mips_hpt_frequen=
cy'.
> >>> This timer frequency is a half of the CPU frequency. To get clocks pr=
operly
> >>> set we need to call to 'of_clk_init()' and properly get cpu clock fre=
quency
> >>> afterwards. Depending on the SoC, CPU clock index in the clock provid=
er is
> >>> different being two for MT7620 SoC and one for the rest. Hence, adapt=
 code
> >>> to be aligned with new clock driver.
> >>
> >>
> >>>  void __init plat_time_init(void)
> >>>  {
> >>> +     struct of_phandle_args clkspec;
> >>>       struct clk *clk;
> >>> +     int cpu_clk_idx;
> >>>
> >>>       ralink_of_remap();
> >>>
> >>> -     ralink_clk_init();
> >>> -     clk =3D clk_get_sys("cpu", NULL);
> >>> +     cpu_clk_idx =3D clk_cpu_index();
> >>> +     if (cpu_clk_idx =3D=3D -1)
> >>> +             panic("unable to get CPU clock index");
> >>> +
> >>> +     of_clk_init(NULL);
> >>> +     clkspec.np =3D of_find_node_by_name(NULL, "sysc");
> >>> +     clkspec.args_count =3D 1;
> >>> +     clkspec.args[0] =3D cpu_clk_idx;
> >>> +     clk =3D of_clk_get_from_provider(&clkspec);
> >>
> >> This is very obfuscated way of getting clock. Why can't you get it fro=
m
> >> "clocks" property of "cpu", like every other recent platform?
> >
> > I did not find any other approach that works for me. So I ended up in t=
his one.
> > Can you point me out in a sample of code doing the same so I can check
> > if it works for me then?
>
> You mean bindings?
> git grep cpus.yaml
>
> Driver?
> git grep clk_get_rate
> clk_get
> eventually of_clk_get
>
> It all depends on the context.
>
> Anyway, it is very easy to find existing solutions not using
> of_find_node_by_name for your platform:
>
> git grep mips_hpt_frequency
>
> First result.

I have tested before all of these and got into panic because clock
cannot get retrieved:

For example first result is to make use of clk_get so change the code into:

void __init plat_time_init(void)
{
    struct clk *clk;

    of_clk_init(NULL);
    clk =3D clk_get(NULL, "cpu");
    if (IS_ERR(clk))
       panic("unable to get CPU clock, err=3D%ld", PTR_ERR(clk));

    pr_info("CPU Clock: %ldMHz\n", clk_get_rate(clk) / 1000000);
    mips_hpt_frequency =3D clk_get_rate(clk) / 2;
    clk_put(clk);
    timer_probe();
}

And I panic because I cannot get the cpu clock...

>
>
> Best regards,
> Krzysztof
>

Thanks,
    Sergio Paracuellos
