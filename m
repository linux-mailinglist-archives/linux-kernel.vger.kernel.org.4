Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD5F071F2D1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 21:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232777AbjFATS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 15:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232681AbjFATS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 15:18:26 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6965213E;
        Thu,  1 Jun 2023 12:18:25 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6af7a84b2bdso1022564a34.2;
        Thu, 01 Jun 2023 12:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685647104; x=1688239104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2+8XSE+hTxJh0x+IXE7UwOHc7LEY5yIqcbqta7lvj5o=;
        b=cuq20YMDgyky2o0sbM3CFiMOfCKtBr9IpDBxO9x6kz6qOyWmCbsuTDsB/jxs4wm7z3
         VF7Y1aUpoEVFQQN83DUKjnjqnf2BQ4ArJtEIDE/8eyFrQRuLgpkedSyhJHudiOLjXlEU
         c8MKrKit/Hm2PGE71HpcDlXFcDvrr+erGZOlhDFsDGlYaQM4u/rMRXDQzf7Wa6r1f8S4
         kzwNf1P9e+8HxAIO0Q7bFpYi5BhBDlbpqK5kSBgMQr48Ryc4NIgY9GtYI2GL7Z722d4V
         8OqdxuNyqkpjcKgM1RHCaDfV4Ok6IuFhQM75GClbEkIRLB5Hrb3MnKlSceIZmoc60cKU
         CxPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685647104; x=1688239104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2+8XSE+hTxJh0x+IXE7UwOHc7LEY5yIqcbqta7lvj5o=;
        b=cihltkLwQeg9koqTfGjSVN/2i1F4PNLYHtd1gmXquKtIhLJBKnkM7ibmDAIq7QBLzq
         y8qJMV0RJgFJvFoAMbl7yAepll67PAsIvky1VmmsKlpF9FwP6KCNWjEItqEsxm1nOuGM
         /l1dfmPFPETGY1YgQw8Kf128zkGfx13m/cXmCy3LnG//qN387SazYSbYWMeBxspTzdPw
         EWM23rmwG2vxv/eJGzP0VuUfLW+hFtS8O0e1VX8YccAr+csvaEPwBAlW96kQa+iHcWYd
         Ltx51WKhffG15opg/lFpugHzjL2G7WUsEhbcaINor8orySvgNyJpL5BJ5RdjWpx7uEb1
         451w==
X-Gm-Message-State: AC+VfDxHXiJsDe7aPLpLyYFkJIczU5PM8L00ax+R1g0rG+dKMwP2kDsI
        uPJ8H8oJq38YWRsvS13H4D2IJNcOSe/7X1lNy0w=
X-Google-Smtp-Source: ACHHUZ7rG3SUNcRD+jPSFP3uOY/pmSqd1IagwYri/eGsMLMz/fVziDHA7e8OgoEb7jNn820VVlnCod+k8kiEblfvCEo=
X-Received: by 2002:a9d:7d0d:0:b0:6af:6de9:1c24 with SMTP id
 v13-20020a9d7d0d000000b006af6de91c24mr372684otn.18.1685647104647; Thu, 01 Jun
 2023 12:18:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230601184451.358272-1-afd@ti.com>
In-Reply-To: <20230601184451.358272-1-afd@ti.com>
From:   Robert Nelson <robertcnelson@gmail.com>
Date:   Thu, 1 Jun 2023 14:17:58 -0500
Message-ID: <CAOCHtYjDutbNDwQqzA9AruivCPtBeo5u4kYpnCzwZtjQdrcjhg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-am625-beagleplay: Use UART name in
 pinmux name
To:     Andrew Davis <afd@ti.com>, Tony Lindgren <tony@atomide.com>
Cc:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

Andew, since we are touching this section, do you want to match with
@Tony Lindgren rename changes here in omap...

https://www.spinics.net/lists/linux-omap/msg166406.html

Regards,

On Thu, Jun 1, 2023 at 1:56=E2=80=AFPM Andrew Davis <afd@ti.com> wrote:
>
> The main_uart0 may not always be the console, but it will always be
> the UART0 in MAIN domain. Name the pinmux node to match. This makes
> it consistent with all other TI SoC based boards.
>
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts b/arch/arm64/=
boot/dts/ti/k3-am625-beagleplay.dts
> index cb46c38ce2cc1..29c51705c2f17 100644
> --- a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
> @@ -397,7 +397,7 @@ AM62X_IOPAD(0x01a8, PIN_INPUT, 7) /* (D20) MCASP0_AFS=
X.GPIO1_12 */
>                 >;
>         };
>
> -       console_pins_default: console-pins-default {
> +       main_uart0_pins_default: main-uart0-pins-default {
>                 pinctrl-single,pins =3D <
>                         AM62X_IOPAD(0x01c8, PIN_INPUT, 0) /* (D14) UART0_=
RXD */
>                         AM62X_IOPAD(0x01cc, PIN_OUTPUT, 0) /* (E14) UART0=
_TXD */
> @@ -736,7 +736,7 @@ wlcore: wlcore@2 {
>
>  &main_uart0 {
>         pinctrl-names =3D "default";
> -       pinctrl-0 =3D <&console_pins_default>;
> +       pinctrl-0 =3D <&main_uart0_pins_default>;
>         status =3D "okay";
>  };
>
> --
> 2.39.2
>


--=20
Robert Nelson
https://rcn-ee.com/
