Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0D91639284
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 01:13:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbiKZAM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 19:12:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiKZAM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 19:12:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D54233B4;
        Fri, 25 Nov 2022 16:12:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DE04FB82AFF;
        Sat, 26 Nov 2022 00:12:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C947C433D6;
        Sat, 26 Nov 2022 00:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669421572;
        bh=NX59x0btHEExShFPzdq1i8eWPgH9Un3tDf6A+TNeddY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JdJ4JFwtw18V1l3Vb4h9RfzMQJEXRUkuMjq9uHDYAnD8AnAi8eWQYW9XahnrTyzLr
         toCX4Y+LryDqiPKxdHKbRay1eg4SNVfy3pZClV/PpTjckkPgZl27M1XHeNjaFphgYn
         V9V532LftfgaAZio/SL4RGMPVt1MI602g7yV/jbIB3KUSCn/aWxkUtZrzFAE5tZ7Hq
         10g3w1lDa8CiorrStWSip/P4mPhAQ39BQ1zaqMx5ktYKDE/yxEzQv92T/qjzMyUGrU
         00bdWfOkajK8RMj2xvIsXfYszZQ+xFTvBCYBBI2T+xaC4RYxjPw2eO8UTb0CIP5ZQW
         oY/0PRYPwN3Xg==
Received: by mail-ej1-f50.google.com with SMTP id n20so13501146ejh.0;
        Fri, 25 Nov 2022 16:12:52 -0800 (PST)
X-Gm-Message-State: ANoB5pkU/JEvR292PNOtfFWjBCG6HSQnW2KV5kTrUs71DLL9IgdjU4cp
        y0Kl0fkDNKlO7F+v5WeeDIpOSKv7HPkJ/AnZ2Wo=
X-Google-Smtp-Source: AA0mqf6y+AsjP1DN+grrm7BVX4iyUMma6U7nH1KxSUQlTyP3Wy9fs9Wn9OeTwkAUAjFcpm5B6srXAl5cvlbkFB7x8hM=
X-Received: by 2002:a17:906:4e8c:b0:7ba:9c18:1204 with SMTP id
 v12-20020a1709064e8c00b007ba9c181204mr11627014eju.262.1669421570883; Fri, 25
 Nov 2022 16:12:50 -0800 (PST)
MIME-Version: 1.0
References: <20221125234656.47306-1-samuel@sholland.org> <20221125234656.47306-2-samuel@sholland.org>
In-Reply-To: <20221125234656.47306-2-samuel@sholland.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Sat, 26 Nov 2022 08:12:39 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQp54e9toE6aU3zNzmXf2gZwhcx+1A_HLR2ZSKDhnGO9w@mail.gmail.com>
Message-ID: <CAJF2gTQp54e9toE6aU3zNzmXf2gZwhcx+1A_HLR2ZSKDhnGO9w@mail.gmail.com>
Subject: Re: [PATCH v2 01/12] MAINTAINERS: Match the sun20i family of
 Allwinner SoCs
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
        Stanislav Jakubek <stano.jakubek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 26, 2022 at 7:47 AM Samuel Holland <samuel@sholland.org> wrote:
>
> Allwinner sunxi SoCs with a RISC-V CPU use the sun20i designator. Match
> that pattern in addition to the designators for 32 and 64-bit ARM SoCs.
Reviewed-by: Guo Ren <guoren@kernel.org>

>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>
> (no changes since v1)
>
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cd2cbb940f11..6a79f736fe35 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1828,7 +1828,7 @@ F:        drivers/pinctrl/sunxi/
>  F:     drivers/soc/sunxi/
>  N:     allwinner
>  N:     sun[x456789]i
> -N:     sun50i
> +N:     sun[25]0i
>
>  ARM/Amlogic Meson SoC CLOCK FRAMEWORK
>  M:     Neil Armstrong <neil.armstrong@linaro.org>
> --
> 2.37.4
>


-- 
Best Regards
 Guo Ren
