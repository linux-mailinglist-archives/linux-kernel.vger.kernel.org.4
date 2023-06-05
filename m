Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93D8B722D00
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 18:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233019AbjFEQwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 12:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234908AbjFEQwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 12:52:22 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED3AD9
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 09:52:21 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-2562b1b1af0so799765a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 09:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1685983940; x=1688575940;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zJNMYZ5ZlCwWFShxq5SVp0goxBjUhrKSnIdXymTHIMA=;
        b=eCI7hkAM00pEJVL1uVIG+L7F7tIEbviV3dizbWupXZgZzYGGiWUr/7YXVjom0pGngN
         WMyAc4/5g8N1IWO57Lf7ZbI1Dpd3DRD7xiNQ6esKC+///UVz4SiZeeL9RqDvxOdRT0aI
         HCgziPbLo3f4sgMozOg6ysKkvbB9rpz+7YNk3gwIBd/KKPclRk9pq0wqepC7lMvg16Hj
         Y8I4Ax7sbrmn/0MZwlznYVucPkBvxHXODAyLSRJf34g5tv6JDP0tZH5jpmIQHxtLgTnd
         rTd0RWlvFe0+NxhfAp8K579bNuj8fVyY93kZAB2Q8MV+sOK0T6ychjXdysLTuJro4Dv7
         iFDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685983940; x=1688575940;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zJNMYZ5ZlCwWFShxq5SVp0goxBjUhrKSnIdXymTHIMA=;
        b=YdV6Pe67g0cTnM/3zjTmmP2jax8CyOPplQD94c1nUXk4ptA/OOSf39pIAdTJxwlVAY
         imgfjgcVrknASju9vxF8FNSkxYgLOj6Q6e9OqNsToey33j98nkF+hx8erpqb19Ie2O0t
         f0r/NDh49LrpUrfXzrG7DqQcRAD9c4gfRuLXN5mIvvbFUA6i8j0HIfJx1CApBeFII/43
         DN4cPvPLSMZRs3XkT+wRinnlo3PzqItqFPJrSgIlWDKkXaYQhudvZSqcRD+9H/H5BLGL
         5dhzVSO3DEJ4RcC2DgbffpSv2+yd5WMMfnLqh+zMbrXF90TT5svMNyMxIiprOta5t8uQ
         odmA==
X-Gm-Message-State: AC+VfDzYsbJt7cnen4zyvwsjuAm9gWEI7bCkZFYDB0Srlwz5AxR/EpAF
        O1hG7d0yDKASPaTYOF+m/b16pw==
X-Google-Smtp-Source: ACHHUZ4plkQPRc81+FMyI3pGvSItsM7r3Pq1a0SJx1hFlpW/XJG6VQ5dkmCpuLqzdFwsuXFaoVWJVw==
X-Received: by 2002:a17:90b:4f47:b0:255:c3a3:43a with SMTP id pj7-20020a17090b4f4700b00255c3a3043amr18747151pjb.4.1685983940422;
        Mon, 05 Jun 2023 09:52:20 -0700 (PDT)
Received: from ?IPV6:2600:380:c01c:32f0:eff8:7692:bf8a:abc6? ([2600:380:c01c:32f0:eff8:7692:bf8a:abc6])
        by smtp.gmail.com with ESMTPSA id e91-20020a17090a6fe400b002508d73f4e8sm8440142pjk.57.2023.06.05.09.52.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 09:52:19 -0700 (PDT)
Message-ID: <286f350c-b1b3-694d-b969-d06747b52144@kernel.dk>
Date:   Mon, 5 Jun 2023 10:52:18 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] blk-ioc: protect ioc_destroy_icq() by 'queue_lock'
Content-Language: en-US
To:     Yu Kuai <yukuai1@huaweicloud.com>, hch@lst.de, dlemoal@kernel.org,
        quic_pragalla@quicinc.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230531073435.2923422-1-yukuai1@huaweicloud.com>
 <03ffbdc4-66e2-5508-f632-e3a1999f40df@huaweicloud.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <03ffbdc4-66e2-5508-f632-e3a1999f40df@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/5/23 6:58 AM, Yu Kuai wrote:
