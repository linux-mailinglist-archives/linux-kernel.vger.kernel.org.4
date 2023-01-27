Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4236D67E651
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 14:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234295AbjA0NNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 08:13:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234012AbjA0NNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 08:13:48 -0500
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0434351421
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 05:13:11 -0800 (PST)
Received: by mail-vs1-xe34.google.com with SMTP id i188so5222283vsi.8
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 05:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=H5OjDI+BmuahlrrPemGCNzWK2D1S3Y5Nfa98DDI8/8k=;
        b=3FNkY8nqZHleZUzbXb0ruzpHilbOFCvkA34g4Qc7SGxbjZHQsXwRHueCfp5zGyjwXI
         lY7ES/g3q0/X/bd0wBh9hEpvZIPccbc6zOwT+p3xZiDqtr6t4qY9RCi1zXW90wgIk5sM
         26P1xqt/PmTMxbkZL6xVJ0ZPWlaPb7aQY1JP8O3FSv2/1LzP2m4n+1EcCCeY/c8uuuia
         6dkuDkjEN9ux5tf3IYSUP7aK+g+Xim8o45dKXXWBxsy2Q2Nf2bHw9ws7CX1u+vi8sJj0
         9VJAXOjuVmP0Ynp+LB8v8HHzuYPN3RRdQ1zrdMWHZjIlYR1s012J4rNL3CNsC5YBSyei
         edTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H5OjDI+BmuahlrrPemGCNzWK2D1S3Y5Nfa98DDI8/8k=;
        b=C8DoPUpC2UOtpH7qVif3VS7atenqPzdcJNEAsZdliZ/5kZnoQLxPMkMDUMkX9owaa2
         nkVjnYbMmkBQJwu/p7JLDzYF2p3JplXhvqaeIqbhez0BImgGnNare3gwLFSkTyqOnMRl
         hU40wXI9GwEDSQgpNRPUhV/VkVaMrTGRCO7uST4VYPo1eG5lC2dzKLD0GRxVDUXGugWJ
         YHJ6eir4GqTFANkPvQFkI1qqYlcOvcd9BcnUySGUQHP5b2FmnhC7VbTmTCuox/cQ1Czp
         0r3GFHtR49685nmIbRD6K8feTJDZEc7loqCg1V13nfEcPPvHsqxdakcI+8HkBcwyuZfs
         Ujxw==
X-Gm-Message-State: AO0yUKVwOb+EfaSfLibrwJ7OJTtjHbUwIznNjg9s9722ow/emrRdUK7L
        z5230rdqAhVUkrQ9nBnFC1fNe6kMsowh7Bd2a8h7EXphjTuD/A==
X-Google-Smtp-Source: AK7set8NJm64JXj8Sonnt3qwTZmV9E5ZtjWIbL/cJOBHCzm8vy8F9tlY1BhQrUCkPFmsLvz/ZCQap95kemwTg5GmAbA=
X-Received: by 2002:a67:c384:0:b0:3e8:d5a8:3fbe with SMTP id
 s4-20020a67c384000000b003e8d5a83fbemr1347040vsj.9.1674825145903; Fri, 27 Jan
 2023 05:12:25 -0800 (PST)
MIME-Version: 1.0
References: <20230127101836.93845-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230127101836.93845-1-krzysztof.kozlowski@linaro.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 27 Jan 2023 14:12:15 +0100
Message-ID: <CAMRc=MdgOnmT2PRVN1Dejf97iFYTuKWSK==oX=e1MWg3WJUiHw@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: ti: use "okay" for status
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 11:18 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> "okay" over "ok" is preferred for status property.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm/boot/dts/da850-evm.dts         | 2 +-
>  arch/arm/boot/dts/keystone-k2e-evm.dts  | 2 +-
>  arch/arm/boot/dts/keystone-k2g-evm.dts  | 2 +-
>  arch/arm/boot/dts/keystone-k2hk-evm.dts | 2 +-
>  arch/arm/boot/dts/keystone-k2l-evm.dts  | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
> index 1fdd9a249165..0ca849885d1f 100644
> --- a/arch/arm/boot/dts/da850-evm.dts
> +++ b/arch/arm/boot/dts/da850-evm.dts
> @@ -415,7 +415,7 @@ &edma1 {
>  &aemif {
>         pinctrl-names = "default";
>         pinctrl-0 = <&nand_pins>;
> -       status = "ok";
> +       status = "okay";
>         cs3 {
>                 #address-cells = <2>;
>                 #size-cells = <1>;

For DaVinci:

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
