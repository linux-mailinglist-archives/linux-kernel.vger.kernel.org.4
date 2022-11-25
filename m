Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0DD163820B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 02:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiKYBPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 20:15:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiKYBPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 20:15:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29AD4281;
        Thu, 24 Nov 2022 17:13:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B9E4E6226C;
        Fri, 25 Nov 2022 01:13:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BAE0C433D7;
        Fri, 25 Nov 2022 01:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669338819;
        bh=6wAMWrQT5K32dko1URWUvuBP/QI8koaN+Dc2CHOpfLI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=E4d9Htr19Pyq8G7SRSdzRer5HpyVGZqnReUgqLEEz1yzPuMZhmJVUZ8rWPhXwNsF1
         F/OnIu6/rLecGFZ93j+GrIvKica8f4PU//D8hh0nrqgGOpXV2OUD1P+9mHJpgJNCIo
         Am70isZkh3adPawAT8KFz1sP/XpM68n7xmpGkYHAaCZfWUVTbIWXRVDW4Awjh5Pw5q
         6KaSlK9HfhkcFLphX/W/nREGvdoQhpxN1JWMUit2t3H7IowN1J51/jhuApBTL7Sp2h
         u6qh6v71xEeJLsvBVwBKejDNUWazhKGyj0R9hoQd+lcBti8qDo8rvKI9+bcTd2U9Js
         Nm1tNf2CoXpdA==
Received: by mail-ej1-f51.google.com with SMTP id m22so7163183eji.10;
        Thu, 24 Nov 2022 17:13:39 -0800 (PST)
X-Gm-Message-State: ANoB5pkCN2d7P7BuyP1LZG4WxcxZrjCyukT6domoI/e0GbO2zeDIx9OF
        02rZu94+qziX0u4eme0tVw94oBPi5wFzQttbIhA=
X-Google-Smtp-Source: AA0mqf6z230oM0JVBCd8skG0dRUC1eHOWIUCdnVZpOLRJGDgCM8enkov2cjezhiPVICTeyE6u1ZjeEMqwWq/0xzAh2w=
X-Received: by 2002:a17:907:9856:b0:780:8144:a41f with SMTP id
 jj22-20020a170907985600b007808144a41fmr30590572ejc.189.1669338817392; Thu, 24
 Nov 2022 17:13:37 -0800 (PST)
MIME-Version: 1.0
References: <20221124130440.306771-1-conor.dooley@microchip.com> <20221124130440.306771-3-conor.dooley@microchip.com>
In-Reply-To: <20221124130440.306771-3-conor.dooley@microchip.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 25 Nov 2022 09:13:25 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSoySxChy5cgQeL6-4bGmXF5YnUKJRgL5FnE3K6Z9Xt+w@mail.gmail.com>
Message-ID: <CAJF2gTSoySxChy5cgQeL6-4bGmXF5YnUKJRgL5FnE3K6Z9Xt+w@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: riscv: fix single letter canonical order
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
> I used the wikipedia table for ordering extensions when updating the
> pattern here in foo.
> Unfortunately that table did not match canonical order, as defined by
> the RISC-V ISA Manual, which defines extension ordering in (what is
> currently) Table 41, "Standard ISA extension names". Fix things up by
> re-sorting v (vector) and adding p (packed-simd) & j (dynamic
> languages). The e (reduced integer) and g (general) extensions are still
> intentionally left out.
>
> Link: https://github.com/riscv/riscv-isa-manual/releases/tag/riscv-unpriv-pdf-from-asciidoc-15112022 # Chapter 29.5
> Fixes: 299824e68bd0 ("dt-bindings: riscv: add new riscv,isa strings for emulators")
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  Documentation/devicetree/bindings/riscv/cpus.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
> index e80c967a4fa4..b7462ea2dbe4 100644
> --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
> +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> @@ -80,7 +80,7 @@ properties:
>        insensitive, letters in the riscv,isa string must be all
>        lowercase to simplify parsing.
>      $ref: "/schemas/types.yaml#/definitions/string"
> -    pattern: ^rv(?:64|32)imaf?d?q?c?b?v?k?h?(?:z(?:[a-z])+)?(?:_[hsxz](?:[a-z])+)*$
> +    pattern: ^rv(?:64|32)imaf?d?q?c?b?k?j?p?v?h?(?:z(?:[a-z])+)?(?:_[hsxz](?:[a-z])+)*$
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
