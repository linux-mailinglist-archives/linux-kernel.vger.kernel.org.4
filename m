Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B397F73D451
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 23:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjFYVIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 17:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjFYVIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 17:08:05 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1301110A;
        Sun, 25 Jun 2023 14:08:04 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-51d93425853so1095366a12.1;
        Sun, 25 Jun 2023 14:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1687727282; x=1690319282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eXLV4vlHgRblurGbsUNfZOWxcEKocikl7BI0LorFN2o=;
        b=C8SC2P9rHj755edoOtxc5j8w+LrILXSDmfvyygE2DPkqJuul2pP+IygQxoj+bvueOM
         +3vzJX074rgvz9lVM9ELJeAZ6Y9W+sNyQ92RLROKLG2JCXbVTtECrfdLMJyQwKitLzRb
         TUtABquz5c93Ofk1shnxd6Qwhy7ngTfpNgtQ/vEaKWM13gVCciui+UOHXekpaLp1m5NU
         p2RDitu/9ST1A+zV966fPPDfjeBqH+yMV/nCI3PQTkuvR1zF/ktyLTmStiJaFsaVLIoy
         VeF+QEMLkhY1YZF5ILar3vk+hgHpe4nAJVIVKzoEU+q4EbTdX0NnwODMh8BLA95w97sf
         EjhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687727282; x=1690319282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eXLV4vlHgRblurGbsUNfZOWxcEKocikl7BI0LorFN2o=;
        b=LTVj1MIE/hR7LE75A0BcjViRjqZ82p/I7Qke+bnAiGxgJzT+bB6Awo4E9YDituuVkd
         qsZfdgdpMTEottlmHS70sp39KuN8IhkTW49z6eb1+akDQxR+bMJha3Wofb/lneloc+Ai
         j48iJhq4d18KFMs11Rh71zwUemPn8eiJyF3jhIZsSdzEqUz7B5lsHrDzfeWh/hDDo27e
         2TPcpQaHtfg1SHOPANkuJOQRnaJZAQ2bjwmpOYBG/W5ijziC+rgv+2J0YemQsxvPJ+PW
         zB/iCMTm7SIO70NhosXT9wybee0yrTJyWcqTFV+sNTMHYxm9SyHrwBnoR+hPowweEfPq
         GAIA==
X-Gm-Message-State: AC+VfDwz7ifNffQIO8FBDJBWGHGAmPfwfZ4SFCnrHZm/kcOaCUy7jUAZ
        yEZkm3pGf8jlIVjfqk0eGL3kDIp1oeE515nzIow=
X-Google-Smtp-Source: ACHHUZ66yMbvwXQLq2TOx+PDvqUL8KVT85zj9wD4oVpTV44CE9hREhfhvnG3dbD1Lti1brA8yVk9QqOQlZiEYKgsnEs=
X-Received: by 2002:a05:6402:12c6:b0:51d:8ab1:5df4 with SMTP id
 k6-20020a05640212c600b0051d8ab15df4mr2105710edx.21.1687727282228; Sun, 25 Jun
 2023 14:08:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230607201641.20982-1-ddrokosov@sberdevices.ru> <20230607201641.20982-6-ddrokosov@sberdevices.ru>
In-Reply-To: <20230607201641.20982-6-ddrokosov@sberdevices.ru>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 25 Jun 2023 23:07:51 +0200
Message-ID: <CAFBinCD-5RD_iszZZRg58XqTHDEHnipJkf2aAex8MdUyh=bVCw@mail.gmail.com>
Subject: Re: [PATCH v1 5/6] arm64: dts: meson: a1: introduce UART_AO mux definitions
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>
Cc:     neil.armstrong@linaro.org, jbrunet@baylibre.com,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, khilman@baylibre.com,
        conor+dt@kernel.org, kernel@sberdevices.ru,
        sdfw_system_team@sberdevices.ru, rockosov@gmail.com,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Oleg Lyovin <ovlevin@sberdevices.ru>
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
> From: Oleg Lyovin <ovlevin@sberdevices.ru>
>
> The Amlogic A1 has a UART_AO port, which can be used, for example, for
> BT HCI H4 connection.
>
> This patch adds mux definitions for it.
In the past we've only taken the pinctrl definitions if we have a
board that uses them.
Neil, do we still have the same policy in place? If so this patch
should be sent with the series that adds support for your A1 board.

> Signed-off-by: Oleg Lyovin <ovlevin@sberdevices.ru>
> Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> ---
>  arch/arm64/boot/dts/amlogic/meson-a1.dtsi | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi b/arch/arm64/boot/=
dts/amlogic/meson-a1.dtsi
> index 0efd922ca7e1..3eb6aa9c00e0 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
> @@ -118,6 +118,22 @@ gpio: bank@400 {
>                                         gpio-ranges =3D <&periphs_pinctrl=
 0 0 62>;
>                                 };
>
> +                               uart_a_pins: uart_a {
Only our newer .dtsi (e.g. meson-g12-common.dtsi) are following the
pattern where node names should use dashes instead of underscores.
So please use: uart_a_pins: uart-a { ...

[...]
> +                               uart_a_cts_rts_pins: uart_a_cts_rts {
similar to the comment from above:
uart_a_cts_rts_pins: uart-a-cts-rts { ...

> +                                       mux {
> +                                               groups =3D "uart_a_cts",
> +                                                        "uart_a_rts";
> +                                               function =3D "uart_a";
> +                                               bias-pull-down;
Out of curiosity: is this pull down needed on all boards or just specific o=
nes?
It seems like all other SoCs use bias-disable for the RTS/CTS pins.


Best regards,
Martin
