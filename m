Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28FC06C381F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 18:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbjCURYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 13:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjCURYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 13:24:07 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D344C6E5;
        Tue, 21 Mar 2023 10:24:06 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id cn12so17005221edb.4;
        Tue, 21 Mar 2023 10:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679419444;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uYD3ffgIy5duZGLsx0RR5hgJ1e2w3VJSqGeiI7Av+FI=;
        b=L1lPVvZ5E6UpwmZadJUbK15jSxOHnY/A28IPax05Ns8kDIfpBIx0fNGv83KNDVFOJb
         LlWaibrQJ9YSaPIolzFsRxiaoPJAjZrreP8Koko8WDnVLsozgHPaioNp3zmbDLJNO10m
         UwYWHU6mYyyLbKbzHko+nkptaRQbcSRtFDfeOGAfFCzhvDJ+GFLpxQN3F2Ji7+6J+9JY
         M/7xZCyzrh6FQB1PCV4T/L0ZAMFf4ZBWTWS8i+5/DdfgbCmn++i34P+tMM0qqpiJZv90
         zvu5PLEAQLlYpdnYyIIfZpN+DN845ITNY+kevBARLUZ89BD09jdix6xw6TbkV3vTm0N1
         kSHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679419444;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uYD3ffgIy5duZGLsx0RR5hgJ1e2w3VJSqGeiI7Av+FI=;
        b=JzuPdiZeRV8ZwBk+ouCFMNnoxYiFf8Tes1GVaHnJEO3XHzQ5Elu7wnu1lQ9IJUyCRe
         WuaO6RNAd+IBfZO7NOIi41MKYm/kbVk9uxzMhjzOtCYnBatc6P6BCjvjNFBAvMlNFkbJ
         r77KRCECQKPYISqPr6HWOETIM9WVfVbIYYHgBEb2yzJR3TZhjPzynabK3uITVE1fGQ/b
         ZjpM+8XuXsutWhb48Zdl9lNrV130z6geR+MFB1Xm8dUBfq/IEAYz9FRk1EgmmcIh9Axm
         w5pBR9WTrh3FBwV/jiv4igkwaHtJK7sGsBq9ZE46vT4OZbz5juA56kX/lrwp/+oMpKuS
         qrog==
X-Gm-Message-State: AO0yUKUYrrZUhnl90nNrwCvMJs9UtDkVZLrSiOxi3i0H9Fy2HIN5/vlo
        IvA/m/AS+5VyxqCNm3SKJQ7MNkkATCQ=
X-Google-Smtp-Source: AK7set/osmJFQCobrauQUqZc0NNqdgQSfyrKXjZAcy946p+Q5sYBnO9HsdZyYANE2uWKqPQa9ver1A==
X-Received: by 2002:a17:906:170c:b0:931:c2f0:9437 with SMTP id c12-20020a170906170c00b00931c2f09437mr4078563eje.8.1679419444466;
        Tue, 21 Mar 2023 10:24:04 -0700 (PDT)
Received: from [192.168.1.16] ([41.42.177.251])
        by smtp.gmail.com with ESMTPSA id t25-20020a170906065900b00939a61113d3sm1299865ejb.110.2023.03.21.10.24.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 10:24:04 -0700 (PDT)
Message-ID: <9ba49867-20d4-1732-b983-b2d6e14ad4ad@gmail.com>
Date:   Tue, 21 Mar 2023 19:24:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 0/3] edits in greybus driver
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Julia Lawall <julia.lawall@inria.fr>, outreachy@lists.linux.dev,
        johan@kernel.org, elder@kernel.org, vireshk@kernel.org,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-pwm@vger.kernel.org
References: <cover.1679352669.git.eng.mennamahmoud.mm@gmail.com>
 <ee77a227-13bd-70ad-1d8e-f9719970e0f8@inria.fr>
 <196b5d53-701f-e2dd-596c-9fdb6a59f5cd@gmail.com> <ZBnawJvBVkgyVh78@kroah.com>
From:   Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
In-Reply-To: <ZBnawJvBVkgyVh78@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On ٢١‏/٣‏/٢٠٢٣ ١٨:٢٦, Greg KH wrote:
> On Tue, Mar 21, 2023 at 06:22:44PM +0200, Menna Mahmoud wrote:
>> On ٢١‏/٣‏/٢٠٢٣ ١٣:٤٦, Julia Lawall wrote:
>>> On Tue, 21 Mar 2023, Menna Mahmoud wrote:
>>>
>>>> This patchset includes change happened in greybus driver in three
>>>> different files two of them patch one and three related to
>>>> checkpatch issue and in second patch convert two
>>>> `container_of` macros into inline functions.
>>>>
>>>> Menna Mahmoud (3):
>>>>     staging: greybus: remove unnecessary blank line
>>>>     staging: greybus: use inline function for macros
>>>>     staging: greybus: remove unnecessary blank line
>>> Different patches should have different subject lines.
>> But I have already the same edit in both file, so should I re-write the
>> subject for one of them?
>>>     You need to either
>>> be more specific about the file affected or merge the two patches with the
>>> same subject into one.
>> each patch related to different file. So, Can I to merge two commits for
>> different files but have the same edit in one patch?
> Yes, or make 2 different patches with 2 different subject lines as they
> are obviously doing different things.
okay, I will fix it.
>
>> but in this case no need to create patchset for all changes in `greybus`
>> driver, right?
>>
>> If okay with that, should I versioning the patches to resend them again, or
>> should add "RESEND" subject prefix?
>>
>> please tell me the best way to resend these patches, appreciate your help.
> What would you want to see if you had to review and apply loads of
> patches like this?
sure add version number will be easy to review.
> (hint, it's not a resend, but a new version...)
>
> thanks,
>
> greg k-h


Thanks,

Menna

