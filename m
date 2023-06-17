Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F64F7341BB
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 16:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233609AbjFQOs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 10:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbjFQOsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 10:48:23 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3D01FD7
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 07:48:22 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-982a0232bdcso278744266b.1
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 07:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687013301; x=1689605301;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j1U4ZmZXx/vAL10/mCf095vEMlIWmF3nehD7kLntIR4=;
        b=ChcxjDgwes6HY4rsFeEdVgdSJcYWw9lrNgoXNUBd42MlO3z+2Tad30VAh2jRuHwnfs
         +Oxv3XcgbIgjyZJhM8C4EvvB+UuqGNmEybmYZjuyrN3lDBEfB8nV5jIX2sjr0diWfC9G
         6jA9xAeyP7ZOhsX1DO7yQgHrYFG4ex+AyLDNc6e0hZPf/rgIqgWIa9Dfq6WXHNPb7BX5
         BiQWPD4JQ3IjSjujjBfBkHDBP9KE8gOI8H4DupELlJeTCtsBCvZT25bgz/NMGz3tRNIz
         trpAh1SZMQ338DW2dhssFVlFheSDJzg7ibKAQ+Kv/JYfaIgjmqB7DbrV35vYAyqPbQTx
         EXiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687013301; x=1689605301;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j1U4ZmZXx/vAL10/mCf095vEMlIWmF3nehD7kLntIR4=;
        b=ddmeu3Rx3jDdEy3s0SyA0o0G09sW2EdmeahLm71sg4hHeKf4n7uA+oNIjOjjUxnz00
         kd5vAsYcf8icubLZ4d1i5AMaRRjyTdaiaOR6rfwvyiBkEwSLcKyQP6Kq4FgjWnbwNwWf
         Ecm8Q9O1eYJThayERLfldruSTlK2BzKAJ/lDLyAkRMB8mHSnkDj4qQdzvFCAoZeZiAEF
         txW65gaFgXzBt5KZLhxnlTyIOF56M6pyjy1tm6KzQ931dhK5A7E+WtclZySeNRICQkyG
         YxMj9hnO3s5NPBQsWOAXO3W2vsUVhlWbPEpv6dZVp5YKi+1FYxFJsm9z59Ew2ZB4LONO
         UYrA==
X-Gm-Message-State: AC+VfDzCZf23Hi7t4IKlAyyecOCRFA0bdQDk01lPOZ6IlD1fMWolPGNx
        31BdT3FG6PSKUracMwemWiNDcg==
X-Google-Smtp-Source: ACHHUZ5Kn/BVDeBc4E+2dSIzgz0zNItmrTa6yJTUuBJ7aeykoelm6bQrtRhisnWHDutx2AdTCHryAQ==
X-Received: by 2002:a17:907:6d81:b0:974:e767:e1db with SMTP id sb1-20020a1709076d8100b00974e767e1dbmr5635437ejc.46.1687013300606;
        Sat, 17 Jun 2023 07:48:20 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id m25-20020a170906235900b00982aec29db1sm3313076eja.126.2023.06.17.07.48.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Jun 2023 07:48:20 -0700 (PDT)
Message-ID: <c1a69db7-96c2-f3ad-3ef2-9a655b10bfb5@linaro.org>
Date:   Sat, 17 Jun 2023 16:48:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 8/9] mips: ralink: get cpu rate from new driver code
Content-Language: en-US
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        linux-clk@vger.kernel.org
Cc:     linux-mips@vger.kernel.org, tsbogend@alpha.franken.de,
        john@phrozen.org, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, devicetree@vger.kernel.org,
        arinc.unal@arinc9.com
References: <20230617052435.359177-1-sergio.paracuellos@gmail.com>
 <20230617052435.359177-9-sergio.paracuellos@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230617052435.359177-9-sergio.paracuellos@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/06/2023 07:24, Sergio Paracuellos wrote:
> At very early stage on boot, there is a need to set 'mips_hpt_frequency'.
> This timer frequency is a half of the CPU frequency. To get clocks properly
> set we need to call to 'of_clk_init()' and properly get cpu clock frequency
> afterwards. Depending on the SoC, CPU clock index in the clock provider is
> different being two for MT7620 SoC and one for the rest. Hence, adapt code
> to be aligned with new clock driver.


>  void __init plat_time_init(void)
>  {
> +	struct of_phandle_args clkspec;
>  	struct clk *clk;
> +	int cpu_clk_idx;
>  
>  	ralink_of_remap();
>  
> -	ralink_clk_init();
> -	clk = clk_get_sys("cpu", NULL);
> +	cpu_clk_idx = clk_cpu_index();
> +	if (cpu_clk_idx == -1)
> +		panic("unable to get CPU clock index");
> +
> +	of_clk_init(NULL);
> +	clkspec.np = of_find_node_by_name(NULL, "sysc");
> +	clkspec.args_count = 1;
> +	clkspec.args[0] = cpu_clk_idx;
> +	clk = of_clk_get_from_provider(&clkspec);

This is very obfuscated way of getting clock. Why can't you get it from
"clocks" property of "cpu", like every other recent platform?

Anyway, NAK for of_find_node_by_name(), because you now create ABI for
node name. It's broken approach.

Best regards,
Krzysztof

