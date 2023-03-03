Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4B496AA07B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 21:09:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbjCCUJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 15:09:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbjCCUJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 15:09:34 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D140914EA4
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 12:09:32 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id ay14so11203394edb.11
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 12:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677874171;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vBfThdkr+R1QJDSnLWRmQSdiN+ot973n4V1yEiFsi/E=;
        b=BtpO3JS9nLte8Bhx760Ii9Ype7OH2+MfecEKdXsQT7LJBZxqio9u5G8Imm914EmcvZ
         Jv9vyzbG5noAob+WXGnDKbSiUKoCtgt3xBx4TwZWw6PSV7JmTSsuqYpwLj/xPYW8uCHU
         cInea7xBeSYT6UgXkBx+FJQc9woZMkOz+FZKzxmY0tspJ+jbLwbVnTTKhW2z6014A+EG
         L4FqWxUG2tp/qT22UHxh0QS5Hk7leDuMAwkSpsKGrGGcr/GQeVNjhFfCmM/1cST4GqMT
         Fi/hWwzs6KxFT/AxMSwD3xcLjPqd8k/fGqtKt8/dxNmh1SL8ehsuCyVWwAyTpkmI3KrY
         QMcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677874171;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vBfThdkr+R1QJDSnLWRmQSdiN+ot973n4V1yEiFsi/E=;
        b=uJ5U9cM7PpXYaup+7WdH0943QzN4HbqgzoiDWpSjPgkDcg7bQqOTlU+y+x8AU2J76B
         k/zqx/LCA3r6ZEbS/BRJHB/kvG41brJAWvlPx6Mjhgwd8oOQtPEwNmcvMwWTy+zlvyYZ
         nWPWKmwMBqn3UzB/uNSgEo4t4jCFJDCxDQWgdyZI65KoraHdKn83v7E/PEV5uDFIzroM
         oCbPtkaoweKUIhYH6pr3oLPDQWcTQ0xHj5afqwuuYlf3f7ZwZvfhrKbqFf97OLUynMr/
         noV214INYB5aWVJOCzqCA1nMKDnrQ30ZqxSUzK+3yiDNqtz8Wci2hKE/0W2ZTxf7Mcyl
         E2Eg==
X-Gm-Message-State: AO0yUKWnlPBd01XVMQP6GG7OwmU8pwSS8mbMNZllGLUo6F2pxAn59N8I
        EpZGL0dxol695AjdW8jwrZooV1rRjnQ/a2nrkfc=
X-Google-Smtp-Source: AK7set+6uqEnIlJuYZ+p6dJCwocssUfFhZo2hsEt2bd661xunQfZfHWb5HDLKmkaNJsT7+atoRiRbA==
X-Received: by 2002:a17:907:2be2:b0:860:c12c:14f9 with SMTP id gv34-20020a1709072be200b00860c12c14f9mr2400939ejc.40.1677874171308;
        Fri, 03 Mar 2023 12:09:31 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:3321:2e91:9111:67ba? ([2a02:810d:15c0:828:3321:2e91:9111:67ba])
        by smtp.gmail.com with ESMTPSA id p12-20020a17090628cc00b008b1797b77b2sm1273007ejd.221.2023.03.03.12.09.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Mar 2023 12:09:30 -0800 (PST)
Message-ID: <b945ebe9-cca5-f3c3-5662-c77aa345c964@linaro.org>
Date:   Fri, 3 Mar 2023 21:09:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] MAINTAINERS: i2c: include all I2C bindings in the I2C
 entry
Content-Language: en-US
To:     Wolfram Sang <wsa@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230303082530.11878-1-krzysztof.kozlowski@linaro.org>
 <ZAJPfaY5NxxS6v3R@shikoro>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ZAJPfaY5NxxS6v3R@shikoro>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/03/2023 20:50, Wolfram Sang wrote:
> 
>> +F:	Documentation/devicetree/bindings/i2c/
> 
> This entry is already present a tad later in "I2C SUBSYSTEM HOST
> DRIVERS".

Ahh, indeed, I forgot that. Patch can be skipped then.

Best regards,
Krzysztof

