Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF8836168A5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 17:24:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbiKBQYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 12:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbiKBQYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 12:24:24 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B0C1097
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 09:19:27 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id v8so5578217qkg.12
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 09:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8+dadXVFqCoia/hpBdLne3NYLRvyf5yEyoSgvo5I6BM=;
        b=TObbKuYy7nPg8oNPSValgebOVaZsjMYhJKJYx7aKLU4RuZIzrRIhxQp8V+DarvhjHQ
         kM1KTC25DYkZJGqAsVJR3r6xOgv/1PB3dk/eDid8vkJd/pP2BtQmecndAdttJj5DBHa3
         mPlwONoVPegx3IC2Gq2INbD2EYWbclezWdTamHMjymis8EVMRHDaNGKZe7K2iTGTAiYe
         jfaYoYOPkyrUBI8fbBXC5uPAsv0m5L6kZqajhBJI2D+fIndYnFpr4t399HUwnh6yOnlk
         ygp/fOmTC2xoDwT9I+OY8f3/D+3qDKG3wtR1lArRjqcC+REr90BdmVdeotxCOnct6ku7
         KJoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8+dadXVFqCoia/hpBdLne3NYLRvyf5yEyoSgvo5I6BM=;
        b=FaGT+jOMTTja7fJBZXA++Y4NGRBasEoC5/hA7t2wrnmM6j/vyjNQKFIlkMsrB+YqCM
         VRPwGVtVbeDDZ1LRQLJP/FHJhNeZRkTK622kWDEskCRs3/s+l7Nm6yWBq9RQreSh+730
         G7nKXIDznpK6jVH9/6/LKBC0/WIpVLvhP4A9Uv5HTf0IHrrqfe0aPBHAphkyoXyWZX2M
         C5j0B6GhfG5AKxnaISBVuZ4qaYKBa/OyRxk5QKf0Hf8c7RV9WarMoYKbWFDMoPy9TykL
         EAQnL8Ri2KPuwDPpDyocLyPgWz/bpJUptTJFDmDIWL8KT4sipxb9A4n25CsTUffcYBuT
         a8nw==
X-Gm-Message-State: ACrzQf3r+nDouaCHCpeLHPD1yrLNbdJVTx+YYRR5+Rez3QIrySctjS+3
        ZaZ3lOfti8DQZoqQw8Aojdu0qQ==
X-Google-Smtp-Source: AMsMyM4bfAu9rx5kzzrk6jmkaHycCDsic51/wAojbsHDb41AJ/LndIGKdkwgHTpqj+hrnlU9ip57jg==
X-Received: by 2002:a37:2f42:0:b0:6fa:65:6f71 with SMTP id v63-20020a372f42000000b006fa00656f71mr17960308qkh.191.1667405966985;
        Wed, 02 Nov 2022 09:19:26 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:28d9:4790:bc16:cc93? ([2601:586:5000:570:28d9:4790:bc16:cc93])
        by smtp.gmail.com with ESMTPSA id x13-20020ac86b4d000000b003988b3d5280sm6751132qts.70.2022.11.02.09.19.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 09:19:26 -0700 (PDT)
Message-ID: <d475d80b-37b5-29ee-4a5d-dee8c4083834@linaro.org>
Date:   Wed, 2 Nov 2022 12:19:25 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 1/2] dt-bindings: leds-lp55xx: add ti,disable-charge-pump
Content-Language: en-US
To:     Maarten Zanders <maarten.zanders@mind.be>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221028133501.95833-1-maarten.zanders@mind.be>
 <20221028133501.95833-2-maarten.zanders@mind.be>
 <34c4037b-d152-412d-e551-dd3ea27b6b46@linaro.org>
 <7cbb1cc5-e333-db25-77e2-7a1ebda70e24@mind.be>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <7cbb1cc5-e333-db25-77e2-7a1ebda70e24@mind.be>
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

On 29/10/2022 03:48, Maarten Zanders wrote:
> 
> On 10/29/22 00:07, Krzysztof Kozlowski wrote:
>> Drop | 
> OK.
>>> +      Disable the internal charge pump.
>> Does it mean that it is enabled by default?
> 
> The device default after reset is "off".
> The current implementation sets it to "auto".
> Other possible modes are "bypass" and "boost".
> 
> Should I change to an optional "ti,charge_pump_mode" as string and set 
> default to "auto"?

enum makes more sense in that case. Just don't user underscores in
property names.

Best regards,
Krzysztof

