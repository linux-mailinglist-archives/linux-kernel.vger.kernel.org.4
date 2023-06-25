Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3CC873D44A
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 23:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjFYVDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 17:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjFYVDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 17:03:35 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65600D1;
        Sun, 25 Jun 2023 14:03:34 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-98de21518fbso206202166b.0;
        Sun, 25 Jun 2023 14:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1687727013; x=1690319013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x1qUTVRqtuFOc3JgBHsj7jo773emKPd31TbXJig8SrE=;
        b=enNyxZrird41eKiFx69ef5eIqFRoukLWnR0269/bqLsyjnLcwGCwX8wy5cSdUpFoja
         ai9j5Keis1OLCIRhST1zZKzlHQuNR/cyQrFgPjdl6fKuwkNnW6/gxYBm1AvFovRI7FCS
         Tw2mrjI2hYZty6Uo2KVgZBAX0Xyt2jze+uvw92T/w6rZzro9m8i3OpPM0Fcfqgl+raYL
         xJ/SYJiK4XSmI/l5iOJjnHh1g8vPosyoyZty0tMYEvMeLo89oTyI8L8zFPiNUBF20G3+
         2nVvo0OwcjfRqRg1psQ9+jMST8WAWQGh4tTwINm/3DpwTublP68zgOPS4SslPwosWa6m
         Vbag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687727013; x=1690319013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x1qUTVRqtuFOc3JgBHsj7jo773emKPd31TbXJig8SrE=;
        b=lEKk2we526g5puBGRNAGCjva5qFlUG1ABi4SDPUB6SlZY3c87Ot6Xlq0CSB6UWZg9O
         lNjvyFCd928pRrcDk732rY3q4e8Rt/Tfe5xBm+5ehQ7nT4jVp1+r4nxbbbENSK/+gF14
         i/LiDLKrXbddsK7tzC6TLppHsLQLsQE/w5LFuz228NoCwnBQ8dd/Bu7P82jeTC7nk3kB
         Xgk5VMr9toj6wzhLVIEwxy4bBILChlE53x8R/+rzgOXGdidAx9WDXP5L9V9/CYWdF9eP
         CKLzNeDQpUV7usPegahl9xRMTgIAgPSqtfj1QS8/9U+GDlpZf0btLniK4nz96dHFTfE5
         qbiQ==
X-Gm-Message-State: AC+VfDy3aORhyzKdZhry9qXFvrpjK9qtRax7mC+QKi4LxjtY0W4uT85o
        ORcgpcNznL6ScSD3l1Vu82XQtQh6hBIts6QmB5I=
X-Google-Smtp-Source: ACHHUZ5alJ2fuFFkTHozOioXL0nwU19Y1j3nLviNjxIaxbzwKLlUz+UVYHCa9X08SsIVGK1SgSlwsJ1tVn0bCXuWrr8=
X-Received: by 2002:a17:907:9623:b0:988:6bd2:b0ab with SMTP id
 gb35-20020a170907962300b009886bd2b0abmr21427420ejc.6.1687727012508; Sun, 25
 Jun 2023 14:03:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230607201641.20982-1-ddrokosov@sberdevices.ru> <20230607201641.20982-5-ddrokosov@sberdevices.ru>
In-Reply-To: <20230607201641.20982-5-ddrokosov@sberdevices.ru>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 25 Jun 2023 23:03:21 +0200
Message-ID: <CAFBinCAGLerkDrz98WbpyVAV3jukkPXqDGSV0vOWY0jNiKaJvQ@mail.gmail.com>
Subject: Re: [PATCH v1 4/6] arm64: dts: meson: a1: introduce SPI Flash Controller
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>
Cc:     neil.armstrong@linaro.org, jbrunet@baylibre.com,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, khilman@baylibre.com,
        conor+dt@kernel.org, kernel@sberdevices.ru,
        sdfw_system_team@sberdevices.ru, rockosov@gmail.com,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Martin Kurbanov <mmkurbanov@sberdevices.ru>
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

On Wed, Jun 7, 2023 at 10:16=E2=80=AFPM Dmitry Rokosov <ddrokosov@sberdevic=
es.ru> wrote:
>
> From: Martin Kurbanov <mmkurbanov@sberdevices.ru>
>
> This controller can be used for spinand flash connection.
>
> Signed-off-by: Martin Kurbanov <mmkurbanov@sberdevices.ru>
> Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> ---
>  arch/arm64/boot/dts/amlogic/meson-a1.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi b/arch/arm64/boot/=
dts/amlogic/meson-a1.dtsi
> index 63faccfc1134..0efd922ca7e1 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
> @@ -199,6 +199,16 @@ gic: interrupt-controller@ff901000 {
>                         #address-cells =3D <0>;
>                 };
>
> +               spifc: spi@fd000400 {
please also sort this numerically, so it should appear before &apb
