Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0455BD259
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 18:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbiISQim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 12:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiISQig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 12:38:36 -0400
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738213BC70;
        Mon, 19 Sep 2022 09:38:35 -0700 (PDT)
Received: by mail-pg1-f180.google.com with SMTP id t70so27249556pgc.5;
        Mon, 19 Sep 2022 09:38:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=CAjB6oP9WAe1W6cMuPIXOBqiG3Ye8XvaCJwLL7WLSyc=;
        b=LOl0D+2D22fjtNXx3oIAj1kbfZCzefH4n/x3mpnnJ83JwTiHUJ7rIHp6rbI0mjfN9q
         xN0PCnPpUMD2g/aD37jydaTM8rvRgQB26I05SpyOyHQJg6HlcGAicTUNYvnyDBN0/WT7
         XWQzZKJTNCspWvXOd0SUqFn2ZHx4Bhn6ykN46NeKqQ8V55KyzTfKLq3ovncHhf+VwqIJ
         1BCpNqlM+0Vru7OLSrKknlJR3XWR6XO84iHeu0A/dDwSBXfO0ncww2QTj6S951UlNa7h
         RYjms0WbVevA9nR/8milu2+aBNcs35VM/Tm7TojSUUkwrM2e1kchQVUTlzqa/xvTxfC9
         oSEg==
X-Gm-Message-State: ACrzQf3UscQVsvbVGLN2HMXUpdI07YT8x7fJjGXPBl4mYOdqkMZ5xY0k
        FxGF/lXlfOsX3ZcdYMhJXcc=
X-Google-Smtp-Source: AMsMyM4pUblTaj/zOW/XcUYO/LvXZRrtb3Ma4FsiIOf/wNcgI4lSDVZyLlfoI0Kn7oOzr78je+Ogxg==
X-Received: by 2002:a63:dd01:0:b0:439:34d8:82d5 with SMTP id t1-20020a63dd01000000b0043934d882d5mr16253418pgg.530.1663605514839;
        Mon, 19 Sep 2022 09:38:34 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:9b5b:c086:d392:8ccb? ([2620:15c:211:201:9b5b:c086:d392:8ccb])
        by smtp.gmail.com with ESMTPSA id h9-20020a056a00000900b0053e5daf1a25sm20674917pfk.45.2022.09.19.09.38.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 09:38:34 -0700 (PDT)
Message-ID: <44b01c70-1b3c-36e6-cb59-6a7c27ae26f5@acm.org>
Date:   Mon, 19 Sep 2022 09:38:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] block/blk-rq-qos: delete useless enmu RQ_QOS_IOPRIO
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>
Cc:     Li Jinlin <lijinlin3@huawei.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linfeilong@huawei.com
References: <20220916023241.32926-1-lijinlin3@huawei.com>
 <f2b8a99d-f6bd-4581-c651-d5b62d6cff21@acm.org>
 <20220916215824.kfxvesl3l6tjqciw@quack3>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220916215824.kfxvesl3l6tjqciw@quack3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/16/22 14:58, Jan Kara wrote:
> On Fri 16-09-22 07:12:23, Bart Van Assche wrote:
>> Jan, please Cc me on future blk-ioprio patches - I just noticed that I was
>> not Cc-ed on commit 82b74cac2849 ("blk-ioprio: Convert from rqos policy to
>> direct call").
> 
> Well, you were on CC of the whole patchset which this patch was part of - see
> [1]. So maybe you've missed it among other patches.
> 
> [1] https://lore.kernel.org/all/20220623074450.30550-1-jack@suse.cz/

Hi Jan,

Hmm, you are right. Looking back at that patch series, what I remember 
is that I looked at the first two patches, noticed that these were 
outside my area of expertise and skipped the other patches. I will pay 
more attention in the future.

Bart.

