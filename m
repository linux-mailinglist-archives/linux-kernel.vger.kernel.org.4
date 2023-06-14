Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F41072FC10
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 13:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbjFNLLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 07:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235923AbjFNLK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 07:10:56 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 295CA1FFD
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 04:10:38 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id 46e09a7af769-6b16cbe4fb6so4759164a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 04:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686741037; x=1689333037;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f4Efw5DfR6kHUKoVdNGUy3CfmJsg9ulDb0gdQoCc7P0=;
        b=rx8X9ZRLJijZ79bDCxtwMEkWFu3yVawiFcCxfbgyzqkxCI6pLB3p7dQyTFlz5whya6
         oB2DARQUr0yFRrraKgjcckXbC3PuTIVo//mJUap1qUaoHSoI5UeuYxF4PEL+Htfq+bhd
         9Yy9+u5aLwuELLRUKywwH97zqDD1YdRYZNzADo7jvcvsEV9ayk+sGiU/idzK9do+j8DU
         fiSNoJU5IuNFdEMo9sRLY+3Hi4WFbOxxHZVyg29sJz+dLWhtBCgcYBRossWQnvYUL0Un
         LGJ6/dq+eF86f5cszITdZyPSK+5sI2PwFjOZ7F88EhoGBNaPkzlhZoPVH8At231NjsWb
         0whg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686741037; x=1689333037;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=f4Efw5DfR6kHUKoVdNGUy3CfmJsg9ulDb0gdQoCc7P0=;
        b=VpcyfUTG2GgKcQM2NkqLw8wuS3bVkTUvWnmrl3+eL26zfvAxUGgZhPpm59BATnnSAu
         yJBLHFyXfdYHfuQzVADT89sgvqFTCvLaWaH29cu0c3PX7rIFe62Vej+wAbFa0HCNSFFz
         ZsOGnTNexm6QzAhn02KVo0/9endwm8rqxsyeDPt6ZRLc01/VpJQ2DWYIh82fymxcrMy7
         xWo5tJu/e773Fbc7CX3zV5o/thZKywU6F73nJlYWBdKdjtEjEuoEU0mpGFIU4J0RCc4p
         AZfbZBowRf7kLHxgDGLtmWpfuhubSxI/iCtGbQF1pcCXLyP5jmoGrVDQ6sPX829rNUp5
         CL0A==
X-Gm-Message-State: AC+VfDzfz8zO8HGS+/lVWCrjHC1z/s6Grgi82rNQEDPCOuBuLG5ztqbA
        tUm9SS2C2yWRYIEWcnDpBhE=
X-Google-Smtp-Source: ACHHUZ4C1mnG/aBQjZIam0AFKfCICLTOt3dN0R8wjrlWCEmsZoSXw3aCovYyUIg+wXiftNnZQ/mJBA==
X-Received: by 2002:a05:6359:c20:b0:129:d027:3a62 with SMTP id gn32-20020a0563590c2000b00129d0273a62mr10143801rwb.16.1686741037153;
        Wed, 14 Jun 2023 04:10:37 -0700 (PDT)
Received: from [10.200.9.101] ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id g12-20020a62e30c000000b0065438394fa4sm10465810pfh.90.2023.06.14.04.10.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jun 2023 04:10:36 -0700 (PDT)
Message-ID: <ec1c4922-bb04-7896-8864-98cd96c9b0fc@gmail.com>
Date:   Wed, 14 Jun 2023 19:10:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH v2 0/3] Optimize the fast path of mas_store()
To:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>
References: <20230609120347.63936-1-zhangpeng.00@bytedance.com>
 <20230613172352.u4oj5ydoloztvdqk@revolver>
Cc:     Peng Zhang <zhangpeng.00@bytedance.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org
From:   Peng Zhang <perlyzhang@gmail.com>
In-Reply-To: <20230613172352.u4oj5ydoloztvdqk@revolver>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SCC_BODY_URI_ONLY,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/6/14 01:23, Liam R. Howlett 写道:
> * Peng Zhang <zhangpeng.00@bytedance.com> [230609 08:04]:
>> Add fast paths for mas_wr_append() and mas_wr_slot_store() respectively.
>> The newly added fast path of mas_wr_append() is used in fork() and how
>> much it benefits fork() depends on how many VMAs are duplicated.
>>
>> Changes since v1:
>>   - Revise comment and commit log. [3/3]
>>   - Add test for mas_wr_modify() fast path. [1/3]
> 
> Thanks for adding the tests.  I'm just trying to figure out how to best
> address testing this in RCU mode. And by testing it I mean add tests in
> RCU that does this and detect the failure by modifying your code, then
> change it back and have it pass the test by falling back to node store.
> This would need to change tools/testing/radix-tree/maple.c to update the
> testing there.
I see what you mean now, I will try to make a test in RCU mode.
> 
>>
>> v1: https://lore.kernel.org/lkml/20230602075353.5917-1-zhangpeng.00@bytedance.com/
>>
>> Peng Zhang (3):
>>    maple_tree: add test for mas_wr_modify() fast path
>>    maple_tree: optimize mas_wr_append(), also improve duplicating VMAs
>>    maple_tree: add a fast path case in mas_wr_slot_store()
>>
>>   lib/maple_tree.c      | 69 ++++++++++++++++++++++++++++---------------
>>   lib/test_maple_tree.c | 65 ++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 111 insertions(+), 23 deletions(-)
>>
>> -- 
>> 2.20.1
>>
> 
