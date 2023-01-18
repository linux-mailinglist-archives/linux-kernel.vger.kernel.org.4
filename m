Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1F50671B60
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 13:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbjARMAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 07:00:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjARMAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 07:00:05 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9168195776;
        Wed, 18 Jan 2023 03:17:20 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id mg12so10057839ejc.5;
        Wed, 18 Jan 2023 03:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+WvnsyBwq6I214G0UUbVvw7PrEfVlf2amNboiSNP2xM=;
        b=coxosbpnlBUyGHvBHIQJT57uSVRTV6tgCiHpsrGO1DnSSC5BrJ5fz6uOeimTEf7ktM
         jmAOSAF7keOAEvddSDQX11c9YWiluXWyEnwOxlYI9isYNLsnqUrj2FA0we/7czFrQI1j
         a8CZy+kaWCltxnp69uj9Sg1GqCTUP/KLqOZj2EhjKpeYGAPGkhekTtVVAyM+Jmwg9YFi
         F7PybMW6TDnBgZWlqZbknFYEFCCQ2N0jI6jOhFirtuslAZTnb020oRZxJPDCjxspYlfA
         pJZVzhY2ZtzJhom37wV+3SVj4qwujDB/WpMbazNa5nBTons04cMgzsB0BCAz2bt1fuIA
         Wuhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+WvnsyBwq6I214G0UUbVvw7PrEfVlf2amNboiSNP2xM=;
        b=lrg9Tz4GMTVLzeZXuaDfWgDYK6yrvpGZqL60pabIEETjWtTkTAbH8mQwBeB09ik688
         XE2XrpvJOb9bUwI8HDuaKRdM3jrNr0NcGaBolXVR+F9pdOlWop+PieyQsgiTK5WSo0n4
         pZKITYEOB9OuILZSfFUrfl2sQp3K8UoZKzMjf8mEe94XrsSmSSrFZL07JU/dHIMlxHkE
         qeyXs657/Ok6JNnjm2q4Q2cTA9G/jLcuBbEuk5mPrB4Vm8KZmUCDxF9CDsv9FjJ6hIBN
         37I816aSlgry+fAwQekFn0MmwCvh79/l9TzfaFjt4Xkz/eBEdAiI3hzTsde+kB+YBslK
         bjlA==
X-Gm-Message-State: AFqh2kq3Tj4FUwCuYdMvImGm8R5jQ0QgEK/xelRJycE3iztZ5Y36TIUg
        ilavlHboQl4CYKybQiCplZzOqykrq4Tm3TFUVpU=
X-Google-Smtp-Source: AMrXdXu6ivjAMpYq0/MbznNJ8/8XkS/dsP5olPmeYxo76R8LvmnQuWvdq5qppZXtVJxss1X21mknCwF5gxbkCB+eeXo=
X-Received: by 2002:a17:907:a2c4:b0:877:5ff6:e340 with SMTP id
 re4-20020a170907a2c400b008775ff6e340mr101142ejc.163.1674040636721; Wed, 18
 Jan 2023 03:17:16 -0800 (PST)
MIME-Version: 1.0
References: <20230113110738.1505973-1-keguang.zhang@gmail.com>
 <20230113110738.1505973-2-keguang.zhang@gmail.com> <63fdd223-c5e1-302d-ffef-9e582874e938@linaro.org>
 <CAJhJPsV5wC_fNgP9iSi1bUp+HFY=dgyh4-x0OueZ8fQO=p7r8w@mail.gmail.com> <4f56e6b3-c698-0909-17a0-ec8c39b6c25d@linaro.org>
In-Reply-To: <4f56e6b3-c698-0909-17a0-ec8c39b6c25d@linaro.org>
From:   Kelvin Cheung <keguang.zhang@gmail.com>
Date:   Wed, 18 Jan 2023 19:16:59 +0800
Message-ID: <CAJhJPsXOX16SA0bb8zWJ=wSxshjv38g038cR0b3u0CDDm1aUQw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: clock: Add binding for Loongson-1 clock driver
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
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

Hi Krzysztof,

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> =E4=BA=8E2023=E5=B9=B4=
1=E6=9C=8817=E6=97=A5=E5=91=A8=E4=BA=8C 18:47=E5=86=99=E9=81=93=EF=BC=9A
>
> On 17/01/2023 11:31, Kelvin Cheung wrote:
> >>> +  "#clock-cells":
> >>> +    const: 0
> >>> +
> >>> +  compatible:
> >>> +    enum:
> >>> +      - loongson,ls1b-clk-pll
> >>> +      - loongson,ls1b-clk-cpu
> >>> +      - loongson,ls1b-clk-ahb
> >>> +      - loongson,ls1c-clk-pll
> >>> +      - loongson,ls1c-clk-cpu
> >>> +      - loongson,ls1c-clk-ahb
> >>
> >> Are you registering single clocks? It looks like. No, make a proper
> >> clock controller.
> >
> > This binding contains two types of clock, pll-clk and div-clk.
> > Should I split the binding to two bindings files?
>
> No, you should register rather one clock controller. Why this have to be
> 3 separate clock controllers?
>
This sounds like a big change for the driver.
Could you please show me a good example of one clock controller?
Thanks very much!
> >>
> >>> +
> >>> +  reg:
> >>> +    maxItems: 1
> >>> +
> >>> +  clocks:
> >>> +    maxItems: 1
> >>> +
> >>> +required:
> >>> +  - "#clock-cells"
> >>> +  - compatible
> >>> +  - clocks
> >>> +  - reg
> >>> +
> >>> +additionalProperties: false
> >>> +
> >>> +examples:
> >>> +  - |
> >>> +    clocks {
> >>
> >> No, not really related to the binding.
> >
> > Should I remove the "clocks" section?
>
> Yes.
>
> >>
> >>> +        #address-cells =3D <1>;
> >>> +        #size-cells =3D <1>;
> >>> +        ranges;
> >>> +
> >>> +        xtal: xtal {
> >>
> >> Incorrect in this context. Missing unit address.
> >
> > XTAL doesn't have reg property.
>
> Yeah, but DTS is not correct now, is it? If you doubt, build your DTB
> with W=3D1.
>
No doubt.
I just want to know the right way to declare XTAL.
Could you please show me an example?
Thanks again!
> >>
> >>> +            compatible =3D "fixed-clock";
> >>> +            #clock-cells =3D <0>;
> >>> +            clock-frequency =3D <33000000>;
> >>> +        };
> >>> +
>
> Best regards,
> Krzysztof
>


--=20
Best regards,

Kelvin Cheung
