Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF866F3E65
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 09:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233634AbjEBH2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 03:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjEBH2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 03:28:08 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B764215
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 00:28:06 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9505214c47fso690838566b.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 00:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683012485; x=1685604485;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uxqIQluB2Z5De+KoFY9KA9mX8YPwnDskO3lw2FlElZs=;
        b=q1fqgb3UJzeU3o8j7LOumaD2lYrexvbU2mq2hlvvdvwphrQAzfR3m/WhZUQXdzzXwo
         anlCHeP/S2shFqkqDCJ8wbEsb12h/Q/gPtGe3ZSb+mV1q9Y7PQ0C51VKo8reaxjNYgPy
         uGgDXcCzuVzu0aeA4qfc5kz4HJHutTyN2m6rcNR2qUlHfCAevmiaaLC3vSQH+SvVtvBh
         6+2xCJhi8laSF7mkG6LmqhBP0tKfdk1QAxFJpjrm3T5hqDr9BzK68PCRCtYHizXFm6/L
         8iE22+UgXIV88tYgeB9jQV3Px2RV1Rac1eDWlPp4P8XUoo9+1wuWJrWOFyt+iDfgsBSc
         5rhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683012485; x=1685604485;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uxqIQluB2Z5De+KoFY9KA9mX8YPwnDskO3lw2FlElZs=;
        b=BuBA7UwnyOfHujte0xRxwlcssavXfzGu1vEBlMS5yK4dXchPSh3cFn+WooVfxfl0WF
         I/7fSM82Wue5LSd630MGr/X9zJD0wTMK5q1D6/AsxSe9iuLP/Zo0fOXNSbtOfqpgOncS
         pwTeWetiF7YMKQaViWv4otgu3uKeBg4BWX6TTpiGG3ExUy8B4gbaj09MQZRcLbb8fEff
         ODSYxDYyXZCN1SdKzM118IfSDvZ/6NjCQ+V9NASsxhVppSl8OoIK5BT2/WZlhcTtn2+m
         oKinojufM3S5UhkDSLJ4A8hEHUk5n/05ZJji1x6VegC/TBXdd8uIRhrEfx6EgpKx6q3O
         hvAA==
X-Gm-Message-State: AC+VfDw2jHByiJ67/H4jvon94OAcHQg13ZV8j/r4WIR7P3lC2+ZFomVK
        ZqEzais0X2nvYfhWI10jMovKRg==
X-Google-Smtp-Source: ACHHUZ4gNy/JK2zvP7iIWv5h2Du0eVngU8hcE0mrCK5p5SUEf7rR3RGpdFzEGjZusLEWsn3q7hbDVQ==
X-Received: by 2002:a17:907:31c7:b0:94a:785e:6a46 with SMTP id xf7-20020a17090731c700b0094a785e6a46mr16023751ejb.24.1683012485294;
        Tue, 02 May 2023 00:28:05 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:bafd:1283:b136:5f6a? ([2a02:810d:15c0:828:bafd:1283:b136:5f6a])
        by smtp.gmail.com with ESMTPSA id l13-20020a170906230d00b0094f2f1c5ea1sm16044643eja.174.2023.05.02.00.28.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 May 2023 00:28:04 -0700 (PDT)
Message-ID: <5edec8db-64de-553b-6313-9b570f4d2a03@linaro.org>
Date:   Tue, 2 May 2023 09:28:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v5 2/2] arm64: dts: meson-gxl: add support for Xiaomi Mi
 box 3
Content-Language: en-US
To:     Karl Chan <exkcmailist@inbox.lv>, linux-amlogic@lists.infradead.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        neil.armstrong@linaro.org, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230425165624.11999-1-exkcmailist@inbox.lv>
 <20230425165624.11999-3-exkcmailist@inbox.lv>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230425165624.11999-3-exkcmailist@inbox.lv>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/04/2023 18:56, Karl Chan wrote:
> From: "Karl Chan"  <exkcmailist@inbox.lv>
> 
> The Xiaomi Mi box 3 is a TV box based on the Amlogic S905X chipset.
> There are two variants:
> - 2 GiB/8GIB
> - 1 GiB/4GIB
> 

...

> +&hdmi_tx_tmds_port {
> +	hdmi_tx_tmds_out: endpoint {
> +		remote-endpoint = <&hdmi_connector_in>;
> +	};
> +};
> +
> +/* This UART is brought out to the uart pad on upper left of the pcb */
> +&uart_AO {
> +	status = "okay";
> +};
> +

Drop stray blank lines.

Best regards,
Krzysztof

