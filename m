Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E172E6C3574
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 16:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbjCUPTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 11:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbjCUPTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 11:19:38 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96FC81FE1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 08:19:36 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id ek18so61123208edb.6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 08:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679411975;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N2mP2BnsQm5zh6A2HZUTUjLmcpObY/zGao0pM3PGo0g=;
        b=a9/mRmDdoKZe4hhJTvpyCKClqpUYC+NK2bBvbKm60dxzY9gnmfTSZj8AiS80GfNyk5
         bW6FwwOD+ms6rmCHj72eMQyXwxGqM9POwKXiUBNj0wELc5Y7PPdEMGFyijxPA1c7iZ49
         OVUqYTmOcT6j8aF9yvCnG5LdN8RzMaZfcIZ00Q4ZBPIf8GXklbycWNde2wHRexk/ppcY
         vQrPhozeuNvycoFLmZs/9ZeWDp2iMSiI/+ApBNMqCXbwXojKQ3xqr6gr440O5yoTVWi6
         /Ky3g6vptPcGfsW9xcc/6VTqiYx9Q5vQmtZ5579ab7l1uS/9hAnYJmN0KeiGEkmD+xyw
         3D2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679411975;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N2mP2BnsQm5zh6A2HZUTUjLmcpObY/zGao0pM3PGo0g=;
        b=xLu+cN0LGr3b07hdapIJCDXSp/taX8ahn4oFQv8YuR/Ld7lDVP/6SuNjE5fVJ6jLfA
         xSdhKalQClTIQPJAsWUeu1yjZQ+Hm2QmmLvR4cAqWR0WpSVhHYTFmWM2QkpREPPrVYfp
         dK7zI+aAzf9TaQu4iFAIr3v5FUYm3EHIzSCJnu+24UHFQrY3C0tbKQLbn/Tt8y+pb3aP
         1qbhxiJYwn7RJLc/2pUQB4SjdtH6xcvQpcoTNmn7hU+2684U1sRhy0f3scTbBkKQxCGS
         SYw5+GwcKXuealmY6Q2VbJBMuBhxgcrblNOq7hR+aVYjYJY4B6uO4ShkQl+Yo9Xk9lzo
         ooUQ==
X-Gm-Message-State: AO0yUKWV0n4w9GHSbmX3hV9bmUZ3woBZvLYpQcahP0jZeiSDFC3j7bOK
        MWUKNuUBJ2CspDFQzLywLtNQkQ==
X-Google-Smtp-Source: AK7set8T8K2wOtiJQwaJ+xGQGB6ZcAZOwXgU8n6yD90OeTQO2Khv8i5BOklJDUGRgKscZAFRclXJ8Q==
X-Received: by 2002:a17:907:75d8:b0:8aa:502c:44d3 with SMTP id jl24-20020a17090775d800b008aa502c44d3mr3318942ejc.41.1679411975153;
        Tue, 21 Mar 2023 08:19:35 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:2142:d8da:5ae4:d817? ([2a02:810d:15c0:828:2142:d8da:5ae4:d817])
        by smtp.gmail.com with ESMTPSA id 11-20020a170906318b00b008d606b1bbb1sm5899106ejy.9.2023.03.21.08.19.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 08:19:34 -0700 (PDT)
Message-ID: <6d4cf513-0787-6b39-8d38-30484be7ddff@linaro.org>
Date:   Tue, 21 Mar 2023 16:19:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 2/4] doc: Add Atmel AT30TSE serial eeprom
Content-Language: en-US
To:     Eddie James <eajames@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc:     linux-aspeed@lists.ozlabs.org, devicetree@vger.kernel.org,
        andrew@aj.id.au, joel@jms.id.au, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org
References: <20230321151642.461618-1-eajames@linux.ibm.com>
 <20230321151642.461618-3-eajames@linux.ibm.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230321151642.461618-3-eajames@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/03/2023 16:16, Eddie James wrote:
> The AT30TSE is compatible with the JEDEC EE1004 standard. Document it
> as a trivial I2C device.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>

Use subject prefixes matching the subsystem (which you can get for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching).

> ---
>  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
> index 6f482a254a1d..43e26c73a95f 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -47,6 +47,8 @@ properties:
>            - ams,iaq-core
>              # i2c serial eeprom (24cxx)
>            - at,24c08
> +            # i2c serial eeprom (EE1004 standard)

AT30TSE?

> +          - atmel,at30tse

Microchip does not find anything on AT30TSE. Are you sure this is the
model name?


Best regards,
Krzysztof

