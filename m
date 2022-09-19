Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 407EB5BC38F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 09:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbiISHhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 03:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbiISHhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 03:37:13 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB1A1A066;
        Mon, 19 Sep 2022 00:37:10 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id u69so309983pgd.2;
        Mon, 19 Sep 2022 00:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=EFnBAeCR2a4S8FMmPocMFLMGIvjeMczwlCWza2QLLDk=;
        b=qjBRdhCuJVGBUDaAHRIv+Z2RrFGeLQxvkouEEvmu6XDci2FxlA42QHIymjgwmwXvb1
         2CMHLzFCSOZYcT+9LkcBf0oPaaO0HO4SqnyoUb9aZWJXqonpXYyCqe2FTsijz9yUzWnO
         ZKq986yWOl3wB4uoBAqtXZAqgETCRiW4SecdVXVM4a8fZDi59fvhVwzhiOQtxNQuy21W
         9wnDoVXiia/YY4X+8gDT89fhWgtvTzymQA/MavvM5FBFaUkr0pj+SKCW2HvwK5OAxJER
         elKitGZNSBueBEhE+mRmg1cPazP5hDEMYCmVc9PKzNds5twOQ8nnnFnbNGCla5cy05VP
         khPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=EFnBAeCR2a4S8FMmPocMFLMGIvjeMczwlCWza2QLLDk=;
        b=olrq51LDHeHSexvBmOm8MT3KffD0jQJ6ZA7wBRNp+ACTBXcgW0fSrNgdgsrGsBQCZw
         v1iQbopwVPMmU91eNQqMirusem+F/+UJ9kRj0O62OK+Umbg2P2Vz9w72uLznTn7snPDq
         j+YvyZ3sJ57BdXGZf135na6rOxwuiwz2itJbo4uxpfIl8TLvMyIWDWKswWDDzLM2XpSz
         yzOoh/EpkIuA0DyjKV9BXOO81AB03wWI0pY1WYuLSccOrNDHawQPhibzf3psvLeqLdjZ
         EKMNBVwoYW+ZB00MyQgKSUelfLu4qZGIkJl+GG08nT2bhb4YlXz+54brxDpgYn7SG7K7
         D5nw==
X-Gm-Message-State: ACrzQf05bS9q77xce86rduiZbEvUOH5MS4VB9znnbEHPQQDaINo17Cxc
        emXJihKTQJsoh8vJIzw3N2c=
X-Google-Smtp-Source: AMsMyM79g9TgQ1DZmsxBhyd6B9R3fmiHWbDu8JMCXWYVJb4cgvVvb03Gaep65N9gzc1DML9koOPsfg==
X-Received: by 2002:a63:f057:0:b0:438:5c6c:de26 with SMTP id s23-20020a63f057000000b004385c6cde26mr14167285pgj.509.1663573030022;
        Mon, 19 Sep 2022 00:37:10 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-18.three.co.id. [180.214.233.18])
        by smtp.gmail.com with ESMTPSA id q7-20020a17090311c700b00174f7d10a03sm20146836plh.86.2022.09.19.00.37.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 00:37:09 -0700 (PDT)
Message-ID: <0e879a2f-1f0a-9fdb-388a-90bc0fe4db86@gmail.com>
Date:   Mon, 19 Sep 2022 14:37:01 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH mm-unstable v15 00/14] Multi-Gen LRU Framework
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Yu Zhao <yuzhao@google.com>, Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        page-reclaim@google.com
References: <20220918080010.2920238-1-yuzhao@google.com>
 <YyfPO8rVujtUzEwt@debian.me>
 <20220918221956.04beefd36e3622490059e537@linux-foundation.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20220918221956.04beefd36e3622490059e537@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/19/22 12:19, Andrew Morton wrote:
> On Mon, 19 Sep 2022 09:08:59 +0700 Bagas Sanjaya <bagasdotme@gmail.com> wrote:
> 
>> The base commit is on what tree? Or I have to wait for rebasing this
>> series on top of latest mm-unstable.
> 
> I pushed this series out in mm-unstable several hours ago.

OK, thanks.

-- 
An old man doll... just what I always wanted! - Clara
