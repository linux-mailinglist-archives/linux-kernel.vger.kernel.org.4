Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8CD618702
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 19:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbiKCSFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 14:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbiKCSEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 14:04:10 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4055123BCF
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 11:01:52 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id v8so1647066qkg.12
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 11:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b6lzWnndPEx47JNYnBGGhAjHV67Tdq93TKvJyHkVGpU=;
        b=DViLWviJRNiRKOZurROMuetripDeQl1g19sw3T0TpCXaliobtAcUpHInTkjSEZib9D
         7MkOjvKLSFviFdXN+hq26Fa5jwANIC5E0nvuHZMsH1ZMn4+BH7MWbRHQW/RwCVq6WX1f
         oYlqXdDmpAXr9dMLKOlPFXsohahRnHVSfZ/5JnhN2gEAOapUL85ILJoN+Cc9GICOlsuV
         5SnIbPzuMXfe4Njcg3+x/kXixf6qYP3BXBlHlHybmibb4qqkdZSY4b8lvmT1wjB3fmWr
         reAyQsiNMRFxuqCzOkiT41wiOdztpQybVWUX3E5LxJsoTndf6ejCMr2bhS71rXNrXpOk
         4X3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b6lzWnndPEx47JNYnBGGhAjHV67Tdq93TKvJyHkVGpU=;
        b=XtteT9ITrRXJSGuR+LTy4iCma3XGRzeWQyHVaFgkTOO8gHP9GJ+i54PbygEb3p/mKK
         0PrtiU+0ic9HsX9NpI20+d13WIkvIwGb7p8HA1WVNcL5nlRd5E0DHN2MOHtKrV9xbPji
         BNBD4/ziE6uLt+ChoLypz61Wjvcp+/GQYkvfCFmmtXSJ1UQfDtc0T06OKSJZyBepR57A
         WUkLjE5UPeDd++PQU9D5HuD8gqoH0JIUgHnXr5GS5R62E6XcmFFS9NkQr9+E6Qc76COt
         +6iaEcYkTySJQNryhhigKYe4rQoQsP3VSlt9Sm7efsfC3f3tAM+paw94LEDvH576ztjl
         B8IQ==
X-Gm-Message-State: ACrzQf33M1zcs5A4NGnppSx9hXwZsriVA7jBm/uKpPXeILNTX1/hcvEa
        tOxG25uXdiPIflAsBY+hEJg3kqJf3Aq00w==
X-Google-Smtp-Source: AMsMyM7TEv/8Z00e6YSXU/dDrn8qkVeUkqCQmw0hY0PNeKAia77RHB8u/EgrArZ2PPcHaORZnrqD3g==
X-Received: by 2002:a05:620a:28cc:b0:6ee:78fe:c519 with SMTP id l12-20020a05620a28cc00b006ee78fec519mr21850553qkp.345.1667498511178;
        Thu, 03 Nov 2022 11:01:51 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:a35d:9f85:e3f7:d9fb? ([2601:586:5000:570:a35d:9f85:e3f7:d9fb])
        by smtp.gmail.com with ESMTPSA id fy5-20020a05622a5a0500b003a533886612sm926956qtb.3.2022.11.03.11.01.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 11:01:50 -0700 (PDT)
Message-ID: <613d7971-37d6-c8db-523e-cf3cbdcd5287@linaro.org>
Date:   Thu, 3 Nov 2022 14:01:49 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v6 1/2] dt-bindings: mfd: Add bindings for MAX5970 and
 MAX5978
Content-Language: en-US
To:     Naresh Solanki <naresh.solanki@9elements.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Patrick Rudolph <patrick.rudolph@9elements.com>
Cc:     Marcello Sylvester Bauer <sylv@sylv.io>
References: <20221103080545.1400424-1-Naresh.Solanki@9elements.com>
 <20221103080545.1400424-2-Naresh.Solanki@9elements.com>
 <0c23e569-61e1-3eba-f9fc-4b42ed228b52@linaro.org>
 <dc6c8f79-9830-dd1b-a064-3b25a3b74a35@9elements.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <dc6c8f79-9830-dd1b-a064-3b25a3b74a35@9elements.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/11/2022 13:53, Naresh Solanki wrote:
> Hi Krzysztof,
> 
> On 03-11-2022 06:43 pm, Krzysztof Kozlowski wrote:
>>> +examples:
>>> +  - |
>>> +    i2c {
>>> +        #address-cells = <1>;
>>> +        #size-cells = <0>;
>>> +        regulator@3a {
>>> +           compatible = "maxim,max5978";
>>> +           reg = <0x3a>;
>>> +           vss1-supply = <&p3v3>;
>>> +
>>> +           regulators {
>>> +               sw0_ref_0: SW0 {
>> No improvements here.
> I've addressed 4 space indentation, bindings are matched, compatible is 
> moved to first, then reg then the rest.

OK, so indeed there are improvements.

Yet still you did not improve the warnings coming from the binding -
this does not match your binding. Test the binding and you will see big
fat warning.

Best regards,
Krzysztof

