Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBCFF638209
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 02:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiKYBNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 20:13:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiKYBNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 20:13:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D6F11DF2A;
        Thu, 24 Nov 2022 17:12:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D65E7B828FD;
        Fri, 25 Nov 2022 01:12:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AA90C433D6;
        Fri, 25 Nov 2022 01:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669338776;
        bh=AZ+eJyz4kBi9o7yRqXnJp9CHNYP6e0YWWstBtF0Fx5Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IqGTVptCpk2UHaExgRgaOGtRUkna0mNtK/SCNKuOh3/VXvACzw7NdD3w7ry37sYNH
         JMekuF1pCHsgd7RY+Q8p16TyGOkXQg5kbNnMMp4LqNAlNCgD0Gu9r9Pyjfibr51wkF
         X1WH/7ln8b0f/yVrOz7YW+j7T/3lXu3+A4U86Ln1MrFv1F5QYuz5w4JOhvoz8TaW4x
         TUuQYOky7r/XzKfY5ejZQCC/xeQIn/DuhUvaUnzTSeTAMurbqeuPpmnF+CbUXoFzvi
         Zjg5R9B5gN2p5btVzmOGkoRM+DF+AGoe8rM9UluK0Drsa0/y5ffHnuei31calhuzYA
         u7J5TMjJTJzIQ==
Received: by mail-ed1-f45.google.com with SMTP id e13so4458458edj.7;
        Thu, 24 Nov 2022 17:12:56 -0800 (PST)
X-Gm-Message-State: ANoB5pl4F6N299ZzLlVE1IcPOS4YZxNEM2QOCFNEyKAkCulRj7bxDEiv
        OOw2ujkr5iVrlxJbA552SI0VYv7MhC8lLT0C1Jo=
X-Google-Smtp-Source: AA0mqf4P9TGIVY6xhW4AH4Pe7XgSIgC76tmLBs0HwHACsHIb/WxIhfz3JFFJDYfojQc3+tJ5hGg2+TT71Cl4uJ6xaf4=
X-Received: by 2002:a05:6402:19a:b0:460:7413:5d46 with SMTP id
 r26-20020a056402019a00b0046074135d46mr32713030edv.47.1669338774785; Thu, 24
 Nov 2022 17:12:54 -0800 (PST)
MIME-Version: 1.0
References: <20221124130440.306771-1-conor.dooley@microchip.com> <20221124130440.306771-2-conor.dooley@microchip.com>
In-Reply-To: <20221124130440.306771-2-conor.dooley@microchip.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 25 Nov 2022 09:12:43 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSonEFVMomBO9g8kDb4nJyV87bi7dKfg7-+1V=MC9jGnQ@mail.gmail.com>
Message-ID: <CAJF2gTSonEFVMomBO9g8kDb4nJyV87bi7dKfg7-+1V=MC9jGnQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: riscv: fix underscore requirement for
 addtional standard extensions
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     linux-riscv@lists.infradead.org, Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Stuebner <heiko@sntech.de>,
        Andrew Jones <ajones@ventanamicro.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 24, 2022 at 9:06 PM Conor Dooley <conor.dooley@microchip.com> wrote:
>
> The RISC-V ISA Manual allows for the first Additional Standard
> Extension having no leading underscore. Only if there are multiple
> Additional Standard Extensions is it needed to have an underscore.
>
> The dt-binding does not validate that a multi-letter extension is
> canonically ordered, as that'd need an even worse regex than is here,
> but it should not fail validation for valid ISA strings.
>
> Allow the first Z multi-letter extension to appear immediately prior
> after the single-letter extensions.
>
> Link: https://github.com/riscv/riscv-isa-manual/releases/tag/riscv-unpriv-pdf-from-asciidoc-15112022 # Chapter 29.5
> Fixes: 299824e68bd0 ("dt-bindings: riscv: add new riscv,isa strings for emulators")
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  Documentation/devicetree/bindings/riscv/cpus.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
> index 90a7cabf58fe..e80c967a4fa4 100644
> --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
> +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> @@ -80,7 +80,7 @@ properties:
>        insensitive, letters in the riscv,isa string must be all
>        lowercase to simplify parsing.
>      $ref: "/schemas/types.yaml#/definitions/string"
> -    pattern: ^rv(?:64|32)imaf?d?q?c?b?v?k?h?(?:_[hsxz](?:[a-z])+)*$
> +    pattern: ^rv(?:64|32)imaf?d?q?c?b?v?k?h?(?:z(?:[a-z])+)?(?:_[hsxz](?:[a-z])+)*$
Acked-by: Guo Ren <guoren@kernel.org>

>
>    # RISC-V requires 'timebase-frequency' in /cpus, so disallow it here
>    timebase-frequency: false
> --
> 2.38.1
>


-- 
Best Regards
 Guo Ren
