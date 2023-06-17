Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68C11733F06
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 09:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234686AbjFQHMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 03:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234063AbjFQHMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 03:12:32 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DCDD213B
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 00:12:31 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f900cd3f69so3643405e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 00:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686985949; x=1689577949;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SHuRK5yrOAZzHQ9WBWjIol/EVx+4lKJS52e0FUFGTIA=;
        b=WYmeWxy/fblK4tTo5Kko5JcGQqtD97d7Pwz9T27oxY49f7Rk1/Y7+TL9JcYKVzg8gd
         9k5WLt/jfmVe2bNcJHyP4hHslgvbbSRlu79hMtGJjclh7W3CApPwMfBJP2iDfXOq3I7t
         t/FhNh7/qBru1saWiMkNUIPegPLhNVpiA7JzZaIQCk4IgaJfvr/XkRiUxZe1VijyFUPM
         rx7/6kSQUPlCGx8/h+FWBDYfaJkb2GllJ/o8Jc4Vi3oP5xNlRd6cDVoc52ovKQPLEEzu
         zto88ihFiT5aOkIEnIWKSUZIlslTxV6WQOlJWNCSpd/YuF+ojwqwfMMqy6dq56+2dWOb
         4ftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686985949; x=1689577949;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SHuRK5yrOAZzHQ9WBWjIol/EVx+4lKJS52e0FUFGTIA=;
        b=U9uCk+41rgnW58tX1iQABU64bisv+oOTOLlABw7T88lO2WwGpqSw/M4DXOXbKm3Ux0
         Q0szWNmlOU8bYzKwHVcMoevXUNypyx8e2Q1CS8WOG4MrZWqBhQohT1nqEhVmmun2lOLM
         baYoBH2qbtowoXig76ZRbQaUUmKlQWpqt8bqqZyjwAZ82YVokX0dF4II+VTjlW9mAskl
         xzf8SfRBf6KdFtIKRhxtcdx7jh78TGUMj6VZXAk3fAALntEvRi88B/lTpe1bzGum7vKm
         GtJQbdciXIZgYY+Gk7WpZpLMBAsGDNwZlATlz7/pYnouFEHIXtCIW/63FIl9UPO/5F/z
         IfSQ==
X-Gm-Message-State: AC+VfDy3LrntrrktzAcMzM7YeABX1UPs4ZxRtp2oGN66K0fyz4AMfjJz
        N6W0MX0GWPyumUMX2UciAwGcHcQi0MFMptO3KxM=
X-Google-Smtp-Source: ACHHUZ4Ud7lQ8ejx3wbY/Gp18DoNVMVg+GQ8oKKNeAmLL51OE2FZE59bFzPi6e1YEfX6Eas25160GQ==
X-Received: by 2002:a7b:c8c2:0:b0:3f9:5d0:b71d with SMTP id f2-20020a7bc8c2000000b003f905d0b71dmr203135wml.30.1686985949539;
        Sat, 17 Jun 2023 00:12:29 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:4aa0:8c56:eebe:c05c? ([2a05:6e02:1041:c10:4aa0:8c56:eebe:c05c])
        by smtp.googlemail.com with ESMTPSA id k24-20020a7bc318000000b003f733c1129fsm4114574wmj.33.2023.06.17.00.12.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Jun 2023 00:12:29 -0700 (PDT)
Message-ID: <422def66-911e-9e2b-34a4-f595776f43dd@linaro.org>
Date:   Sat, 17 Jun 2023 09:12:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] thermal/drivers/loongson2: Fix thermal zone private data
 access
To:     zhuyinbo <zhuyinbo@loongson.cn>
Cc:     rafael@kernel.org, loongson-kernel@lists.loongnix.cn,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        zhanghongchen <zhanghongchen@loongson.cn>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
References: <8ca44091-35fd-cc24-9896-0317772c5620@loongson.cn>
 <20230616143407.689515-1-daniel.lezcano@linaro.org>
 <9c12ece8-3a85-105b-d8d3-208fe816734a@linaro.org>
 <323267b7-3dbc-8982-7f16-08672b19039b@loongson.cn>
Content-Language: en-US
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <323267b7-3dbc-8982-7f16-08672b19039b@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/06/2023 03:52, zhuyinbo wrote:
> 
> 
> 在 2023/6/16 下午10:35, Daniel Lezcano 写道:
>> On 16/06/2023 16:34, Daniel Lezcano wrote:
>>> The thermal zone device won't be accessible directly anymore.
>>>
>>> Use the private data accessor.
>>
>> To be folded with your next version
>>
> 
> 
> okay, If I understand correctly, I will make this patch as a independent
> [3/3] patch of the v15 series patch.

It is better to merge it with your patch 2 in order to prevent a git 
bisecting error (no need to add a my signoff or whatever)

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

