Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5239F659759
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 11:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234720AbiL3KfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 05:35:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234667AbiL3Ke7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 05:34:59 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF5819C32
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 02:34:58 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id bn6so11864280ljb.13
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 02:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4gZZiGQ+xFONbkR4CIrEsTxT504WgQCnXV2mN31jYnM=;
        b=ZieVv/XajF8WcLke51z9UL9xLXnO6yPGYeZ1sAnknxajcy8CtxONvzg71hHfrWp1VF
         afe/qJvMx53OPPDBTLU+KBPdyZXvlC99rmPZR2vPt8e1gg1SE0Au+XN1LUtoSI+XcZOe
         TKBZQbK5tglBFbUT0Av8/WlLY3OWQctjym6STjgeUVvXtHQSYHHlrG1+TTiyejHLxyg+
         E0fAKenwqhoqV06lFIGt4kBVIs4UewJhQPSq8PgOYt/QQZrsPPyjLu0gID6xXCU62fPe
         gjriEDf99TKGTpSz9GcVP8qHRHhGxvQ3l1vAyIkkhbgxdua1T6SYhEz/jLqttY67XPiF
         KK3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4gZZiGQ+xFONbkR4CIrEsTxT504WgQCnXV2mN31jYnM=;
        b=2zYbC0Q/rtFtQ9JRdCsz8DYHuQxk01ojmOp6vscAuU6pxCLEa8eAPFEk14u/CJadxa
         ZqcdXCs702craa9N1pmaVkDLBeF0yPgLq1RTnxWG1RL0Uzfxdvmi+8/71/AG0mAtSlKT
         +OS4pDLOic2gy1g7FM9ZcHPNTtGbem5CjYXOin0/1JVUxJiOHO8X2DdfydCU9D+Ib79n
         KbKV4jB+MLBVFnYMOgXMkBFuZglboT4zgD9qOexppGfpFe8u0CID9ZvkkaW5WXR4wCk+
         643pYKW/1r23Odx92p1ASwX8PRC8oJGDE7i2JnmJBu9+obdFjxwd3lqrxvYwoeQdJfP6
         DpXw==
X-Gm-Message-State: AFqh2kr0PtJNNumhMs98v7uoV9MBPZlzBXpwDW9wEwN9ecb8RQ/yXRdo
        2Z2nifcQ4PX0Nx14ZQDp6rp8qQ==
X-Google-Smtp-Source: AMrXdXvzF8oYbHVC+IVUBfdVwMBkjkv7OIATsoaATU44WqsdaR+oea3Fo0kgBAOv9WJknPjgOyGm0Q==
X-Received: by 2002:a2e:553:0:b0:27e:521c:92c8 with SMTP id 80-20020a2e0553000000b0027e521c92c8mr9407978ljf.7.1672396496325;
        Fri, 30 Dec 2022 02:34:56 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id q18-20020a2eb4b2000000b0027713ef5360sm2579821ljm.71.2022.12.30.02.34.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Dec 2022 02:34:55 -0800 (PST)
Message-ID: <aa0de3c8-d783-f8cc-42a9-7988acd6ab87@linaro.org>
Date:   Fri, 30 Dec 2022 11:34:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH V8 5/5] ASoC: dt-bindings: Add schema for "awinic,aw883xx"
To:     wangweidong.a@awinic.com, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        perex@perex.cz, tiwai@suse.com, ckeepax@opensource.cirrus.com,
        rf@opensource.cirrus.com, povik+lin@cutebit.org,
        pierre-louis.bossart@linux.intel.com, james.schulman@cirrus.com,
        flatmax@flatmax.com, cezary.rojewski@intel.com,
        srinivas.kandagatla@linaro.org, tanureal@opensource.cirrus.com,
        steve@sk2.org, stephan@gerhold.net, zhuning0077@gmail.com,
        shumingf@realtek.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     zhaolei@awinic.com, liweilei@awinic.com, yijiangtao@awinic.com,
        duanyibo@awinic.com
References: <20221230093454.190579-1-wangweidong.a@awinic.com>
 <20221230093454.190579-6-wangweidong.a@awinic.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221230093454.190579-6-wangweidong.a@awinic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/12/2022 10:34, wangweidong.a@awinic.com wrote:
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
> index 000000000000..b677427ebcd1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/awinic,aw883xx.yaml
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
> +  - Stephan Weidong Wang <wangweidong.a@awinic.com>
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
> +    const: awinic,aw883xx

Now the question what does "xx" stand for? I cannot find such product on
awinic website:
https://www.awinic.com/En/Index/queryAll/wd/aw883xx.html

> +
> +  reg:
> +    maxItems: 1
> +
> +  reset-gpios:
> +    maxItems: 1
> +

Why there is no sound-dai-cells?


> +  sound-name-prefix: true

Drop it.

> +
> +required:
> +  - compatible
> +  - reg
> +  - reset-gpios
> +
> +additionalProperties: false

Instead:
unevaluatedProperties: false

unless this is not a codec and sound-dai-cells cannot be used?

> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        audio-codec@34 {
> +            compatible = "awinic,aw883xx";
> +            reg = <0x34>;
> +            reset-gpios = <&gpio 10 GPIO_ACTIVE_LOW>;

Does not look like you tested the bindings. Please run `make
dt_binding_check` (see
Documentation/devicetree/bindings/writing-schema.rst for instructions).

Best regards,
Krzysztof

