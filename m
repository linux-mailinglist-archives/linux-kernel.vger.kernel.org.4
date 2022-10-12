Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A55C35FC2D2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 11:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbiJLJPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 05:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbiJLJP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 05:15:27 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE6A491E9;
        Wed, 12 Oct 2022 02:15:25 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29C8tfB7026001;
        Wed, 12 Oct 2022 11:15:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=WuRU+MntGnCMaXFzcXMNoaYrVG/2orVNcEHKCqBKaQg=;
 b=aw/8jJZgI81jBzPEP9vF3LPDs5aPjpEocaar0BEyHQIeBVJf3IwXqr8qU9eA4qNGhZD9
 E/nWHpM0HKAQu6GHR9oua6gbkxKEp8P8I2lo/AA8USiX4Xe+czS5yGGuVt7q+1ZN9Xwn
 ePM0vVGgCRcJnkLY7tg+T3VvVfJ414fl/qxlyr4ks3itHGgzRBBRHp9ywxuXepQEGey/
 T+Xyefm7Ygfu2fYejo3QmnJtKUFGrSTrb+yS8LMlEXZiWh/6XipB/p1YXMR2nZQJA0V8
 McEPwXYZZpTlLsru2vbghdKsFOAMtA36QFVBzB6m+JVbv9Mc4jx3/vva+CYVqy7dyBd1 uA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3k4hwf66qg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Oct 2022 11:15:11 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6AE25100034;
        Wed, 12 Oct 2022 11:15:04 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A10C32194EC;
        Wed, 12 Oct 2022 11:15:04 +0200 (CEST)
Received: from [10.201.22.54] (10.75.127.122) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.31; Wed, 12 Oct
 2022 11:15:01 +0200
Message-ID: <cce333f4-17db-f891-a9a2-97036c7d7332@foss.st.com>
Date:   Wed, 12 Oct 2022 11:15:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] ASoC: dt-bindings: Convert dmic-codec to DT schema
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        "Mark Brown" <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        <arnaud.pouliquen@foss.st.com>, Heiko Stuebner <heiko@sntech.de>
CC:     <devicetree@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>
References: <20221011184119.3754096-1-robh@kernel.org>
From:   Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
In-Reply-To: <20221011184119.3754096-1-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.122]
X-ClientProxiedBy: GPXDAG2NODE4.st.com (10.75.127.68) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-12_04,2022-10-11_02,2022-06-22_01
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 10/11/22 20:41, Rob Herring wrote:
> Convert the dmic-codec binding to DT schema format.
> 
> The '#sound-dai-cells' and 'sound-name-prefix' properties were not
> documented, but are in use, so add them.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/sound/dmic-codec.yaml | 55 +++++++++++++++++++
>  .../devicetree/bindings/sound/dmic.txt        | 22 --------
>  2 files changed, 55 insertions(+), 22 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/dmic-codec.yaml
>  delete mode 100644 Documentation/devicetree/bindings/sound/dmic.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/dmic-codec.yaml b/Documentation/devicetree/bindings/sound/dmic-codec.yaml
> new file mode 100644
> index 000000000000..767152fa99cc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/dmic-codec.yaml
> @@ -0,0 +1,55 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/dmic-codec.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Generic PDM Digital microphone (DMIC) codec
> +
> +maintainers:
> +  - Arnaud Pouliquen <arnaud.pouliquen@st.com>

I don't have much activity on the audio topic anymore, so I don't know if I'm
the best person.
But if one maintainer is needed, that's fine.
Please just change my email address to arnaud.pouliquen@foss.st.com
With that and the fix reported by the bot
Reviewed-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>

Thanks,
Arnaud

> +
> +allOf:
> +  - $ref: name-prefix.yaml#
> +
> +properties:
> +  compatible:
> +    const: dmic-codec
> +
> +  '#sound-dai-cells':
> +    const: 0
> +
> +  dmicen-gpios:
> +    description: GPIO specifier for DMIC to control start and stop
> +    maxItems: 1
> +
> +  num-channels:
> +    description: Number of microphones on this DAI
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 1
> +    maximum: 8
> +    default: 8
> +
> +  modeswitch-delay-ms:
> +    description: Delay (in ms) to complete DMIC mode switch
> +
> +  wakeup-delay-ms:
> +    description: Delay (in ms) after enabling the DMIC
> +
> +required:
> +  - compatible
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio.h>
> +
> +    dmic {
> +        compatible = "dmic-codec";
> +        dmicen-gpios = <&gpio4 3 GPIO_ACTIVE_HIGH>;
> +        num-channels = <1>;
> +        wakeup-delay-ms <50>;
> +        modeswitch-delay-ms <35>;
> +    };
> +...
> diff --git a/Documentation/devicetree/bindings/sound/dmic.txt b/Documentation/devicetree/bindings/sound/dmic.txt
> deleted file mode 100644
> index 32e871037269..000000000000
> --- a/Documentation/devicetree/bindings/sound/dmic.txt
> +++ /dev/null
> @@ -1,22 +0,0 @@
> -Device-Tree bindings for Digital microphone (DMIC) codec
> -
> -This device support generic PDM digital microphone.
> -
> -Required properties:
> -	- compatible: should be "dmic-codec".
> -
> -Optional properties:
> -	- dmicen-gpios: GPIO specifier for dmic to control start and stop
> -	- num-channels: Number of microphones on this DAI
> -	- wakeup-delay-ms: Delay (in ms) after enabling the DMIC
> -	- modeswitch-delay-ms: Delay (in ms) to complete DMIC mode switch
> -
> -Example node:
> -
> -	dmic_codec: dmic@0 {
> -		compatible = "dmic-codec";
> -		dmicen-gpios = <&gpio4 3 GPIO_ACTIVE_HIGH>;
> -		num-channels = <1>;
> -		wakeup-delay-ms <50>;
> -		modeswitch-delay-ms <35>;
> -	};
