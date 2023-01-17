Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2C966DC07
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 12:14:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236676AbjAQLO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 06:14:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236842AbjAQLNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 06:13:38 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48FB42B083
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 03:13:36 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id h12-20020a05600c314c00b003da50afcb33so5587376wmo.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 03:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6E73OKZGFC8KlEV5K+4dmiSqL5MeLnVsI9NufUq0/Qk=;
        b=deYr0LmgzrLFK1aoSsIg3H9oleKzD0u8Di4/Vk8ZfniLB0192jc9ZHGtpVO2HjSFzt
         sy94YCBcXYyiyd8MYK+BnKJmzpM8P6LHfKkFb/HH3fiw9sRCAf6BLvGtVRpsnbFcuGMU
         yaHmOsws+tmLy1/q9nS13EmAX1suDpPQQ80SOa6aQrtTDqr7vzliTdtX3t19ISKeVduR
         v1hCcoqHEM2pCANzroxa5obX1BczZOmDClKMcaqDHE9Rb+wg3QZKug9R5ZZNf42AZQPL
         cWoCMwASKolu7kh873RYf4WGm+pqcJPWUarKZAQlnHywf/BfGtUMpK2nlDMdub2y1nvb
         cEGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6E73OKZGFC8KlEV5K+4dmiSqL5MeLnVsI9NufUq0/Qk=;
        b=OBDwPmhU/aZrkqcTES4O1kc9rGe8SF1lX+DHjOv06TJYyMPtzQl06U5vdMT+I3YmoC
         eVJXc+6GU455/T+EkUeh6NxWU/Y+zOdpY3mh/nAsz7RcmxspLQ1lgQlcH1EoavYgJEMd
         D8am9IchCINqwA+tXCs03ZKWfc/MC1Js+grBLTfgJJhi/051Wy/DutIBbOUTDhgALyVs
         /V+/TdcG6JLJeuiXMR3lsGFc/p+z5VFXWU1V7d7utrmKSm5CG/2DB5zk5LAuuQMPHBOU
         PuvEuMn0gwoDghYp1GYny5jhqDuaL8LA8gv+45EVc13WY4bTLtuPmoe71JN13jzwZUcN
         MeEQ==
X-Gm-Message-State: AFqh2kpgvFFvWMKjRv8uw/bMQVsiGiAAbwoAIXqWStflyYCPyqZrqGW2
        mKqIPiwzDM2lUKxPd8+UbF9EtA==
X-Google-Smtp-Source: AMrXdXs5ZMgafBZZX2IEn9ljGfxmf4yKbG7WJzajhPYUrZMq7eopmS63raTaCM5nJwQ7o8SPJru50g==
X-Received: by 2002:a05:600c:348b:b0:3cf:7b8b:6521 with SMTP id a11-20020a05600c348b00b003cf7b8b6521mr2627992wmq.32.1673954014729;
        Tue, 17 Jan 2023 03:13:34 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id f15-20020a7bcd0f000000b003d9a71ee54dsm35441612wmj.36.2023.01.17.03.13.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jan 2023 03:13:34 -0800 (PST)
Message-ID: <c5167eb8-22d6-c230-5828-80e59154aeb0@linaro.org>
Date:   Tue, 17 Jan 2023 12:13:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3 2/4] powercap: idle_inject: Add update callback
Content-Language: en-US
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rui.zhang@intel.com, amitk@kernel.org
References: <20230117020742.2760307-1-srinivas.pandruvada@linux.intel.com>
 <20230117020742.2760307-3-srinivas.pandruvada@linux.intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230117020742.2760307-3-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/01/2023 03:07, Srinivas Pandruvada wrote:

[ ... ]

> +struct idle_inject_device *idle_inject_register(struct cpumask *cpumask)
> +{
> +	return idle_inject_register_full(cpumask, NULL);
> +}
>   EXPORT_SYMBOL_NS_GPL(idle_inject_register, IDLE_INJECT);

Why not just add the parameter to idle_inject_register() ?

There is only one user ATM


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

