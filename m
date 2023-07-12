Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15EA6750BCB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 17:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233182AbjGLPGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 11:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233291AbjGLPGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 11:06:47 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145B11FDE
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 08:06:37 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-7748ca56133so55744739f.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 08:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1689174396; x=1691766396;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pC0bLEcnBiwLIxu3syoVMwHeIHk1xFP1scSsLouie0I=;
        b=eS71i0anKlE6fUCJhqBlfIR7gzxmlpePoIgjdxv7LESb/DQouUJs4o95gw8uM98szf
         N34KIxNSbgiF0oWIdBMmitBzsv1S8FM6QC3etmI/4HKMVbsIL81HtNKU57CBkmFxCOnd
         gGx4t7h7hTRBYFGlkKZYlryCRSoEKfBNLa8m3jSYnSiSxvKrRX3yXxkClzMHk0BSC15D
         BCpReSbIZA8ROeWiGvuK7RUZus32QHkjVWNSJhQcbn4M9oGfJUoBvR99WhIVV2SZoecW
         +c7ZfkIWP7D6nf7S9TkDACqPmXcHdzasrXWWJj0NOAIdMMUbud52Rl2btAgdnlvBvmjG
         u3xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689174396; x=1691766396;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pC0bLEcnBiwLIxu3syoVMwHeIHk1xFP1scSsLouie0I=;
        b=T7hrTz/7mQUhsbk8dOlDsgmaEPxLQwCeUxALgXeuhnJfSLEuiY9ro1zbbOW5KVACE2
         G/EMz3gn53yb9kUIlfqDwQJde+dbz7uaX0/xrMAAYQS/s9dSyLMZ4ySZ3uQShk2Hyg43
         HEFxYTByhCS0JwY9Ee9Qyqm6A15e4vQShqOcTeLWRgzLW5itXpYnU6MzYP8zHI8oFC+P
         byCEYnqQhKi85YIh3oDi/LRbNCukBupffdesIDtg1Y0WQ0/4zy2/KujbUZrsARr9bNoA
         FHDArG3fifJBfuxVIyl5bWvlZ0mpSCNUDoQYBzNVCOPBhMbnePL701hfofGHGZ3Df4m8
         iZaw==
X-Gm-Message-State: ABy/qLaqsgOSP1ws3yS28r0vsS5IKBldMxsD5kt/v/fFFbBjQurTD2E/
        UHmW4sbENlSLeBiEd5qL+0DlSQ==
X-Google-Smtp-Source: APBJJlHKyhHW5PHmC2sm3pULY2t3Ytv4DMMumMPTzNWWa/3C/5MiAdbU930YyPpPhsCB0NEwz75yQw==
X-Received: by 2002:a05:6602:474e:b0:77a:ee79:652 with SMTP id dy14-20020a056602474e00b0077aee790652mr19984055iob.1.1689174396427;
        Wed, 12 Jul 2023 08:06:36 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id a9-20020a029f89000000b0042b76deb22fsm1212784jam.92.2023.07.12.08.06.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 08:06:35 -0700 (PDT)
Message-ID: <e2d478de-24de-dc56-ca33-e008c09163ee@kernel.dk>
Date:   Wed, 12 Jul 2023 09:06:35 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 5/7] futex: make futex_parse_waitv() available as a helper
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com
References: <20230712004705.316157-1-axboe@kernel.dk>
 <20230712004705.316157-6-axboe@kernel.dk>
 <20230712092514.GE3100107@hirez.programming.kicks-ass.net>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230712092514.GE3100107@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/12/23 3:25?AM, Peter Zijlstra wrote:
> On Tue, Jul 11, 2023 at 06:47:03PM -0600, Jens Axboe wrote:
> 
>> Since we now provide a way to pass in a wake handler and data, ensure we
>> use __futex_queue() to avoid having futex_queue() overwrite our wait
>> data.
> 
>> diff --git a/kernel/futex/waitwake.c b/kernel/futex/waitwake.c
>> index 3471af87cb7d..dfd02ca5ecfa 100644
>> --- a/kernel/futex/waitwake.c
>> +++ b/kernel/futex/waitwake.c
>> @@ -446,7 +446,8 @@ static int futex_wait_multiple_setup(struct futex_vector *vs, int count, int *wo
>>  			 * next futex. Queue each futex at this moment so hb can
>>  			 * be unlocked.
>>  			 */
>> -			futex_queue(q, hb);
>> +			__futex_queue(q, hb);
>> +			spin_unlock(&hb->lock);
>>  			continue;
>>  		}
> 
> I'm not following; I even applied all your patches up to this point, but
> futex_queue() still reads:
> 
> static inline void futex_queue(struct futex_q *q, struct futex_hash_bucket *hb)
> 	__releases(&hb->lock)
> {
> 	__futex_queue(q, hb);
> 	spin_unlock(&hb->lock);
> }
> 
> How would it be different and overwrite anything ?!?

Good catch, this is a leftover from storing the task/wakeup data
separately. But I got rid of that, so it's stale comment at this point
and we can certainly use futex_queue() here again and drop this hunk.
Will make that edit.

-- 
Jens Axboe

