Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4A70615E3A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 09:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbiKBIrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 04:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbiKBIr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 04:47:28 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894E327CE7
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 01:47:27 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id z14so23423568wrn.7
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 01:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LacC/W4nEJTi1K9NvGGjHmz+dnzd8gTcBfyb9WbOq1M=;
        b=cXkcNEA+d7XPal/bfe1WsUKa0kt+a7cEVY5J1DH2cAjO5ctiRDAXvLJkieIOm/BYsi
         V3Qcizyu8AjXWzf0DaZi1udr2/bzEBEAFszhuorxVUNx9Puy3d+SBQirSUf00/PaZa15
         EnUbo0wweZJLFmIyVyXLkVj7+rmM7cjlU3Z3wje96es7TejoUW0aKip2QLWkUOz9eJdr
         yzZ0FE3o8aChRbHFOtchLMwlRXClbTZ7MllSb9jfK19BC+CvDgVHDfuQNjAd4/pvuBUL
         00cPXDYBJKSimPvt7e6XTzAYvVnONZvL/c8AXMUvtKEdm7+FhFZaUfMx4pMrV0tWgPPF
         BYGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LacC/W4nEJTi1K9NvGGjHmz+dnzd8gTcBfyb9WbOq1M=;
        b=14Jpba6W/ABo8Jh4JMUL6kA10r01K1l1l8uiEvEbtl5oVRFnQIyDJWyJ2RJ7tGeY9Y
         ldadkpcUBl/B6Kxy0CeD2+5EpGUKZpaYXZoOQFD6JAlNv2bR7tLGLPMLp3PSB3bPdcVR
         EvhpnJF9WYuzV68bGQryPG0sVbG5cpB34oJo5iWMn7M7yOkCZihHGsJ5s1XyQ+uitZCj
         2qHGFlQ5FQWtKGYwZIdi4k8bdNio15NhwShgrs4gjdn2N0JTrLyW7J2PcZhE8gTEHB9T
         Y8ZR39nM5/3g6y3tv8wzAWdEdqYp25NwVoS8ZtT+yD9qmfaFGZB46LfMiC95KgDIT0cq
         ibkg==
X-Gm-Message-State: ACrzQf2lEeFWehQq3qgajxn7MbLlf0vEPg52IzaNPL7jtp0t88Er4pcB
        7rNDu3LWEuKnIYW2ln/FJLNvjg==
X-Google-Smtp-Source: AMsMyM4/UnCKSPJDBb89BPx/nxH21VzXl0PaOgeJTz0qotnPqdKToT8N/zbTLYVlVCWaRARLV4HsJQ==
X-Received: by 2002:adf:f50b:0:b0:236:7d5d:d785 with SMTP id q11-20020adff50b000000b002367d5dd785mr13787442wro.427.1667378846080;
        Wed, 02 Nov 2022 01:47:26 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:6bae:ac40:a798:cbb4? ([2a01:e0a:982:cbb0:6bae:ac40:a798:cbb4])
        by smtp.gmail.com with ESMTPSA id q9-20020adfdfc9000000b002366d1cc198sm12634001wrn.41.2022.11.02.01.47.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 01:47:25 -0700 (PDT)
Message-ID: <3ee4a424-1a1f-514f-3289-cb813c382327@linaro.org>
Date:   Wed, 2 Nov 2022 09:47:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 1/4] dt-bindings: reset: document Odroid Go Ultra
 power-off
Content-Language: en-US
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Sebastian Reichel <sre@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        devicetree@vger.kernel.org
References: <20221031-b4-odroid-go-ultra-initial-v1-0-42e3dbea86d5@linaro.org>
 <20221031-b4-odroid-go-ultra-initial-v1-1-42e3dbea86d5@linaro.org>
 <CAFBinCAQKf9RvRWQTCSg7g+7NP_vbEFBUeCoFbYnyfmqeegy5g@mail.gmail.com>
Organization: Linaro Developer Services
In-Reply-To: <CAFBinCAQKf9RvRWQTCSg7g+7NP_vbEFBUeCoFbYnyfmqeegy5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/10/2022 22:16, Martin Blumenstingl wrote:
> Hi Neil,
> 
> On Mon, Oct 31, 2022 at 5:47 PM Neil Armstrong
> <neil.armstrong@linaro.org> wrote:
>>
>> The Hardkernel Odroid Go Ultra poweroff scheme requires requesting a poweroff
>> to its two PMICs in order, this represents the poweroff scheme needed to complet
> s/complet/complete/
>> a clean poeroff of the system.
> s/poeroff/poweroff/
> 
> Please wait with re-sending this patch in case the dt-bindings and
> reset experts have more to say than finding typos.

Thx for spotting those typos !

> 
> 
> Best regards,
> Martin

Neil

