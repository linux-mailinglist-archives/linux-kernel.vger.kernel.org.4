Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 845CE66DB94
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 11:54:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236355AbjAQKyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 05:54:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236144AbjAQKyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 05:54:20 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B1F30288;
        Tue, 17 Jan 2023 02:54:19 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id v10so43265433edi.8;
        Tue, 17 Jan 2023 02:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ab9kaP68KTbfELnA5RfuMX2nySH/a7yjfTaW9w+IzMo=;
        b=IMJsIosuncWC677AT8d/nb0C8g4B8iGlXdSzem9YfITAYaR9yAt5Q5kEttKpLUGHBP
         8BrQB2vCWSwh9RhZ1Jc6J5UthP3dFY54ygujzPKPWNQtx21Kw2LDi80zSZl//ZaOfjO8
         YxN47xbBSz3U/NF7iUB6wNsMch+flIXxZMeELpyl1tcQjCp113nnzXwrifGx1r8a/jQ3
         39jQ0gRTzePAMgJH/nCSljQWKER4SDfz7dWihYz1vTO/7T8GytIcFmlFspFLQp3qL0E1
         tVYMp4znWVE9axpv4BO7I66dyt+rGMbIRP134wq3OudZCW4/HiqArbKt0OzxKa5c8nEp
         JM+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ab9kaP68KTbfELnA5RfuMX2nySH/a7yjfTaW9w+IzMo=;
        b=P3OKO2mazzMhPMWlZryZ7fyQKhhFF7RIFsRg+C7xyV2IzVx8fRQAbWv2BiOm+iUGT5
         3cUY8o+W2pNbzrDr6yHzgtfXqm9qEUvdBRH+sFpJYL3olZKpGjukxL6XvpFnvoqykHEu
         gotH3A/4mSbhisX9Tu/OThm29JE5EjewFjymB+5o9xyvj9puAzhxaVihZffMn41FypfC
         nizfRQVT2mvgeFjkklHHI8+5jLPtUyuxOXsY0pQQPoTFn2wc4ZlRIDa7S5U9piIKiiJB
         eGlW42036Slhwmx3PBle8t/7FH/39prbitkmT8yB3zcWYwHACEXy42mmhek/0/Xk+JFO
         UJjg==
X-Gm-Message-State: AFqh2kpdQYtj1bF8vwo5E0gAVOG8i8q/6oWVBJWxn20Dth7WHiRfjxkn
        yvGS/AUb60day9xhJUm8sIWS0YPJ0immiJYNSEr+C4EWfnliXQ==
X-Google-Smtp-Source: AMrXdXtUkj+X80GHaCSEtfK6VJkoXzpNIi4Od+Fm5gJKD0odkEZAqk2seQg9CBH2llI5M+tCvOu1m9jg56a0UoHPfa0=
X-Received: by 2002:a05:6402:910:b0:49d:f658:7989 with SMTP id
 g16-20020a056402091000b0049df6587989mr268384edz.300.1673952857535; Tue, 17
 Jan 2023 02:54:17 -0800 (PST)
MIME-Version: 1.0
References: <20230113110738.1505973-1-keguang.zhang@gmail.com>
 <20230113110738.1505973-2-keguang.zhang@gmail.com> <167362342081.2212182.3990856069388425566.robh@kernel.org>
In-Reply-To: <167362342081.2212182.3990856069388425566.robh@kernel.org>
From:   Kelvin Cheung <keguang.zhang@gmail.com>
Date:   Tue, 17 Jan 2023 18:54:00 +0800
Message-ID: <CAJhJPsX-c_05bzA6cvN5b5wubS=cJCcXvRcQNTqR2RUa6Y3ZFw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: clock: Add binding for Loongson-1 clock driver
To:     Rob Herring <robh@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-mips@vger.kernel.org, linux-clk@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
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

Rob Herring <robh@kernel.org> =E4=BA=8E2023=E5=B9=B41=E6=9C=8813=E6=97=A5=
=E5=91=A8=E4=BA=94 23:26=E5=86=99=E9=81=93=EF=BC=9A
>
>
> On Fri, 13 Jan 2023 19:07:37 +0800, Keguang Zhang wrote:
> > Add devicetree binding document for the Loongson-1 clock driver.
> >
> > Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> > ---
> >  .../bindings/clock/loongson,ls1x-clk.yaml     | 81 +++++++++++++++++++
> >  1 file changed, 81 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/clock/loongson,ls=
1x-clk.yaml
> >
>
> My bot found errors running 'make DT_CHECKER_FLAGS=3D-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> Documentation/devicetree/bindings/clock/loongson,ls1x-clk.example.dts:36.=
39-41.15: Warning (unique_unit_address_if_enabled): /example-0/clocks/cpu_c=
lk@1fe78034: duplicate unit-address (also used in node /example-0/clocks/ah=
b_clk@1fe78034)

I did notice this warning.
But my situation is the cpu_clk and ahb_clk share the same registers.
May I have your suggestion?
Thanks!
>
> doc reference errors (make refcheckdocs):
>
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/202301=
13110738.1505973-2-keguang.zhang@gmail.com
>
> The base for the series is generally the latest rc1. A different dependen=
cy
> should be noted in *this* patch.
>
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
>
> pip3 install dtschema --upgrade
>
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your sch=
ema.
>


--=20
Best regards,

Kelvin Cheung
