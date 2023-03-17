Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3641D6BE4D4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 10:05:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjCQJF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 05:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbjCQJEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 05:04:34 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674C8E20E3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 02:02:50 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id z21so17675710edb.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 02:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679043767;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qadA+1qgVzIVJptk1TzTcVZVcd/nhqgPDjOkVsBhDJA=;
        b=TLKVwPMZHX6P3jlfayvr6QkI2EVRgBgIGgNsQFXb7hSoX2iPmT+RBMt4xCRfnlHRg8
         orU0292sumU90PpF4NrW4/MbgkacLqeC5u+AnoY5c8RC1TAQYa+ujxtBNZHpFuqpUNjC
         RKnLxdfnExFQG62fxiM/Uf5uR/4TN12UCsflPrA3biF6CpurGt31rG9P28KSkFaBzmb2
         JCI9YnDSLWJtNSMjIoKfNpVnnB5eBc27Wuokqxs6Rjw8UEui4d5s/TyUlNcRX42gCNhU
         6isHCx9ok9xXg6v9jes0PYIIWF7J7lswf5DlhAPYpd9gHpJvHK9kFA1vBafT53OYlScn
         mC8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679043767;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qadA+1qgVzIVJptk1TzTcVZVcd/nhqgPDjOkVsBhDJA=;
        b=TfAvfE6gFMc7sxNwycmg/AErSHz92UUpwxw1jtrdJtEfofQ766MZKffPhz1+2j72sr
         FIXy2tfUACpMgvYwHcnMMjkS4TAv0rg7qybPXqtI/H7nA1ekTDrjtxHl7t1SGRpGBgGE
         NrLJ/hR+EwS86tSJDbjOOvrnbpxzppxK/fDq92GdiRrNaf5AYCyFkOFp79zUAH43Y2yY
         uj1+F5B666Nu8VRsTGuoi9WpNWr5b7/Bt5iSIV1A4VZ+uoceF2jKY4m4N1w1kxAoNagC
         iTbpXugQWB5NPa2m2TPb7d9F8y98LGQhqozLEIrs/ZiwA/CGW+PrUkMp6L29BWwn+o9I
         fbRA==
X-Gm-Message-State: AO0yUKWdbqgtBL+aFIM8nKaIJEufGWve3bcBt7aEOS1Y/+uQ8+KI10Um
        ZKmLw61SibVBH1zies5V1X8A+A==
X-Google-Smtp-Source: AK7set9m47WzsVcZLP9pUJ8siTpzZytgu6fM08sg9bi87Lb874uak5iZMoDOYLqXybgiOeCjaKZjvw==
X-Received: by 2002:a17:906:f2c9:b0:931:bc4a:ce08 with SMTP id gz9-20020a170906f2c900b00931bc4ace08mr2027612ejb.36.1679043767346;
        Fri, 17 Mar 2023 02:02:47 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:848a:1971:93e0:b465? ([2a02:810d:15c0:828:848a:1971:93e0:b465])
        by smtp.gmail.com with ESMTPSA id s30-20020a50ab1e000000b004c5d1a15bd5sm765305edc.69.2023.03.17.02.02.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 02:02:46 -0700 (PDT)
Message-ID: <9f4cef36-d6cd-367d-161c-5dc78572f2dc@linaro.org>
Date:   Fri, 17 Mar 2023 10:02:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 4/4] dt-bindings: arm: hisilicon: Add Hi37xx SoCs
Content-Language: en-US
To:     David Yang <mmyangfl@gmail.com>
Cc:     Wei Xu <xuwei5@hisilicon.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org
References: <20230317085347.10147-1-mmyangfl@gmail.com>
 <20230317085347.10147-5-mmyangfl@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230317085347.10147-5-mmyangfl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/03/2023 09:53, David Yang wrote:
> Add devicetree binding for Hisilicon Hi37xx SoCs.
> 
> Signed-off-by: David Yang <mmyangfl@gmail.com>
> ---
>  .../bindings/arm/hisilicon/hisilicon.yaml     | 28 +++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.yaml b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.yaml
> index 540876322..0e0fcb1c7 100644
> --- a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.yaml
> +++ b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.yaml
> @@ -25,11 +25,39 @@ properties:
>            - const: hisilicon,hi3670-hikey970
>            - const: hisilicon,hi3670
>  
> +      - description: Hi3716cv200 based boards.
> +        items:
> +          - const: hisilicon,hi3716cv200

None of these here are correct compatibles for boards. Board compatible
has minimum two pieces: board compatible and SoC compatible.



Best regards,
Krzysztof

