Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 837DB73813A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbjFUK0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 06:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232209AbjFUK00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 06:26:26 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A81419BD
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 03:26:23 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-978863fb00fso885118966b.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 03:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687343181; x=1689935181;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dcl/mkU9nXIhvMdXPVz6mSenFfwzfIPrN42NIXl5kI4=;
        b=mU6ZIIUtRa/sdiidVkimjlwvSwTuPqtoC7WcpCVShqzlRohQhACtesKUVq7WQMvzf3
         V8ghhupL8eNUrafY5IdtezWrAL3RBENeyY3avIF9kk6Wp6xBEAe1TYmMK5KHlrbvDCpY
         oIiz31p8n8EornPTuQAXENoFe5OwZ8GaMq3CsFp+ZF19ND25JdlxEcpIcqYg5sS0R9Oy
         15N8ZmBVLZQWSpnM0u/z77XCQc+29AHKoL1C9j1mIbxf5BJh6+KC0I2fZ3bKAvYoNjP7
         HeFAtrWRI1nfsbH4yRXZ0Uy/38JF4Nmz8dCVReR3hrrN3XOvFWE1By3YGpagpOTNCMDR
         0stA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687343181; x=1689935181;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dcl/mkU9nXIhvMdXPVz6mSenFfwzfIPrN42NIXl5kI4=;
        b=J6VpZ3Puxb47tIlBgE3UhZNAJJnPGmfuzuhvybf0V3yVwWhKq/MOQiZx0zYt8UF8HO
         0cJdXqvwUhZVST94Kq2n5Afa8vnmZzYxiOhyqw2X/IGFhHzlXPVgk5RoHmCgxzrj+BQY
         ccKp6PnJvi+A+u5Q+tQ4xaREH9cUjdZh3gk8u4JEuMU70BEibY4K18m3UuPoioby+YI+
         PDtGwQ7md1bqvR1XbPH453NqFb7cT9QQPiAYRF1vWvT9XlJRTrDMrzT3ncb3dso5RrtE
         6rcGtJXl4zVyQSAdGsV06iX8RJunPTQvHOoWjJctrBCvWVF0JcwUeNY7oQkzS6bXMF4U
         E5rQ==
X-Gm-Message-State: AC+VfDwjb6Nm895X+YtoUeMzLmm+vXZ4opQvV0xryFEeY7SI4+oe5COO
        rrn+t5EtbG0NjlEaGlrXpg9xHg==
X-Google-Smtp-Source: ACHHUZ690EzI8mAWGFm9FGAZap8ahsbyAMf9kbLN7HZZoYoMnF8SIStoZXztypCmbxhPKpCUyxqd/A==
X-Received: by 2002:a17:906:4793:b0:965:ff38:2fbb with SMTP id cw19-20020a170906479300b00965ff382fbbmr14974192ejc.1.1687343181722;
        Wed, 21 Jun 2023 03:26:21 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id t13-20020a170906a10d00b009745b0cb326sm2913093ejy.109.2023.06.21.03.26.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jun 2023 03:26:21 -0700 (PDT)
Message-ID: <3d4fdc26-4fd5-9900-68b5-7476996839b5@linaro.org>
Date:   Wed, 21 Jun 2023 12:26:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 1/6] dt-bindings: can: tcan4x5x: Add tcan4552 and
 tcan4553 variants
Content-Language: en-US
To:     Markus Schneider-Pargmann <msp@baylibre.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Michal Kubiak <michal.kubiak@intel.com>,
        Vivek Yadav <vivek.2311@samsung.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Simon Horman <simon.horman@corigine.com>
References: <20230621093103.3134655-1-msp@baylibre.com>
 <20230621093103.3134655-2-msp@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230621093103.3134655-2-msp@baylibre.com>
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

On 21/06/2023 11:30, Markus Schneider-Pargmann wrote:
> These two new chips do not have state or wake pins.
> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> ---
>  .../devicetree/bindings/net/can/tcan4x5x.txt          | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/can/tcan4x5x.txt b/Documentation/devicetree/bindings/net/can/tcan4x5x.txt
> index e3501bfa22e9..170e23f0610d 100644
> --- a/Documentation/devicetree/bindings/net/can/tcan4x5x.txt
> +++ b/Documentation/devicetree/bindings/net/can/tcan4x5x.txt
> @@ -4,7 +4,10 @@ Texas Instruments TCAN4x5x CAN Controller
>  This file provides device node information for the TCAN4x5x interface contains.
>  
>  Required properties:
> -	- compatible: "ti,tcan4x5x"
> +	- compatible:
> +		"ti,tcan4552", "ti,tcan4x5x"
> +		"ti,tcan4553", "ti,tcan4x5x" or
> +		"ti,tcan4x5x"

One more example why wildcards are not allowed. Ehh,


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

