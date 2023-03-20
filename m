Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E99D6C1FFE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 19:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjCTSg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 14:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbjCTSgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 14:36:03 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974751E1D7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 11:28:02 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id x3so50407979edb.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 11:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679336859;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9GL/gMKYjQsk9fh4rVL/eijfW2qYZr4TjJI+SyTkgTQ=;
        b=kkmRSq3gBgb5sUjkL1a9g8K75iOgtwzUfCYpQ3HwSEabl+x0Mv+tmBALDtc3qDJhob
         RpyzbiHrpNalaNp5228hmPqGZEHnSpJRG+02EijRhQ2Y82yl9YKs2FoWghB/Sm004FAb
         +OBlUqhNxyBc7c4cdT4cSzMb17EevBEYa7Tc2jYqsF1NKW/P9JkOjgbzR21NLu6ZiCni
         I3c+VGAC7N2SWXaePmAC5lQqE6/MqOF4Tc0OHDyzdCeicUpC8Tj1yHQghSARLYNJWZAg
         RF+7B6oGrdE4M/PQerXCl8TYnoCWTuMsaJCCUOYYm7qmZJvWrVTBaxnKgVPX7lTvHH9E
         ifQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679336859;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9GL/gMKYjQsk9fh4rVL/eijfW2qYZr4TjJI+SyTkgTQ=;
        b=Tn3fGxmtsSKoqFBi1Tr6J3yBHT8Y4YLEb6nmIlNW7+y46qJU0kaIW0r6bbWhdmsd9S
         DqZEiAvXsjIX7xMcSJhHTrh2dbdSGebf1qUQhof5Yz1JpDT6NgR4mYvrwy+NBs9OMQLk
         k9yUjMgihUi0wVqJdF7omO/mzJWNgiakfaKpcLN8kLnmGNvsWQktmalCDQyeDa9/ZUR/
         Bkx4qlmgEqa/xLleIO7pLoaz/X0ehxWYZuj9/9Wp9BqkrCEhZRDT6XgvJfLlYTOLSbZf
         boHBAyd+hBKqk4R6BcmnnvUQlWVHcz+M3sxoaGLVvhgP7icFJt3NAW2Pmgweqj/WRmog
         4apw==
X-Gm-Message-State: AO0yUKUx3KkGNSrWWHnb4gmoRuma9cw1/QmAYIbPYRKo3Zemm3XhewGe
        N0MVsh7b6gNut21nh8Q9wofIuljgeDA=
X-Google-Smtp-Source: AK7set98Opt3EVAa4aOpB9ZtlHknIMZG0/gsytg7ShGrmg5/8kmpBsWS1GpzH5IZ4F7pmuh4iGcGiw==
X-Received: by 2002:a17:906:2807:b0:8e1:12b6:a8fc with SMTP id r7-20020a170906280700b008e112b6a8fcmr56113ejc.4.1679336859045;
        Mon, 20 Mar 2023 11:27:39 -0700 (PDT)
Received: from [192.168.1.16] ([41.42.177.251])
        by smtp.gmail.com with ESMTPSA id u27-20020a50951b000000b004bf999f8e57sm5254282eda.19.2023.03.20.11.27.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 11:27:38 -0700 (PDT)
Message-ID: <2d991001-0d31-988b-fbfd-c6c2452adcc0@gmail.com>
Date:   Mon, 20 Mar 2023 20:27:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3] staging: greybus: use inline function for macros
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     outreachy@lists.linux.dev, johan@kernel.org, elder@kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Julia Lawall <julia.lawall@inria.fr>
References: <20230320103258.6461-1-eng.mennamahmoud.mm@gmail.com>
 <ZBh+3W4eTL9IMW3n@kroah.com>
From:   Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
In-Reply-To: <ZBh+3W4eTL9IMW3n@kroah.com>
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


On ٢٠‏/٣‏/٢٠٢٣ ١٧:٤٢, Greg KH wrote:
> On Mon, Mar 20, 2023 at 12:32:58PM +0200, Menna Mahmoud wrote:
>> Convert `to_gbphy_dev` and `to_gbphy_driver` macros into a
>> static inline function.
>>
>> it is not great to have macro that use `container_of` macro,
>> because from looking at the definition one cannot tell what type
>> it applies to.
>>
>> One can get the same benefit from an efficiency point of view
>> by making an inline function.
>>
>> Suggested-by: Julia Lawall <julia.lawall@inria.fr>
>> Signed-off-by: Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
>> ---
>> change in v2:
>> 	remove newlines added in previous patch.
>>
>> change in v3:
>> 	fix the patch to be against Greg's tree.
> I am lost in a twisty maze of patches from you for the greybus code that
> all seem alike but are different :(

I am sorry for that.

> Can you send a patch series of the latest changes you have made, as I
> really don't know what is, and is not, the latest versions at all, so
> I'm going to have to drop them all from my review queue right now.


Sure, I will.

>
> thanks,
>
> greg k-h


Thanks,

Menna

