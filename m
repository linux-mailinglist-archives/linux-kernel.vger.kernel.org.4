Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83C85616D52
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 20:01:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbiKBTB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 15:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231663AbiKBTBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 15:01:16 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68AA922C
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 12:01:14 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id g10so5859761qkl.6
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 12:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sVOm0gkttgsBAWPoT64yXGgGPw+pzS3zQxWBnd3fbbM=;
        b=i/HQi3+YSYC4jl29Z8UKo0eGiXSyRDdGn4mkSvN62YT4Kv6F+iAA5WlbkShic6K7Ge
         dpfcxIaQTgRrZWIyS0J60QvBV+WO9zPMfIl+beTkO3MBAJ9Sfu2qHgIkCc9rrVSOfNB4
         wJ7PHYjlTi2SG6BrbqfSTnRlqwRYx8VgYcEEmoS6mZ6lNRElq9RYyY9T/LQkMEuQm2hY
         QY/Fw0Mo0DdH3usOMcc0KfEwcjxiEnOhYSrfq7oo5GnqsWdJ/kWV9f8wPW8JXHnfljXy
         3rwpmi2qMBH50/rjntk4qkn2aww2sKw6FRjXQcLURrNfKwDXr3NWDJxXHX7ahRdMEFMc
         SG6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sVOm0gkttgsBAWPoT64yXGgGPw+pzS3zQxWBnd3fbbM=;
        b=DyWach67hxFaHcR/YEFMb4vqp+3brVXqFyxrMMusNqciGjiEDo96SBpw8kqE0QU5tR
         ZZpnAuCR2EmHGP9hgW+c1fp8GibVPzsAlDPMmzszldJQVfh8DMrVB2zjwt4A7PC+DF+9
         dcNFjfCDiAx9q6kha3vuoz66M5X4GpBOixojd6BWNSX/gLRb8b2nNWnqY4g4ujvvckE9
         glYqMJeB7pliSpZKTXj+hyNH931XyrHJ9Y/lU7q+F1p2ArhgrNOgbEQC9qadm/kuspMY
         j6R/Wgr3zRlED58KQ8s+2Vwv/TB0u9t/TiFh/09+eWyRDA7MlnHSpCg8/4TwBqOGF2p6
         P9kA==
X-Gm-Message-State: ACrzQf1yZXco6np9T6/5PzZcwbCg5kXe/Wd7ebZTXolBvvq7CVuNvquX
        KsVft3oJWrjwpestq/jZuNJv0g==
X-Google-Smtp-Source: AMsMyM5G/bzcAiZVcMOSMNvjC2XSgKcFvvH+T7uTTncVFc0P+4YkvEk+N6yFwcrX6orIRxb2K63QhQ==
X-Received: by 2002:ae9:d806:0:b0:6f1:15cc:d870 with SMTP id u6-20020ae9d806000000b006f115ccd870mr18717294qkf.114.1667415673550;
        Wed, 02 Nov 2022 12:01:13 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:28d9:4790:bc16:cc93? ([2601:586:5000:570:28d9:4790:bc16:cc93])
        by smtp.gmail.com with ESMTPSA id de36-20020a05620a372400b006ce9e880c6fsm8844655qkb.111.2022.11.02.12.01.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 12:01:12 -0700 (PDT)
Message-ID: <91ebdf1b-d6e2-47a2-ae1c-bc1848bb74c2@linaro.org>
Date:   Wed, 2 Nov 2022 15:01:11 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH V2 1/2] dt-bindings: remoteproc: imx_rproc: add
 fsl,startup-delay-ms
Content-Language: en-US
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, andersson@kernel.org,
        mathieu.poirier@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
References: <20221102112451.128110-1-peng.fan@oss.nxp.com>
 <20221102112451.128110-2-peng.fan@oss.nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221102112451.128110-2-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/11/2022 07:24, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> add fsl,startup-delay-ms property indicating delay some time after just
> kicks remote processor.

Start sentences with capital letter.

> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../devicetree/bindings/remoteproc/fsl,imx-rproc.yaml         | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
> index ad3b8d4ccd91..d99d3342ad52 100644
> --- a/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
> @@ -76,6 +76,10 @@ properties:
>        This property is to specify the resource id of the remote processor in SoC
>        which supports SCFW
>  
> +  fsl,startup-delay-ms:
> +    $ref: "/schemas/types.yaml#/definitions/uint32"

Drop quotes.

> +    description: Startup time that remote processor ready for communication

Looks quite hacky...

Best regards,
Krzysztof

