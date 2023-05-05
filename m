Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 301C96F7D8F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 09:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbjEEHN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 03:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbjEEHNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 03:13:25 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC2B14E7A
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 00:13:23 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-94f1d0d2e03so221613166b.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 00:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683270802; x=1685862802;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LjPti0SVf6hmj4N0H313/55MiUrWdpZNvzPtpM8uR3Y=;
        b=KSRYsw+W1lrvQqIyAomaDqVEM8xAGeLseIR/4uBsLmebPEyJUBuQBwvCTXEzpOMq9u
         AFiPu0uEzbyPyzn/5fKp3RBeQMnx7feR/ep6QzWHp/2GN2vv3/We/tZUk1tgEgcKNSIp
         mXSsfR6GbTtiv2QRS62IWB/gi0a//k2zL+Cdpz66A6DgxenD1aLu3730CP0th8T9h9D+
         6oOFUvslt6PzDG8AIJ9JtBmzRGaXUmxuf0JRYaj7trhS36t9EBUtFLHhzruYWePdnZyv
         fEXX4eXaza5nVCYWycGrLxXoIt9a+fmY08OiLyJNT1E0gcmJfkZSunZD/TsWGrmAh2/I
         Sccw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683270802; x=1685862802;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LjPti0SVf6hmj4N0H313/55MiUrWdpZNvzPtpM8uR3Y=;
        b=MPrl49snYtU2d2XzzQ1dw2Xt+S2DSeQ6qHu+WEfzqY3uR6oS43++R6EjLWydf3JTD8
         ey/37eibxpLBhGPvcrgI003sFPHT7hsiU+N/w6tefp+DVyAQJaRmpuomXzL3xt8H4hft
         ngNXZBRzN1y0r3brsAcQOaSWOUpi8CFEWAI4vH7xVvlVknSJWlcd3NiY9osqvFgN/E5B
         Oe8IoMt4im4kbkxrl0RuXN2AeJjbQSOU+XuCalNTwHdEOPKlJzj/D2LDfl4TZct9iCQz
         sZDGuWOZ9PLY137r5OibfsgX58hkVQr2O/OgRLHLHmmbhDWOuk/ELR5TRiTLBwDlbrQ2
         iYfA==
X-Gm-Message-State: AC+VfDxVCggs2EsZISS1/0hM/Twq0c2cj44fsgQ6hjgFZw/pMpds9o4D
        tAknb0gqTx65DV6fOqAH9iKRmw==
X-Google-Smtp-Source: ACHHUZ51C0pF2OmSh3ZV19RMD0Jz6GfDImw2bVfTjB/4HVx9UvCSzaKvElz8ivKA9nmTvCyMTvu8Tg==
X-Received: by 2002:a17:907:98e:b0:94a:5c6d:3207 with SMTP id bf14-20020a170907098e00b0094a5c6d3207mr320366ejc.44.1683270802121;
        Fri, 05 May 2023 00:13:22 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:52e:24ce:bbc1:127d? ([2a02:810d:15c0:828:52e:24ce:bbc1:127d])
        by smtp.gmail.com with ESMTPSA id n22-20020a170906b31600b00965e9a23f2bsm205645ejz.134.2023.05.05.00.13.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 00:13:21 -0700 (PDT)
Message-ID: <66d344b2-899b-3d00-2d8f-5dd86f0af985@linaro.org>
Date:   Fri, 5 May 2023 09:13:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2 1/4] dt-bindings: remoteproc: st,stm32-rproc: Rework
 reset declarations
Content-Language: en-US
To:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230504094641.870378-1-arnaud.pouliquen@foss.st.com>
 <20230504094641.870378-2-arnaud.pouliquen@foss.st.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230504094641.870378-2-arnaud.pouliquen@foss.st.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/2023 11:46, Arnaud Pouliquen wrote:
> With the introduction of the SCMI (System Control and Management
> Interface), it is now possible to use the SCMI to handle the
> hold boot instead of a dedicated SMC call.



>  additionalProperties: false
>  
>  examples:
>    - |
>      #include <dt-bindings/reset/stm32mp1-resets.h>
> -    m4_rproc: m4@10000000 {
> +    m4_rproc_example1: m4@10000000 {

Just drop the label. It's not used.


>        compatible = "st,stm32mp1-m4";
>        reg = <0x10000000 0x40000>,
>              <0x30000000 0x40000>,
>              <0x38000000 0x10000>;
>        resets = <&rcc MCU_R>;
> +      reset-names = "mcu_rst";
>        st,syscfg-holdboot = <&rcc 0x10C 0x1>;
> -      st,syscfg-tz = <&rcc 0x000 0x1>;
> +      st,syscfg-rsc-tbl = <&tamp 0x144 0xFFFFFFFF>;
> +      st,syscfg-m4-state = <&tamp 0x148 0xFFFFFFFF>;
> +    };
> +  - |
> +    #include <dt-bindings/reset/stm32mp1-resets.h>
> +    m4_rproc_example2: m4@10000000 {

Also here.


Best regards,
Krzysztof

