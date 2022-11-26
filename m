Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7ECA63928D
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 01:14:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbiKZAOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 19:14:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbiKZAOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 19:14:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B321D4E439;
        Fri, 25 Nov 2022 16:14:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5033561157;
        Sat, 26 Nov 2022 00:14:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9065C43141;
        Sat, 26 Nov 2022 00:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669421653;
        bh=N74f9IDDlvZlnyuOCje55je2uSM3m6cjmtYX6V2hg/g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=W0RxMFzvqCZxFGdKxkTd+/hYOd16SuE+JNOHjr6P774AS/1/L+8yul74UVZ5xKYb7
         CE4CoYfV1c3wsD67NrS6SZNyYC2UQ60cIcFWMwbn7E/TivY6/lpegphSywkbAB0pIP
         HMXSDY6WdLRKP3uO/wxxqba62Qg11gjrHIU2qHQPf8RnaknmP6VhGuRi5srTF68PgM
         6hU7Pi8+uyBaMfx+15ZsKQFzgt7rGGJ1ThL6Rrh5WsqclFxuBEAVQOc5tcv5deyf43
         cmRLIlcFgf/VjO3i8fxxh4V474LMmBSinvkaXczxi7eFhjXuOQLzjlimqrgXPFfqBC
         zOniNf8ukrevA==
Received: by mail-ej1-f44.google.com with SMTP id n21so13376744ejb.9;
        Fri, 25 Nov 2022 16:14:13 -0800 (PST)
X-Gm-Message-State: ANoB5pksXIsj26+v2iY9TEKzouYomWZkA+DKohUIl2DUlxANCJ5BxeDb
        h/QNlw0RxgIynGV9md0KAo+TdZW76BAxzl7XVcw=
X-Google-Smtp-Source: AA0mqf6HG42rf/HfnEimx0EAtLwPqQGcB27y2FKCmyx3exOnkFF5dvFVMCfC53gZ0ELIJ3NNCB1u7iZj2WTecYK5skE=
X-Received: by 2002:a17:906:6a8e:b0:78d:a136:7332 with SMTP id
 p14-20020a1709066a8e00b0078da1367332mr34001772ejr.355.1669421651963; Fri, 25
 Nov 2022 16:14:11 -0800 (PST)
MIME-Version: 1.0
References: <20221125234656.47306-1-samuel@sholland.org> <20221125234656.47306-3-samuel@sholland.org>
In-Reply-To: <20221125234656.47306-3-samuel@sholland.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Sat, 26 Nov 2022 08:14:00 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRmHWQ5K=_jKDvum6hxmL_B_0KksPYkofOLutFk3VJ75g@mail.gmail.com>
Message-ID: <CAJF2gTRmHWQ5K=_jKDvum6hxmL_B_0KksPYkofOLutFk3VJ75g@mail.gmail.com>
Subject: Re: [PATCH v2 02/12] dt-bindings: vendor-prefixes: Add Allwinner
 D1/D1s board vendors
To:     Samuel Holland <samuel@sholland.org>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor@kernel.org>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andre Przywara <andre.przywara@arm.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        Christian Hewitt <christianshewitt@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Stanislav Jakubek <stano.jakubek@gmail.com>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Guo Ren <guoren@kerenl.org>

On Sat, Nov 26, 2022 at 7:47 AM Samuel Holland <samuel@sholland.org> wrote:
>
> Some boards using the Allwinner D1 or D1s SoC are made by vendors not
> previously documented.
>
> Clockwork Tech LLC (https://www.clockworkpi.com/) manufactures the
> ClockworkPi and DevTerm boards.
>
> Beijing Widora Technology Co., Ltd. (https://mangopi.cc/) manufactures
> the MangoPi family of boards.
>
> Acked-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>
> (no changes since v1)
>
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index 592e43911a07..f2c67b7418e4 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -262,6 +262,8 @@ patternProperties:
>      description: Cirrus Logic, Inc.
>    "^cisco,.*":
>      description: Cisco Systems, Inc.
> +  "^clockwork,.*":
> +    description: Clockwork Tech LLC
>    "^cloudengines,.*":
>      description: Cloud Engines, Inc.
>    "^cnm,.*":
> @@ -1430,6 +1432,8 @@ patternProperties:
>      description: Shenzhen whwave Electronics, Inc.
>    "^wi2wi,.*":
>      description: Wi2Wi, Inc.
> +  "^widora,.*":
> +    description: Beijing Widora Technology Co., Ltd.
>    "^wiligear,.*":
>      description: Wiligear, Ltd.
>    "^willsemi,.*":
> --
> 2.37.4
>


-- 
Best Regards
 Guo Ren
