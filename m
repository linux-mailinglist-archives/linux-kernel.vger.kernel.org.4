Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D66C570BA34
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 12:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbjEVKcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 06:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjEVKcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 06:32:43 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99EEBE6
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 03:32:41 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f607766059so4329035e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 03:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684751560; x=1687343560;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=anxRZjbisfXv68Exs9/M/EgRFLJ+O3gsRtmUqgFfXNE=;
        b=Cwh49v8YgPBzZkFVGi+CvETiehO3eRtwXPREEi4Q9s0ott1jAh8Nqoo2FAI3/O9Eay
         T8fNfI055zgzUscGL9fa6lJPssWDCkCAJXSxkuB2Z/MiEHNjoCh2bOD75HlGOe+azLyl
         UyNRhklOHqZD36qrGcyVCAY7e57y/6R0nhFK2aygTiXWSMZlDEuY6ag/jOGxttLEw9YF
         N+H7O1Z0SlvhUa+xgQXVRd3jPNNe4i/7ft3WkLz2BDNZAPE7v1lFFk/nSQ8T9y9RLV4w
         ZrdmvqLR8nuoV+6LAZxtQ9MWu6dlFAmeoGwrmEBGJjKBR+NyBSGoZSPGQ0brt9SZ30fv
         MjZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684751560; x=1687343560;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=anxRZjbisfXv68Exs9/M/EgRFLJ+O3gsRtmUqgFfXNE=;
        b=kQt0QonhWWDgn2ktnQHhhhl2BGnlAaLX8OIUMwFZwPjWK9r5LwKrOZ4Mm4w7P+6T7Z
         cD4Tb03fzXBlsMcFY4pEd4bIJncGviKhwwh/A8O9dKfB0Lk8NXFcD9CTWUPwsvjZNcyv
         PAvnMtVKYx9BlFt1/wqmSb7yYZUsL7wzx3tOpHnguGoRZHs3QHoNAq4UQ6YKeFfxLjOe
         CWuXiNqd7udYqfLytO4srft3ePZ+2H2pbeQEm82ZUzPin6+kkRczUJtHC847FBUqeP96
         PUCSHL3OoDJmFVtyYnHlEAtE5Hms2K4HJMnn9zGHzOqVbnMtbCQ9PYH4v5Rkm0bhIGbW
         tdfg==
X-Gm-Message-State: AC+VfDxBAIuLC0YxotfaeKTSSCVcypPJmfpPVh7qISi5FAkKA0tSIsST
        jrW5h5WzcGNNfC2Xwnm8RJM=
X-Google-Smtp-Source: ACHHUZ4zLFSDmj85YEyHnaUdgCr8poYluz2vwoDLaAtHD6etOmmGCnZ718vk0uDZ5VpomKaVrjDvhw==
X-Received: by 2002:a7b:cbd2:0:b0:3f5:967:bf1b with SMTP id n18-20020a7bcbd2000000b003f50967bf1bmr7372922wmi.11.1684751559870;
        Mon, 22 May 2023 03:32:39 -0700 (PDT)
Received: from ?IPV6:2a01:c23:c506:b200:b0cf:63c1:2e22:5cc? (dynamic-2a01-0c23-c506-b200-b0cf-63c1-2e22-05cc.c23.pool.telefonica.de. [2a01:c23:c506:b200:b0cf:63c1:2e22:5cc])
        by smtp.googlemail.com with ESMTPSA id p19-20020a05600c205300b003f60101074dsm5794203wmg.33.2023.05.22.03.32.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 May 2023 03:32:39 -0700 (PDT)
Message-ID: <59e86f97-3e77-14e0-948a-1a87ccf72f36@gmail.com>
Date:   Mon, 22 May 2023 12:32:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: r8169: disable ASPM during NAPI poll locking changes --> BUG:
 Invalid wait context --> PREEMPT_RT pain
Content-Language: en-US
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mike Galbraith <efault@gmx.de>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <e55be0ae115ad6494ebb48fecd03e5c2fe528230.camel@gmx.de>
 <28727b435c143f15feddffb4c29095fee2500dff.camel@gmx.de>
 <20230522080604.MgUGcyeU@linutronix.de>
From:   Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <20230522080604.MgUGcyeU@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.05.2023 10:06, Sebastian Andrzej Siewior wrote:
> On 2023-05-21 16:27:10 [+0200], Mike Galbraith wrote:
>> On Sun, 2023-05-21 at 08:03 +0200, Mike Galbraith wrote:
>>> Greetings,
>>>
>>> The locks added to prep for $subject induce invalid context moaning due
>>> to not being raw locks, but if I do that, the hold time does very bad
>>> things to RT.
>>
>> The locks aren't really 160us horrible. The GPU was enabled (oops),
>> nouveau then makes box horrible for RT (and graphics:).  With GPU
>> turned back off, the largest trace I saw was 77us, which jibes pretty
>> well with new max of low to mid 50s without ftrace running, or up a tad
>> over 20us for this now pretty old commodity i7 desktop box.
> 
> So you are saying it is all good?
> I've been looking at the r8169 the other day and it seemed all good
> since it was only scheduling workqueues and NAPI. But now I see this
> mac_ocp_lock + config25_lock which are acquire in hardirq context but
> can't. This needs to be taken care.

What do you mean with "but can't"? Taking a spinlock in hardirq context
is normal.

> 
>> 	-Mike
> 
> Sebastian

