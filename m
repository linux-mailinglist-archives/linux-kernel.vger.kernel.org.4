Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 299476D8681
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 21:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234461AbjDETEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 15:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232950AbjDETEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 15:04:12 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68E06A4B;
        Wed,  5 Apr 2023 12:04:08 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id bm2so27416982oib.4;
        Wed, 05 Apr 2023 12:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680721448;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=f2PHQcp6j+fOB0wOWpZhgTKBcLCw1aqfvMVgCTudii0=;
        b=Blh1+p9JnizMWNsizP4LG04uOuW/nGAceNKeEqSmP/vmiQkIeZNM45BNgQJzJj623B
         LEV/mVGUyYh1Smy5SRjfQ8AjWlAMG6n4JqjcdwaPNt6tD3Q5uYn+u94IIauzf3Gn3Ma0
         rUW2pLwfZApoHB119cRYceb8HKkjHx3BbR9BkJEHCxUMrl8d4lqcPP/xkgI76GXrfC+e
         BSoHKits0j0Qr659ize08DpQSxIFHqp0H6Q0DnTED9I60X9znJOjaCdD2H2vtANDlBpR
         bdL+hTkAzm/xufVhyxuuS9KbIJ5J+5Qy41xnzvEsWDW/ByA1nb8hlQAJtlEUVYLK2KHH
         8mEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680721448;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f2PHQcp6j+fOB0wOWpZhgTKBcLCw1aqfvMVgCTudii0=;
        b=lYKhpR3hcnxxjiuOq05sgjgVWhYISq3SF87IcY712lCkatjavZe/tEYvyhlDbaCBmr
         seQmKJp+PBECToDRC96HXuCcQssLdJ4s3HTx61bTSKG+erU0a6zX8MsjBArAtIOBWXRF
         mMpYR9e5zTVpXt9bFIRRCkh2acH0kxz9vpiWTUefqUFJ6b/pSg2GkxKdsedHOC3r637X
         D8J2PKcIhRrBSSXb1tph6Q69nPdHIuteMtI/FSP/V+vz9k2aHf2d+RgmIar269ZfWaYy
         3eyphmX+6rLKFIWBHVjW1GTt2SA8Z8eovHsloKMobSp2G5EC2994GDJRKV+42rrhfVpf
         FKLw==
X-Gm-Message-State: AAQBX9eG/wtgHuWknoOaDYRjo324vrtkzz0fuVfeOL4XEAfeOlaUZoB0
        iMNWE79/SeKrbnIKvGBbn5s=
X-Google-Smtp-Source: AKy350YEv9MdPEl3n9VRLhEeklhy8ACWem+NigjVwgr7lXnx4zWfNnLSr4Kmw1u5p5gZ7I9O1/P/pw==
X-Received: by 2002:a05:6808:638e:b0:386:bcc9:fe99 with SMTP id ec14-20020a056808638e00b00386bcc9fe99mr2988908oib.5.1680721447212;
        Wed, 05 Apr 2023 12:04:07 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u13-20020a056808150d00b0038413a012dasm6474916oiw.4.2023.04.05.12.04.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Apr 2023 12:04:06 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <1a914522-8780-febd-7224-121b1f1fc2ba@roeck-us.net>
Date:   Wed, 5 Apr 2023 12:04:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: (subset) [PATCH v2 0/2] Add PWM fan support to Rock 5B board
Content-Language: en-US
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        kernel@collabora.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
References: <20230404173807.490520-1-cristian.ciocaltea@collabora.com>
 <168071663557.3186456.17606522894011578076.b4-ty@sntech.de>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <168071663557.3186456.17606522894011578076.b4-ty@sntech.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/5/23 10:45, Heiko Stuebner wrote:
> On Tue, 4 Apr 2023 20:38:05 +0300, Cristian Ciocaltea wrote:
>> This patch series enables support for the PWM controlled heat sink fan
>> on the Rock 5B SBC and, additionally, converts the hwmon PWM fan bindings
>> to DT schema format.
>>
>> Changes in v2:
>>   - Updated PATCH 1/2 according to Rob's review
>>   - Added Reviewed-by from Christopher to PATCH 2/2
>>   - v1: https://lore.kernel.org/lkml/20230403105052.426135-1-cristian.ciocaltea@collabora.com/
>>
>> [...]
> 
> Applied, thanks!
> 

Both patches or only the second one ?

Thanks,
Guenter

