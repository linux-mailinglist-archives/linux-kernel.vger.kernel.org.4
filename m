Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D04B65412D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 13:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235572AbiLVMlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 07:41:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiLVMlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 07:41:47 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB4B22BD3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 04:41:45 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id x11so1762408ljh.7
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 04:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0RC77huOuZ1tL4G8TsG8hVc4JWG5AumcDRtuYq9SLKc=;
        b=E7YDzpOwi6G6CgOH+oI5odto7tZlUB+aKr5uh5nxFX5mSEYqom+cJvHx6y5XQTOs2F
         DFgoASkAQbIHRd33qAk5J7VYNKnjq8XNTbPN9BFNVO+q51I3jKXRyycsMqNqEL5klQWz
         uxMc8Rud2W/YEuc1ddqTboYD/4WjMsPIXdd+agHxWg9HFl0bgKi/1lKK+6VtK7+2LHsn
         71iAM2dqzISnZRa1x/ezCuJuzGW2uVYkrfVolzBj1gBdyxaxWZ4Gb6OeWLkpFEXeLkDU
         boqScC+FcDFJ5nTn1w1ap6IIJp/v1HMmKE9GQsPfIHwSBmrPCpmgZ/2hc+MCjfd4trKV
         GtLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0RC77huOuZ1tL4G8TsG8hVc4JWG5AumcDRtuYq9SLKc=;
        b=DyPTRc0ZrpC9+yyGfH+6tIDpgI7af55hjyajxRf5nqpvk1n9ItLzdrqquhRjuJsQ/j
         8jT3dVSFK4PEgHSXFiVlrw80xq7sZXJy0itqK7wjcBHA55SusYbfldDPxkREiSoExeY5
         6ZG/CPn/PpePQ1UYNjbbD9RL2+M+jlmx+9dAN5+j7yNFYmIlP2pJDT/NmUsbIVNAqz8g
         aYxG+33DTQiDf+Po4GCrR4CSwHUiXFJcsB4DbHSaskXZwkpg61iHi4/AFox3o3fzZ+SU
         kNzxLZkN+cAaTk+1vdDkXQP21lRml/YADGjydJdeTODmEh05NwvFPcC2b75myolvkl54
         nSpA==
X-Gm-Message-State: AFqh2koIq6k+vxN+dAEP+wDyEmGVONweq35iXcSUqVfrNIGPfW18Tr8C
        nd1W245WhxrIbF4Ze51uUifwww==
X-Google-Smtp-Source: AMrXdXsvXowNhJXCaGGsO8mKuYF+/MQWHP2HfUgvhMuGS+EhnuwqM/q9CQssShr902wvC5qi9gT5Kw==
X-Received: by 2002:a2e:8005:0:b0:27a:2e09:c5be with SMTP id j5-20020a2e8005000000b0027a2e09c5bemr1395091ljg.16.1671712903511;
        Thu, 22 Dec 2022 04:41:43 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id k7-20020a05651239c700b004b5766f48d8sm61833lfu.19.2022.12.22.04.41.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Dec 2022 04:41:42 -0800 (PST)
Message-ID: <bb05ad5b-6109-a618-0f98-6fe267de8b0b@linaro.org>
Date:   Thu, 22 Dec 2022 13:41:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH V7 5/5] ASoC: dt-bindings: Add schema for "awinic,aw883xx"
Content-Language: en-US
To:     wangweidong.a@awinic.com, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        perex@perex.cz, tiwai@suse.com, ckeepax@opensource.cirrus.com,
        rf@opensource.cirrus.com, peter.ujfalusi@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, james.schulman@cirrus.com,
        flatmax@flatmax.com, ryan.lee.analog@gmail.com,
        jonathan.albrieux@gmail.com, tanureal@opensource.cirrus.com,
        povik+lin@cutebit.org, 13691752556@139.com,
        cezary.rojewski@intel.com, stephan@gerhold.net,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     liweilei@awinic.com, zhaolei@awinic.com, yijiangtao@awinic.com,
        zhangjianming@awinic.com, duanyibo@awinic.com
References: <20221222123431.106425-1-wangweidong.a@awinic.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221222123431.106425-1-wangweidong.a@awinic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/12/2022 13:34, wangweidong.a@awinic.com wrote:
> From: Weidong Wang <wangweidong.a@awinic.com>
> 
> Add a DT schema for describing Awinic AW883xx audio amplifiers. They are
> controlled using I2C.
> 
> Signed-off-by: Weidong Wang <wangweidong.a@awinic.com>
> ---
>  .../bindings/sound/awinic,aw883xx.yaml        | 49 +++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/awinic,aw883xx.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/awinic,aw883xx.yaml b/Documentation/devicetree/bindings/sound/awinic,aw883xx.yaml
> new file mode 100644
> index 000000000000..af4e0e27f8f7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/awinic,aw883xx.yaml

Filename matching the compatible.

> @@ -0,0 +1,49 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/awinic,aw883xx.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Awinic AW883xx Smart Audio Amplifier
> +
> +maintainers:
> +  - Stephan Gerhold <stephan@gerhold.net>
> +
> +description:
> +  The Awinic AW883XX is an I2S/TDM input, high efficiency
> +  digital Smart K audio amplifier with an integrated 10.25V
> +  smart boost convert.
> +
> +allOf:
> +  - $ref: dai-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: awinic,aw883xx_smartpa

This is a friendly reminder during the review process.

It seems my previous comments were not fully addressed. Maybe my
feedback got lost between the quotes, maybe you just forgot to apply it.
Please go back to the previous discussion and either implement all
requested changes or keep discussing them.

Thank you.

Best regards,
Krzysztof

