Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB7D36A90DD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 07:22:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjCCGV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 01:21:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjCCGV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 01:21:57 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BAA113DC6;
        Thu,  2 Mar 2023 22:21:56 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id r40so1098292oiw.0;
        Thu, 02 Mar 2023 22:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677824515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7uu9usq4mOX/FOI6pJz5zLJ5pzNWKUs6IvxsWUK8a5c=;
        b=fTXyzaCdRaPj0J8hS+NqiNvQyp+yT3pjGkvVFYFKdtXQrqsLwtfmjgrJnX5eZRFHVz
         /4V0diy/bNPdxM3fArpgy8WEGKWfFDKRwKcCVwI1y6L0d0fTGNrfOz10icx1Ko6ZDT6s
         gQ1YsTwWU//GXRs/O1FvhSJEYVcXuB0MW1XHTbrV9C1EhYOYxRWfFS0fK4FfiSzKiljg
         ZM96f/zYX53MqjABYL4QjB4Yoeie3T8r0+V7XUpQT1qMdK+dfq9UVh95zGS0FhIjWtGl
         mqjk0lWsnq6OhEGtPEv0Mtlqnr0zG4deisg6k1svN+Wf6g0BldiUfTfmHBTjqL1FLTRM
         zKZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677824515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7uu9usq4mOX/FOI6pJz5zLJ5pzNWKUs6IvxsWUK8a5c=;
        b=CZc8+BP0qKpUwb2Eyv40l5zNAElJkJJ2EpbfW7h7TSr9u5a2kLj7kxL/+ALAsgDNns
         na7aa5scx7F2AdwBQFBOdGi3fa4fiEfGU8oOtnMWf7hFDVsKyyydHAoTa8RjwGHIkZNN
         AKQSk8CIj8AKqTnfKKSGif6aG8+ngiCeXo5U16HUpas7at9cKR2aGaqNStWAQY4j8zrd
         24J7EAIoXOh9iNvXIyWPObJDkg249C8TXnOkJZxU0TOg9ikI8uuPwhkApmz0Td0au/eZ
         TMh3f1fdCjlEks2hAh7DqGxfhT7zuiO38oFANISELOHTuOnyhLVXoOnhkz7q2ASJ5uIh
         Ezlg==
X-Gm-Message-State: AO0yUKWd9rGrFuV0T2LAulvr+8D8X/Ybs0EK7eI2dtzJkw9hVIOKxuSZ
        wpYjLgHsayXzGgGWkmifkuD8nWs1ltT94+u0ck4=
X-Google-Smtp-Source: AK7set+z64CcHHKhQaG66pxc/FizbSgSp6kitd5gdIWhn5D4zQQDUYQReQikK/llQrfMO6ymTKDyCLfdWAe8qczJ6AI=
X-Received: by 2002:a05:6808:b10:b0:384:c7b:5fa7 with SMTP id
 s16-20020a0568080b1000b003840c7b5fa7mr181580oij.2.1677824515356; Thu, 02 Mar
 2023 22:21:55 -0800 (PST)
MIME-Version: 1.0
References: <20230303002850.51858-1-arinc.unal@arinc9.com> <20230303002850.51858-21-arinc.unal@arinc9.com>
In-Reply-To: <20230303002850.51858-21-arinc.unal@arinc9.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Fri, 3 Mar 2023 07:21:43 +0100
Message-ID: <CAMhs-H-eLjKG=4gTFKQHm2zDsXOB2P7Pr=TgExKLkwY5frjbvw@mail.gmail.com>
Subject: Re: [PATCH 20/20] MAINTAINERS: move ralink pinctrl to mediatek mips pinctrl
To:     arinc9.unal@gmail.com
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        linux-mediatek@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        William Dean <williamsukatube@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Daniel Santos <daniel.santos@pobox.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>, erkin.bozoglu@xeront.com
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

On Fri, Mar 3, 2023 at 1:30 AM <arinc9.unal@gmail.com> wrote:
>
> From: Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc9.com>
>
> The Ralink pinctrl driver is now under the name of MediaTek MIPS pin
> controller. Move the maintainer information accordingly. Add dt-binding
> schema files. Add linux-mediatek@lists.infradead.org as an associated
> mailing list.
>
> Signed-off-by: Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc9.com>
> ---
>  MAINTAINERS | 29 ++++++++++++++++++++++-------
>  1 file changed, 22 insertions(+), 7 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8a851eb053ca..83fa1e9651ef 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16541,6 +16541,28 @@ F:     Documentation/devicetree/bindings/pinctrl=
/mediatek,mt7622-pinctrl.yaml
>  F:     Documentation/devicetree/bindings/pinctrl/mediatek,mt8183-pinctrl=
.yaml
>  F:     drivers/pinctrl/mediatek/
>
> +PIN CONTROLLER - MEDIATEK MIPS
> +M:     Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc9.com>
> +M:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
> +L:     linux-mediatek@lists.infradead.org (moderated for non-subscribers=
)
> +L:     linux-mips@vger.kernel.org
> +S:     Maintained
> +F:     Documentation/devicetree/bindings/pinctrl/mediatek,mt7620-pinctrl=
.yaml
> +F:     Documentation/devicetree/bindings/pinctrl/mediatek,mt7621-pinctrl=
.yaml
> +F:     Documentation/devicetree/bindings/pinctrl/mediatek,mt76x8-pinctrl=
.yaml
> +F:     Documentation/devicetree/bindings/pinctrl/ralink,rt2880-pinctrl.y=
aml
> +F:     Documentation/devicetree/bindings/pinctrl/ralink,rt305x-pinctrl.y=
aml
> +F:     Documentation/devicetree/bindings/pinctrl/ralink,rt3352-pinctrl.y=
aml
> +F:     Documentation/devicetree/bindings/pinctrl/ralink,rt3883-pinctrl.y=
aml
> +F:     Documentation/devicetree/bindings/pinctrl/ralink,rt5350-pinctrl.y=
aml
> +F:     drivers/pinctrl/mediatek/pinctrl-mt7620.c
> +F:     drivers/pinctrl/mediatek/pinctrl-mt7621.c
> +F:     drivers/pinctrl/mediatek/pinctrl-mt76x8.c
> +F:     drivers/pinctrl/mediatek/pinctrl-mtmips.*
> +F:     drivers/pinctrl/mediatek/pinctrl-rt2880.c
> +F:     drivers/pinctrl/mediatek/pinctrl-rt305x.c
> +F:     drivers/pinctrl/mediatek/pinctrl-rt3883.c
> +
>  PIN CONTROLLER - MICROCHIP AT91
>  M:     Ludovic Desroches <ludovic.desroches@microchip.com>
>  L:     linux-arm-kernel@lists.infradead.org (moderated for non-subscribe=
rs)
> @@ -17486,13 +17508,6 @@ L:     linux-mips@vger.kernel.org
>  S:     Maintained
>  F:     arch/mips/boot/dts/ralink/mt7621*
>
> -RALINK PINCTRL DRIVER
> -M:     Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc9.com>
> -M:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
> -L:     linux-mips@vger.kernel.org
> -S:     Maintained
> -F:     drivers/pinctrl/ralink/
> -
>  RALINK RT2X00 WIRELESS LAN DRIVER
>  M:     Stanislaw Gruszka <stf_xl@wp.pl>
>  M:     Helmut Schaa <helmut.schaa@googlemail.com>
> --
> 2.37.2
>

Acked-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

Thanks,
    Sergio Paracuellos
