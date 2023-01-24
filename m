Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D281C67A057
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 18:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234632AbjAXRmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 12:42:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233508AbjAXRma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 12:42:30 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D9F16AD1;
        Tue, 24 Jan 2023 09:42:29 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id a18so2900891plm.2;
        Tue, 24 Jan 2023 09:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1aw+tabE+7rYoEAruCtHY8q3Q+/Ll8iXEYyydAkaDNY=;
        b=R+AA3leOaim17iaMKFAzsawKyaijVW6fPPQgkOdlk7UzFry0/PiHwMNFGXJtl7yHCr
         ULY4o6z8Y0NVssb96Cye2MobRy/ktiXfhpC7CDVtWHA4wxDnyEIbu00Abc6s5UMX1lrR
         0TAJqAvSnKSKF8v/E382vIYgt1gR8ri7SLycTykkiQAKS13BlSZUFmH6h2OKPQxNDbEV
         Ap+UaAusl5mWKhkAPBKq45L1N8tVMcofPMAdefsnK0agQ48OvsR3pL+SA05cvl8PVo79
         lMsZsGa1G4M9fNykaekbgJhps8eu9VziE6RQeiyEDkPQAV1HMRlJTwwqaEgUdl1jqpSt
         moHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1aw+tabE+7rYoEAruCtHY8q3Q+/Ll8iXEYyydAkaDNY=;
        b=j6JbGmBCfzpjX90KP2bdWE+YaJbay/4ls4Exu4jrPAI0ht63/s5PwNDdjl7T8Cr0zj
         jVtFREn9mUVP7ly4P61fTsCU1nngYrQ3dStwevwfueG94i87PVIs9SjjQ76EYXnUkN6s
         fT4Ztjo0L9cc6awRCP1mUR7xJQpALPPM9e9NHtZDacATCqWK8kjwtTHWenLfIYWd/5T/
         G5vNm2lTFfE2gjJxenFeO+6hQPxY4rkmr5CgSzTe/SvBiukU02FMvaFrgdHxi+/sEpOE
         a+E18LLYdXRI1+gXLgbJOWOUcSxifHyPAeV14fAdwYKZof44XFx2z4t2vY/6Rk6xprgv
         vBiA==
X-Gm-Message-State: AFqh2kphsC9w6THjJy7duJ1pJZoomXaA/oV3+EYeVIEI6x43wQxYJ/Zt
        fubze+XahIba9oDep97JuXc=
X-Google-Smtp-Source: AMrXdXsXtJNxzI/D+JIweau0WKFTWKJlEQGlPCfvTU6QWtRH2bpaxbbbHvEm21C2Se4ICIHZaNGszg==
X-Received: by 2002:a17:90a:db90:b0:22b:b3b6:cf76 with SMTP id h16-20020a17090adb9000b0022bb3b6cf76mr16714631pjv.17.1674582148347;
        Tue, 24 Jan 2023 09:42:28 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id t8-20020a17090a1c8800b0020aacde1964sm8605583pjt.32.2023.01.24.09.42.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 09:42:27 -0800 (PST)
Message-ID: <4982a703-fc6b-b778-78a5-ada5ea5aedb2@gmail.com>
Date:   Tue, 24 Jan 2023 09:42:19 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: (subset) [PATCH 0/6] rtc: brcmstb-waketimer: add RTC alarm irq
Content-Language: en-US
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Doug Berger <opendmb@gmail.com>
Cc:     Brian Norris <computersforpeace@gmail.com>,
        Markus Mayer <mmayer@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230120190147.718976-1-opendmb@gmail.com>
 <167451526504.1264870.8427240602882815591.b4-ty@bootlin.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <167451526504.1264870.8427240602882815591.b4-ty@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/23/23 15:08, 'Alexandre Belloni' via BCM-KERNEL-FEEDBACK-LIST,PDL 
wrote:
> 
> On Fri, 20 Jan 2023 11:01:41 -0800, Doug Berger wrote:
>> Support is added for an interrupt that can be triggered from the
>> brcmstb-waketimer hardware while the system is awake.
>>
>> This interrupt allows the driver to pass the rtctest selftest.
>>
>> Doug Berger (6):
>>    rtc: brcmstb-waketimer: introduce WKTMR_ALARM_EVENT flag
>>    rtc: brcmstb-waketimer: non-functional code changes
>>    rtc: brcmstb-waketimer: compensate for lack of wktmr disable
>>    rtc: brcmstb-waketimer: rename irq to wake_irq
>>    dt-bindings: rtc: brcm,brcmstb-waketimer: add alarm interrupt
>>    rtc: brcmstb-waketimer: allow use as non-wake alarm
>>
>> [...]
> 
> Applied, thanks!
> 
> [1/6] rtc: brcmstb-waketimer: introduce WKTMR_ALARM_EVENT flag
>        commit: 90226f6b17a3edcb0bddaf2f16991861c99d6a15
> [2/6] rtc: brcmstb-waketimer: non-functional code changes
>        commit: 2cd98b22c1443d1f2921a371baee658da184868e
> [3/6] rtc: brcmstb-waketimer: compensate for lack of wktmr disable
>        commit: 516ae02c38ff3ae867f9b19fa050f78157e2bdae
> [4/6] rtc: brcmstb-waketimer: rename irq to wake_irq
>        commit: eae258edcb8705932c9e5c61a99f91d8235f688b

That was quick, how about patch 6? It does not actually have a 
dependency on the Device Tree binding (patch 5) and the second interrupt 
is looked up by index.
-- 
Florian

