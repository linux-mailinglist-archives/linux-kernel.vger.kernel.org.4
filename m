Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E644A60C20B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 05:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbiJYDF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 23:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbiJYDFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 23:05:53 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865B818E04;
        Mon, 24 Oct 2022 20:05:51 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id bs21so2894406wrb.4;
        Mon, 24 Oct 2022 20:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XHZj3l3++Ddr3AOE8EL7nYLAyx2hz56W7EAVPvSQms4=;
        b=NPSEdvmAHyQF7GYSkWJQEQkWJSJpiFYRTsRfpCyuezJNlbV6knOWbB6PP/Cuu1uQG4
         5CAung3kEF3WKB9l/h7Sw08bSjk0rgtCMdbMLtUIhzdvDSobxbRBd11J0amsDi+ttgeQ
         fKjjU2XHz6OmLtkwhMkPTveeI3pK7DGq22kro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XHZj3l3++Ddr3AOE8EL7nYLAyx2hz56W7EAVPvSQms4=;
        b=h8sv2Cr8AKMxfJ+C2ztbk0zoIdgiKy59Ky/SJbrtaFvlqe30omzBwwIQGbTyQBEpM0
         bACEMiB7mwL7YF7YrdC2x+9qV9EON9FVXxhMPqaEbJOQ5AyPagSX0LAF6yLIe3hK+qL5
         qYbMvfDCVPy214JadHoe9x8vCzn4bd9Tj5xroBBMaWkaQa39H1LgFlweexmP/2f0AUd7
         Hg/jByrmXMu+up2Jw9DasAqltRD4Pl4zijeLLypOLMjgtA5BzdRl8LlluBdaQFgqtn6P
         mI1+2zJz2R5C/9Eqid3S5FDuR+YXkP0s/KDR1h96mY6q9usvsK7IxOFms0TA9LMGsjKL
         /PwQ==
X-Gm-Message-State: ACrzQf1YnFq66z0vUDzowpJ6aSsP+hOFj05Nbo9C34tszDnjGwAvgPRr
        8WfwUHoY+BNXaej/L5yFb15ngt0BXDs5m8PuV08=
X-Google-Smtp-Source: AMsMyM4PUgPNLOA6UQuNP0O23XeSyalN1qOy6S5PHSg5rvuSZ55XK4sYYo6iVHQAylF9tZnjSQED/H3/2Wbjqbo6rZo=
X-Received: by 2002:adf:df83:0:b0:236:6d5d:ff8b with SMTP id
 z3-20020adfdf83000000b002366d5dff8bmr6843563wrl.315.1666667149764; Mon, 24
 Oct 2022 20:05:49 -0700 (PDT)
MIME-Version: 1.0
References: <20221025024145.1561047-1-potin.lai.pt@gmail.com>
In-Reply-To: <20221025024145.1561047-1-potin.lai.pt@gmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Tue, 25 Oct 2022 03:05:37 +0000
Message-ID: <CACPK8XdpeKVaxFki3GRyo30bWYNF6Q5wL706j5deaqi8P=ssdA@mail.gmail.com>
Subject: Re: [PATCH 1/1] ARM: dts: aspeed: bletchley: add aliases for mdio0
 and mdio3
To:     Potin Lai <potin.lai.pt@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Patrick Williams <patrick@stwcx.xyz>,
        Potin Lai <potin.lai@quantatw.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Oct 2022 at 02:43, Potin Lai <potin.lai.pt@gmail.com> wrote:
>
> Add aliases for mdio0 and mdio3 so that we can use name to lookup the
> address of Aspeed SOC.
>
> For example:
> root@bletchley:~# cat /sys/firmware/devicetree/base/aliases/mdio0
> /ahb/mdio@1e650000
> root@bletchley:~# cat /sys/firmware/devicetree/base/aliases/mdio3
> /ahb/mdio@1e650018
>
> Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
> ---
>  arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
> index c02c15f15465..2825d5f3f78b 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
> @@ -15,6 +15,8 @@ / {
>
>         aliases {
>                 serial4 = &uart5;
> +               mdio0 = &mdio0;
> +               mdio3 = &mdio3;

Should this go into the dtsi instead?

>         };
>
>         chosen {
> --
> 2.31.1
>
