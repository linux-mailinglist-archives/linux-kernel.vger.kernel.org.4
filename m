Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF90D5EE2E2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 19:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234546AbiI1RRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 13:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234681AbiI1RQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 13:16:37 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1819DEEB64
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 10:15:56 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id d42so21460513lfv.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 10:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=yvPLxoKxASU1oV0ydqT/WaUJJZ+f2nyTFfImwwyybhM=;
        b=gZyEjk+n32pMC2gI++dHQxgG17ROlFc/Rvb3c+K/AU/nl1uoFy1H+qW8pkv5UpGjat
         yRPMAize2tCACO120SCUKuMSbs91+q47z684UJUN+g7du2TnFk9W/GJrlxKFg5i7gavZ
         qiIrM2WqXYGW4dJhFlcDFKrOzX1DyoV3Auae5yQUg+F/gYwv5bgnxnjCn5WEk4O595Wo
         ft6MEtg6k0x2ScwiLtw269gdKeVxZkYWxChZnCKuP7JVU+lNz7gZD5zFdPP6oXMSguDb
         uNsqKomugM/GpErZEuvJnUIKZWjI7md5ngpT9GaGkzSlZ/t1qSRNoOtOxejjFG3uo1Sj
         Zv8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=yvPLxoKxASU1oV0ydqT/WaUJJZ+f2nyTFfImwwyybhM=;
        b=b5mDCvOw+qyUkOvOoWfSanfruWfEwY13OMAnx3//V+1RGyfRrucANSgamdeDuFRiZk
         IwxW4x9+y5mb1f0L06mjEzqHsCTdRtIOiq1NzazYg0KoMSvHqSuQl5/x6G2cEtEuN6Uq
         AYsptnL7jbrmgCr+GH6yvVzMaB686d3pAAw8xSbB5y8dhh4NikYTjMeF9LOlGCQZxH89
         526PnfbtJELnQuZr72NrbneIIWbE8DxZbWvzMbNF12hkUKv6Rl+VuANyZ1VTiNK86yW9
         VfYGTr+CwR0Jl4LP/oJ/5xV6zDQjR656EhZbuH9eajH10aTehJFr1OPtCHh/E8C0CkRt
         RqCw==
X-Gm-Message-State: ACrzQf28jRiMcKF65L7n57s2FyFYKjVhW5ZF8xym/H0spwBr2rLJS4bR
        p7pAgIIO+2Yf8TdKa0++Brht7g==
X-Google-Smtp-Source: AMsMyM6CMlioEhHvKg/S6bggNWBpvr4jWCPRIj3BoalVJONNliyV8cxuDdIf4DcvQdjpOTg7fZti5g==
X-Received: by 2002:a05:6512:401f:b0:49e:ea65:cd49 with SMTP id br31-20020a056512401f00b0049eea65cd49mr13368705lfb.419.1664385353790;
        Wed, 28 Sep 2022 10:15:53 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id q6-20020a2eb4a6000000b00264b292232asm476672ljm.63.2022.09.28.10.15.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 10:15:52 -0700 (PDT)
Message-ID: <ef396764-af53-8e5a-5203-f3e103bbb7a3@linaro.org>
Date:   Wed, 28 Sep 2022 19:15:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCHv4 1/3] dt-bindings: mmc: synopsys-dw-mshc: document
 "altr,sysmgr-syscon"
Content-Language: en-US
To:     Dinh Nguyen <dinguyen@kernel.org>, jh80.chung@samsung.com
Cc:     ulf.hansson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220928165420.1212284-1-dinguyen@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220928165420.1212284-1-dinguyen@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/09/2022 18:54, Dinh Nguyen wrote:
> Document the optional "altr,sysmgr-syscon" binding that is used to
> access the System Manager register that controls the SDMMC clock
> phase.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> ---

Thank you for your patch. There is something to discuss/improve.

> +
> +allOf:
> +  - $ref: "synopsys-dw-mshc-common.yaml#"
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const:
> +              - altr,socfpga-dw-mshc

It still should not be an array, even if there is no warning.

> +    then:
> +      required:
> +        - altr,sysmgr-syscon
> +    else:
> +      properties:
> +        altr,sysmgr-syscon: false

Best regards,
Krzysztof

