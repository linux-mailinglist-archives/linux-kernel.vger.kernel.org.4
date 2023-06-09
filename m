Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9968F729CFB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 16:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbjFIOfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 10:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241482AbjFIOer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 10:34:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69BC530F8;
        Fri,  9 Jun 2023 07:34:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 05B48658A0;
        Fri,  9 Jun 2023 14:34:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F054C4339E;
        Fri,  9 Jun 2023 14:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686321285;
        bh=6hi3QOrXBuWBmFSLc1LCcSZkPYNC/LjyWkqKBdgQtYI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=t2zwqZY++aHOeqkffOIRqTQwaFGYg/NlJ7x1vCYz/K+ZilOefocnMcGfiq6zqcf9a
         0uz5FX80e1MTsFaeAsiOt9n82ThnzSWWQFwBB5SQ2JR4xa/BwlmgzkwZGU0gS6cVSS
         wWM4IE8G+4mL1pkGa/mLU1KZYCVDHG+rqQnHMIXHbGT0DbiLEUOnHvDzyUYlLX7soc
         ZWTGdcvnDa1wt8I+HMTFxSC3fmK6rqAcc1xeiJ/xrVlikzbrJKwa1lHZPJIhZ/WdC2
         wzg2HJ8JZaBP4IJqDfoSCd6etqsXNZvushR2eLeRQ0wXuyjMhyOvTn+5hZzXjvaWg9
         JNTb8A2CbbPuQ==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2b1b30445cfso20947721fa.1;
        Fri, 09 Jun 2023 07:34:45 -0700 (PDT)
X-Gm-Message-State: AC+VfDxJfhAr9f50jYHr1Xlhd1XeukQemBA7nLYFDDnYgi91yb/swS9q
        RiL5xtrHEInMwMVk5Vs3gaVLGXQu0pJOtGYGgQ==
X-Google-Smtp-Source: ACHHUZ5RlhCvj6SZ4qT0ESmlowGIP4EXqIRZ5+cA0hTrUzwiZ/YarhwSg72TilmhiLhF0QJ+br0GiIgWs2wltkkoIHo=
X-Received: by 2002:a2e:9c90:0:b0:2af:2466:1c18 with SMTP id
 x16-20020a2e9c90000000b002af24661c18mr1326079lji.18.1686321283406; Fri, 09
 Jun 2023 07:34:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230609140706.64623-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230609140706.64623-1-krzysztof.kozlowski@linaro.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 9 Jun 2023 08:34:31 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+5oZdHi6B-R1YUEwSOc8x8Vd9sHt1bgp5ydM_hAQJE3w@mail.gmail.com>
Message-ID: <CAL_Jsq+5oZdHi6B-R1YUEwSOc8x8Vd9sHt1bgp5ydM_hAQJE3w@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: riscv: cpus: drop unneeded quotes
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Conor Dooley <conor@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 9, 2023 at 8:07=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Cleanup bindings dropping unneeded quotes. Once all these are fixed,
> checking for this can be enabled in yamllint.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/riscv/cpus.yaml | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Note that I already have the whole tree done. Just not all split up.

Acked-by: Rob Herring <robh@kernel.org>

>
> diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Document=
ation/devicetree/bindings/riscv/cpus.yaml
> index db5253a2a74a..8a56473cdd5a 100644
> --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
> +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> @@ -61,7 +61,7 @@ properties:
>        hart.  These values originate from the RISC-V Privileged
>        Specification document, available from
>        https://riscv.org/specifications/
> -    $ref: "/schemas/types.yaml#/definitions/string"
> +    $ref: /schemas/types.yaml#/definitions/string
>      enum:
>        - riscv,sv32
>        - riscv,sv39
> @@ -95,7 +95,7 @@ properties:
>        While the isa strings in ISA specification are case
>        insensitive, letters in the riscv,isa string must be all
>        lowercase.
> -    $ref: "/schemas/types.yaml#/definitions/string"
> +    $ref: /schemas/types.yaml#/definitions/string
>      pattern: ^rv(?:64|32)imaf?d?q?c?b?k?j?p?v?h?(?:[hsxz](?:[a-z])+)?(?:=
_[hsxz](?:[a-z])+)*$
>
>    # RISC-V requires 'timebase-frequency' in /cpus, so disallow it here
> @@ -120,7 +120,7 @@ properties:
>        - interrupt-controller
>
>    cpu-idle-states:
> -    $ref: '/schemas/types.yaml#/definitions/phandle-array'
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>      items:
>        maxItems: 1
>      description: |
> --
> 2.34.1
>
