Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9D863C01C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 13:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbiK2Mdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 07:33:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234267AbiK2Mdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 07:33:47 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A22185B840
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 04:33:45 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id j16so22208519lfe.12
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 04:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eWiURuJRvAmuYPzpqI5IuB0ekBiTCCwJkSVslWsTGxk=;
        b=UiRPU+UB4O8IwKcHb80Kp4fIqFBx4i0T/QAwF0fryNwIqRMo6wjAbpF3FTq1Uc6oEd
         l2XCJUWyUHNdWjjgqg0E7bQpm1qkfSB2XbDxksmg2fhl8y5BkZRSIGJsK97PxsARF5Lz
         2d/FrFy+1ezdgESwcoVKyCa/XJlkXSSBsC2GfL7hBAsTQQ00g3Du5QOXtkOOnvJ8z1P0
         3ePddbTBACGeX1aKhwew2QOk9s4wwn0/qYhJhV+n29QDVMKMABGocjd4y2CUNxSIxnlA
         2sDwogQwGt1Tv+vrcJtQrRD7TGv4DXbpkAbv0J4kXJ80ka20e8+uBgzFLwGq8yXOvmwX
         JqYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eWiURuJRvAmuYPzpqI5IuB0ekBiTCCwJkSVslWsTGxk=;
        b=woOcmRmawr6UWXFd6VL1SBskPoLwT5OzNAqOYXCbaeC7HOeMUtvxrD/4ZUnItqTWhw
         vPNT+TZLR3v20ePj6TXx31XbSMm9dUPw8YfIvKn/DPD6/BI+2DZI+XSglmZ5C9nndWQi
         CVsnwJCRrccRHGFGMQ+00GKrGldCKP378yT8cq8t4YF+M/fuR/t+UjfgAEm1CvCToJ0R
         RDF0EIr8ySLHYJcyILkj0wgZrfv5qMKmrvJQ0oSYw998rwNoko6TGwv4fs1E+s7QEU7N
         UYVR2v3J5pWvC9yD5I5kkHp8E30OZgqJWlFOleA4w407oiYPdYt64nASHG8ZiYa5nqyG
         ZjXg==
X-Gm-Message-State: ANoB5pnGIPisSv2LhRvkO6EQnKd2TPOglxXqqDMlJBwpwce+Esa5ETwU
        ZPgSLUEizAebp1FsgKw6vMwO/w==
X-Google-Smtp-Source: AA0mqf4oipRDlOIiFITebYunhRAq9eBxigTkhcl/VBISsSItweziG7YPuy5kUrZ5/YAYa3KHhgLc4g==
X-Received: by 2002:a05:6512:3248:b0:4aa:148d:5168 with SMTP id c8-20020a056512324800b004aa148d5168mr18029487lfr.561.1669725224037;
        Tue, 29 Nov 2022 04:33:44 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id z14-20020a056512370e00b004acb2adfa1fsm2185015lfr.307.2022.11.29.04.33.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 04:33:43 -0800 (PST)
Message-ID: <bb035398-ba56-0ce0-3b14-b8dc5863b7f3@linaro.org>
Date:   Tue, 29 Nov 2022 13:33:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] dt-bindings: mmc: Make comment on wakeup-source less
 confusing
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        linux-kernel@vger.kernel.org, Marek Vasut <marex@denx.de>,
        kernel@dh-electronics.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20221122111124.6828-1-cniedermaier@dh-electronics.com>
 <20221122111124.6828-3-cniedermaier@dh-electronics.com>
 <CAPDyKFqc2kc4O55BAVikZFeZpAeRYo3AAfnHyxKPcsUujeGauA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAPDyKFqc2kc4O55BAVikZFeZpAeRYo3AAfnHyxKPcsUujeGauA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/11/2022 13:06, Ulf Hansson wrote:
> On Tue, 22 Nov 2022 at 12:43, Christoph Niedermaier
> <cniedermaier@dh-electronics.com> wrote:
>>
>> The current comment on wakeup-source is a bit confusing, because it isn't
>> clear at first sight which property is actually deprecated.
>> Change the comment to one that is less confusing.
>>
>> Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
>> ---
>> Cc: Ulf Hansson <ulf.hansson@linaro.org>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
>> Cc: Marek Vasut <marex@denx.de>
>> Cc: kernel@dh-electronics.com
>> Cc: linux-mmc@vger.kernel.org
>> Cc: devicetree@vger.kernel.org
>> To: linux-kernel@vger.kernel.org
>> ---
>>  Documentation/devicetree/bindings/mmc/mmc-controller.yaml | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
>> index 802e3ca8be4d..a921442c6c1d 100644
>> --- a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
>> +++ b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
>> @@ -293,7 +293,7 @@ properties:
>>      description:
>>        SDIO only. Preserves card power during a suspend/resume cycle.
>>
>> -  # Deprecated: enable-sdio-wakeup
>> +  # Use wakeup-source instead of the deprecated enable-sdio-wakeup
>>    wakeup-source:
>>      $ref: /schemas/types.yaml#/definitions/flag
>>      description:
> 
> Rob, Krzysztof - do we have a preferred pattern for how to express
> deprecated bindings - or is the above okay to you?

Yes, we have:
  deprecated: true

I don't get why this is in response to LED patch? I entirely ignored
this thread because of it.


Best regards,
Krzysztof

