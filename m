Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAF997343CD
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 22:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233150AbjFQUo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 16:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232762AbjFQUoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 16:44:25 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2426100
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 13:44:23 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-519f6e1a16cso2399849a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 13:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687034662; x=1689626662;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bmzHP69vnJ8i0TjPJPu+QhOAU8ORkNj2xDKDBmcQppI=;
        b=WPKhszkvvBkUTyLNdoUWdArTIFn7Sz/Bbj4JY7JZuLXtMgvH/niQdJc7D1uPg54VOZ
         xpnUhYHjDWSzsi3Q+KFhHxkvOfd/2FnSboBAX13VYbCeD5eZ3/uJx3hjep7hITczQMRM
         0QxwY3rHXGEIfP09t49lgyN93kmHy45QqUuucWI1IImmaScj0nt1oFL+CH34lGfwNac3
         Zdy2WP43Yrf+R5jvUb0lcox3LlmdhQyxeGszqoaA/qc942SknG+9k5gdVvV0OQpiZ5Rz
         uscgVmgFBAqnqwEHUC9hCo888JihSpCbODwOcZZrAk9dlFl89GDaMOSNoLNZCYnKc9ph
         KBSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687034662; x=1689626662;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bmzHP69vnJ8i0TjPJPu+QhOAU8ORkNj2xDKDBmcQppI=;
        b=X1ELNkw6c3m9JWyZrpZB79NUg9HU57K5/JLyg1P4pYJO1EZXXeFhByTnJ6C6eWoR7c
         Wdvp0PYv7zsDmqSiTdefLOrrbs8eo1orq8v+s7tbwsEquIF/0t6TZsXlMTghE1521n1e
         BR5juLedsxzLund5VgMON+c4xmdmtMHIREUtN821jY64ZOSNFRKBlcWNoSRyBvXIA+je
         zmtivDnxyNI+Z70qN6I51CkdSI79hDt8AecmuCecYd2WLwGuPGiBzaUA3iG5f69k3WET
         Qmt1MJ3sGA8kzOn/HNJjyKD9p1mFXpYRPGplH6IHile5ON/xgpGSufZRHgFJPHK65Lyv
         8Nhw==
X-Gm-Message-State: AC+VfDz4efciPsqPqB+D6do9TMU1fRdfan1WXEwzgDbevjJr+dQvvMV4
        6kZwm+w7slVGYjyRwbozLLpS0A==
X-Google-Smtp-Source: ACHHUZ6+WnpmeJX8nz99i1JN10squFKc+jqPPPC4i66Vtt1wdh2lU+L19tKpauCLHvwipMlzUjjyAA==
X-Received: by 2002:a05:6402:692:b0:51a:3334:f87f with SMTP id f18-20020a056402069200b0051a3334f87fmr3565617edy.37.1687034662141;
        Sat, 17 Jun 2023 13:44:22 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id u10-20020a056402064a00b0051a318c0120sm2314087edx.28.2023.06.17.13.44.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Jun 2023 13:44:21 -0700 (PDT)
Message-ID: <2625a937-a37e-52ee-1818-c7611f0e3b3b@linaro.org>
Date:   Sat, 17 Jun 2023 22:44:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCHv2 1/2] dt-bindings: arm: rockchip: Add Firefly Station P2
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>,
        Furkan Kardame <f.kardame@manjaro.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, heiko@sntech.de, broonie@kernel.org,
        deller@gmx.de, dsterba@suse.com, arnd@arndb.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230617135315.25441-1-f.kardame@manjaro.org>
 <20230617135315.25441-2-f.kardame@manjaro.org>
 <20230617-compacter-unloader-ab326e0badfc@spud>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230617-compacter-unloader-ab326e0badfc@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/06/2023 22:40, Conor Dooley wrote:
> Hey Furkan,
> 
> On Sat, Jun 17, 2023 at 04:53:14PM +0300, Furkan Kardame wrote:
>> Station P2 is a single board computer by firefly based
>> on rk3568 soc
>>
>> Signed-off-by: Furkan Kardame <f.kardame@manjaro.org>
>> ---
>>  Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
>> index ec141c937..fa21640bc 100644
>> --- a/Documentation/devicetree/bindings/arm/rockchip.yaml
>> +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
>> @@ -185,6 +185,11 @@ properties:
>>            - const: firefly,rk3566-roc-pc
>>            - const: rockchip,rk3566
>>  
>> +      - description: Firefly Station P2
>> +	items:
>> +	  - const: firefly,rk3568-roc-pc
>> +	  - const: rockchip,rk3568
> 
> yaml files are indented with spaces, not tabs.
> 

Which is pointed out by testing, so this was not tested :(

Please run `make dt_binding_check` (see
Documentation/devicetree/bindings/writing-schema.rst for instructions).
Maybe you need to update your dtschema and yamllint.

Best regards,
Krzysztof

