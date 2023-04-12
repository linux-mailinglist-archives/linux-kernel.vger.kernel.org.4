Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 682246DEAE6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 07:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjDLFSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 01:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjDLFSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 01:18:12 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592044222;
        Tue, 11 Apr 2023 22:18:11 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id l18so9551727wrb.9;
        Tue, 11 Apr 2023 22:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681276690; x=1683868690;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:cc:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=23jw4wGKLELZol6xO6kwjfhk3S68zzLUVSsJHxPhCD8=;
        b=ZUkM5oKdb4ookaFWsqWFvBmCxeDBYZLd9D3FiN+0Qi6TRnV/WdccjioIPAL6mpJPVj
         0qEhyYsF22F3JOqC3cVWagGijDx0dgPoETlo1DSREi1iD/6uL3Hd9waeInofJd7BnjhT
         ONSfjWVDSDLSLJOxksqouG/urMhIUrp2Ja+UOZ5XxWEEBSd4hPSWP5EOKkc/7ucNLIJf
         UeuIGdcocv3My7QQenqZulTkxPaybkjUPOKoi2IB0Vfto5kq09sBH2fEHfyTgzvNJAvU
         Hc6av23QV9yv7Jl/8GcCt1/C6H46kaOsURijs0vMx45xhxJZBAiILjcso9Zyz0XTqhOS
         LBLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681276690; x=1683868690;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:cc:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=23jw4wGKLELZol6xO6kwjfhk3S68zzLUVSsJHxPhCD8=;
        b=W33KBEVN8oddDjBcVOhkOwnPQib+Ce/uohR+WWvfBxtZkB945OokGTSfuHs/VBZ5DG
         woXtdTXr+Bp5KuzYXN0TXA5opIrq8+MYtp3JFcmRY1e4gfIAGTN+h3h2aZV+FhyBRXVW
         WtFUjcZ6yfBgzVDO2b2wCpZPxzy/TeF3iJVDzaTnQyoKuZh+sF6JFu0XTfI1Fw2d+P7h
         UOHxpDWZOlOYS9WVh+7RaxJPz778drGb/OxLfPgb50wA05/f5Tgy40cFI3aEdc674NHa
         ZmwFmkgDw6BMp9MFL7S5K3RjwR4ira05Tz/UfyI1yfr2ywRjVgeniT0zoJH4+OM1J2y6
         lJdQ==
X-Gm-Message-State: AAQBX9fyjZShJ4AME9tWLPQnF854+BE/RDsClbY71wx/xvr5h3Ujn/GS
        hRMrxZuGBFtLIqSM25xNSTRrkvZRWJjJSQ==
X-Google-Smtp-Source: AKy350b01aD4wQXPQCnVvryxDWQadGDFF+swBMFZwGRtWEWz7Eh1hiBU4r4t1USDzKLxOWAAvukKKQ==
X-Received: by 2002:a5d:6804:0:b0:2c8:f78:2772 with SMTP id w4-20020a5d6804000000b002c80f782772mr10177676wru.19.1681276689567;
        Tue, 11 Apr 2023 22:18:09 -0700 (PDT)
Received: from [192.168.0.22] ([87.116.164.178])
        by smtp.gmail.com with ESMTPSA id h16-20020a5d5490000000b002c8476dde7asm16113421wrv.114.2023.04.11.22.18.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 22:18:09 -0700 (PDT)
Message-ID: <9d8194bc-34d0-bbe9-825b-2b7635056a10@gmail.com>
Date:   Wed, 12 Apr 2023 07:18:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Cc:     savicaleksa83@gmail.com, linux-hwmon@vger.kernel.org,
        Jack Doan <me@jackdoan.com>, Jean Delvare <jdelvare@suse.com>,
        Leonard Anderweit <leonard.anderweit@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (aquacomputer_d5next) Fix alignment of function
 call params
To:     Guenter Roeck <linux@roeck-us.net>
References: <20230409183549.12683-1-savicaleksa83@gmail.com>
 <c24a071e-b191-4626-8edc-1658a01d80ef@roeck-us.net>
 <5f24cb94-d7f1-f8b0-71f0-2b39a89bb2dc@gmail.com>
 <07419415-3087-48e6-955a-b5024d943e07@roeck-us.net>
Content-Language: en-US
From:   Aleksa Savic <savicaleksa83@gmail.com>
In-Reply-To: <07419415-3087-48e6-955a-b5024d943e07@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-11 22:19:21 GMT+02:00, Guenter Roeck wrote:
> On Tue, Apr 11, 2023 at 08:26:32PM +0200, Aleksa Savic wrote:
>> On 2023-04-10 18:53:08 GMT+02:00, Guenter Roeck wrote:
>>>
>>> I am not sure I understand how this would improve readability.
>>> It seems to accomplish the opposite. Sure, I know, checkpatch --strict
>>> complains, but that is still better than unreadable code just to make
>>> checkpatch happy.
>>>
>>> Guenter
>>
>> Both seemed fine to me, the idea was to fix the checkpatch warning.
>> If it's OK for it to complain about this, plus the changes would make it
>> harder to read, please ignore this patch.
>>
> 
> checkpatch is useful, but not in situations where following its guidance
> results in code which is diffficult to read. I run checkpatch --strict when
> applying patches, so I do notice when it complains. If I want a report
> to be addressed, I'll say that (such as, for example, when people are
> overly generous with empty lines). If not, you can assume that I am ok with
> the report and find it more important to have readable code than being
> checkpatch-clean.
> 
> Guenter

That clears it up, thanks!

Aleksa
