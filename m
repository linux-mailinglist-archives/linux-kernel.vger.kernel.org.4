Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1A86BBE78
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 22:05:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbjCOVE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 17:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231971AbjCOVE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 17:04:56 -0400
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9106E199E4;
        Wed, 15 Mar 2023 14:04:20 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-544787916d9so64859037b3.13;
        Wed, 15 Mar 2023 14:04:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678914196;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ebjbFrpz/+X5Ecv3vTakODOSpqaDbNAgDhn1xxmZU9U=;
        b=tttn2P0p+WyKEMVzQUJ6YjjobMsWOQNPJnwI83c4Jw8lyZaOnvcR8WCt9AqIfc9E2w
         GjrDpyyC98mHo+ZZarmdPgTiKfI/mtrQEBsyjq400j0W4f6EV1REW4GoGL6daEZ17i7b
         iSD625DW0QzrW4ffQvOMjA8Q6DBtt5n6R3TVZrMCWj1oWyODVCSH2h2Tze2CGjqU/HcJ
         bbdZiy9Dx6ga6yYbwIzf/i4QDTOsSIXL0ikGTPbOZh5n4Lvzuhtvp4BKIzflGHe1dMHZ
         BGgK5XAOYl+iAUrKUTOt5nJg9iL8+i7FAxcURkybzWQb9iKSRIgw5rOwX5ds/DrvLSks
         vrLQ==
X-Gm-Message-State: AO0yUKX2D8GQwH1W7OTcBGLlZ4oYIytUztbW3UH6zSFMErfdw9f9jMsO
        oLGaKtdkjel5cEcl6hmvcsuWOvJAxU3rPP3ppFk=
X-Google-Smtp-Source: AK7set8e62pYUbve18yCJPm1tnWapIagB1amLfxYzcrmp2PVa0ygDPClmkdqYSa+gmKrEF5fpCTg0Pmh3w2ZgUi4VaQ=
X-Received: by 2002:a81:aa0c:0:b0:530:b21f:d604 with SMTP id
 i12-20020a81aa0c000000b00530b21fd604mr751829ywh.9.1678914196433; Wed, 15 Mar
 2023 14:03:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230315055813.94740-1-william.qiu@starfivetech.com> <20230315055813.94740-3-william.qiu@starfivetech.com>
In-Reply-To: <20230315055813.94740-3-william.qiu@starfivetech.com>
From:   Emil Renner Berthing <kernel@esmil.dk>
Date:   Wed, 15 Mar 2023 22:03:05 +0100
Message-ID: <CANBLGcx1r0Uws5ob5iAwpVdBxvxt4-bHaNyLajxp4oMUoWHFEw@mail.gmail.com>
Subject: Re: [RESEND v6 2/2] riscv: dts: starfive: Add syscon node
To:     William Qiu <william.qiu@starfivetech.com>
Cc:     devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Mar 2023 at 06:58, William Qiu <william.qiu@starfivetech.com> wrote:
>
> Add stg_syscon/sys_syscon/aon_syscon node for JH7110 Soc.
>
> Signed-off-by: William Qiu <william.qiu@starfivetech.com>

Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

> ---
>  arch/riscv/boot/dts/starfive/jh7110.dtsi | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> index d484ecdf93f7..49dd62276b0d 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> @@ -362,6 +362,11 @@ i2c2: i2c@10050000 {
>                         status = "disabled";
>                 };
>
> +               stg_syscon: syscon@10240000 {
> +                       compatible = "starfive,jh7110-stg-syscon", "syscon";
> +                       reg = <0x0 0x10240000 0x0 0x1000>;
> +               };
> +
>                 uart3: serial@12000000 {
>                         compatible = "snps,dw-apb-uart";
>                         reg = <0x0 0x12000000 0x0 0x10000>;
> @@ -466,6 +471,11 @@ syscrg: clock-controller@13020000 {
>                         #reset-cells = <1>;
>                 };
>
> +               sys_syscon: syscon@13030000 {
> +                       compatible = "starfive,jh7110-sys-syscon", "syscon";
> +                       reg = <0x0 0x13030000 0x0 0x1000>;
> +               };
> +
>                 sysgpio: pinctrl@13040000 {
>                         compatible = "starfive,jh7110-sys-pinctrl";
>                         reg = <0x0 0x13040000 0x0 0x10000>;
> @@ -495,6 +505,11 @@ aoncrg: clock-controller@17000000 {
>                         #reset-cells = <1>;
>                 };
>
> +               aon_syscon: syscon@17010000 {
> +                       compatible = "starfive,jh7110-aon-syscon", "syscon";
> +                       reg = <0x0 0x17010000 0x0 0x1000>;
> +               };
> +
>                 aongpio: pinctrl@17020000 {
>                         compatible = "starfive,jh7110-aon-pinctrl";
>                         reg = <0x0 0x17020000 0x0 0x10000>;
> --
> 2.34.1
>
