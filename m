Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4C746BDD7C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 01:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjCQAUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 20:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjCQAUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 20:20:09 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1257EBCFFB
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 17:20:08 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id b10so3328632lfb.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 17:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679012406;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eJfooYfiLnyVHMtBP0P+hnf9PjpuzYGXRXEsT+tgyzI=;
        b=nW3MKB7OKkV+d4bYJ+vHJpGKSWfVdrP6bPA83AffzauIa5tTDSxIj7xCI4LxuWVOCV
         +8+eYl/wpYEERaU6YqIrNipahM3kUzHTZ0Aon2BEnttcvsrK91bvQqEobCecka7bM3ib
         CG+WIFwZrrbjMM7zd0npOWaJXc4ODygZfBV0aBYFCaAkZPeFzkhSkN00WjIOUDzpb22Z
         4/3NXZVqACU23kiTRuKreUlwrzMzK8GXgrAuuC72cis3wlQEdRqXdr+TYBt5RBNP+ym8
         Oj6Rtfel2QNavhCJRPLvDZO6c+ZaBhd0sIXvrD1JNmae57swOTg4jpTgItYbxZ4DbLgO
         ppDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679012406;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eJfooYfiLnyVHMtBP0P+hnf9PjpuzYGXRXEsT+tgyzI=;
        b=xjgpXhKwU2sRZLP2T3QFQFvk7trh3TQpUrPkDIXwaiMui/6qHTWolgXbzk7q+hjNV9
         RwzVCcvKgyc7wC9yyYlBLOyLOmjXATS9CU7LaU/7q5FF1E2bbVPH1MthZ1lbIcZQVOsi
         oZ5vl27yEZ+Haq124QVgf9tr4Z+zbvpFrsM7minW/AcosWD+mMeDo9/F4HdpxD6H3+gQ
         wwh+gzEyT05UBONZYbe6oJ9kGLTqszMqc6Usl/V6TAqAkDXbkfLaBUcoEcp+5ie0/ltb
         5Gc5j9qh2Tn+R5Sf0OYpA9i8a4y5lJCxLX7Zh8YWAFclc/6KTgNMuN1RhE5W4FaKpoC+
         rRxA==
X-Gm-Message-State: AO0yUKUKbBrKO+XAfWAMAG7cNHW4F6ZOYVrKv10U0F2p6QFrN6GocZlO
        AeqJ5Z7rSN97OuXiZMj60LN3XA==
X-Google-Smtp-Source: AK7set+wpE6uD3b+c/Jttu9+QRRIOkO4Azi+PCTTajQ02BKXGgpmQUOov1ihx7Bgb04g1hDDsfInqw==
X-Received: by 2002:ac2:4113:0:b0:4d8:4fed:fa0c with SMTP id b19-20020ac24113000000b004d84fedfa0cmr3249120lfi.9.1679012406206;
        Thu, 16 Mar 2023 17:20:06 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id a16-20020a056512021000b004e845954a81sm97951lfo.296.2023.03.16.17.20.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 17:20:05 -0700 (PDT)
Message-ID: <f744cff0-e93d-509c-4949-fced3fa7123c@linaro.org>
Date:   Fri, 17 Mar 2023 01:20:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] dt-bindings: timer: armv7: Don't sanction
 address/size-cells values
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, marijn.suijten@somainline.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20230308012854.294939-1-konrad.dybcio@linaro.org>
 <20230316224710.GA4017716-robh@kernel.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230316224710.GA4017716-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16.03.2023 23:47, Rob Herring wrote:
> On Wed, Mar 08, 2023 at 02:28:53AM +0100, Konrad Dybcio wrote:
>> The driver itself does not read the -cells values (and frankly, it
>> shouldn't), 
> 
> Agreed, because this is standard address translation and only the DT 
> core address functions should read cells props.
> 
>> so there's little sense in only allowing [1, 2] x [1].
> 
> Why does the timer need 64-bits of address space? It doesn't, so that's 
> the reason for restricting it.
> 
>> Allow any values.
>>
>> Fixes: 4d2bb3e65035 ("dt-bindings: timer: Convert ARM timer bindings to json-schema")
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>  .../devicetree/bindings/timer/arm,arch_timer_mmio.yaml      | 6 ++----
>>  1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/timer/arm,arch_timer_mmio.yaml b/Documentation/devicetree/bindings/timer/arm,arch_timer_mmio.yaml
>> index f6efa48c4256..236e2a05c1ad 100644
>> --- a/Documentation/devicetree/bindings/timer/arm,arch_timer_mmio.yaml
>> +++ b/Documentation/devicetree/bindings/timer/arm,arch_timer_mmio.yaml
>> @@ -26,11 +26,9 @@ properties:
>>      maxItems: 1
>>      description: The control frame base address
>>  
>> -  '#address-cells':
>> -    enum: [1, 2]
>> +  '#address-cells': true
> 
> So 3 address cells is valid?
> 
> Until recently (and not yet in a dtschema release), there was no 
> constraint on #address-cells or #size-cells values other than the 
> #.*-cells constraint of 8. Now it is 3 and 2.
Okay, I didn't know that. I suppose we can forget about this patch.

Konrad
> 
>>  
>> -  '#size-cells':
>> -    const: 1
>> +  '#size-cells': true
>>  
>>    ranges: true
>>  
>> -- 
>> 2.39.2
>>
