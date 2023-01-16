Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9FEF66BDA1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 13:18:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbjAPMSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 07:18:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbjAPMRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 07:17:33 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA6C21F90E
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 04:17:23 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id x2-20020a17090a46c200b002295ca9855aso2788206pjg.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 04:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DPqO0oBcmgLKXeUWn1XrKDG5BAxYKOWw0dzZV7vwqgY=;
        b=RBemEAblyGxLU2fm+hF8zw3C54DMdenP3WBAbUkch/IgLgrsspgI0YHK0xnoM41K6c
         D6DLw3KbsYIr8wOBErprC+IDge8r0EZCkO4gYqUuuMJ71XI4SiRpl+6jYMh/ka+XnC3O
         qBM4uqF9B69lckXQpNFIc8rJs6GbxIdEywcyzAy66ly7cI2Pq2t9pRqB28mV//niLz+c
         vS1ZEY0tjlPlzKLDbAAlwUd77tSF6GpNoWJxRWlmSRUYkOSbhIPCHOKZTV7t2jN5BxkD
         288U3zbCm7TE50rGRtDtdoLZxtyivIU6QKp1o+mcPfuvt2bNSmElRv5Qm+jMylI7LA6q
         C8Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DPqO0oBcmgLKXeUWn1XrKDG5BAxYKOWw0dzZV7vwqgY=;
        b=oO0D8ZhUi6snMuHDfMkg0vpfQ/xHIFogUW++pS9nzlh4z094wbBYqDhYxCNESq+BHe
         jTdd9BAxGjFs8o4Fhv6mjv/UBZW6oL2cCS1c9tR/syn0n1c35KZGag8RhhXy/6KUtGX3
         uv9dFav1iDTRO9l0yTNpUvufr3eL2PaRYrBV8GrBzjkZhyfIDvwTGkcf0xIutbbjouv/
         xyE1E0hkAkUzNEmsEC5r0GFlpWEinq2STPd34UAH0c7ltIsJQeZD3mnd+V3Rdu7JdaU0
         oEeUNsBD+l/xYGJ38jDT6E4c8qILI3uVgv0qwK1ojNHVIrnAD8vSwhjgxkkDwspHUplT
         bBNg==
X-Gm-Message-State: AFqh2kpGeSN7OJbvISb0Y2EYKdMN6JySk3xhEKUyjZJ44493+daM5fjT
        p0lygwjxnbXXSsRz10o3ktLr0cAnbRc0TfCroCvOcQ==
X-Google-Smtp-Source: AMrXdXtjP8Sa+jjQ/yKSmwOET06UAgBRMczv2XdwvgBPcFbZjhPB2Nmss/cYPNG3ijFP/Uj+v3ozjZeYtP9vh3SqL4A=
X-Received: by 2002:a17:902:9692:b0:186:a98c:4ab8 with SMTP id
 n18-20020a170902969200b00186a98c4ab8mr644271plp.118.1673871443175; Mon, 16
 Jan 2023 04:17:23 -0800 (PST)
MIME-Version: 1.0
References: <20230115195212.2530087-1-andreas@kemnade.info>
In-Reply-To: <20230115195212.2530087-1-andreas@kemnade.info>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 16 Jan 2023 13:16:47 +0100
Message-ID: <CAPDyKFoTAiBFPu5cjLzX+VhWfRU3LMp+pLqGJthqqCwo3=KC_w@mail.gmail.com>
Subject: Re: [PATCH v3] dt-bindings: mmc: fsl-imx-esdhc: Add some compatible fallbacks
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Jan 2023 at 20:52, Andreas Kemnade <andreas@kemnade.info> wrote:
>
> Currently make dtbs_check shows lots of errors because imx*.dtsi does
> not use single compatibles but combinations of them.
>
> Add fallbacks for imx6sll/ull which are useful for U-Boot.
>
> This will significantly reduce noise on make dtbs_check.
>
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>

Applied for next, thanks!

Kind regards
Uffe


> ---
> Changes in v3:
> - simplify things by using enums
>
> Changes in v2:
> - allow only combinations with fallback compatible
> - reduce them to the cases where they are actually useful
>
>  Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> index dc6256f04b42..3423e1cd8b5d 100644
> --- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> @@ -29,14 +29,17 @@ properties:
>            - fsl,imx53-esdhc
>            - fsl,imx6q-usdhc
>            - fsl,imx6sl-usdhc
> -          - fsl,imx6sll-usdhc
>            - fsl,imx6sx-usdhc
> -          - fsl,imx6ull-usdhc
>            - fsl,imx7d-usdhc
>            - fsl,imx7ulp-usdhc
>            - fsl,imx8mm-usdhc
>            - fsl,imxrt1050-usdhc
>            - nxp,s32g2-usdhc
> +      - items:
> +          - enum:
> +              - fsl,imx6sll-usdhc
> +              - fsl,imx6ull-usdhc
> +          - const: fsl,imx6sx-usdhc
>        - items:
>            - enum:
>                - fsl,imx8mq-usdhc
> --
> 2.30.2
>
