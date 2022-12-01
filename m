Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41F9363F702
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 19:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbiLASA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 13:00:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbiLASA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 13:00:56 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D828B2771
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 10:00:55 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id s16so1082455iln.4
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 10:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mLmQ9FuLQV/3WYg6WIyM6UQ5+aTXTDiwF3md5aMgLKE=;
        b=warFrrLffutg4BA21c3UlAQ+DI9pvBMP2jZvjocySvHdk0YnKonKWoTMV1r5Fkgfqk
         t6fYtIgN4kzMEV7T/AAxi4rXxSY4U60Ym7uO81kbq/zV1jWwnrMBWKCzivHDFYrU54u+
         TEKvyJuZFXInC8FSQKOzsdCMiA4cEwZKPtzp7baKTowghYvbUYfHX4ZyTe3AQNcFhRPY
         RseGYVRgPIePpH2nPJPYhJ5OGVNNbx2Z6Z+AVBbhRMRXUZsEUTfXI9cIyao+1jknzPJO
         ufPH+Vd/AqVV4O1MmICq/ZflguQP3LirFPeiEDmWCyOccvGo21L1IvetyAaSYGGupot9
         Izfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mLmQ9FuLQV/3WYg6WIyM6UQ5+aTXTDiwF3md5aMgLKE=;
        b=UR1AUpEZIUfpWnFDiVqbuYDSaFchjz4M3CWjx6zJ1QN36dWeNmA61ANusiLXQ1rK/t
         +tFb8ihtB0RwuSsszaz1eLRYy42Kv9z/q4bMPE467vvplCxIdfkZWAlxJn8YHZe22JtB
         hk3tD+aUk9GuOGM3EeaesVwWQVfx+6LRszrBpzCbGIvX56QeHIgNAK/FEUdE+RC6VaEB
         vlWWtZmYPkTdRvx5CLh3SuKNbnZut1sjuPuUb32cS2Xfk9Bqri9aAs9bqRvuWxowDWOa
         X/PFJPNhiU+SbVBOjioa+33SJjvXGd4OBH2Mv2akkJI/Lfg+w7HUuorL5Ab35UK5fQwq
         nYuw==
X-Gm-Message-State: ANoB5pkRQZ0vx42ZxPLgBTP6NJka3WKGon3+CWqdCBNXKdNHZH/S7Rca
        9OtDg7iwcELkrLl3t2Vz/HudAw==
X-Google-Smtp-Source: AA0mqf7pMLfmPCOnWsEzbt4qZ5dRqmAd5e/FC+k4b+Dpqd1z7c4CXwBLHthxHIR7+AhkTxHUfFwsPA==
X-Received: by 2002:a92:a30b:0:b0:302:555a:f761 with SMTP id a11-20020a92a30b000000b00302555af761mr21047770ili.323.1669917654401;
        Thu, 01 Dec 2022 10:00:54 -0800 (PST)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id l66-20020a6b3e45000000b006dfbf3fe79dsm1831823ioa.32.2022.12.01.10.00.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Dec 2022 10:00:53 -0800 (PST)
Message-ID: <8d195905-a93f-d342-abb0-dd0e0f5a5764@kernel.dk>
Date:   Thu, 1 Dec 2022 11:00:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 6/6] eventpoll: add support for min-wait
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
To:     Soheil Hassas Yeganeh <soheil@google.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     Willem de Bruijn <willemb@google.com>,
        Shakeel Butt <shakeelb@google.com>
References: <20221030220203.31210-1-axboe@kernel.dk>
 <20221030220203.31210-7-axboe@kernel.dk> <Y2rUsi5yrhDZYpf/@google.com>
 <4764dcbf-c735-bbe2-b60e-b64c789ffbe6@kernel.dk>
In-Reply-To: <4764dcbf-c735-bbe2-b60e-b64c789ffbe6@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> @@ -1845,6 +1891,18 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
>>>  		ewq.timed_out = true;
>>>  	}
>>>  
>>> +	/*
>>> +	 * If min_wait is set for this epoll instance, note the min_wait
>>> +	 * time. Ensure the lowest bit is set in ewq.min_wait_ts, that's
>>> +	 * the state bit for whether or not min_wait is enabled.
>>> +	 */
>>> +	if (ep->min_wait_ts) {
>>
>> Can we limit this block to "ewq.timed_out && ep->min_wait_ts"?
>> AFAICT, the code we run here is completely wasted if timeout is 0.
> 
> Yep certainly, I can gate it on both of those conditions.
Looking at this for a respin, I think it should be gated on
!ewq.timed_out? timed_out == true is the path that it's wasted on
anyway.

-- 
Jens Axboe

