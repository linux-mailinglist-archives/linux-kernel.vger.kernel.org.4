Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F17618989
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 21:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbiKCU0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 16:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbiKCU00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 16:26:26 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953301F2DE
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 13:26:23 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id j6so1911148qvn.12
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 13:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0H6/+dMjWUBnPMgwjJq799Jgq3lnBKy0RVt55+vq0Ew=;
        b=Bl2ZTNtKFnnIvYsOfQERwkCEwNmqNrad2S+IpF12P0pr9vsUwSh8iMcsuKPmAiBZP4
         LRpJ1N2X+rmKxk6mI7o9ge85MX0pcQOX/VoQHhMFZdl7K9txklDWcy1C+hzjaY2vhEOY
         DOacbK/7la00r3v/fJMB+qCRILBySKQsgekG3HjWRIO3XDZjGVk88+TDzDR7zQreLAxX
         ZU2UvhrWOMp/BUn/zfLuYn8X27ESL/prYEP4dOCgnTkepXjeD7estuU1U4VK9b8EUQRX
         VK8sS4MBdwmtKt/N4mOE4GrMfaHprXzxMhsZNhhbSvWX0AH2GmDyFNnN36T1xoWbAF3F
         x48w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0H6/+dMjWUBnPMgwjJq799Jgq3lnBKy0RVt55+vq0Ew=;
        b=e5NSG2eLu6l1T3UkPZdm3GQcCvqFU8EHzpx9W6fydhFv4w4XlHtw2YeECPW9UH0Nmx
         rtlDYaOdkD3+n/LyISYg9HbDnHNZjuQiRK/4PSs7USQl6WCHSCCFnylOmDj42VHoBFi9
         8qgG9zDN8VxFDcZpmeLktkoFIu8As58EHTv6mNBVBxy8C/k5rdewEiIjmzQMQuQxeL20
         G9kX64Ii7DUlsbNTj6yPAdKzvClvOnqePPCR0VX/y764CAw/Wb4mp9+UunKNjULoKkv4
         +gO2/afUMpAEbQdpUi7LkHQ4vn0+mwg1XWf4dCy3Eah36CJkebfLfp3/cOZaAL1mtHWf
         bQWw==
X-Gm-Message-State: ACrzQf38KCHrI+CGTKNjOXNQFWVX9JOFSIo2OJcQhk/EjEktGsfy7o9y
        qxqRGUdUDO56dsZD812qh9t80w==
X-Google-Smtp-Source: AMsMyM7WClO7SZr5UjDB+4kKmADKw3G6zZrnkYj8gqAdfPJXcTkWWHdQxE37rYnHUdnzF/PRZiQHJw==
X-Received: by 2002:a05:6214:2589:b0:4bb:8ef1:2581 with SMTP id fq9-20020a056214258900b004bb8ef12581mr28164069qvb.16.1667507182823;
        Thu, 03 Nov 2022 13:26:22 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:a35d:9f85:e3f7:d9fb? ([2601:586:5000:570:a35d:9f85:e3f7:d9fb])
        by smtp.gmail.com with ESMTPSA id w5-20020a05620a424500b006b61b2cb1d2sm1443728qko.46.2022.11.03.13.26.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 13:26:22 -0700 (PDT)
Message-ID: <e3164343-3b0d-6672-e628-87347a03000f@linaro.org>
Date:   Thu, 3 Nov 2022 16:26:21 -0400
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
 <613d7971-37d6-c8db-523e-cf3cbdcd5287@linaro.org>
 <b9b77873-9004-425c-276d-ea5ef8ebf7dc@9elements.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <b9b77873-9004-425c-276d-ea5ef8ebf7dc@9elements.com>
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

On 03/11/2022 14:20, Naresh Solanki wrote:
> 
> 
> On 03-11-2022 11:31 pm, Krzysztof Kozlowski wrote:
>> OK, so indeed there are improvements.
>>
>> Yet still you did not improve the warnings coming from the binding -
>> this does not match your binding. Test the binding and you will see big
>> fat warning.
> Not sure what I've missed but below is the output:
> make dt_binding_check -j1 V=1
> make -f ./scripts/Makefile.build obj=scripts/basic
> make -f ./scripts/Makefile.build obj=scripts/dtc
> make -f ./scripts/Makefile.build obj=Documentation/devicetree/bindings
>    dt-extract-example 
> Documentation/devicetree/bindings/mfd/maxim,max5970.yaml > 
> Documentation/devicetree/bindings/mfd/maxim,max5970.example.dts
>    gcc -E 
> -Wp,-MMD,Documentation/devicetree/bindings/mfd/.maxim_max5970.example.dtb.d.pre.tmp 
> -nostdinc -I./scripts/dtc/include-prefixes -undef -D__DTS__ -x 
> assembler-with-cpp -o 
> Documentation/devicetree/bindings/mfd/.maxim_max5970.example.dtb.dts.tmp 
> Documentation/devicetree/bindings/mfd/maxim,max5970.example.dts ; 
> ./scripts/dtc/dtc -o 
> Documentation/devicetree/bindings/mfd/maxim,max5970.example.dtb -b 0 
> -iDocumentation/devicetree/bindings/mfd/ 
> -i./scripts/dtc/include-prefixes -Wno-avoid_unnecessary_addr_size 
> -Wno-graph_child_address -Wno-interrupt_provider 
> -Wno-unique_unit_address -Wunique_unit_address_if_enabled -d 
> Documentation/devicetree/bindings/mfd/.maxim_max5970.example.dtb.d.dtc.tmp 
> Documentation/devicetree/bindings/mfd/.maxim_max5970.example.dtb.dts.tmp 
> ; cat 
> Documentation/devicetree/bindings/mfd/.maxim_max5970.example.dtb.d.pre.tmp 
> Documentation/devicetree/bindings/mfd/.maxim_max5970.example.dtb.d.dtc.tmp 
>  > Documentation/devicetree/bindings/mfd/.maxim_max5970.example.dtb.d ; 
> dt-validate  -u ./Documentation/devicetree/bindings -p 
> ./Documentation/devicetree/bindings/processed-schema.json 
> Documentation/devicetree/bindings/mfd/maxim,max5970.example.dtb || true
> 
> Didn't get any error or warning on example.
> Made sure python package dt-schema is updated as well.

Eh, true, but you have there "additionalProperties: true" which are not
allowed. This must be false and about leds I commented. False must be in
all other places as well.

Best regards,
Krzysztof

