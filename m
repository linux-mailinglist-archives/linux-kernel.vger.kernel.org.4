Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 807856BC1D0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 00:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233108AbjCOXyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 19:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbjCOXys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 19:54:48 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121894B824;
        Wed, 15 Mar 2023 16:54:47 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id bg16-20020a05600c3c9000b003eb34e21bdfso2079944wmb.0;
        Wed, 15 Mar 2023 16:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678924485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VaBC8VbXPeoS4Rhzpa1x7rfgBVJkXDyo8VEwCQbyxgY=;
        b=KRagSc0q5Ts39y9KYANs228UbpMEAjveR9gsU9dG9HY8+V2/OSekEJS2J0bBDWqyVI
         l7vrGExr1bsZS2sN3M22EavsRQXv8z0w+06kcWBwV1K1ES3hh8VoY7R6h9nGa63Aarjk
         7SNLTfoPpTsveVczJ/vHV2/QVzUlEm+UqlHh5V0yta61BCbZl9gaZnUohhAKjgfggFAV
         dzLElYqNNkatAF0S87bOvVOTFcqwtyIHhm3AiXvY0JVxGjag6Nu8+evXFwT65Jn83ILF
         qczmuwbUwdluhSfZGcYSssriD0qoLBboM+8+Avfua94OrP4sefDHExsW+DGrL68NFzuK
         tvoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678924485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VaBC8VbXPeoS4Rhzpa1x7rfgBVJkXDyo8VEwCQbyxgY=;
        b=BckD2fiQhayDpYoFFyfybRItqSls9PRbJ7lcLDxJWnUqxgXQ6gCCj/C7sJnaqMqFR2
         +DtPMmQtRKSDOp7lAsqhxvw1nT8oq67keCROp6NoeoK2yrWAKzoCFerDkmoq6KqkhKii
         JtYTkr6YjUEGkwkSfc+pvJrUijQmL0/GJ7sb5wPfzfcoNukfAuyNAwQUwkIQvpfIJqFM
         pFZoJZKIE1F9dQV/ePUlN9v1awrsNePYFBsyQ6WjlG6L2S6tAAi6YBdqjBZ9x9FNCuYD
         VPKF73X3OIhVgJOhcrAVqfUsTez35+N+8+3+0o1TuWX0EDKy1uxyOrn0mz2Rtu5Oxqed
         dHdQ==
X-Gm-Message-State: AO0yUKXpZ3sEEBZoST+1ml8VKpPZF6yXEmFoHPlmxXM8th81ObApp1BG
        74HLMdAEd1Z+XP64ltTGFxcyqAwUJRkpKNP+5Rk=
X-Google-Smtp-Source: AK7set9KWyqo4l8uXCJJtkj2AlRPkIOnFBuxBmSkyLnEZIV4Mw+VWV8nkO0wKXUaQZ0aClFi8oLMzH7dSRAdQenQRqs=
X-Received: by 2002:a05:600c:5114:b0:3ea:8ed9:8e4b with SMTP id
 o20-20020a05600c511400b003ea8ed98e4bmr5590816wms.6.1678924485358; Wed, 15 Mar
 2023 16:54:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230315160228.2362-1-cnsztl@gmail.com> <20230315160228.2362-6-cnsztl@gmail.com>
In-Reply-To: <20230315160228.2362-6-cnsztl@gmail.com>
From:   Vasily Khoruzhick <anarsoul@gmail.com>
Date:   Wed, 15 Mar 2023 16:54:18 -0700
Message-ID: <CA+E=qVcL1PNMcJ5M1zHQhZNpajxLJWWGQoXYeLER+OmV5Qz33A@mail.gmail.com>
Subject: Re: [PATCH 5/5] arm64: dts: rockchip: enable rk809 audio codec on the
 NanoPi R5 series
To:     Tianling Shen <cnsztl@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Peter Geis <pgwipeout@gmail.com>, Andy Yan <andyshrk@163.com>,
        Brian Norris <briannorris@chromium.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        Andrew Powers-Holmes <aholmes@omnom.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
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

On Wed, Mar 15, 2023 at 9:03=E2=80=AFAM Tianling Shen <cnsztl@gmail.com> wr=
ote:

Hi Tianling,

> +       rk809-sound {

There is no audio jack on my R5S, see [1] and I don't see it on R5C
either, see [2]. I don't see audio output on the pin header either.
How is it supposed to work?

> +               compatible =3D "simple-audio-card";
> +               simple-audio-card,format =3D "i2s";
> +               simple-audio-card,name =3D "Analog RK809";
> +               simple-audio-card,mclk-fs =3D <256>;
> +
> +               simple-audio-card,cpu {
> +                       sound-dai =3D <&i2s1_8ch>;
> +               };
> +
> +               simple-audio-card,codec {
> +                       sound-dai =3D <&rk809>;

It looks like rk809 doesn't have #sound-dai-cells property and it
results in a warning:

arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dtsi:48.27-50.5:
Warning (sound_dai_property): /rk809-sound/simple-audio-card,codec:
Missing property '#sound-dai-cells' in node /i2c@fdd40000/pmic@20 or
bad phandle (referred from sound-dai[0])

Regards,
Vasily

[1] https://wiki.friendlyelec.com/wiki/index.php/NanoPi_R5S
[2] https://wiki.friendlyelec.com/wiki/index.php/NanoPi_R5C
