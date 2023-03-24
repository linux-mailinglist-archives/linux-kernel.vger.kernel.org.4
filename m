Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1860E6C7D44
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 12:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbjCXLgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 07:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjCXLgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 07:36:53 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C731D90B
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 04:36:51 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id t10so6648240edd.12
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 04:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679657810;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vlkMAwkSL6A+6l6qhyo9+I+btfsSVV+jS0eHZv1Cz/4=;
        b=hmJq3ncfz9zmAyQlRRCODWQq2YRZTe4STlK+rTkj4KcWTlJJXIMOdQUmKLUfJGSvBY
         95//pT1vXhXjch/H4B2NfkMcZMwjhBHPY1hnC5sSJtwgEOl9YHV1EcLoZlUxLYjfxY2q
         /Rw23+XrtJZIRGCYUcuoi7r9xMHOb6hRZ+DWfTvwZBRm6btkbfLHOOVtFjtQdnjWmdNv
         iKGTrF2iOdWhZgXzBHMok4rKqvsszdLusl05KRAwx9gyQ5FA5nHZ8QYDI/gg7WH+n6br
         6TFjnIWR+3TpXQNRjQv9gMQsq4jQf5Sys/ZYEDJ31obzKBmaj+CuZsWdZ3lk7Nyrv9Vi
         fsBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679657810;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vlkMAwkSL6A+6l6qhyo9+I+btfsSVV+jS0eHZv1Cz/4=;
        b=oQVnweOjiw+f3g2oyLwp9DLbkvb4JOSk0FlzfK1K7+B8SgAQCyT0G5L3koVIfq8Zho
         Afa3FUHAUcKz8tF/AJwxtKpNFIMCA6PJKjDSulowsvJJCr1PAyd6nekdZ3rqrQfOgAws
         uKXlGGjaI85nW4UYW+xhToTmFBXiWvWXJWExog4YcGfZ6u37C5QLC/mRVoj7jSq3wJLa
         XFG+I5Ja91L4ivP0Tu1Bdxzo5z3Et1J92CPyRMzRhz1jO0bY165H9eIoMZzLzHFzOLwW
         Nxl5OnwaRhdjXXa20JH16hIQN9W+TJhy2BCNiwDcLpgAiUQ1ylPMpxRS4YLNxM7eOPpY
         P9cA==
X-Gm-Message-State: AO0yUKUWCjheLeAuAF2klf0LER4ttK7lsEROFRpcOSaTWrQaq1+Z2xF9
        UjorG2Bi25M96RVIOnd8ksitIQ==
X-Google-Smtp-Source: AK7set8JifsJoxUHo/xqsd+naerD1nr5pkzdEbY1ebVhB0Uat3D1Hfe+F+ZknhKDRxIvYIT5MrNL/A==
X-Received: by 2002:a05:6402:1748:b0:4fb:223a:76e7 with SMTP id v8-20020a056402174800b004fb223a76e7mr8892025edx.18.1679657810234;
        Fri, 24 Mar 2023 04:36:50 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:3027:fb0b:ae08:588? ([2a02:810d:15c0:828:3027:fb0b:ae08:588])
        by smtp.gmail.com with ESMTPSA id m10-20020a50998a000000b004e48f8df7e2sm10688391edb.72.2023.03.24.04.36.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Mar 2023 04:36:49 -0700 (PDT)
Message-ID: <cbfbbfeb-8ce9-3908-9a61-58b7daa4e7d9@linaro.org>
Date:   Fri, 24 Mar 2023 12:36:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH V3 2/2] ASoC: dt-bindings: max98363: add soundwire
 amplifier
Content-Language: en-US
To:     =?UTF-8?B?4oCcUnlhbg==?= <ryan.lee.analog@gmail.com>,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, rf@opensource.cirrus.com,
        ckeepax@opensource.cirrus.com,
        pierre-louis.bossart@linux.intel.com, herve.codina@bootlin.com,
        wangweidong.a@awinic.com, james.schulman@cirrus.com,
        ajye_huang@compal.corp-partner.google.com, shumingf@realtek.com,
        povik+lin@cutebit.org, flatmax@flatmax.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        ryans.lee@analog.com
References: <20230323175256.2606939-1-ryan.lee.analog@gmail.com>
 <20230323175256.2606939-2-ryan.lee.analog@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230323175256.2606939-2-ryan.lee.analog@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/03/2023 18:52, “Ryan wrote:
> From: Ryan Lee <ryans.lee@analog.com>
> 
> This patch adds dt-bindings information for Analog Devices MAX98363
> SoundWire Amplifier.

No improvements here. So reminding:

Do not use "This commit/patch", but imperative mood. See:
https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95

> 
> Signed-off-by: Ryan Lee <ryans.lee@analog.com>
> ---
> Changes from v1:
>   Fixed a syntax error for the 'dt_binding_check' build.
>   Removed unnecessary properties.
>   Added description about SoundWire device ID of MAX98363
> Changes from v2:
>   Removed the legacy from i2c/i2s driver and added SoundWire device ID info.
>   Added missing information about DAI.
> 
>  .../bindings/sound/adi,max98363.yaml          | 62 +++++++++++++++++++
>  1 file changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/adi,max98363.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/adi,max98363.yaml b/Documentation/devicetree/bindings/sound/adi,max98363.yaml
> new file mode 100644
> index 000000000000..92352a23e1cb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/adi,max98363.yaml
> @@ -0,0 +1,62 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/adi,max98363.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices MAX98363 SoundWire Amplifier
> +
> +maintainers:
> +  - Ryan Lee <ryans.lee@analog.com>
> +
> +description:
> +  The MAX98363 is a SoundWire input Class D mono amplifier that
> +  supports MIPI SoundWire v1.2-compatible digital interface for
> +  audio and control data.
> +  SoundWire peripheral device ID of MAX98363 is 0x3X019F836300

lowercase hex

> +  where X is the peripheral device unique ID decoded from pin.
> +  It supports up to 10 peripheral devices(0x0 to 0x9).
> +
> +allOf:
> +  - $ref: dai-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: sdw3019F836300

lowercase hex (also in example)

> +
> +  reg:
> +    maxItems: 1
> +
> +  '#sound-dai-cells':
> +    const: 0
> +
> +  sound-name-prefix: true

Drop this.

> +
> +required:
> +  - compatible
> +  - reg
> +  - "#sound-dai-cells"
> +
> +additionalProperties: false

Instead:
unevaluatedProperties: false

Best regards,
Krzysztof

