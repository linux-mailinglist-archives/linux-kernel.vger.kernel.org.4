Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F17D6E6603
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 15:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjDRNdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 09:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbjDRNdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 09:33:03 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD48BB768
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 06:32:52 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f086770a50so16881335e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 06:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681824771; x=1684416771;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0Aq3Nd4jMdfAR3KI1AWe8WTAyHvr67utxQYkTtLldt0=;
        b=v7kNjL7LKX9niN5Xue8ikJnWBDrtm0XVLtHOxdvZy90cSRzm5VZ/1vWHikT4VdFu/P
         i5QVBtfkWWtv8emxmNaiZsLZlQbQkTe/Ue5z6NsCz300mHrERcs6ebUpcWpvg749zy4l
         jUq7I28kjHW3Sry/O405flDY6bwGyeaZpVUUaGvq8slXQZDvYCAzJNEuPubrCrEFGU3R
         smoaKHT/fxwUBbkmYgrpEZ2mg8uu0Bpgm7p5eBlkzr7CzB0TOvqSpthr3U0WEL3MFovR
         qTjZlGJfWK8vflQ/wNV6gRiLYddpfgUTMREdyifwgkP+ocQausvMgj4axUrDtrDrpKEx
         ezqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681824771; x=1684416771;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Aq3Nd4jMdfAR3KI1AWe8WTAyHvr67utxQYkTtLldt0=;
        b=gP9asm1yBdMrVjwvqoDYuH7ykCb6PI7QOMIYJViEdnLLlmj3aXhjqDEWRik5Jj6O1A
         8FdyUQqxVWcofUUFoTmGI0EESXVzigxzQtnJDuESlsHFpAZzwfGZ2V5hySA26vHAeavj
         of71PHY4i6O3tcJevrHCwkX6fNuEwvU5OGRxIz55ebK7h9s/0PWKl0IqWPQFy8RJpUZ2
         ISKX9POl/0HpYaI1C9Cccb5lX8VXYBDtk5Zcn+fbGnECjBv9eGmynwbMO288F1ywUp9X
         tmsw1nS+RlxCjMKTV6d5Z8WNf4CSDJwHB0iPsnCcyqu5qbakavtYoXVPpygtgQrOhtXd
         96iw==
X-Gm-Message-State: AAQBX9ft9GssSqqsIe6bkPF8Fb7znToxmu6FIbpMSiLOp27vbdx7dyus
        axZS7/F8052Ou81NemxVzRBGKw==
X-Google-Smtp-Source: AKy350Ypz3bNF+Gog3Q+ZFf+kExMFZuNRn07Jb3XMx9YombBMVJkADD4UHvJI5BGq2hd8TNAqyW0Sw==
X-Received: by 2002:a5d:44ce:0:b0:2f1:d97f:5711 with SMTP id z14-20020a5d44ce000000b002f1d97f5711mr1635126wrr.30.1681824771135;
        Tue, 18 Apr 2023 06:32:51 -0700 (PDT)
Received: from [192.168.2.1] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id t16-20020a7bc3d0000000b003f1692ebd0asm9738705wmj.3.2023.04.18.06.32.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 06:32:50 -0700 (PDT)
Message-ID: <40bbbda0-92b9-5e94-8a94-ba053c8a0301@linaro.org>
Date:   Tue, 18 Apr 2023 15:32:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] thermal/drivers/cpuidle_cooling: Delete unmatched
 comments
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Chenggang Wang <wangchenggang@vivo.com>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1681789108-28130-1-git-send-email-wangchenggang@vivo.com>
 <20230418035307.f6p2jp3nxgfyebns@vireshk-i7>
 <CAJZ5v0gZFU8Lreto8fDYa9PYUo=ZiNLr21FFSbYxMcsAc0hA=Q@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0gZFU8Lreto8fDYa9PYUo=ZiNLr21FFSbYxMcsAc0hA=Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/04/2023 15:30, Rafael J. Wysocki wrote:
> On Tue, Apr 18, 2023 at 5:53 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>>
>> On 18-04-23, 11:38, Chenggang Wang wrote:
>>> The function no longer returns a value, synchronize the comments.
>>>
>>> Signed-off-by: wangchenggang@vivo.com
>>> ---
>>>   drivers/thermal/cpuidle_cooling.c | 3 ---
>>>   1 file changed, 3 deletions(-)
>>>
>>> diff --git a/drivers/thermal/cpuidle_cooling.c b/drivers/thermal/cpuidle_cooling.c
>>> index 4f41102..7779739 100644
>>> --- a/drivers/thermal/cpuidle_cooling.c
>>> +++ b/drivers/thermal/cpuidle_cooling.c
>>> @@ -236,9 +236,6 @@ static int __cpuidle_cooling_register(struct device_node *np,
>>>    *
>>>    * This function is in charge of creating a cooling device per cpuidle
>>>    * driver and register it to the thermal framework.
>>> - *
>>> - * Return: zero on success, or negative value corresponding to the
>>> - * error detected in the underlying subsystems.
>>>    */
>>>   void cpuidle_cooling_register(struct cpuidle_driver *drv)
>>>   {
>>
>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> Daniel, are you going to pick up this one?

Yes

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

