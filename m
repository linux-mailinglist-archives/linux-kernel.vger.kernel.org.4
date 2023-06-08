Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E523727C51
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 12:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233839AbjFHKHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 06:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjFHKHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 06:07:00 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 159AB30E4
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 03:06:38 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f61530506aso3456485e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 03:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686218793; x=1688810793;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8gI0fKfzakee3UsQiGKM6OVjsfWkCZv8+SIDHGZOJ4w=;
        b=UWuxe0O24P69fQg0yj/SPM6qxaViIUYXWVsqJmDkn0vVeKI82+dh+9djqbFUtfdBD4
         iqlel9jF1FDq3OwY+iJ02KF82HPEvHLZqs0RvZRDeqCjAUCay8mQxF8dWYN1Egs/a0Ck
         9+Gw5r5IbETzI7eVrEyGIBPChEXxzZBGYj5qbZeT05GSKqashwzh9C3I+wkT+BFb0Cqq
         BbZT8cnPxoZStIcnN6BoEHbolB7GR4CSs6pbj1nufGErFgIwCnibJwrNTxi787nVFmYb
         lo1kt9aTzSpDjdid/CQCuC1xsr52VOtkLJahNDmStC7XXo7ue9ylCB2pbU89wc4ULhK/
         suxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686218793; x=1688810793;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8gI0fKfzakee3UsQiGKM6OVjsfWkCZv8+SIDHGZOJ4w=;
        b=WNcoqQwv6gu+QCrrUteNmqb8SKvoAIrJmTjc+FKD+FYZ6d/eR+S9nSOXrowH9KyhyQ
         hmaP3cABWqUjrGSiNkAe2uCi+MpxKvAWFZS7F461pQASu0PLy9qnES1YnDiKf69WOiXC
         tDE7SE9wmNbT5KMO5JXXzkYWTzyKYIyVXESk9UEmENCksneM3oCT7lZNsascYbpFVSkK
         egRvUNZc0G5H2gBLOr3RnptB8Zeg8QYIdlByoeHw3XrI1lW9GXHAmaD39IPQAQeV73Zq
         8FS0R49np8G17+P/rxLW0H3YzXnUry66A5zmoWeMcUVpSUDwxZmReyZx9puWKgJnVzEn
         FlNw==
X-Gm-Message-State: AC+VfDwT6k0d/ELC1ZpA2Jubeae5EuPrt5+gnP3vbxwribGt10uOK7fu
        mG5khuqvFWrXU/dHb4xiogTmiA==
X-Google-Smtp-Source: ACHHUZ5p+rzWdm6UEkkaehf/5TJoZVuIXCAqfyzj+sBEwOp5zet5JMZcogn3/cNi4rWlyI7HvjlKFg==
X-Received: by 2002:a7b:ce87:0:b0:3f7:f584:5792 with SMTP id q7-20020a7bce87000000b003f7f5845792mr1170848wmj.0.1686218792992;
        Thu, 08 Jun 2023 03:06:32 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:35fa:41a8:60f5:b00b? ([2a05:6e02:1041:c10:35fa:41a8:60f5:b00b])
        by smtp.googlemail.com with ESMTPSA id n6-20020a1c7206000000b003f7aad8c160sm4740214wmc.11.2023.06.08.03.06.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jun 2023 03:06:32 -0700 (PDT)
Message-ID: <eb9e97d8-4983-b2be-6b52-0af362d17005@linaro.org>
Date:   Thu, 8 Jun 2023 12:06:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v4 0/5] Add LVTS support for mt8192
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Chen-Yu Tsai <wenst@chromium.org>
Cc:     =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>,
        angelogioacchino.delregno@collabora.com, rafael@kernel.org,
        amitk@kernel.org, rui.zhang@intel.com, matthias.bgg@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        rdunlap@infradead.org, ye.xingchen@zte.com.cn,
        p.zabel@pengutronix.de, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        james.lo@mediatek.com, rex-bc.chen@mediatek.com,
        abailon@baylibre.com, amergnat@baylibre.com, khilman@baylibre.com
References: <20230530195132.2286163-1-bero@baylibre.com>
 <CAGXv+5EVfgEBDm=7MmQ=OsP322KmE23PwycJ-0LjU+3dEZygUQ@mail.gmail.com>
 <572f5a88-8c2e-4324-b477-836a5024ec67@notapiano>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <572f5a88-8c2e-4324-b477-836a5024ec67@notapiano>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/06/2023 19:09, Nícolas F. R. A. Prado wrote:
> On Wed, May 31, 2023 at 12:49:43PM +0800, Chen-Yu Tsai wrote:
>> On Wed, May 31, 2023 at 3:51 AM Bernhard Rosenkränzer <bero@baylibre.com> wrote:
>>>
>>> From: Balsam CHIHI <bchihi@baylibre.com>
>>>
>>> Add full LVTS support (MCU thermal domain + AP thermal domain) to MediaTek MT8192 SoC.
>>> Also, add Suspend and Resume support to LVTS Driver (all SoCs),
>>> and update the documentation that describes the Calibration Data Offsets.
>>>
>>> Changelog:
>>>      v4 :
>>>          - Shrink the lvts_ap thermal sensor I/O range to 0xc00 to make
>>>            room for SVS support, pointed out by
>>>            AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>>
>>>      v3 :
>>>          - Rebased :
>>>              base-commit: 6a3d37b4d885129561e1cef361216f00472f7d2e
>>>          - Fix issues in v2 pointed out by Nícolas F. R. A. Prado <nfraprado@collabora.com>:
>>>            Use filtered mode to make sure threshold interrupts are triggered,
>>
>> I'm seeing sensor readout (either through sysfs/thermal/<x>/temp or hwmon)
>> fail frequently on MT8192. If I run `sensors` (lm-sensors), at least a couple
>> of the LVTS sensors would be N/A. Not sure if this is related to this change.
> 
> Yes, it is. Filtered mode has some delay associated with reading, meaning most
> of the time the value isn't ready, while immediate mode is, well, pretty much
> immediate and the read always succeeds.
> 
> For temperature monitoring, filtered mode should be used. 

Why?

> As far as the thermal framework goes, it's ok that filtered mode doesn't always
> return a value, as it will keep the old one.

It is not by design but just the code not returning the error when 
updating the thermal zone as it should so the side effect is giving the 
illusion everything is all right.

> But of course, having the
> temperature readout always work would be a desired improvement.

More than a desired improvement, it is mandatory. How can the thermal 
framework protect and mitigate the temperature with a twisted vision of 
the thermal situation?

> As for ways to achieve that, I think the intended way would be to enable the
> interrupts that signal data ready on filtered mode (bits 19, 20, 21, 28), read
> the temperature and cache it so it is always available when the get_temp()
> callback is called.

It sounds very strange how the filtered mode is working. We setup the 
filtered mode, then we shall receive an interrupt telling the data is 
ready so we can read it?

> The issue with this is that it would cause *a lot* of
> interrupts, which doesn't seem worth it.

Why not use the immediate mode + interrupts ?


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

