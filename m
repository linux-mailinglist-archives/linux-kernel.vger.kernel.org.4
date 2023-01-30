Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFDB9681277
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 15:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237608AbjA3OVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 09:21:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237513AbjA3OVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 09:21:01 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887573FF30;
        Mon, 30 Jan 2023 06:19:49 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id f7so3849461edw.5;
        Mon, 30 Jan 2023 06:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=k+Oo1lodryIMqmzr2Eid+QVBl9SbaXzX/i9lxIpx/ls=;
        b=oXRSmtI7+kfluXGdPzqgmBsbEWnYVqqktepEU2DT5aRYKXgkWk97ysBAT/yIBkLn5N
         02rOO8XRU2AqISiVjhdev9VemPfygs1waGbWjr4hQM4gbG3lOYecqInCwlIcGP5Pbv7K
         BalUX+njkzDmx9hMpk9g6wCeerLR+6w5dyv+c5wlpSMsdq9rcJZX+lYvb2IiOQmDz+iv
         XdcWqfYKGIKym5yM/de/9e9RL8z60ulpoO3iJ2dxo/BgRNXC0T2F+ImbiErLfXAv1zV0
         s3LNP3CW2hCO9VQOw1ZlsprwcURflX8YpG9XKxTEh9KNZm7+v11onOb7QN+HCZPMAovr
         FNqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k+Oo1lodryIMqmzr2Eid+QVBl9SbaXzX/i9lxIpx/ls=;
        b=CgPvrSNJFQyLXWfqp7k/69EPBMVDqu0kXFQsdoLfvydOTYflUA3eRcbISkFDHjvk5C
         AIopJzxOEFAtxt05cVHm4J94dZOQkI3svXWKnK+93XRnjIwFNS+E+ia/SEZIHZiWK97F
         R6kx1q8zkCnSQ7HUSwLQFyNFC9ciJVWdtdM83g5BFvfSHNzITLixGSEtoy3vnfIKkca1
         kiAVRICvya21g7EM5kE4vsFWn0KG32500uzuep0xmURQBnTO3r0FSUyWhRX4iLdL3iTV
         REud5CxExig9CiW92jKn/wEcic59yfiCL8oZQF6J//9/kWFCZJky7H2eNWBuLArs1kc1
         z23w==
X-Gm-Message-State: AO0yUKVtlG3wHgqi7thkF71s2F+vQ8QjSKGI7iHwxL2VsaVRlZWClF4w
        ErTzGSoxx1Bn7Z6Or1SahOAzSy1PZzNlA271agc=
X-Google-Smtp-Source: AK7set+M9ZVT6Rum3TxEEYVfIbKhmyXDZsfxkzsnuc6uFqbZ5gm2rsCy5XTxNLlEPxG9EavNpdslbi7JY/S5m7AG/go=
X-Received: by 2002:aa7:cd85:0:b0:4a2:ea2:4f38 with SMTP id
 x5-20020aa7cd85000000b004a20ea24f38mr3242518edv.20.1675088355597; Mon, 30 Jan
 2023 06:19:15 -0800 (PST)
MIME-Version: 1.0
References: <20230128055214.33648-1-jamiemdouglass@gmail.com>
In-Reply-To: <20230128055214.33648-1-jamiemdouglass@gmail.com>
From:   Petr Vorel <petr.vorel@gmail.com>
Date:   Mon, 30 Jan 2023 15:19:03 +0100
Message-ID: <CAB1t1CwzUCEL1josABxfyqX91Z6DsrbEuopsDYsgq-eNxh6Btw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: msm8992-lg-bullhead: Correct memory
 overlap with SMEM region
To:     Jamie Douglass <jamiemdouglass@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Dominik Kobinski <dominikkobinski314@gmail.com>,
        Konrad Dybico <konrad.dybico@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jamie,

On Sat, 28 Jan 2023 at 06:53, Jamie Douglass <jamiemdouglass@gmail.com> wrote:
>
> A previously committed reserved memory region was overlapping with the

IMHO there should be marked commit which you're fixing:
Fixes: 22c7e1a0fa45 ("arm64: dts: msm8992-bullhead: add memory hole region")

> SMEM memory region, causing an error message in dmesg:
>         OF: reserved mem: OVERLAP DETECTED!
>         reserved@5000000 (0x0000000005000000--0x0000000007200000)
>         overlaps with smem_region@6a00000
>         (0x0000000006a00000--0x0000000006c00000)
> This patch splits the previous reserved memory region into two
> reserved sections either side of the SMEM memory region.

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Tested-by: Petr Vorel <pvorel@suse.cz>
...
> +++ b/arch/arm64/boot/dts/qcom/msm8992-lg-bullhead.dtsi
> @@ -53,8 +53,13 @@ cont_splash_mem: memory@3400000 {
>                         no-map;
>                 };
>
> -               removed_region: reserved@5000000 {
> -                       reg = <0 0x05000000 0 0x2200000>;
> +               reserved@5000000 {
Can we keep "removed_region:" ?
removed_region: reserved@5000000 {

> +                       reg = <0x0 0x05000000 0x0 0x1a00000>;
> +                       no-map;
> +               };
> +
> +               reserved@6c00000 {
Not sure which label to add, maybe append 2?
removed_region2: reserved@6c00000 {
@Konrad @Krzysztof WDYT?

Kind regards,
Petr

> +                       reg = <0x0 0x06c00000 0x0 0x400000>;
>                         no-map;
>                 };
>         };
