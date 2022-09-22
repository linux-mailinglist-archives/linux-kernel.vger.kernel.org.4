Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBDD15E6A84
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 20:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232040AbiIVSRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 14:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232373AbiIVSRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 14:17:17 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F34ECCF4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 11:17:16 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id h21so6899367qta.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 11:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=1SnYPOYWPXNRM2Psm7rj/ZZy/4CgkkceBm/2enTCC9U=;
        b=kScHmmvBQQeXEUoxKTYBLHOonsFqgth8+o3WQMQwdN+YZu5PkXbN9yUGeXQd/Uoaen
         ou+HDIkcebMZWz37Ij3VqywT+0ljJkxdWyYPHd7GFjBRsmpmfkdj3CatgU6YH84/avKU
         iXK2s46UaCJiEiNzaJ73jyvd3Yh7AIMt1ptBnGDPoW7gipMpr1+Uoslv9CVVPtajrcFL
         68ZNfX19xJpg5RBhveqP5taX3BM8TtoAZ3zA1Ae7HvHJYLlLHjL1IsjsxzLWDuYlICN6
         k1UbOA+zKgsnbTML41Eib94Mxwc3wqFVcp2zUS2PxmbLVp4uNk1gmD1aGcIE8klkS384
         8Ymw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=1SnYPOYWPXNRM2Psm7rj/ZZy/4CgkkceBm/2enTCC9U=;
        b=Qz5f65epf2L5LzN6hiQV9Ws34rQtQBbR8eOgPi86CAqk65s5WguuDn4AQ+5mCQYfpS
         b1qeXjOt3J7H+W40/dayYxB17IsP4mWuoUQA8Rsgwy7Y/PZ7j6qbtl9XuiANzm0EG3aF
         deEWVGabTciYWffSeD9OlJGurTiWdc9HVxwMhRqEePNvetDip47oYaMe/YKZzPHYwBbe
         4s2sp7wINW1QpeiyPtQJ45yiFJZe329x6VMNu3zcILJlzOmuRD+BK9poUUWkmlIFbxWa
         GObHttzmaQf1wQRycwOdQCdQi8Ow7YYGziPS4dKupDn4DGK6AObHGCXQYkTq7lbmBXrc
         ALcQ==
X-Gm-Message-State: ACrzQf1R0sfZMdCjXYRvQ4pqga/P+1fi8hQT8daj2qovYF4KgfSM+c+V
        kWTavOfweObUC5FchnVxb2A=
X-Google-Smtp-Source: AMsMyM4UtZoCgwhBcqHMe/T1MoOeSeqkKSdnQ24nY00Sf0kkYMUwS7O40wN8a3eP67aqz7mkjk2esg==
X-Received: by 2002:a05:622a:1989:b0:35c:dd7a:4206 with SMTP id u9-20020a05622a198900b0035cdd7a4206mr4007735qtc.592.1663870635655;
        Thu, 22 Sep 2022 11:17:15 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id d18-20020ac851d2000000b00342fa1f4a10sm3807254qtn.61.2022.09.22.11.17.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 11:17:15 -0700 (PDT)
Message-ID: <8c1c4506-bd21-a35e-d6e5-3c7897715c18@gmail.com>
Date:   Thu, 22 Sep 2022 11:17:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [GIT PULL] ARM: SoC fixes for 6.0-rc6
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <acdecda4-b11a-4e15-9ac9-6d2696218012@www.fastmail.com>
 <87427dd0-7307-57b2-4008-2ffb839a099a@gmail.com>
 <CAHk-=wiux9J6zi8sEHyLBVYc7zsWe6JwYOf7ggF+Oowc6fp4tQ@mail.gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <CAHk-=wiux9J6zi8sEHyLBVYc7zsWe6JwYOf7ggF+Oowc6fp4tQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/22/22 11:13, Linus Torvalds wrote:
> On Thu, Sep 22, 2022 at 10:19 AM Florian Fainelli <f.fainelli@gmail.com> wrote:
>>
>> In case Linus has not had a chance to pull it just yet, could you amend
>> it?
> 
> I did see this email, but as I expect to be AFK for the next few
> hours, I took Arnd's pull request as-is.
> 
> I could pull your Broadcom fixes directly on top if you/Arnd would
> prefer that as a solution?

Thanks for the offer, no real urgency on my side, if there is a -rc7, 
maybe Arnd can submit a follow up for ARM SoC fixes, as there is a good 
chance we will accumulate more of those between -rc6 and then. If not, 
and Arnd is fine with it, yes please pull mine directly, thanks!
-- 
Florian
