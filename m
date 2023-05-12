Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A588700AE2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 16:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241640AbjELO6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 10:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241617AbjELO6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 10:58:16 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB01D2FC
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 07:58:14 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id e9e14a558f8ab-3355cb2f4a1so873615ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 07:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1683903494; x=1686495494;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zGuO9uAkYQgkNZy7b91jsKYegy6TbOpfslNkTDY+8ac=;
        b=1WVL72ya6qP7dGrPu7BNlkLeAizIvkdbU8SZrfj2rNUaajZGhH5j+aRAqiRDTgAyEC
         G01rOMNEGf01xwDcwtnNtvXJEcSP/sb/cUQ6KOn0kOiJb7STskLaiVUhLD/Xuufq2mkN
         FoHxF1nshyFhZtC6oqXhZmYkGDq9jdilM89fwAXuqYnTylcmcejSMBatZ03GKhl9qZ17
         Etal008fc/HStLgLA8JYEzR5DZQF99LjqFcxHyzuUg375D4y5IepKMbRIfOh7TkxXiG+
         d+VJxXq3G+bU5wOJ37xGsdVj+j9kK+uVt4E2n6uydwMRFnNrrfWekqs5Ukom3HHB/VxY
         GM5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683903494; x=1686495494;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zGuO9uAkYQgkNZy7b91jsKYegy6TbOpfslNkTDY+8ac=;
        b=Mxn8zGsj2FAKZaUUV64Nve7ppPclRWPtTuHCktepL3gBlvcmL9wCS9Qyd/wmSv9vw5
         qDqPsAnXa0bv3jWpuc7SSLlTrxJLJCvdcklRtnRjoBd2kYaj20Qg5SxZhi33b8IBQOJh
         uj6Eu+st9WTBRMNBjqnZDXUfoS9/dEldl0cgLBC+7btMYspSdMatXxTZUP0qhZym7im+
         xSE4azbGOao1+/pBN/4VZn8aVFJMdQR9SJbywXNhOoJ/mfaT8umSm2tPt+MJj528R848
         TUjdPD/P33CmRssKeusCZol1Rlkvj9oK3y3O5YFfWv5KrybtFOghHzFuRPhR1VmmynNq
         x3XQ==
X-Gm-Message-State: AC+VfDwZJ0iSeisL9RvAibskHh1It1Ok7akvn03olVzeS9Xafz1BuYWK
        wJ4QA+KwfjVwnpDrnTAGZS3qbg==
X-Google-Smtp-Source: ACHHUZ4tREfqhvKm6HZzH3bDbtNZfeS/vtcf5wxZcKNt9Kiz6niZQjLR0Bh2nrF7rlg1xgnEFxbH8A==
X-Received: by 2002:a05:6e02:1b08:b0:331:1267:31f9 with SMTP id i8-20020a056e021b0800b00331126731f9mr12668601ilv.0.1683903493782;
        Fri, 12 May 2023 07:58:13 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id z1-20020a92cec1000000b0032648a86067sm5084686ilq.4.2023.05.12.07.58.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 May 2023 07:58:13 -0700 (PDT)
Message-ID: <2b18e6ed-bce0-44f5-5ec4-8903f3c85cfe@kernel.dk>
Date:   Fri, 12 May 2023 08:58:11 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH -next v2 0/6] blk-wbt: minor fix and cleanup
Content-Language: en-US
To:     Yu Kuai <yukuai1@huaweicloud.com>, hch@lst.de, tj@kernel.org,
        josef@toxicpanda.com, yukuai3@huawei.com
Cc:     lukas.bulwahn@gmail.com, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com
References: <20230512093554.911753-1-yukuai1@huaweicloud.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230512093554.911753-1-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/12/23 3:35 AM, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Changes in v2:
>  - make the code more readable for patch 1
>  - add a new attr_group that is only visible for rq based device
>  - explain in detail for patch 4
>  - add review tag for patch 2,3,5
> 
> Yu Kuai (6):
>   blk-wbt: fix that wbt can't be disabled by default
>   blk-wbt: don't create wbt sysfs entry if CONFIG_BLK_WBT is disabled
>   blk-wbt: remove dead code to handle wbt enable/disable with io
>     inflight
>   blk-wbt: cleanup rwb_enabled() and wbt_disabled()
>   blk-iocost: move wbt_enable/disable_default() out of spinlock
>   blk-sysfs: add a new attr_group for blk_mq
> 
>  block/blk-iocost.c |   7 +-
>  block/blk-sysfs.c  | 181 ++++++++++++++++++++++++++-------------------
>  block/blk-wbt.c    |  33 +++------
>  block/blk-wbt.h    |  19 -----
>  4 files changed, 117 insertions(+), 123 deletions(-)

We need a 6.4 version of the fix to get rid of the regression. If you
want to do cleanups on top of that, then that's fine and that can go into
6.5. But don't mix them up.

-- 
Jens Axboe


