Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72EB3691FD7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 14:37:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbjBJNh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 08:37:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232242AbjBJNhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 08:37:25 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E1A34F6F
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 05:37:16 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id m16-20020a05600c3b1000b003dc4050c94aso4069881wms.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 05:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N7ekQ1ebVb37EvbrSMM8z2fZgMGZlkF4SAJIlmmXlIM=;
        b=FCf0kR0Gjrjfjr3X70C69QAWt/URQpaCkheBjnMlDc70dl4LzCqdDKZ0tAGyf2FEPs
         jI5F7nxgsGcpWMgcP2KL1Hk8Fdjak4Vu8TW1zgX+nZN6Rmm0FBgJLubzWXJ0r1J7zaVf
         mwcTyZz4yHW9LtRcav7buitHSFWRy133YRyTOHELsVJiYUHYLRuOroxoW//jkYnbnqoi
         NwmS2XnikbTHrOW1s95tZj6joLbawoAuRxPw5MJF3DvR04vpJfp/F6MHutBoPRwKRrd0
         Vm0mnznVit4L96oO2PsX4Pg+016PNwIf1cfSyu/McZj3p2W0I862YPPV5Jz9TFrumF2a
         Au3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N7ekQ1ebVb37EvbrSMM8z2fZgMGZlkF4SAJIlmmXlIM=;
        b=fu4mMq8bRu7eVzW7NvKg7e1LydAfjEmT8I+ypTGiS/vknDFQqQjzMLgGApbvMni0tt
         RcHd/5BwXct23VHycR+hhHgxLNmh9w11NgSD1bUrStC0uPTyDTw2PEv5dnwrCnRpmKF8
         HFjrFkLBluRt6wWN5n15anDyJJUYeZ7ByZjO8tZdhLh1D5IK3Mkgmji+CYCkUPRBPB+u
         74SWtEJBcvPgRiL/NJc0kf37KkYn1iRZBoQWOe4Vt6zYT0PXuJZlLgs1YftZnJCC5FrT
         SmkrzStC6hkXt5GezFXHqRQ9czod9lFfe6Vt/6RzIzUx2NSXV3bxmtgEWJ6JnbhXUgST
         43JA==
X-Gm-Message-State: AO0yUKXQr3mnV15urmp/gc4/34x4EBclCZN/HmfOG8djWn165x/MYJKq
        sHZJ41sFgwUPq1vg4IHQxY948w==
X-Google-Smtp-Source: AK7set8fjEPYu9ZwvA/RHRPBjh1BbgUcbDV5WYTXQPAUasU7/Z6NTrezKJEnTnCHemufwUts1ejAxA==
X-Received: by 2002:a05:600c:4a9a:b0:3dc:f24:f2de with SMTP id b26-20020a05600c4a9a00b003dc0f24f2demr12948965wmp.12.1676036234711;
        Fri, 10 Feb 2023 05:37:14 -0800 (PST)
Received: from [192.168.2.1] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id bi5-20020a05600c3d8500b003db012d49b7sm12578383wmb.2.2023.02.10.05.37.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Feb 2023 05:37:14 -0800 (PST)
Message-ID: <1d2d879c-4563-4ee0-7bf1-141d5796fe74@linaro.org>
Date:   Fri, 10 Feb 2023 14:37:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] clocksource/drivers/timer-sun4i: Add
 CLOCK_EVT_FEAT_DYNIRQ
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, tglx@linutronix.de, wens@csie.org,
        jernej.skrabec@gmail.com, samuel@sholland.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev
References: <20230209040239.24710-1-frank.li@vivo.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230209040239.24710-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/02/2023 05:02, Yangtao Li wrote:
> Add CLOCK_EVT_FEAT_DYNIRQ to allow the IRQ could be runtime set affinity
> to the cores that needs wake up, otherwise saying core0 has to send
> IPI to wakeup core1. With CLOCK_EVT_FEAT_DYNIRQ set, when broadcast
> timer could wake up the cores, IPI is not needed.
> 
> After enabling this feature, especially the scene where cpuidle is
> enabled can benefit.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

