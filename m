Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9472E685E82
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 05:32:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbjBAEcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 23:32:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjBAEc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 23:32:29 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF0811655;
        Tue, 31 Jan 2023 20:32:28 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id ml19so24258298ejb.0;
        Tue, 31 Jan 2023 20:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jmtcPyOipFfISUEaFPuxMyH7xC2EhWjx/P+P8SbqFbM=;
        b=WZQTUn5XvgZeK7p9Qnu83Tl3WQziy5tMUfiHiHs5fKagrJdf3+AtP5Bdi7tLr0IrNr
         Mk/8U1rZbJikBZEszwykadJP7ANZ7j/VTRZKUudizkH1v9eY5qTBIKJHqWbT+bH6X6pj
         /eyVgtxC+34i+osxQmfmbdINqRStepwgO6vbk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jmtcPyOipFfISUEaFPuxMyH7xC2EhWjx/P+P8SbqFbM=;
        b=RqxEzoD38tlfkOOwTZROopj6LJ6jwARl9LgKXlPp1W9JXgpTYwwhytY8Q/++Oy7nDt
         Y/P5OsGGWyRKRQegEod0kYfF9Vr2K4GP0fsiTD2kKHKeNYp9FfIy4b7iMndIWGtXeRDZ
         eNc4rYAWn7zBW4+kfSNWb1uF/6TflemL4M4o0DBiGNWI9M/eBMmzVGyQxmPgzzpC9NTT
         xIN+PDX4aOZdn5+w2Qt9DEh2kqrFjKkgEhYv/rBrz2RFBlTRdTPRn2iUTDk4qegwuB5s
         JG/rWQGYGJfJYAiCpkrbNTAQuCef98/W/xnedQ3GDK6bQgvHFaONgm1QAqQ+vPfX97JU
         Gesw==
X-Gm-Message-State: AO0yUKUZ2Ka7d52INhn2cs8SD4UvqpKE/IcyVc7DlsHZp3NOWDBNS74V
        D9/Rb6zANfKqlgmH7Gj3+HirLeA2S0Cki1wYpiQ=
X-Google-Smtp-Source: AK7set8zmWzH+90LbAm2nhhkY1es4i1QHBAYtoSehCXSZKNIv2muxYvow9oaturRjZgbH0YESbqDHSmzMgPxaVYD2f4=
X-Received: by 2002:a17:907:2391:b0:87f:5802:fd72 with SMTP id
 vf17-20020a170907239100b0087f5802fd72mr247263ejb.237.1675225946301; Tue, 31
 Jan 2023 20:32:26 -0800 (PST)
MIME-Version: 1.0
References: <20230129112611.1176517-1-j.neuschaefer@gmx.net>
In-Reply-To: <20230129112611.1176517-1-j.neuschaefer@gmx.net>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 1 Feb 2023 04:32:13 +0000
Message-ID: <CACPK8Xf2=uAo-03+q2A5ZOdYoHrdgs6viskxk6QncvXOgtxh_A@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: wpcm450: Add nuvoton,shm = <&shm> to FIU node
To:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     openbmc@lists.ozlabs.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Jan 2023 at 11:26, Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.n=
et> wrote:
>
> The Flash Interface Unit (FIU) should have a reference to the Shared
> Memory controller (SHM) so that flash access from the host (x86 computer
> managed by the WPCM450 BMC) can be blocked during flash access by the
> FIU driver.
>
> Fixes: 38abcb0d68767 ("ARM: dts: wpcm450: Add FIU SPI controller node")
> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>

Reviewed-by: Joel Stanley <joel@jms.id.au>

I'll send this to the soc maintainers.


> ---
>  arch/arm/boot/dts/nuvoton-wpcm450.dtsi | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/boot/dts/nuvoton-wpcm450.dtsi b/arch/arm/boot/dts/n=
uvoton-wpcm450.dtsi
> index 299fcbba3089b..fda2f13093f98 100644
> --- a/arch/arm/boot/dts/nuvoton-wpcm450.dtsi
> +++ b/arch/arm/boot/dts/nuvoton-wpcm450.dtsi
> @@ -478,6 +478,7 @@ fiu: spi-controller@c8000000 {
>                         reg =3D <0xc8000000 0x1000>, <0xc0000000 0x400000=
0>;
>                         reg-names =3D "control", "memory";
>                         clocks =3D <&clk WPCM450_CLK_FIU>;
> +                       nuvoton,shm =3D <&shm>;
>                         status =3D "disabled";
>                 };
>
> --
> 2.39.0
>
