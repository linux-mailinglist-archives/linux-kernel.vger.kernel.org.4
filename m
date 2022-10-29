Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D38A3612000
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 06:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbiJ2EVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 00:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiJ2EVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 00:21:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3F76EF0F;
        Fri, 28 Oct 2022 21:21:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C47A9B82CDB;
        Sat, 29 Oct 2022 04:21:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 758FDC43470;
        Sat, 29 Oct 2022 04:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667017270;
        bh=DAQCxbXwMfg1p4G23fMdN/nNri7kMOq1RxK2JbdA5iw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lAA8fUmpWpwGK7nAiRCN7c8bxUf7G4fwR2nsld0ekFqYZbosaGz9g5YfoXcoHGHRr
         OWjtN83FaI0nFw/8R9A4h3cK4RXpFYc8cLp2lHupVpjUaU6CbjHm8NZlmig8AZ1riM
         dgYHChefDc4EPHt2aQ/IXM4jjjsPkbnKPimWRRnORu4V/9rSgrbWH78JpycB8wODfa
         nCcg912jYtrOEOhNUmnhJlP2xpUTuOC9a5sQGguXZ6rY7C1Rk3LCPhDhXr33Y8vtD5
         5BGlIGs07bGcn/8+IcpcARE9WYrao2tAQZHKCxoVHLTk/yDVTX7lNaPTwxS65slsvP
         T9/O8FWG+5NNQ==
Received: by mail-oi1-f173.google.com with SMTP id y67so8158257oiy.1;
        Fri, 28 Oct 2022 21:21:10 -0700 (PDT)
X-Gm-Message-State: ACrzQf2c36rVOE4Pjd8x2vDJbWCjfo3BipzT6MxV+FQ6hQMo1zd0tyv0
        O7wouyBKE2TGac27tuXVUkfmwQjbD7QTYYL/zRM=
X-Google-Smtp-Source: AMsMyM6FOABjTLDcw3RrE443Uzjnikyq9yGGZy+gLlTL3TwV3Lam38lhpojPimnyjLnasX0VFaVeg3G05mq2c7E4sPc=
X-Received: by 2002:a05:6808:f0e:b0:359:b055:32ea with SMTP id
 m14-20020a0568080f0e00b00359b05532eamr9041256oiw.112.1667017269693; Fri, 28
 Oct 2022 21:21:09 -0700 (PDT)
MIME-Version: 1.0
References: <20221028165921.94487-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20221028165921.94487-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20221028165921.94487-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Sat, 29 Oct 2022 12:20:57 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSaEi=Hjy+57bxNFSKBj4-_ayeh+=9qtX9HXsK3pw3LUw@mail.gmail.com>
Message-ID: <CAJF2gTSaEi=Hjy+57bxNFSKBj4-_ayeh+=9qtX9HXsK3pw3LUw@mail.gmail.com>
Subject: Re: [PATCH v5 2/7] dt-bindings: riscv: Add Andes AX45MP core to the list
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@rivosinc.com>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 29, 2022 at 12:59 AM Prabhakar <prabhakar.csengg@gmail.com> wrote:
>
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> The Renesas RZ/Five microprocessor includes a RISC-V CPU Core (AX45MP
> Single) from Andes. In preparation to add support for RZ/Five SoC add
> the Andes AX45MP core to the list.
>
> More details about Andes AX45MP core can be found here:
> [0] http://www.andestech.com/en/products-solutions/andescore-processors/riscv-ax45mp/
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> v4 -> v5
> * Included RB tag from Conor
>
> v3 -> v4
> * No change
>
> v2 -> v3
> * Included RB tag from Geert
>
> v1 -> v2
> * Included ack from Krzysztof
> ---
>  Documentation/devicetree/bindings/riscv/cpus.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
> index ae7963e99225..2bf91829c8de 100644
> --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
> +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> @@ -28,6 +28,7 @@ properties:
>      oneOf:
>        - items:
>            - enum:
> +              - andestech,ax45mp
Reviewed-by: Guo Ren <guoren@kernel.org>

>                - canaan,k210
>                - sifive,bullet0
>                - sifive,e5
> --
> 2.25.1
>


-- 
Best Regards
 Guo Ren
