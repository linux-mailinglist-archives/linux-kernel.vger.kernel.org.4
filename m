Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADB5A6CC18A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 15:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232812AbjC1N5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 09:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232709AbjC1N5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 09:57:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE6447AA9;
        Tue, 28 Mar 2023 06:57:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 41617617E3;
        Tue, 28 Mar 2023 13:57:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A01BDC4339B;
        Tue, 28 Mar 2023 13:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680011869;
        bh=c4euR0Zd/JmQDuRN94iXNF8EoUEzpV1yUc9zAbWxy8o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HoC6h7QU4XWblNdAiVGhRKVv9EmdFymQkbE2FWmAu2SiD0CIjYkyGvvpOGMiA4Ccx
         RjRSwHjaNhaeDy3y08Hq7vOR2WxCx7o0QaPTg6uqD8bLrVXZVqCA/aWwbFkZPtNpd8
         hmMyAiMec4EsjjTqkRnut6UhjQ9vDfte3ZjjlJfDLPa74oxO7g4uW6ymYrlaFwYvZw
         mO9GcFUmi3nWIAMCTRzkvXc6W18kzgQWvMINkVemukvzff0Yc6+ZPq9/42Qo+sUghM
         CAjkUp1Q4BTITN/W2b1Vff7BitGUaYo6Mtydz6boxAk0bvyiUmbA+3udCC+YlRuG9h
         lgCGJjHOWVktw==
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-5419d4c340aso230970667b3.11;
        Tue, 28 Mar 2023 06:57:49 -0700 (PDT)
X-Gm-Message-State: AAQBX9ctDLKIDq7l0UyFEEP/cdw55LiP0YND1XG048eD2uiZ0lRBK10k
        pdhKvEtKDv4c8UZL4wcMBv5LENolX5zm9kapdA==
X-Google-Smtp-Source: AKy350bNpz7Bd9Ci5RKAGrw9sEV5urpvR4mBLxm8yWSi0X2LA+KdtSuZf7hKYv3CptV9NNhk2Tgm4cfMKtlSJaP0l5k=
X-Received: by 2002:a81:4410:0:b0:545:a7d8:f278 with SMTP id
 r16-20020a814410000000b00545a7d8f278mr6922784ywa.5.1680011868714; Tue, 28 Mar
 2023 06:57:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230328052912.1957000-1-peng.fan@oss.nxp.com>
In-Reply-To: <20230328052912.1957000-1-peng.fan@oss.nxp.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 28 Mar 2023 08:57:37 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJvOZvw7BKYZRTf3gQwyVOmhva8BFHYF8-rf5uyo_HMUA@mail.gmail.com>
Message-ID: <CAL_JsqJvOZvw7BKYZRTf3gQwyVOmhva8BFHYF8-rf5uyo_HMUA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: gpio: fsl-imx-gpio: update gpio-ranges
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, stefan@agner.ch, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 12:24=E2=80=AFAM Peng Fan (OSS) <peng.fan@oss.nxp.c=
om> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> one is not enough for i.MX8, so enlarge it.

But it wasn't 1, it was unbounded. As dtbs_check shows, the new bounds
aren't right either.

>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  Documentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml b/D=
ocumentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml
> index be56c3faec0f..e303455eadce 100644
> --- a/Documentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml
> +++ b/Documentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml
> @@ -66,7 +66,10 @@ properties:
>
>    gpio-controller: true
>    gpio-line-names: true
> -  gpio-ranges: true
> +
> +  gpio-ranges:
> +    minItems: 1
> +    maxItems: 16
>
>    power-domains:
>      maxItems: 1
> --
> 2.37.1
>
