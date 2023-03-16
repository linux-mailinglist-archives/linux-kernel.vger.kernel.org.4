Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 420D06BC612
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 07:26:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjCPG0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 02:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjCPG0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 02:26:00 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD9796F00;
        Wed, 15 Mar 2023 23:25:59 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id o12so3338323edb.9;
        Wed, 15 Mar 2023 23:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678947958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6uZ4jN92GiZ4W0MGudnlAhsr4/aq12M9FC/ERUX3tKY=;
        b=J3JSeGrqYPstvafF3+Fa30BoDbXRvsJ2uoOGfwd4Z9IX0iwzKAaJXCbr/7mEhb2gcV
         C18dejcLFksRV4C8kesIWm8aUGca5xfhgwS0Ng8hQqgdDK58VZSWa9kqWpyjoKmCDplG
         IANYmTWwyAytuuPuZp/YLDAnZaOU9a7rcX6FC4zu3sU4TKGrws3H/k11B+ASYHLbU970
         CWx43Owa7awuFEZYArLY94cJ4vIBaFN7c5luExbpYLS8iEiwoV3MBTLKZtZQ1bC+D09/
         wZoZSTmv1uxD+YfyRi8/O688gjCeQcy0a1NtG/34iTrNO27a4tMWAowMuyVz6hAmvrP0
         R97A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678947958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6uZ4jN92GiZ4W0MGudnlAhsr4/aq12M9FC/ERUX3tKY=;
        b=xz2DckZYobONVnq4ucjPb+mYKrCHSX9rWcTUlJFsZWEVDyHcHkYHAoojDwiEgFcZR6
         pcAmZhoRxo46jSAFJVU0Jg/M+J/flp1etw7qDZ+HbtDzHxuInMr6fyb0yGSuoZK0tF2U
         KIBAiIfAhItwV7O+eAe0lnZ8e7SavvVz8JoONMf5Vz6oM25mlU99ra7dBJcS7AQVm56L
         tMTN2F7yxq+/ZcDXygBVbcl7CbjhKaXQH3urxO6Rn0Cr5duWxqg+0Ju88Drg+uBHcOom
         /lzD1+tL5HVkEGEkewlh37Uwm41awOf4U4mFdGz9vPxY3dWNJ17I9yRDYjpCNlA6p+Fb
         Uc2Q==
X-Gm-Message-State: AO0yUKWosQoUs4IDxpxeueeOqiD/BJqSlezqObh+3WZrTUg7xPz5dwTK
        Wwv/D8Y5BppnT3+/qEybywdYRc60KT2xn+CASVA=
X-Google-Smtp-Source: AK7set8UnRz6OAnYSjZpykIzZSrQeCCNq55Zjv7Ei91DkblwdmeQqQBYTYSJF8vk4HTxbUhlXKoIxTr+uKZOoZY8aNg=
X-Received: by 2002:a50:d08e:0:b0:4fe:9251:d4fc with SMTP id
 v14-20020a50d08e000000b004fe9251d4fcmr2858219edd.4.1678947957946; Wed, 15 Mar
 2023 23:25:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230315160228.2362-1-cnsztl@gmail.com> <20230315160228.2362-6-cnsztl@gmail.com>
 <CA+E=qVcL1PNMcJ5M1zHQhZNpajxLJWWGQoXYeLER+OmV5Qz33A@mail.gmail.com>
In-Reply-To: <CA+E=qVcL1PNMcJ5M1zHQhZNpajxLJWWGQoXYeLER+OmV5Qz33A@mail.gmail.com>
From:   Tianling Shen <cnsztl@gmail.com>
Date:   Thu, 16 Mar 2023 14:25:45 +0800
Message-ID: <CAOP2_Tjg=Y4XRTT-WyHfTP_YgBx3PvXEHEbrMRgSHgY96C+_xA@mail.gmail.com>
Subject: Re: [PATCH 5/5] arm64: dts: rockchip: enable rk809 audio codec on the
 NanoPi R5 series
To:     Vasily Khoruzhick <anarsoul@gmail.com>
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

Hi,

On Thu, Mar 16, 2023 at 7:54=E2=80=AFAM Vasily Khoruzhick <anarsoul@gmail.c=
om> wrote:
>
> On Wed, Mar 15, 2023 at 9:03=E2=80=AFAM Tianling Shen <cnsztl@gmail.com> =
wrote:
>
> Hi Tianling,
>
> > +       rk809-sound {
>
> There is no audio jack on my R5S, see [1] and I don't see it on R5C
> either, see [2]. I don't see audio output on the pin header either.
> How is it supposed to work?

I was confused by the vendor dts. I found them enabled rk809 audio
codec [1],but also disabled
the I2S1 TDM audio controller. I'm not sure what they want to do.

But from my side I agree this should not be added. And the i2s1_8ch
node in current dts
should be removed as well.

Thanks,
Tianling.

1. https://github.com/friendlyarm/kernel-rockchip/blob/2b22fccccb0c6ff18a6c=
952fe81e13ba4c9ba6a1/arch/arm64/boot/dts/rockchip/rk3568-nanopi5-common.dts=
i#L125-L138
2. https://github.com/friendlyarm/kernel-rockchip/blob/2b22fccccb0c6ff18a6c=
952fe81e13ba4c9ba6a1/arch/arm64/boot/dts/rockchip/rk3568-nanopi5-common.dts=
i#L592-L600

>
> > +               compatible =3D "simple-audio-card";
> > +               simple-audio-card,format =3D "i2s";
> > +               simple-audio-card,name =3D "Analog RK809";
> > +               simple-audio-card,mclk-fs =3D <256>;
> > +
> > +               simple-audio-card,cpu {
> > +                       sound-dai =3D <&i2s1_8ch>;
> > +               };
> > +
> > +               simple-audio-card,codec {
> > +                       sound-dai =3D <&rk809>;
>
> It looks like rk809 doesn't have #sound-dai-cells property and it
> results in a warning:
>
> arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dtsi:48.27-50.5:
> Warning (sound_dai_property): /rk809-sound/simple-audio-card,codec:
> Missing property '#sound-dai-cells' in node /i2c@fdd40000/pmic@20 or
> bad phandle (referred from sound-dai[0])

Yeah, I did miss some properties here. There are some minor differences bet=
ween
vendor bindings and upstream ones.

>
> Regards,
> Vasily
>
> [1] https://wiki.friendlyelec.com/wiki/index.php/NanoPi_R5S
> [2] https://wiki.friendlyelec.com/wiki/index.php/NanoPi_R5C
