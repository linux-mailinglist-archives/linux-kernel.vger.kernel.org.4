Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5484665B3D5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 16:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236105AbjABPHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 10:07:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236264AbjABPHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 10:07:23 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3DA65F8
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 07:07:23 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id k19so11116395pfg.11
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 07:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wEXS7nrJFORzyDPmh7+FGBbOMiQgOyBfpmUbiyI6pu4=;
        b=ksEFKm7Ezybsf9oLGYhGyyq9SUeqw7ldNnAXgJPWsgDlHveaQG2HQ0t8A+azOrymmz
         w6teBZkH4bQoTPToLP4aZAKnPKzAvVw7E5jIvrbL62W5AIInjy4PBUZ6NBTBGrPiuYiV
         RdIFYU66E5/o+VSA+WhPSoh9SkbhX4w7T7UNbaYeuEPVNWifUslWMXmI7oERQrKbcjMv
         PT6oxXLbE3yarjKVJqkY5J8FzFbcAHd8v9ycpR7cWIZ3A1XkBXIPMgT6D/0Vlrgynzjo
         QQMmosORKY+kTsHmdxEc+mGD9mUOw9zi0/cEcif0Zb9Z7vmO8Wfo3/GjL7TAZbmS+Kxe
         LlKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wEXS7nrJFORzyDPmh7+FGBbOMiQgOyBfpmUbiyI6pu4=;
        b=wdtX6Z6+WaSSCkI2daTTCLfyHwQemdlz4CsRxC4/KoGPHpDJaEz/hYmaAdYG0M6a9d
         iEEaqZVashAro1qab58omZPDLWh0y/Kn4SWV/gOKntEgwtETEwhys8TqzoqfsFmekfGi
         Cod+UPpmIJ4gc3j5+aFZj/UQdKnflxMuJ5XokA2cddGoTDTB4To7aVH9TNBvD9lis7x5
         oheZ5Oqk5FsMeB4KlAUXziCqXdvvoPSbBsZRwJ650so60L8E7px1vxgsO3tdNnzFw4sY
         T0IHpoa0eEfTot2ldECnk6vlZHx/B0O+JrSXkSBrkzyLDLAFGblLeCNC5Zm1eLmXdJAP
         7lJQ==
X-Gm-Message-State: AFqh2koJdwZeM9ODPN5WRH4GsxgjaN/5qGH1RiT/P01Z6Bl2WXsGEIFy
        H/uX9rOx6GNzrYW4FHZmcMIaD7rhyluMMvQu6ZDbEA==
X-Google-Smtp-Source: AMrXdXveB6w6ko5UpGztJDmBUhjBlHnkl7XTn0GFtvIltj3YGiKK2OxzvjEJPtgCrP69aZ6NJTh37oya64dSSpnFuxI=
X-Received: by 2002:a63:24c4:0:b0:499:c23c:d65b with SMTP id
 k187-20020a6324c4000000b00499c23cd65bmr1292737pgk.541.1672672042769; Mon, 02
 Jan 2023 07:07:22 -0800 (PST)
MIME-Version: 1.0
References: <20221223030347.17093-1-peng.fan@oss.nxp.com>
In-Reply-To: <20221223030347.17093-1-peng.fan@oss.nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 2 Jan 2023 16:06:46 +0100
Message-ID: <CAPDyKFq3f+_8SqupidTqzLmJtDwVaamb-6uWrUN3isivhHZ3PQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: fsl-imx-esdhc: update binding for
 i.MX50 and i.MX7D
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Dec 2022 at 04:02, Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> i.MX50 eSDHC is compatible with i.MX53. i.MX7D uSDHC is compatible with
> i.MX6SL. So update for them.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> index dc6256f04b42..546ebcecaf95 100644
> --- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> @@ -37,6 +37,12 @@ properties:
>            - fsl,imx8mm-usdhc
>            - fsl,imxrt1050-usdhc
>            - nxp,s32g2-usdhc
> +      - items:
> +          - const: fsl,imx50-esdhc
> +          - const: fsl,imx53-esdhc
> +      - items:
> +          - const: fsl,imx7d-usdhc
> +          - const: fsl,imx6sl-usdhc
>        - items:
>            - enum:
>                - fsl,imx8mq-usdhc
> --
> 2.37.1
>
