Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14B8B70F3C5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 12:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbjEXKJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 06:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjEXKJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 06:09:37 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08155BF
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 03:09:36 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f601c57d8dso7001855e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 03:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684922974; x=1687514974;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mkWYRILc4zy51036RiiXREJqmRLbxu9AB+NtWj3Jni8=;
        b=YGNM3RguBhMUXngIJqlzwDDyrWHYTLPV2xGHTVfWE9MTPH8PGd8fAht8TnnHCOgJPJ
         DJ9Ef6jgsu6MQRw7ud6tN3KsnUFpBV12BTvyXayg4nhFmsUF0UY9DTUo2EvU+NaJF6dq
         Z7pP1kDLLmywsTj9Vk/8L8a8yOnHdZKWdGGuqxWhd/gJ512zN7EhaYhoVFJ2dVKtpwyA
         5CeUlkPHLeEOfVyYe84JvLYmt1SRIW4EGYtjJBIDGz7fmhnMKYgcXb9hEt4sshPCSY04
         7O+OWw3oUgwFFTslI0Yzw6tItCg8NOgEBrDTT5HS/lv532EGVlL5qzxgVn8+xZYQvC3b
         Dbsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684922974; x=1687514974;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mkWYRILc4zy51036RiiXREJqmRLbxu9AB+NtWj3Jni8=;
        b=XHp5Cw4HxEwLytkNT2oq6edkbwTfGWkTTrKADAyJ18xDrMvsAlQNV8kTdLkx/qYcim
         LoIYyDomgjEPypn4nPgGMryGqFc/l6zFWhghB1lLvYj9DfjymJIqGD3FmhPJ0ABWD/9S
         U2R/9uXe8e1eMIv4n4/5ElEQHC2ndkGvpjlL99W61JdWxBhycNI1HL0IknWdK8bE3qfu
         La+sD5rJztilMwXbZCjC11uagXa6H7Fyn1nPBGFmVVZur4gyJXYWQkvXSInQPoDwUnzq
         2xT5gnuYA5e2+WJDspT5QCJ/VpRqrphmy3RBp1lagmAhAy+IDflJ7gYsylxwYEsA8blm
         aDig==
X-Gm-Message-State: AC+VfDxwJmHdWqExIq01wFZn4z6ImvVqBVnte/jQIuK4UjYTrtksKXiZ
        OaJoIORechCFtf1MJl1SX0FXxw==
X-Google-Smtp-Source: ACHHUZ59u3mMLKjfTqBnaTrhebMf6WVp1mzKWUJdDg/MYHjYyDzloa73nCjuMEQFrhQ3qMK9cZnqIw==
X-Received: by 2002:a05:600c:1e01:b0:3f6:b44:3163 with SMTP id ay1-20020a05600c1e0100b003f60b443163mr3986833wmb.12.1684922974446;
        Wed, 24 May 2023 03:09:34 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id i1-20020a05600c354100b003f61177faffsm3488271wmq.0.2023.05.24.03.09.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 03:09:33 -0700 (PDT)
Message-ID: <bdceb6e4-9de8-07ab-502b-c526e97a592d@linaro.org>
Date:   Wed, 24 May 2023 11:09:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] ASoC: codecs: wsa883x: do not set can_multi_write
 flag
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
        ckeepax@opensource.cirrus.com, kuninori.morimoto.gx@renesas.com,
        linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
        alsa-devel@alsa-project.org
References: <20230523154605.4284-1-srinivas.kandagatla@linaro.org>
 <00283665-e44f-457b-b2c9-1acf59d1cbd8@sirena.org.uk>
 <c37b88ae-7f54-3c07-666f-010a5fd84bd1@linaro.org>
 <d94e734c-e816-4b3f-9fb3-a6589063c05a@sirena.org.uk>
 <af7b7d4f-d7ab-b5ef-e639-9a8b13de54ee@linaro.org>
 <c24b2f1c-3b08-492f-954c-c4f10ae5ad81@sirena.org.uk>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <c24b2f1c-3b08-492f-954c-c4f10ae5ad81@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/05/2023 10:48, Mark Brown wrote:
> On Wed, May 24, 2023 at 10:42:21AM +0100, Srinivas Kandagatla wrote:
>> On 24/05/2023 09:57, Mark Brown wrote:
> 
>>> I'm unclear, is this a limitation of the hardware or of the current
>>> Soundwire code?
> 
>> Its both.
> 
>> Codec itself does not have any private write callback to support this and
>> AFAIU Qualcomm Soundwire controller does not have any such hw facility to
>> program multi-registers for device at one shot.
> 
> How about the *CODEC* hardware?
> 
No, Codec does not have any such interface to write to device registers 
directly without going via Soundwire.

>> Is write callback used for both Bulk writes and multi-writes?
> 
> Only multi-write at this point but we probably should consider redoing
> bulk writes to use it as well.

By the looks of the code, its other way around.

> 
>> Is multi-write feature of regmap bus or device?
> 
> Well, I don't think any buses that understand registers have implemented
> it yet but there's nothing fundamental that means that a bus couldn't
> usefully do something with multi-write.  The current users all use raw
> buses that don't know anything about registers or values.
