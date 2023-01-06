Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 082B666004E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 13:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbjAFMdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 07:33:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232460AbjAFMcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 07:32:54 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8B6676CE
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 04:32:52 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id bs20so1151205wrb.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 04:32:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=da10G3UmxKY1sOpQGZA/k2Utzz3wOV8wVJe9TJzAXVY=;
        b=RpCTodbz9uuZKViQh3ZnI5T/0FO8utQhtXyfKfpWeHcB0eSOvCDMdwYXsFQUSAPP65
         8FQKvzag/Eedi/4+I2gIOiO17cCdSNnSp+yU8lutEkFMzWxU6C9FUd0N2mr4ak06zcER
         72IhBIZkP6ahebWgPVgk5I35d/BzujhU8p+RLUaQcttGT41ClH3krumgRglgBktSEAOI
         5+nNm64l5VaoZFcLP2j1MTM3ke4lsH95T1Ej+gJtgbsUyj4uSTAmvCKR7av/SgOPo9K/
         ubLbRMdq40TqKWNSmGFJWAWA4PIbq+I9P4tnw9Q+QZb5TuxRQJ77y8CWyXDHwFDlpf6Z
         hqSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=da10G3UmxKY1sOpQGZA/k2Utzz3wOV8wVJe9TJzAXVY=;
        b=1HGomm94gjl9vsRxlKkJFUprGU+R9prvzHJ8uYHtMmdtrCK+SaVWHEUm+Z19MvbIdh
         0+XXZ+T4gJHilBTF6FWI28O8m8HMOpGA22P+QTiPH7ASZJLhjU7fveX1315cN5ER1JsJ
         IuAcen0Z1o4Difyq3/cR7gAoPN3t213ZyDnNF4o5g/8af4JdhQ8qtBw1WkT6Wn7XVmHE
         nP9djye7aHVWiu76CVyYU9YQ8T9XdgnSDeagVt/azStiuPq4i0H4PJHo9BedcGfwbdlh
         1CdBGU0MJYvEBw/wuCgNS2CrhSUh/AKD90IOX3eXGodFRsG1i0WJAtiLGsLV2Gi0jWpn
         L5hQ==
X-Gm-Message-State: AFqh2krjWF0aEbhq3rRwP5CsWtWBMGdodpH9pcxTEvzZWZKC1/uswBgD
        SyRmtPGzKVtZEq+uSbpx6me+6Q==
X-Google-Smtp-Source: AMrXdXu7aCpLhDm4tVtPRj9/+0rOw4/1fINTlypLBXTTrVwLtIA8dvcsUoa/l7qsob4sQ4Q8sog+Mg==
X-Received: by 2002:a5d:6508:0:b0:2b7:88d3:d224 with SMTP id x8-20020a5d6508000000b002b788d3d224mr2424755wru.55.1673008371049;
        Fri, 06 Jan 2023 04:32:51 -0800 (PST)
Received: from [192.168.1.102] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id bx9-20020a5d5b09000000b0023662245d3csm1065232wrb.95.2023.01.06.04.32.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jan 2023 04:32:50 -0800 (PST)
Message-ID: <b866e6e1-da10-9152-8bda-966015998877@linaro.org>
Date:   Fri, 6 Jan 2023 13:32:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/3] dt-bindings: pinctrl: msm8226: Add General Purpose
 clocks
Content-Language: en-US
To:     =?UTF-8?Q?Matti_Lehtim=c3=a4ki?= <matti.lehtimaki@gmail.com>,
        linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230106114403.275865-1-matti.lehtimaki@gmail.com>
 <20230106114403.275865-2-matti.lehtimaki@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230106114403.275865-2-matti.lehtimaki@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/01/2023 12:44, Matti Lehtimäki wrote:
> Document the general purpose clock functions that are found on MSM8226.
> 
> Signed-off-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
> ---
>  .../devicetree/bindings/pinctrl/qcom,msm8226-pinctrl.yaml     | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,msm8226-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,msm8226-pinctrl.yaml
> index 3b79f5be860b..6e3808065845 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,msm8226-pinctrl.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,msm8226-pinctrl.yaml
> @@ -66,8 +66,8 @@ $defs:
>          enum: [ gpio, cci_i2c0, blsp_uim1, blsp_uim2, blsp_uim3, blsp_uim5,
>                  blsp_i2c1, blsp_i2c2, blsp_i2c3, blsp_i2c4, blsp_i2c5, blsp_spi1,
>                  blsp_spi2, blsp_spi3, blsp_spi5, blsp_uart1, blsp_uart2,
> -                blsp_uart3, blsp_uart4, blsp_uart5, cam_mclk0, cam_mclk1, sdc3,
> -                wlan ]
> +                blsp_uart3, blsp_uart4, blsp_uart5, cam_mclk0, cam_mclk1,
> +                gp0_clk, gp1_clk, sdc3, wlan ]

Driver does not support them (and there is no driver change, unless you
cc-ed people selectively...).

Best regards,
Krzysztof