> Hi, Jens
> 
> 在 2023/05/31 15:34, Yu Kuai 写道:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> Currently, icq is tracked by both request_queue(icq->q_node) and
>> task(icq->ioc_node), and ioc_clear_queue() from elevator exit is not
>> safe because it can access the list without protection:
>>
>> ioc_clear_queue            ioc_release_fn
>>   lock queue_lock
>>   list_splice
>>   /* move queue list to a local list */
>>   unlock queue_lock
>>   /*
>>    * lock is released, the local list
>>    * can be accessed through task exit.
>>    */
>>
>>                 lock ioc->lock
>>                 while (!hlist_empty)
>>                  icq = hlist_entry
>>                  lock queue_lock
>>                   ioc_destroy_icq
>>                    delete icq->ioc_node
>>   while (!list_empty)
>>    icq = list_entry()           list_del icq->q_node
>>    /*
>>     * This is not protected by any lock,
>>     * list_entry concurrent with list_del
>>     * is not safe.
>>     */
>>
>>                  unlock queue_lock
>>                 unlock ioc->lock
>>
>> Fix this problem by protecting list 'icq->q_node' by queue_lock from
>> ioc_clear_queue().
>>
>> Reported-and-tested-by: Pradeep Pragallapati <quic_pragalla@quicinc.com>
>> Link: https://lore.kernel.org/lkml/20230517084434.18932-1-quic_pragalla@quicinc.com/
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   block/blk-ioc.c | 30 +++++++++++++-----------------
>>   1 file changed, 13 insertions(+), 17 deletions(-)
>>
>> diff --git a/block/blk-ioc.c b/block/blk-ioc.c
>> index 63fc02042408..d5db92e62c43 100644
>> --- a/block/blk-ioc.c
>> +++ b/block/blk-ioc.c
>> @@ -77,6 +77,10 @@ static void ioc_destroy_icq(struct io_cq *icq)
>>       struct elevator_type *et = q->elevator->type;
>>         lockdep_assert_held(&ioc->lock);
>> +    lockdep_assert_held(&q->queue_lock);
>> +
>> +    if (icq->flags & ICQ_DESTROYED)
>> +        return;
>>         radix_tree_delete(&ioc->icq_tree, icq->q->id);
>>       hlist_del_init(&icq->ioc_node);
>> @@ -128,12 +132,7 @@ static void ioc_release_fn(struct work_struct *work)
>>               spin_lock(&q->queue_lock);
>>               spin_lock(&ioc->lock);
>>   -            /*
>> -             * The icq may have been destroyed when the ioc lock
>> -             * was released.
>> -             */
>> -            if (!(icq->flags & ICQ_DESTROYED))
>> -                ioc_destroy_icq(icq);
>> +            ioc_destroy_icq(icq);
>>                 spin_unlock(&q->queue_lock);
>>               rcu_read_unlock();
>> @@ -171,23 +170,20 @@ static bool ioc_delay_free(struct io_context *ioc)
>>    */
>>   void ioc_clear_queue(struct request_queue *q)
>>   {
>> -    LIST_HEAD(icq_list);
>> -
>>       spin_lock_irq(&q->queue_lock);
>> -    list_splice_init(&q->icq_list, &icq_list);
>> -    spin_unlock_irq(&q->queue_lock);
>> -
>> -    rcu_read_lock();
>> -    while (!list_empty(&icq_list)) {
>> +    while (!list_empty(&q->icq_list)) {
>>           struct io_cq *icq =
>> -            list_entry(icq_list.next, struct io_cq, q_node);
>> +            list_first_entry(&q->icq_list, struct io_cq, q_node);
>>   +        /*
>> +         * Other context won't hold ioc lock to wait for queue_lock, see
>> +         * details in ioc_release_fn().
>> +         */
>>           spin_lock_irq(&icq->ioc->lock);
> 
> Sorry that I made a mistake here to use spin_lock_irq() for recursive
> locking.
> 
> Should I resend this patch or send a new fix patch?

Your patch is already staged in for-6.5/block, so please send a patch
that fixes up the current tree.

-- 
Jens Axboe


