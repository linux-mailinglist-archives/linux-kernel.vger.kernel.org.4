Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3F36C1BD6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 17:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbjCTQgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 12:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232395AbjCTQgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 12:36:12 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C665591
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 09:29:50 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id r11so49056656edd.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 09:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679329788;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ljDW1DCJeBc6T6NBPVNN8pyn9ol9qgM9RQwkASNKOA8=;
        b=gCXyekbQrdNhVu7FjywwAzLyawMTDALwaQ/dDmZXzYtkMwbHJvDTxmczvCTQoRVGgp
         4IBMZyligdURAXS6baYzLqGCpWk5ru0wa3ly/Hne9EQamNDeSw9SGo2VvCv5U4O3N0Oy
         Z5u6266V/r9eexPhQz/kq8OMYKS/G8+bD+0Rym9NQyA3+NVkC9Qv8ICFDBbtP4j31RNT
         a89cIPodE3qCumLzz1yqGXS7TVgG71LVqCUTInjo13nCxp6JYYDx/GSMUWZqujPOU2zm
         HGVOqe+6eCshuslVEnlgGsP0ldDmZ6oVV1DCL9FPpT0vqJcbZAQn8aBndg0xmQN3gpVB
         xBZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679329788;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ljDW1DCJeBc6T6NBPVNN8pyn9ol9qgM9RQwkASNKOA8=;
        b=Ggjprp+FGWYjOsOiNDyuRUHHd1K1mEa7eL31mYxZd5WUb0zYoycBlNu6wv1DOIDqL/
         6DpgH4jc/1kmWuc1VgzN8qVSfADSeQ591zN6gzJWmh2faUxoS4X47sagWKhv27ORFZzP
         04hT2Yk93S+3pvwG3Gzi+2r7CohP0W3svYjijONZ2XtkasNlnGWjdHN4qEoObc/cPR24
         6IhuFnEOVWwrDIZGglXu48HKyrlbAUUQoZxKsdtbscae5Ub1o/omUyjjaoKJVF+0/NVX
         wF9SPXbF/2TGaRYwBV2hdfpzM5QNBcp1qGJXCbFn1LAvi33t3UN0oKOpvv74k73Y+IQD
         2soQ==
X-Gm-Message-State: AO0yUKVTUCxDSimXKbXi1902JLiOh9MeoblCCKuFxe2TVm/aOIyQJgVq
        bK5kQ6Ly3Vg+r4g19YP9niJi6g==
X-Google-Smtp-Source: AK7set/qO1ZrewJn4bmj3vLDXbMy65GyvyS6dUKXJ11/6IUGi1XwJdzu7rdFlm46eTvxSINFStw9Jg==
X-Received: by 2002:a17:906:4ed3:b0:932:2282:dbd6 with SMTP id i19-20020a1709064ed300b009322282dbd6mr11253746ejv.5.1679329788739;
        Mon, 20 Mar 2023 09:29:48 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:458e:64e7:8cf1:78b0? ([2a02:810d:15c0:828:458e:64e7:8cf1:78b0])
        by smtp.gmail.com with ESMTPSA id d7-20020a1709067f0700b00882f9130eafsm4603368ejr.26.2023.03.20.09.29.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 09:29:48 -0700 (PDT)
Message-ID: <cd1eace0-7c0b-e6e3-ec56-18a88e974bc0@linaro.org>
Date:   Mon, 20 Mar 2023 17:29:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 2/5] dt-bindings: trivial-devices: Add acbel,crps
Content-Language: en-US
To:     Lakshmi Yadlapati <lakshmiy@us.ibm.com>, robh+dt@kernel.org,
        linux@roeck-us.net, jdelvare@suse.com,
        krzysztof.kozlowski+dt@linaro.org, joel@jms.id.au, andrew@aj.id.au,
        eajames@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230320154019.1943770-1-lakshmiy@us.ibm.com>
 <20230320154019.1943770-3-lakshmiy@us.ibm.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230320154019.1943770-3-lakshmiy@us.ibm.com>
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

On 20/03/2023 16:40, Lakshmi Yadlapati wrote:
> Add Acbel CRPS Series power supply to trivial devices.
> 
> Signed-off-by: Lakshmi Yadlapati <lakshmiy@us.ibm.com>
> ---
>  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
> index 6f482a254a1d..ae2cf4411b39 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -30,6 +30,8 @@ properties:
>      items:
>        - enum:
>              # SMBus/I2C Digital Temperature Sensor in 6-Pin SOT with SMBus Alert and Over Temperature Pin
> +          - acbel,crps
> +            # Acbel CRPS Series power supply

Wrong placements of comments. This is AD, not Acbel.

>            - ad,ad7414
>              # ADM9240: Complete System Hardware Monitor for uProcessor-Based Systems
>            - ad,adm9240

Best regards,
Krzysztof

