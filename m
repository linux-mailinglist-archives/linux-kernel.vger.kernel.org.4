Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1960B689E70
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 16:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232766AbjBCPi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 10:38:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232100AbjBCPiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 10:38:54 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4518A7DA
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 07:38:33 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id qw12so16452679ejc.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 07:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mind.be; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W9D1MtwohWAcSI+dqXIF3V/F6XwBaTkRzipfSL8tRIU=;
        b=PbovNEv5EDv8GaV3xzbWFWOX+wZxwnJ9wtulJadvd2aJPRPjEEu1TZCv3EjkV71nPi
         fvBH87FI1O+w1rsup6XgFuEwdu/zVnDm2ji/Gyc1twP0A+r9is+43dGJR06R0cLaoi8v
         nBURDhCsdtg8SrH918xCJT8f15aB1wcFe1or/rF3/Kgd/YJj7VJtIeUsUaMIK20FewWY
         qJdMRXWabVH6X6Wu0SpAJvgiKpRXDWfrngTjMIpyi8++gJtWTjXohFjSd9CONnXWov0Z
         oRM7NEd+BPQcEqzSocE1jvlB3TKB4Guf+tIDTY5XYNYhHRD65l99H0i/o1sW7galLsBf
         oCwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W9D1MtwohWAcSI+dqXIF3V/F6XwBaTkRzipfSL8tRIU=;
        b=OrfPi/EGX+jlWI2Ouj0sMsScHDBpATUHO1s92U148y9oEWMuj/gAOl8O9m1pYVVzoy
         exD3Ri5lsuP4DrWi35oi+2iRCrmOrxvOJ+eZAaf07DzynDCynHteho6HLX/tEpdsgg7F
         5XTc2ljQOOMrYeWi4lc7eVRx4nvYZV1FzEegZcALXdPGl6opHK/yc4OMxa7zk8Po//lW
         k4YyWCkdo66taufhedoDjedZmtmUA89WTP7wqoKSm3RlORvppyQfCG/KCLTfMWyrNify
         8rvSZESAty/fAy0aqSpnCKY+NGoaEe3IioKotlS4k58A+jEbqTRUy815oQ7A06s/YCMj
         ZCPQ==
X-Gm-Message-State: AO0yUKWcZZ9tZ0H5F0onGfdYAWmGBbtL0RZxgUL+r2oDhmMwPNETIL5Y
        Wcuz/ka6p1vMXWjFG60oyBUdpg==
X-Google-Smtp-Source: AK7set/n1bZMm/DBcUP7HFdnSACAio4aFr1UdewcRdhd8EFQdo2q7K4Jfxhz/uNDcak+BP0sUq+x0w==
X-Received: by 2002:a17:906:2d4a:b0:883:5b33:e019 with SMTP id e10-20020a1709062d4a00b008835b33e019mr10385242eji.61.1675438712037;
        Fri, 03 Feb 2023 07:38:32 -0800 (PST)
Received: from [192.168.2.9] (78-22-137-109.access.telenet.be. [78.22.137.109])
        by smtp.gmail.com with ESMTPSA id p2-20020a170906498200b00878803d4049sm1541899eju.93.2023.02.03.07.38.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Feb 2023 07:38:30 -0800 (PST)
Message-ID: <1452beba-19b0-7417-716e-a255c6aaa739@mind.be>
Date:   Fri, 3 Feb 2023 16:38:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v4 1/2] dt-bindings: leds-lp55xx: add ti,charge-pump-mode
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230202101032.26737-1-maarten.zanders@mind.be>
 <20230202101032.26737-2-maarten.zanders@mind.be>
 <28cf0c1f-ee5f-79e4-609a-2cdd24db9f1c@linaro.org>
Content-Language: en-US
From:   Maarten Zanders <maarten.zanders@mind.be>
In-Reply-To: <28cf0c1f-ee5f-79e4-609a-2cdd24db9f1c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/2/23 21:13, Krzysztof Kozlowski wrote:
> + ti,charge-pump-mode:
>> +    description:
>> +      Set the operating mode of the internal charge pump as defined in
>> +      <dt-bindings/leds/leds-lp55xx.h>. Defaults to auto.
>> +    $ref: /schemas/types.yaml#/definitions/uint8
> This should be then uint32

Why is that? I specifically chose uint8 because other settings for LED 
are also uint8. The implementation is also uint8. I surely hope we'll 
never get to >256 modes for a charge pump.


> default: 3
> (and drop last sentence about default)
OK
> +/* SPDX-License-Identifier: GPL-2.0 */
> Dual license.

OK

Best regards,
Maarten

