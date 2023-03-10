Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43D4D6B549E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 23:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbjCJWkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 17:40:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231513AbjCJWkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 17:40:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C266012DDDA;
        Fri, 10 Mar 2023 14:40:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 728D7B8233B;
        Fri, 10 Mar 2023 22:40:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E33C2C433A0;
        Fri, 10 Mar 2023 22:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678488009;
        bh=X6JJ8hKaOwjK+z85rFeVDIA0F8rbcMZOIeRWogzIjB4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IreQiwUg2l90VWXx0SVc5MK/HfOvai9Jj8sV99x78eYPhaBLRrkuMLL9kB5NT2jyc
         PaNY43x+Graq29L3aW5W4bLyTHdK5+BhB+8uJxaIaHQfSo96Ni1goURjs6n9FiJEig
         AFtaZujpbUTKD5c79ywYJdDGDheeyBwzk0KOcFAr/yQlwuTQGFoDRtR1Y5z/05F39Q
         6XgD0HNJHw1IprlERxsQVQaM+BfVDeD1zlrd6lHIRaSbjp7JFnnI5TcK9yrk3j7XVZ
         NoRF75mneLE52uNYiOMqdpDmLse9ayIBXy6H/BZaillBzjcXaDoL/CV9PYHubdqgzo
         lsUlg6FIFBL/A==
Received: by mail-ua1-f46.google.com with SMTP id p2so4581350uap.1;
        Fri, 10 Mar 2023 14:40:09 -0800 (PST)
X-Gm-Message-State: AO0yUKWyU2QZxOjlSSryWyyhYRIDPh3dmpB6Sepz5XpPq67sbcyS8y74
        YSqVQCFEPvOtiHI7CB9UzJYMv5SQwBhoCzDCmg==
X-Google-Smtp-Source: AK7set+Z52Frd//pueEciK1V0k1o5hAldF9l+GJeEdz88kQqINdcsNfemJBGP8kHwDNSRn+msUGBFNIbcvN4gs3UIZI=
X-Received: by 2002:ab0:4714:0:b0:68e:2ed3:92eb with SMTP id
 h20-20020ab04714000000b0068e2ed392ebmr12478359uac.1.1678488008830; Fri, 10
 Mar 2023 14:40:08 -0800 (PST)
MIME-Version: 1.0
References: <197ea188-c59d-6c53-77fd-3a0551ef8e70@linaro.org>
In-Reply-To: <197ea188-c59d-6c53-77fd-3a0551ef8e70@linaro.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 10 Mar 2023 16:39:57 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLYdyqe+=zb_sDOcffbbb3AUhxsCbUp_1GHk1fKu2xiJw@mail.gmail.com>
Message-ID: <CAL_JsqLYdyqe+=zb_sDOcffbbb3AUhxsCbUp_1GHk1fKu2xiJw@mail.gmail.com>
Subject: Re: Qualcomm Kryo core compatibles
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        dt <devicetree@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 8, 2023 at 4:44=E2=80=AFAM Konrad Dybcio <konrad.dybcio@linaro.=
org> wrote:
>
> Hi!
>
> I was recently debating what to do about Qualcomm Kryo compatibles.
>
> There are basically 3 cases:
>
> 1. Falkor/"real Kryo" - the (never shipped?) server platform & MSM8996
>
> This one's easy, it's actually Kryo so it should stay Kryo.
>
>
> 2. Fake Kryo ("customized" Arm Cortex cores) (MSM8998-SM8x50)
>
> This one's tough.. Qualcomm marketing material seems to sometimes say
> Cortex, sometimes Kryo, sometimes "customized Cortex".. They do use
> their own arm IMPLEMENTER_ID in the MIDR_EL1 register and their
> PART_NUM values are not Arm-stock, but these cores don't seem to be
> any special.. Maybe some irq lines are routed differently? Not sure.
>
> My proposition here is to do:
>
> "qcom,kryoXXX", "arm,cortex-ABC"
>
> or
>
> "qcom,kryoXXX-PQR", "arm,cortex-ABC"

I don't see much value in the fallback here. We don't do much with the
values anyways as everything uses ID registers anyways. Do you know
the level of modification?

> where PQR is one of:
> - silver (LITTLE cores)
> - gold (big cores)
> - gold_plus (prime core(s))
>
>
> 3. Arm cores modified within Arm implementation-defined allowance (SC8280=
XP+)
>
> These cores report Arm IMPLEMENTER_IDs and actual Arm PART_NUMs, which wo=
uld
> suggest they're bone stock Arm Cortex cores, with some Qualcomm-iness com=
ing
> as part of implementation details which are.. expected since Cortex allow=
s for
> some IMPLEMENTATION DEFINED things. The only non-obvious part here is tha=
t
> the REVISION field they report does not always seem covered by the Arm TR=
Ms.
>
> In this case I think going with
>
> "arm,cortex-ABC"
>
> is fine.. I already did this for 8550 and 8280xp and Rob seems to have li=
ked it.
>
> So, I suppose the real question is what to do about 2., should they stay =
as
> they are, or maybe my proposition seems attractive?

What about the generic 'qcom,kryo' strings?

Rob
