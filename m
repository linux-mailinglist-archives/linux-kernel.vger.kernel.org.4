Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6C056A7CEE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 09:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjCBIir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 03:38:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjCBIiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 03:38:46 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2DAE199FA
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 00:38:44 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id x3so1504914edb.10
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 00:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677746323;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8OmjhpD7dDGUvVSO/SqKryp8My2PRSUeyOUaxxJZfRs=;
        b=UnLrRW/Q6MZ2RNM4/ZhdMneBbHQ9DrMlYoVGDla3MFWwfQDOX1BT3qMXzrFiGqc3AJ
         GXsi5y9tWOumhOIg6he9mvnX7hZAwyXfVb7dYmAYFcl5Sc/KD3pB27p4kq0fGx5am8nT
         UWcfrkHrGnL+LH0lXxo+zy9QYt30JqslFsIuWOYeXUupP+N0CpyHnE6RNXStCzcJUdYe
         pdqFBvJU9ACgRPvOcmgHZZqTvGyLHfLY0kbstrwYyL+5tJ/zLZpODB13ZBBLaumLOnKv
         QaXj/8Vgl2+CONG4vPzP33OrDCw5nTCEN21lKQlB9/smT6rjBEXlI67L1Dm5YXrfC/qb
         Q10w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677746323;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8OmjhpD7dDGUvVSO/SqKryp8My2PRSUeyOUaxxJZfRs=;
        b=FY4oWxQ3QuJ45aJLQeq4fRNUreYSFe48ncj+p5jSw1vUavziL7euCCPNsagJrB6MbB
         NwoQTUIxCklmRM/U9q62LS4i8+UplXS2NOqhk+Cbhc5O31K9HFWjS7EZbCEN7kZdUlRA
         TA1+gvba6yji9wY+9ym53ogZqToh8qb5ZpbQq26dfZVs1IxHDClqJJLjEGEkKVPUweXw
         V3KPKZIKE7PmwzjUSYIy099blV7ezkZIgrSsIspzeblzwBN2i/LNO4/0AjJKqLK1OIzN
         Pem+SRb9JFnkxMB6CdB8FTrCLlBtj5tXub/nRvrhxMtRyD57qFiModzDiNKRtheZ9WJd
         r5IQ==
X-Gm-Message-State: AO0yUKVGSgqkH0m4wReKI0TibPQNFLsdK1fXblEZZoX7HkSDUbmf9jy9
        NgKYCFGv09NXcvstIZYvhT+duw==
X-Google-Smtp-Source: AK7set9O6MpdGHSGj3dkOhPuuXKSCW5u6UDxH1HI3rOWFMaotUTCWOAQxcl8JXq28G9RZByzk9DNAA==
X-Received: by 2002:a17:907:c20b:b0:906:2b5c:7390 with SMTP id ti11-20020a170907c20b00b009062b5c7390mr5809736ejc.16.1677746323099;
        Thu, 02 Mar 2023 00:38:43 -0800 (PST)
Received: from [192.168.1.20] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id ha14-20020a170906a88e00b008c405ebc32esm6766102ejb.28.2023.03.02.00.38.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Mar 2023 00:38:42 -0800 (PST)
Message-ID: <f726c3c6-dc71-fb51-aa64-3e98c657b8f8@linaro.org>
Date:   Thu, 2 Mar 2023 09:38:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] dt-bindings: clock: imx8m: add interrupts property
Content-Language: en-US
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, abelvesa@kernel.org,
        abel.vesa@linaro.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
References: <20230301020122.3389102-1-peng.fan@oss.nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230301020122.3389102-1-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/03/2023 03:01, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Since the CCM module could trigger interrupt, so add interrupts property
> for i.MX8M.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  Documentation/devicetree/bindings/clock/imx8m-clock.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/imx8m-clock.yaml b/Documentation/devicetree/bindings/clock/imx8m-clock.yaml
> index 0dbc1433fede..ac7ad8459c79 100644
> --- a/Documentation/devicetree/bindings/clock/imx8m-clock.yaml
> +++ b/Documentation/devicetree/bindings/clock/imx8m-clock.yaml
> @@ -39,6 +39,10 @@ properties:
>        ID in its "clocks" phandle cell. See include/dt-bindings/clock/imx8m-clock.h
>        for the full list of i.MX8M clock IDs.
>  
> +  interrupts:
> +    minItems: 1
> +    maxItems: 2

You should describe the interrupts. Why they are variable in number?

Best regards,
Krzysztof

