Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB7776C2AA4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 07:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbjCUGqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 02:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjCUGqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 02:46:10 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7B613DD2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 23:46:00 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id eg48so55580029edb.13
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 23:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679381159;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mUdHje46W1zTNIZ/CNDjQ6OgFD/hkF9BqC9f0d1Yp9M=;
        b=TB5gf0cvfqQErXIDKzhTilnhKc+Giz9y1+e86uIzU/0xKYTMgwA/IgCKLMpazw9ryD
         mfcDTbDBDoXseNMRrrY56pFaTEj9uBIHJePDrH2UHcvgBS7EZpkkwqinD4xK4Tik8AOa
         FPZEhAACyT3+UbI5tkPnoI+n/FTDSkIfRPUw7YUlNfZPYZIhjhfV1DNsfmB7Pg561+xt
         +TJaI6+kDXRyzcGehlirCDanGlXqwWQj7cLMH89R+ybR57wEq6RaqWgcMyUYyKNaHp9l
         BCb+MXlpw0bVFIYYJqo5sOVQj3SDIl1ysphQeIQ8TVvXkPvaUSHEuoMR7+mRnFBUXhId
         gN3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679381159;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mUdHje46W1zTNIZ/CNDjQ6OgFD/hkF9BqC9f0d1Yp9M=;
        b=tJ9Ej1Kmf1uVI+uklHutX6qqzQrea/s4tJqN0V2upNDFR4irk3X80G+6LFXCw1BbEj
         jauCWsPsT/BHu+iLjFqHSvsOwVJIZp/HYeiOBUxudGYWzvV/BDSTMGdq+iOug96PFmOm
         SS5RkWd2T65KO1GKdcdyk73vw15b261ZyCTRBFsE4RndzKilv2xPo2iv9Adp3G7KG+54
         vTLBAkZq2MVhPGYhQTxxdrRuWPq3NZLdojzplFE4dZ2uB8oMbrBf9iE2R2c2gadn+ecF
         ArnpG/s1gCgo278z6ioqP/YoCKEyvJRXdQU00GaBvKafF6B4KrIaxq900YNq5uRJPUju
         EHnA==
X-Gm-Message-State: AO0yUKX+xj5AzOVdcLZkbhlvbwzSIbqb/zf1DiynkCNgKPuFKDlsfo7l
        CsVFhoKAM7EXQ46dziLlP2uE2Q==
X-Google-Smtp-Source: AK7set9KntAUZelH9dbtcgqaN9WTD/LLuB564Gyuw5k4TY2V6hGRJS5Ic08qeAgb7GRXGx2RHKYnNA==
X-Received: by 2002:aa7:cc09:0:b0:4fd:8333:e29f with SMTP id q9-20020aa7cc09000000b004fd8333e29fmr1986856edt.41.1679381159099;
        Mon, 20 Mar 2023 23:45:59 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:2142:d8da:5ae4:d817? ([2a02:810d:15c0:828:2142:d8da:5ae4:d817])
        by smtp.gmail.com with ESMTPSA id g12-20020a170906198c00b00930c7b642d0sm5319444ejd.166.2023.03.20.23.45.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 23:45:58 -0700 (PDT)
Message-ID: <5f295438-8334-d374-2ae6-2a385ffb317d@linaro.org>
Date:   Tue, 21 Mar 2023 07:45:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 1/9] dt-bindings: clock: add mtmips SoCs system
 controller
Content-Language: en-US
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        linux-clk@vger.kernel.org
Cc:     linux-mips@vger.kernel.org, tsbogend@alpha.franken.de,
        john@phrozen.org, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, devicetree@vger.kernel.org,
        arinc.unal@arinc9.com
References: <20230321050034.1431379-1-sergio.paracuellos@gmail.com>
 <20230321050034.1431379-2-sergio.paracuellos@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230321050034.1431379-2-sergio.paracuellos@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/03/2023 06:00, Sergio Paracuellos wrote:
> Adds device tree binding documentation for system controller node present
> in Mediatek MIPS and Ralink SOCs. This node is a clock and reset provider
> for the rest of the world. This covers RT2880, RT3050, RT3052, RT3350,
> RT3883, RT5350, MT7620, MT7628 and MT7688 SoCs.
> 
> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> ---
>  .../bindings/clock/mediatek,mtmips-sysc.yaml  | 65 +++++++++++++++++++
>  1 file changed, 65 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mtmips-sysc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/clock/mediatek,mtmips-sysc.yaml b/Documentation/devicetree/bindings/clock/mediatek,mtmips-sysc.yaml
> new file mode 100644
> index 000000000000..f07e1652723b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/mediatek,mtmips-sysc.yaml
> @@ -0,0 +1,65 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/mediatek,mtmips-sysc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MTMIPS SoCs System Controller
> +
> +maintainers:
> +  - Sergio Paracuellos <sergio.paracuellos@gmail.com>
> +
> +description: |
> +  MediaTek MIPS and Ralink SoCs provides a system controller to allow
> +  to access to system control registers. These registers include clock
> +  and reset related ones so this node is both clock and reset provider
> +  for the rest of the world.
> +
> +  These SoCs have an XTAL from where the cpu clock is
> +  provided as well as derived clocks for the bus and the peripherals.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - ralink,mt7620-sysc

Since you decided to send it before we finish discussion:
NAK - this is already used as mediatek

> +          - ralink,mt7620a-sysc
> +          - ralink,mt7628-sysc

Same here.

> +          - ralink,mt7688-sysc

I expect you to check the others.



Best regards,
Krzysztof

