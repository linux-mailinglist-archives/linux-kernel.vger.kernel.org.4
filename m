Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F4009618759
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 19:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbiKCSUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 14:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbiKCSUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 14:20:48 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC0714081
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 11:20:47 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id b1-20020a17090a7ac100b00213fde52d49so2584839pjl.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 11:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qjre8fS+9GViFqByLAyAAoZAyQGtJAkIzdGZFWs/uEM=;
        b=F/ztarU0i2pP/28LjCo+KRL2ZOnrAYcPT9/Qb1KZj6z7sko+JVW2Tnqv2RS27v66mw
         gWqH4pbR6KdQ2b+j/2GaVgO8j6MvfGCLoePsZRlLwJCU05FdpNDZPhhoB4Njj5iLKGRY
         /fgFtuCH+0QLHKODGhjgxoWnAlDNrMSAXUvVd04RkMNi0rU5w/igC5FKd2JPTA0HPND4
         sCYC7mtGe3MSaG/UfMMiMwcVMEVpCMrYD2ybsH0yGuvUlf+QpetFcklip800dRGhoNgW
         vynerNDFklqpX1merQwgD4qfIw6Bubp6zWItbfSqqIp10ZJ4oOs0N2oiYBcNY29xqBnM
         UXDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qjre8fS+9GViFqByLAyAAoZAyQGtJAkIzdGZFWs/uEM=;
        b=jh6XFZZRKm9M02jqtOWS/792DYXFqvoCFKWotYZveOJfwuXBkgyT8lsnqePBoYjBfm
         AHCeTFQ7gwOO9DTzK8QA4ZuUlk6FyVKExwI/mCl5jQmIdhkr4KqNQeZ1VuHwyKUg/51m
         DFPDYE6yrRy2iUUmI3ETaCdH3AGEwY4Kndn2cKnP0/q+L0NlC3DstynVH00x9Q+7Ar/t
         qE8AxC4BCxhU7bosDkDLb7E6w513o6Zmf+5D4uLjuR6ms1H6M+e1E/FpiEAdvXDjclb5
         LHu+2Lba3YqpZCZrqqk9bsfjLpeiOfjhjimFJXZsyVOOkfVwXiKTJ2kjZU/yNrsYHHpx
         QKGw==
X-Gm-Message-State: ACrzQf1is+Rg1mXJ3QUtdVlPvxhyxH7afgl9MyGP75l/PjSzDBEovGfg
        /dkEHLyJwZb2AUsqXOKUL2GnFkncws2mYCo6
X-Google-Smtp-Source: AMsMyM6uE+XKGYfv9vRMAA/DxbRTR0KKTAqQ4fFJ2yoC9/emk8bT9TSf2H09N1x8/vE2qUH5rCQJPA==
X-Received: by 2002:a17:90a:5987:b0:215:d4e8:6f7f with SMTP id l7-20020a17090a598700b00215d4e86f7fmr8311685pji.246.1667499647000;
        Thu, 03 Nov 2022 11:20:47 -0700 (PDT)
Received: from ?IPV6:2405:201:d02f:da6a:d4a2:1253:adfc:370? ([2405:201:d02f:da6a:d4a2:1253:adfc:370])
        by smtp.gmail.com with ESMTPSA id z12-20020a170903018c00b00186e8526790sm997572plg.127.2022.11.03.11.20.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 11:20:46 -0700 (PDT)
Message-ID: <b9b77873-9004-425c-276d-ea5ef8ebf7dc@9elements.com>
Date:   Thu, 3 Nov 2022 23:50:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v6 1/2] dt-bindings: mfd: Add bindings for MAX5970 and
 MAX5978
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
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
From:   Naresh Solanki <naresh.solanki@9elements.com>
In-Reply-To: <613d7971-37d6-c8db-523e-cf3cbdcd5287@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03-11-2022 11:31 pm, Krzysztof Kozlowski wrote:
> OK, so indeed there are improvements.
> 
> Yet still you did not improve the warnings coming from the binding -
> this does not match your binding. Test the binding and you will see big
> fat warning.
Not sure what I've missed but below is the output:
make dt_binding_check -j1 V=1
make -f ./scripts/Makefile.build obj=scripts/basic
make -f ./scripts/Makefile.build obj=scripts/dtc
make -f ./scripts/Makefile.build obj=Documentation/devicetree/bindings
   dt-extract-example 
Documentation/devicetree/bindings/mfd/maxim,max5970.yaml > 
Documentation/devicetree/bindings/mfd/maxim,max5970.example.dts
   gcc -E 
-Wp,-MMD,Documentation/devicetree/bindings/mfd/.maxim_max5970.example.dtb.d.pre.tmp 
-nostdinc -I./scripts/dtc/include-prefixes -undef -D__DTS__ -x 
assembler-with-cpp -o 
Documentation/devicetree/bindings/mfd/.maxim_max5970.example.dtb.dts.tmp 
Documentation/devicetree/bindings/mfd/maxim,max5970.example.dts ; 
./scripts/dtc/dtc -o 
Documentation/devicetree/bindings/mfd/maxim,max5970.example.dtb -b 0 
-iDocumentation/devicetree/bindings/mfd/ 
-i./scripts/dtc/include-prefixes -Wno-avoid_unnecessary_addr_size 
-Wno-graph_child_address -Wno-interrupt_provider 
-Wno-unique_unit_address -Wunique_unit_address_if_enabled -d 
Documentation/devicetree/bindings/mfd/.maxim_max5970.example.dtb.d.dtc.tmp 
Documentation/devicetree/bindings/mfd/.maxim_max5970.example.dtb.dts.tmp 
; cat 
Documentation/devicetree/bindings/mfd/.maxim_max5970.example.dtb.d.pre.tmp 
Documentation/devicetree/bindings/mfd/.maxim_max5970.example.dtb.d.dtc.tmp 
 > Documentation/devicetree/bindings/mfd/.maxim_max5970.example.dtb.d ; 
dt-validate  -u ./Documentation/devicetree/bindings -p 
./Documentation/devicetree/bindings/processed-schema.json 
Documentation/devicetree/bindings/mfd/maxim,max5970.example.dtb || true

Didn't get any error or warning on example.
Made sure python package dt-schema is updated as well.
