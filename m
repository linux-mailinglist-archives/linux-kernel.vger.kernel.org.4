Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C132B6406DF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 13:33:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233498AbiLBMd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 07:33:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233332AbiLBMdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 07:33:21 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1035A47C1
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 04:33:20 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id h12so7541581wrv.10
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 04:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cJwzaKaMrWFhAvex11bm93qTJcU89/Sq0ScCxsqnnvs=;
        b=V24Vuwv1wN58pQrlA1Re2kKmo6y+/g9N5UepmSSvbRygx/FQM2FblAcdwc6VDk8Eyv
         V0Ouzo2xwGqA7HwDm+J2v9mf9SF4V5gwpaDyXzipyUnQBp5ROnVOR6IzRooGKCpLJMHo
         tMRxfc5m5uuSzGtCIU6tBPfCrukw/l8diopKifgGAxnYx2KdcXRR64FQmnID+RxnqQg5
         h8tXuURfMdDQprX8PPck9Kv6dUCH7zJT6KAvUlXaK4H3vcouV5QfIFlNO+xIoMfLXS2w
         3ScqeF+B8Z0DuqfQvtlspz+L9v+j5vGyQuFuutn5XniaJulqIExhEZ7GzoRXtJqIVI4f
         E5sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cJwzaKaMrWFhAvex11bm93qTJcU89/Sq0ScCxsqnnvs=;
        b=GKvg8qopoY8S4hKW97wcG0Jlu07dSaz/Zn1S+R6Zht1sg0COOeD4vs1ATTrrDBVrnH
         uxosv34Zeu0aw+lhkAvDWO3T8ju3ZfK7JhgeaBZwnepGHziJ8r+Y/stOsC+Xn/uACPlt
         iy/t754I1Qt9/pLZ1B55A1cM52TkgnbAiNyolc8ad/egb4eWTKZYzDgxxP2I/KQM9s5m
         m6DI1OaOg3o4WSNnW2RpAJ7tAMQUdThB078YhYpARclLX4bjzICb/wtMVVyubGbBddcC
         ESNLdvlT1RtikBEQ+Ak+dBFi3LxQk8Xk02JdTuhB89nyR0yc1qbyEU3qnoV9SFt9cvZz
         ZvJw==
X-Gm-Message-State: ANoB5pn824xQ70OL7MbP7dGdFGYwh4dxxnRFIvKSopT6wNE+td4fHKHK
        oZizjO2zthbs58zB9sU/IIN8tg==
X-Google-Smtp-Source: AA0mqf4zPMi2Eevw6Im0UvBKeRGnX4L/F4vs06SZXVKkBZLgBESdfK7Xq0T7I942LkFK/plWa8ugBA==
X-Received: by 2002:adf:f74d:0:b0:236:4e3c:7720 with SMTP id z13-20020adff74d000000b002364e3c7720mr44036138wrp.674.1669984399227;
        Fri, 02 Dec 2022 04:33:19 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id v7-20020adfe287000000b00241fea203b6sm6948112wri.87.2022.12.02.04.33.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 04:33:18 -0800 (PST)
Message-ID: <ab0e318d-0840-a76f-bf34-73db659eef63@linaro.org>
Date:   Fri, 2 Dec 2022 13:33:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] clocksource/drivers/hyperv: use Hyper-V's page size to
 calculate PFN
Content-Language: en-US
To:     Wei Liu <wei.liu@kernel.org>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "mail@anirudhrb.com" <mail@anirudhrb.com>,
        "kumarpraveen@linux.microsoft.com" <kumarpraveen@linux.microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20221103152338.2926983-1-anrayabh@linux.microsoft.com>
 <BYAPR21MB1688743DD4507008D33499B0D7389@BYAPR21MB1688.namprd21.prod.outlook.com>
 <Y2PiyAEJZitd3LS8@liuwe-devbox-debian-v2>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <Y2PiyAEJZitd3LS8@liuwe-devbox-debian-v2>
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


Hi,

On 03/11/2022 16:48, Wei Liu wrote:

[ ... ]

>> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> 
> Thank you both for the quick turnaround. I will just squash this patch
> into the previous one.

Can you point to the mailing list the squashed version ?



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

