Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84FCD6406E6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 13:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233326AbiLBMgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 07:36:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233291AbiLBMgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 07:36:21 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2011AC6C2
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 04:36:20 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id v124-20020a1cac82000000b003cf7a4ea2caso6353443wme.5
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 04:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZuLGoyf4GNsq+QzU1X4N1jLCkchIEVfU5M3p1piI1WA=;
        b=wyIfqbwoITCKNp8LMX0MY4JUoX0mGHnGbDlC4CVvs7aXv8d8rWToEu3V8RmDa0JWuG
         O7QnmFJlEryHMNxughnFR0HcR6rJMPchzZXr+6/ec/yvIf0YQQRndSUzIeoqotl1Se64
         YZRgUFXqXo25zwfSGTGvsMj7gvZneArp/Y9EdJrw0Cx6g53GsE9qgSrmn0xPQTLi5vWK
         DO65nrU5fP2dHe8YzATt0dUsG0DMFAb4My7/rCWyJan/hSU2Tec1O9V1kRX42kBf9Sea
         TxK0PEyW50rVSxRWgi7GD8gOiBiG5CdqAA+cftOtCOBJia3UgFw1ERMa5QgYsnqMkPbH
         YTtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZuLGoyf4GNsq+QzU1X4N1jLCkchIEVfU5M3p1piI1WA=;
        b=AhWJ4IAVKas/p5XO2NJfV2ZyHFZE/b7Oc1aOpTrNOwmBVEEsNu+emjw/kRcjnxRGcV
         VIYYTwOHjjhiL3GJYAdAgeb4e6iqkkazgRJQoSOByuyYsqt9aXVvxbm8ExIO5iCnvhpE
         SixJzFfZp5P0MFQwCTHVSUEnbTsj6Z6FRbY4WcILOg9NiO5MCON8kYT4JCQ/Koa53UiV
         m/+2GZUnNKZzpxG3hPuJSMZs5Wgb11T4Bcj0YEXdbX5D7NrthabD6RBp29BjqnxhaQ6Y
         OZqazHt1xFVtC7ASefpDmy20yhU5Pc1AO1DtOBYuCVD/41tVlJXykKEtURwtvHyuLZDx
         5vGQ==
X-Gm-Message-State: ANoB5pnXABglc+vcFxQJ+m8c5c+m4kWYqlweZlkbF7m6AWLquChkOd1q
        N9j9Dns46TnvEh/eDuyTwUdXSw==
X-Google-Smtp-Source: AA0mqf6r43gQ4U4/KHgL2eifqynbjOH3f0HGiMQx/mRRO5hdW1LC42I+EBOGbTlrL/FxO02Fo7a/2w==
X-Received: by 2002:a7b:cb91:0:b0:3c6:cb54:ef66 with SMTP id m17-20020a7bcb91000000b003c6cb54ef66mr41708617wmi.90.1669984579054;
        Fri, 02 Dec 2022 04:36:19 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id f16-20020a056000129000b002421ce6a275sm6839195wrx.114.2022.12.02.04.36.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 04:36:18 -0800 (PST)
Message-ID: <e0dfe6b9-7a68-852a-501d-a7c86ed3145c@linaro.org>
Date:   Fri, 2 Dec 2022 13:36:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2] arm64: arch_timer: XGene-1: TVAL register math error
 breaks timer expiry calculation.
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>,
        Joe Korty <joe.korty@concurrent-rt.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221024165422.GA51107@zipoli.concurrent-rt.com>
 <86o7u0dqzj.wl-maz@kernel.org> <b6bfebb77b593e578bacec70646bc7e3@kernel.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <b6bfebb77b593e578bacec70646bc7e3@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Marc,

On 03/11/2022 16:05, Marc Zyngier wrote:
> On 2022-10-25 13:31, Marc Zyngier wrote:
>> Daniel, would you mind fixing it up when applying this patch? XGene is
>> trivially broken without this fix, and it would be good if it could
>> make it in one of the 6.1-rc.
> 
> Daniel, are you able to take this patch? I don't mind respinning
> it myself if necessary.

Yes please, if you can take care of updating the patch that will help. 
I've been in leave during a long time and I'm still processing all the 
submitted changes I received in the meantime


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

