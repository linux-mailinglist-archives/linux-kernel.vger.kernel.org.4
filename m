Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 046B063FD69
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 01:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbiLBA64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 19:58:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbiLBA6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 19:58:53 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC0E618384
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 16:58:49 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id t11-20020a17090a024b00b0021932afece4so6838805pje.5
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 16:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n3+ONzpAtXlifkW6XWzzPleBiUtoMQaIHTVrV3OgNP4=;
        b=H3GkGIBo8XgqkK5DkeHABIGwit48vACrV9sP+ulWzbjHLxzYOQN3hE03P9S2tOP7AY
         7dpsG3WSV3lq7/hfTLkWUGaHqQq4hXPzO6VALO/cEm4sIciNa1hl5OywZjXJjFWTt+6u
         VPjphHPKnYsdDbJ6KlZy/SmRBuMLa5aUwOzfmUmhP1zfy7pCnU5AntfcUa2w1pmv4Qha
         YH+yr/QJSBhHC8M33t0TMvyGqeisYEWXp0D/XovewUrgTp6zVqWGh9DwMkf9OOl862lF
         5CMSm3pGn7rnlSqYWoefs0QuB02rGll2gU2CB+didToOa9T7NojCo6ZN++AItUMnl49e
         SRzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n3+ONzpAtXlifkW6XWzzPleBiUtoMQaIHTVrV3OgNP4=;
        b=MvyxS7Em6WO4R/dcjFWObCczw42nn0/06oz2KWlVPSpyWfjq5EXTy7/PHgebimkm86
         sW7DXxAA4RBl5DZLA30YVoOBcks/D3eBpZQ0QH6ckAVUS7UjDtYMdWHobuByTxNpV+AG
         4p1dUZmgvmQ/mf0UPl7Zys9lFR5k/zQZDJ0LgUBatGsQpY8i/1hLnaXj83964VbFYsHI
         42I+pAuea2XVPSUN9mw5Aj8X3mxj7D6U0u4H57BGuI68eOOM/yayT78gWn/E4yNNBmbC
         YpfFz/3Iexj+dVcCY7GxFwcnWdY1MOsHssFwbl/OK67MAYHprWcsSvwN9P2GdiQnLbtr
         d7FA==
X-Gm-Message-State: ANoB5pm5N48Gh2UUbg7vPwoHIhtS9lnpERNesnI/VLInOuprsYoeOaaX
        /N8lOGOVICTUZXsb6A0SOXYrnw==
X-Google-Smtp-Source: AA0mqf7y6YtI3WuzJyh/YaeQl8mQ9WJF44L69Hgz8h8YPZoMqb1wU28XCTcKCF1e96tnuiuTXPNGYA==
X-Received: by 2002:a17:902:ea82:b0:189:9bb4:70 with SMTP id x2-20020a170902ea8200b001899bb40070mr16451154plb.108.1669942729324;
        Thu, 01 Dec 2022 16:58:49 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id oj4-20020a17090b4d8400b00217cdc4b0a5sm5451177pjb.16.2022.12.01.16.58.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Dec 2022 16:58:48 -0800 (PST)
Message-ID: <e6a984e9-f597-d987-2eef-9c3dd8ae7f0e@kernel.dk>
Date:   Thu, 1 Dec 2022 17:58:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 1/5] sbitmap: don't consume nr for inactive waitqueue to
 avoid lost wakeups
Content-Language: en-US
To:     Kemeng Shi <shikemeng@huaweicloud.com>,
        Kemeng Shi <shikemeng@huawei.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linfeilong@huawei.com, liuzhiqiang@huawei.com
References: <20221201045408.21908-1-shikemeng@huawei.com>
 <20221201045408.21908-2-shikemeng@huawei.com>
 <81e3f861-f163-c17c-49d4-2408f16c3350@huaweicloud.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <81e3f861-f163-c17c-49d4-2408f16c3350@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        SUSPICIOUS_RECIPS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/22 12:21?AM, Kemeng Shi wrote:
> 
> 
> on 12/1/2022 12:54 PM, Kemeng Shi wrote:
>> If we decremented queue without waiters, we should not decremente freed
>> bits number "nr", or all "nr" could be consumed in a empty queue and no
>> wakeup will be called.
>> Currently, for case "wait_cnt > 0", "nr" will not be decremented if we
>> decremented queue without watiers and retry is returned to avoid lost
>> wakeups. However for case "wait_cnt == 0", "nr" will be decremented
>> unconditionally and maybe decremented to zero. Although retry is
>> returned by active state of queue, it's not actually executed for "nr"
>> is zero.
>>
>> Fix this by only decrementing "nr" for active queue when "wait_cnt ==
>> 0". After this fix, "nr" will always be non-zero when we decremented
>> inactive queue for case "wait_cnt == 0", so the need to retry could
>> be returned by "nr" and active state of waitqueue returned for the same
>> purpose is not needed.
>>
>> Signed-off-by: Kemeng Shi <shikemeng@huawei.com>
>> ---
>>  lib/sbitmap.c | 13 ++++++-------
>>  1 file changed, 6 insertions(+), 7 deletions(-)
>>
>> diff --git a/lib/sbitmap.c b/lib/sbitmap.c
>> index 7280ae8ca88c..e40759bcf821 100644
>> --- a/lib/sbitmap.c
>> +++ b/lib/sbitmap.c
>> @@ -604,7 +604,6 @@ static bool __sbq_wake_up(struct sbitmap_queue *sbq, int *nr)
>>  	struct sbq_wait_state *ws;
>>  	unsigned int wake_batch;
>>  	int wait_cnt, cur, sub;
>> -	bool ret;
>>  
>>  	if (*nr <= 0)
>>  		return false;
>> @@ -632,15 +631,15 @@ static bool __sbq_wake_up(struct sbitmap_queue *sbq, int *nr)
>>  	if (wait_cnt > 0)
>>  		return !waitqueue_active(&ws->wait);
>>  
>> -	*nr -= sub;
>> -
>>  	/*
>>  	 * When wait_cnt == 0, we have to be particularly careful as we are
>>  	 * responsible to reset wait_cnt regardless whether we've actually
>> -	 * woken up anybody. But in case we didn't wakeup anybody, we still
>> -	 * need to retry.
>> +	 * woken up anybody. But in case we didn't wakeup anybody, we should
>> +	 * not consume nr and need to retry to avoid lost wakeups.
>>  	 */
>> -	ret = !waitqueue_active(&ws->wait);
> There is a warnning reported by checkpatch.pl which is
> "WARNING:waitqueue_active without comment" but I don't know why.

Most likely because waitqueue_active() could be racy, so a comment is
warranted on why it's safe rather than using wq_has_sleeper().

-- 
Jens Axboe
