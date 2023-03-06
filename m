Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC3C36AC086
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 14:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbjCFNPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 08:15:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbjCFNO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 08:14:58 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B272E0D5
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 05:14:15 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id x12so8003468ybt.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 05:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678108455;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sjrCU8dfwt2r52mtNocw9w9eS+r3p5I80G2XWIYONwo=;
        b=imkXfalDXcbd10QyjB+ndurA7z/hros2mKvpPj+lajBxpK6l2mtOWPDMjulcfDSG89
         crCR8HVY6dBSwt7NVI3bOt+C2Sieo7BRVTCr4+H3hKkjNf3S6ln9WStozd7Kuv1oNJhe
         N+THPGLK9MWrG9CeSWXXIJxfW2pwgeJNBDIopflzJJJlj6OoubbnBHQ8nEba/EeI76dZ
         V2eaEoPOTKjg5UFYk2KFzJPDnpdauXGNAeJsSXeW5i045uPT+5Mix3RIqc1v55+LDY7H
         86RIM/qNIfL1v92hDWXybUJlTfaI17VDaUTlz0ODnx/fc8sIbJdsULEqZM0cuR994xc+
         wUDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678108455;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sjrCU8dfwt2r52mtNocw9w9eS+r3p5I80G2XWIYONwo=;
        b=uo9WqogwXRWcmKp6cLjTkdz3t6jl3N+5qHPg44QF7iQzlRH5KCHfb1oLoRLycya8li
         8811t3kZYdWwlE8OqqoqTeSxegMDQnxOZfhIk9pmxFDkyszEDqdqTNhIa6nL6RDZKdO6
         1B5+V3G1MNDqQd/aiYMA+pSaLeTACkGasehKDYhOjPs6pJUaFjmgB1Bv/j17pcvNYssL
         3KVm8uyiO245w6Hwcz/KeraZP6QunLLNZ9lqDuuW+P2nFS2ezL0MGcyuDWY/boIHTpPt
         NL9vk69D6DuXNoCWe3qqOiQBUfehRm0b+MQaYS4p6cLrG+x4hd3cNQ1M0LC4Dsi9b5nB
         SElQ==
X-Gm-Message-State: AO0yUKXJSMHnTUpGMjD7yFdGtDmqbImMcAsudVqCg4yr4DS/MSwtHPCY
        GPIKZzWoq9SDwJcvX3fF+MwhmKT/izhUHmH2KGkFFQ==
X-Google-Smtp-Source: AK7set/9eXofjnPoXZfw7UlW58CMp0dIpumH5qKagGWd2A1jVBQssoZ5W4hJK0gzmJ5RZgIOkmp/e1aK3WLMpy2vXoE=
X-Received: by 2002:a5b:b84:0:b0:ab8:1ed9:cfd2 with SMTP id
 l4-20020a5b0b84000000b00ab81ed9cfd2mr6441002ybq.5.1678108455003; Mon, 06 Mar
 2023 05:14:15 -0800 (PST)
MIME-Version: 1.0
References: <3eeaa940-9d40-5e33-bc36-c9b0449ded9f@gmail.com> <774d712d-bcdf-677a-2d9c-a49ed829e965@gmail.com>
In-Reply-To: <774d712d-bcdf-677a-2d9c-a49ed829e965@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 6 Mar 2023 14:14:03 +0100
Message-ID: <CACRpkdbkKgPnkop5V0Diw5goZ9Km4mHXD7=7sb_Nj8k1UtMTvA@mail.gmail.com>
Subject: Re: [PATCH v4 2/7] dt-bindings: gpio: rockchip,gpio-bank: add unique
 hardware GPIO ID
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
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

On Thu, Feb 23, 2023 at 8:46 PM Johan Jonker <jbx6244@gmail.com> wrote:

> Add a unique hardware GPIO ID to the Rockchip GPIO nodes with
> the "rockchip,gpio-controller" property to be independent from aliases
> and probe order. "gpio-ranges" can't be used for that, because there is
> no semantic restrictions on how they are set up.
>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>
> See discussion:
> https://lore.kernel.org/u-boot/CACRpkdZx8EaSFLeh4vruRsdC+Sx_ieBiKmuE7t37zhiYqtS3WQ@mail.gmail.com/
> ---
>  .../devicetree/bindings/gpio/rockchip,gpio-bank.yaml        | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/gpio/rockchip,gpio-bank.yaml b/Documentation/devicetree/bindings/gpio/rockchip,gpio-bank.yaml
> index 2e9a5179c..39ac41e9d 100644
> --- a/Documentation/devicetree/bindings/gpio/rockchip,gpio-bank.yaml
> +++ b/Documentation/devicetree/bindings/gpio/rockchip,gpio-bank.yaml
> @@ -52,6 +52,12 @@ properties:
>
>    gpio-line-names: true
>
> +  rockchip,gpio-controller:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    maximum: 8
> +    description:
> +      Unique hardware GPIO ID.

So we need to discuss this with the Device Tree people because if this is needed
it need to be motivated in terms of "any operating system needs this".

Very similar precedents exist:

pinctrl/renesas,rzg2l-poeg.yaml

  renesas,poeg-id:
    $ref: /schemas/types.yaml#/definitions/uint32
    enum: [ 0, 1, 2, 3 ]
    description: |
      POEG group index. Valid values are:
        <0> : POEG group A
        <1> : POEG group B
        <2> : POEG group C
        <3> : POEG group D

pinctrl/st,stm32-pinctrl.yaml

      st,bank-name:
        description:
          Should be a name string for this bank as specified in the datasheet.
        $ref: "/schemas/types.yaml#/definitions/string"
        enum:
          - GPIOA
          - GPIOB
          - GPIOC
          - GPIOD
          - GPIOE
          - GPIOF
          - GPIOG
          - GPIOH
          - GPIOI
          - GPIOJ
          - GPIOK
          - GPIOZ

I don't know how the above properties are used in practice, but any creative
driver writer can use them exactly as you intend to do with this, so we need to
figure out if this is something all operating systems actually need or
whether we
should let driver authors just keep smuggling it in under the radar as
is already
happening.

Yours,
Linus Walleij
