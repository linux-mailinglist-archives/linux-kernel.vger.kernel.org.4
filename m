Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7C4631DCA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 11:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbiKUKJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 05:09:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbiKUKJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 05:09:50 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9BE5647B
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 02:09:48 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id g12so18098944lfh.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 02:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i3YXumFsPw6lbI2IHMtFObomGfN5gHhNwcdgLP+EhJk=;
        b=jMQDqklr6GJhwiLPT9kPQTPmexECun/4HMUGVLBEqBvYISI8XEuWKkoKtj+dKN2kW8
         LnyRPehM4XhFvmvIv7o8L1T7/0ugBPOT9oMyWvlsqngtdLPsdhc4DftPtJVqPwZ3ajMF
         zB5BQky4xx8qaU/c7Wuq25mcd7cAeoJdiEwFZ1lptGOkknfifq8ztal99bBbiWwkWfeM
         5wjxp2czMpvgnJavWNh1b6EWfwNwQ9tncKAkyrzSefAaBJDi9YSwOtA9aR826sp/4z67
         iIIsu0EgU2jqZF5JijtlmtYruvIVVwTIl2+CscNbK7DLfXToq2+9aMY/qiUQ8lg2sfEx
         hQ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i3YXumFsPw6lbI2IHMtFObomGfN5gHhNwcdgLP+EhJk=;
        b=jkpAvu5TWITJugmAwLKdPkSmVYpXMLP1rkjduMcgDB9WFoSph1R5ShO0BotdhlTY3N
         QCif/DixXdSRvRqvUR80y+r3kbUFgU9XUaUHp12qndfYjz/Ing0yTA5oRQvq4+OXXBHk
         EvkfbEThJSOlAV7PQSsmUywa9VrsFLY3VvQ/yZ4pSEGhcSJkQo6ffpagH+qtVGMEh6Lx
         qNVkQYKyhbI9+Icus0DXiYii59Dn/AjROlTg/TgwQXFsn6pCtVvmphYbzSD7N5lU3YDd
         ItxiFUWD6NYo9Qq6+Rd/U5c1DwxSQUEuSc6LLOrqA86KX6v2UKsDDLroS8iUR7YSrJiY
         SpOA==
X-Gm-Message-State: ANoB5pl7wITSbz1R3xUHgua3r69QTsHVUkBgzMKf2H/L+lRN4sNmyeHH
        YIxC6aAI2UwNSQ8V71ADZIYetA==
X-Google-Smtp-Source: AA0mqf6DBfrEF5O0+Ktio6r059/CuVFDgOS3eqygqMtw5mUk3rI1/U6Kjd8+p/QbRjRwyx2S7laiMA==
X-Received: by 2002:ac2:5e2c:0:b0:4a2:243a:ef6e with SMTP id o12-20020ac25e2c000000b004a2243aef6emr942157lfg.454.1669025387158;
        Mon, 21 Nov 2022 02:09:47 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id be34-20020a056512252200b0049e9122bd1bsm1975586lfb.164.2022.11.21.02.09.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 02:09:46 -0800 (PST)
Message-ID: <9d287ce2-a826-5777-8d88-8e05e6924670@linaro.org>
Date:   Mon, 21 Nov 2022 11:09:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 5/7] riscv: dts: bouffalolab: add the bl808 SoC base
 device tree
Content-Language: en-US
To:     Jisheng Zhang <jszhang@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20221120082114.3030-1-jszhang@kernel.org>
 <20221120082114.3030-6-jszhang@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221120082114.3030-6-jszhang@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/11/2022 09:21, Jisheng Zhang wrote:
> Add a baisc dtsi for the bouffalolab bl808 SoC.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/boot/dts/Makefile               |  1 +
>  arch/riscv/boot/dts/bouffalolab/bl808.dtsi | 74 ++++++++++++++++++++++
>  2 files changed, 75 insertions(+)
>  create mode 100644 arch/riscv/boot/dts/bouffalolab/bl808.dtsi
> 
> diff --git a/arch/riscv/boot/dts/Makefile b/arch/riscv/boot/dts/Makefile
> index ff174996cdfd..b525467152b2 100644
> --- a/arch/riscv/boot/dts/Makefile
> +++ b/arch/riscv/boot/dts/Makefile
> @@ -1,4 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
> +subdir-y += bouffalolab

Nothing to build there, so not yet.


Best regards,
Krzysztof

