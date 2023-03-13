Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 580456B8523
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 23:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjCMWvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 18:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjCMWu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 18:50:58 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC147A90F
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 15:50:18 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id i19so7718442ila.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 15:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678747768;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RXdBPjaM1WfjoK8YXDJdoMOlz61gqqSKxs3ISgBCJio=;
        b=Sk4tcyiJZY4eqUC1+qs15WscbJpRa4XaHSgMMdJ+Nt07bNH+pbjWa0BhGMYnxJZuJ3
         1SvpsB/UGcqOiXXXMQ4Cm6njzHw9AIuZboMjSsiiDuX8Txk5U4fB36jQCzP+X2+BDbmQ
         Dh4721MFLa0LsA0Ypa6PaLTUoTYtqeCizEZZiyKYzerCO8KrcaCoxBxs4CaL/ssX1gL9
         9Bn6ULxzu393Hk6S4II4I+RfbSFvkwPtNUtwemGkE/gZb2Tt7uYlwZmPFAuvd9+UUN81
         6VBxo+jO3FsXk0gEk/LOee1mQ4HBg3tUS0d4csD3bkMOOF6dTkxduqfRZmxrhPhlhaJc
         3ZeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678747768;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RXdBPjaM1WfjoK8YXDJdoMOlz61gqqSKxs3ISgBCJio=;
        b=fQk1AeG6JWRDlJ32SljQzN/zk3FD7x2uTsDR3IXvT6b7H5iM33RPc9Ggo094MECSCF
         DTzWXTeV2DRAMlaCEnoyhVa6DU2EXnRt2mLM0qW7eVtxT3l25thDY4cqkJWfxiNiyaei
         T1TGEd62mC05q//EhoijWK90Ad4icV1rvf6A7TlCZN6o5S4URfR9P9rY2jjmiGg77S4N
         4KMxMHth5Fu3GMucoW14XG9a3A2xFHXD6y3YlYR8SFCkZTyfeRpULAm2kA9WXihEFiUg
         J5E22snBe9sxoGvoJCg4YdrSOZQqkQhimBObccTuAPj5lItOS/EG+4CX0nSB8YXTMHc7
         uoRA==
X-Gm-Message-State: AO0yUKVQaHSCg47ewjyQ9t0pUMhWlRjJXA+4knUE1IRP26xLFkd4U+t/
        hoa+fT7Tps5/V+XeGwgeCa8=
X-Google-Smtp-Source: AK7set/kZvixLEKQlPAXhmkAVSq3gLLeEAAaNMLLciV0ZM0KF/MiseYcD5PptZ79hSsZjhYR+vwY6g==
X-Received: by 2002:a92:da05:0:b0:323:70c:ba7a with SMTP id z5-20020a92da05000000b00323070cba7amr1155204ilm.0.1678747768693;
        Mon, 13 Mar 2023 15:49:28 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g7-20020a92dd87000000b00310f9a0f8a7sm293937iln.76.2023.03.13.15.49.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 15:49:27 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <c5f4fe2d-fc32-cb2f-669c-c9c5f6e3b46e@roeck-us.net>
Date:   Mon, 13 Mar 2023 15:49:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAHk-=wii6BZtVKYfvQCQqbE3+t1_yAb-ea80-3PcJ4KxgpfHkA@mail.gmail.com>
 <d915df60-d06b-47d4-8b47-8aa1bbc2aac7@roeck-us.net>
 <CAHk-=wi8xQw6eTRncbJfWWYHHi0UBG2B_AfHrzZbPr=k0V_WYQ@mail.gmail.com>
 <fce02d50-65a7-4aa7-8949-6a82321da292@roeck-us.net>
 <CAHk-=wgVCTJTQPwoLrscmOa+n9X8+bc5ieCD+7PXw35Ke7i6ng@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: Linux 6.3-rc2
In-Reply-To: <CAHk-=wgVCTJTQPwoLrscmOa+n9X8+bc5ieCD+7PXw35Ke7i6ng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/13/23 15:16, Linus Torvalds wrote:
> On Mon, Mar 13, 2023 at 1:30 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> It gets weird. Bisect log below. Reverting the identified patch does
>> indeed seem to fix the problem, only I have no clue why this might
>> be the case. The patch looks completely innocent to me. Yet, I can
>> reliably reproduce the problem with v6.3-rc2, but at least so far I
>> have not been able to reproduce it with commit f3dd0c53370 reverted
>> (and I am trying on five different servers in parallel).
> 
> Yeah, that commit looks very innocuous. I'm surprised it would even
> change any code generation, but it's very possible that it ends up
> affecting some code layout or something almost by mistake.
> 
> I'd be inclined to think that the problem is very timing-sensitive,
> and has probably been there for a while, and some random moon phase
> just made it happen now.
> 

Maybe, but it seems unlikely. I can reliably reproduce the problem
with v6.3-rc2. Typically it takes some 20-30 boot attempts to see it. With
f3dd0c53370 reverted I tried more than 1,000 boot attempts and did not see
the problem. I also don't recall ever having seen it before.

Anyway, I'll probably just disable CONFIG_DEBUG_LOCK_ALLOC for my
arm boot tests to avoid the message. I don't want it to create noise
and hide other problems.

Thanks,
Guenter

