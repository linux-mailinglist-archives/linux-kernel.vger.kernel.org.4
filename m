Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 206CC5B3D82
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 18:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbiIIQ7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 12:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiIIQ7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 12:59:46 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C8BB24F12
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 09:59:44 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id r12so1020405ljg.10
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 09:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=ql3YShxCvfwOd1yaJ2SrG8NA5IT316l4wnpDFrUd5i8=;
        b=cy0dBIh2VfqaTt0dv8T+F9mubGXWOuHFQHQNk+VPWOAJm6PKjxUNFN3WCfhDuiMv27
         WzPUky2fLM1pSJssD6xPAI4qbg+ag6uksii3UlfH6dziEwwuBCNoa/VSs7PmU06zfF8m
         loBjpIEwYv8wyePEQesT+QHLkHfpJoKIM4eiWN0fwssM9IWzOphutCFJMx2csjXsOGql
         gJ/FNomb9ChsdkXUPt09zpJ3tgQBdgDCXgV+o3TjPmYmQyfyb6boDpaSOXaFQ6dDtMfc
         mBVg7bot4Mt6BSAtn5jY6JH2IMK57IjRrKONqm0eQjd7ULmR9eBy+Bh+AdpoDGao/ICC
         cJYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=ql3YShxCvfwOd1yaJ2SrG8NA5IT316l4wnpDFrUd5i8=;
        b=d26y5B7yqjeB43L/27Ig2abi6jiNgmZ8ESEfMvg2oIymtdpOsfApkSdSOVePHTjrxm
         tAR0Fsosd1hmXF7DbU2v+042ERopWnVKmLgsrqfLGnD4sHwc74hrW/mfjMskgeGF46Ek
         Ju2sMh8fG3gl7agT78UP2Z508/C/Jyt9fD+ck29wHWbOsOyo5lcN7SD3QFVAKS9qNrmZ
         wWDk4XbOaetFQ7wia4FhLFkmXyfL5hfmZlbiuVehaku7TChfPn1X0fjuG9tj+/G4qakR
         cQLGdsWFm5SEuLpZtGoS+prc9bs/h9f/nZ5irMrG6g2OxLGihht8PXbwS5O4c2sFuFd0
         3UNQ==
X-Gm-Message-State: ACgBeo3/ad0vSbSohBWvkfkZU07wB3ScZQX9XVIizt5UWxk6+v7h5RBd
        P3NUrdqojcwJNblNSwjSV5FXAVQ/F//0iw==
X-Google-Smtp-Source: AA6agR4r4QMgXaqfAUxwOTtjxr6FDHQlE2UN3PoeQoARGTTOMFNHhWbzEfKHPt+sHLQ+6hFvHcpAlw==
X-Received: by 2002:a05:651c:12cb:b0:25e:44ef:8bfa with SMTP id 11-20020a05651c12cb00b0025e44ef8bfamr4352879lje.324.1662742782699;
        Fri, 09 Sep 2022 09:59:42 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id u5-20020a2ea165000000b0026a999966bbsm153473ljl.24.2022.09.09.09.59.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 09:59:42 -0700 (PDT)
Message-ID: <bd277041-db44-58c2-54f5-94f081a07f30@linaro.org>
Date:   Fri, 9 Sep 2022 18:59:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v8 3/4] dt-bindings: hwmon: Add bindings for max31760
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>
Cc:     jdelvare@suse.com, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux@roeck-us.net,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org
References: <20220909133718.388213-1-Ibrahim.Tilki@analog.com>
 <20220909133718.388213-4-Ibrahim.Tilki@analog.com>
 <1662740789.477872.1507147.nullmailer@robh.at.kernel.org>
 <20220909164710.GA1537271-robh@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220909164710.GA1537271-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/09/2022 18:47, Rob Herring wrote:
> On Fri, Sep 09, 2022 at 11:26:29AM -0500, Rob Herring wrote:
>> On Fri, 09 Sep 2022 16:37:17 +0300, Ibrahim Tilki wrote:
>>> Adding bindings for Analog Devices MAX31760 Fan-Speed Controller
>>>
>>> Signed-off-by: Ibrahim Tilki <Ibrahim.Tilki@analog.com>
>>> ---
>>>  .../bindings/hwmon/adi,max31760.yaml          | 44 +++++++++++++++++++
>>>  1 file changed, 44 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/hwmon/adi,max31760.yaml
>>>
>>
>> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
>> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>>
>> yamllint warnings/errors:
>>
>> dtschema/dtc warnings/errors:
>> ./Documentation/devicetree/bindings/hwmon/adi,max31760.yaml: error checking schema file
> 
> Not sure why the error is useless ATM. I'm checking that.
> 
> The problem is that 'reg' is a matrix and you need to either fully 
> define it or use the simplified form for a single cell:
> 
> reg:
>   minimum: 0x50
>   maximum: 0x57

I think this was in v7, so I understand that schema in that case expects
the third option from anyOf - #/single?

https://github.com/devicetree-org/dt-schema/blob/main/dtschema/meta-schemas/cell.yaml#L62

Best regards,
Krzysztof
