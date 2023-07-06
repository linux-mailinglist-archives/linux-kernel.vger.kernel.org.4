Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A03574959F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 08:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233293AbjGFGa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 02:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232501AbjGFGaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 02:30:55 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B8E1B6
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 23:30:54 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3142a9ff6d8so233295f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 23:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688625053; x=1691217053;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QAx0zzZBH3vJ3zYXTImqXKLwPTv5LFpuSZLAoB3gyh8=;
        b=pj9BWCQnSTyNUIepazWS9qHh3NCIvW6mOZA9WeObO+hlR3nDeFbM+35uynR+ieHB1t
         FABwwgmGB1MuWVNiuA10/Zu6jeImjWz1sVKN9jXK4yVtyJHZLKTS95xV6M6CiQRAOggR
         lgmyumJZbKHmamvi9GwK3ARK7zpj7jmaGc0RITjSH4iyifObRzhZZ0qR22ScO0gJb1+d
         xDaB0T6ur7hHHeAMUxNc1MEsvr0QXlDyy830XkNSfZPxKY1BLbX00Q3wKtFloVhWwOpp
         t2nr8Yvb5nfQpAGJ2hsI449g60MLLfafkPS8om+xYnESsN77py0wdmCiCK7ii8dniJHB
         mM0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688625053; x=1691217053;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QAx0zzZBH3vJ3zYXTImqXKLwPTv5LFpuSZLAoB3gyh8=;
        b=Gv0/MONAHHSGcaOGN+pvKI/NLVl/YxxTtBPG0vdmT4CdxpwrDn2Qm/w5ORdSLDOEFr
         ViFC6iHltji4o5JSOPQ/5QNRnlvCzpAwv3l9kMpxvZFbsnRxWqu2gxGl+MFNicipHCXS
         1RQ41tW1GhvPtnfzZL16UpyDtJMCw5YTbEJHwCBex7O7C34wTgyQUAHHodZPLiheSOUO
         ks/BgKaELs8qt/WrkZleCzaJX4dh4zuIahCyUDW/iwkPX3ABbmUMXeTXjm/Gp7OEwLzL
         vDSd6+7Pm08FnTWGcnBdOr+WzvRR5w6+X/ua3zDCrlrfscCKDpERp7AemsivlcQItom0
         COyA==
X-Gm-Message-State: ABy/qLa4tzHHJU+nqokHQZFSzA5+jnZq58XmWJZSr6ZDzMfinNY3WaeK
        0NZT+FZEqGo34mL2e73WOZJl7w==
X-Google-Smtp-Source: APBJJlFAPFSbjMBxwG92flXkhw2d9dQpQiiXgI9QJfyjY4KmxKdFx3W2AJqlSUwX4MsetY1xbEoa3w==
X-Received: by 2002:adf:f60b:0:b0:314:50b4:c3c with SMTP id t11-20020adff60b000000b0031450b40c3cmr604098wrp.71.1688625052744;
        Wed, 05 Jul 2023 23:30:52 -0700 (PDT)
Received: from [192.168.45.155] ([95.152.217.99])
        by smtp.gmail.com with ESMTPSA id g3-20020a5d5543000000b0030e5bd253aasm942566wrw.39.2023.07.05.23.30.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jul 2023 23:30:52 -0700 (PDT)
Message-ID: <c4b9f02f-3f6a-74b4-4e0d-3da314f90aa8@linaro.org>
Date:   Thu, 6 Jul 2023 07:30:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: qemu-x86_64 booting with 8.0.0 stil see int3: when running LTP
 tracing testing.
Content-Language: en-US
To:     "Richard W.M. Jones" <rjones@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        =?UTF-8?Q?Daniel_D=c3=adaz?= <daniel.diaz@linaro.org>,
        Benjamin Copeland <ben.copeland@linaro.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
References: <CA+G9fYsETJQm0Ue7hGsb+nbsiMikwycOV3V0DPr6WC2r61KRBQ@mail.gmail.com>
 <2d7595b1-b655-4425-85d3-423801bce644@app.fastmail.com>
 <20230621160655.GL2053369@hirez.programming.kicks-ass.net>
 <20230704074620.GA17440@redhat.com> <20230705162830.GC17440@redhat.com>
 <20230705215008.GD17440@redhat.com>
From:   Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230705215008.GD17440@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/5/23 22:50, Richard W.M. Jones wrote:
> tb_invalidate_phys_range_fast() *is* called, and we end up calling
>    tb_invalidate_phys_page_range__locked ->
>      tb_phys_invalidate__locked ->
>        do_tb_phys_invalidate
> 
> Nevertheless the old TB (containing the call to the int3 helper) is
> still called after the code has been replaced with a NOP.
> 
> Of course there are 4 MTTCG threads so maybe another thread is in the
> middle of executing the same TB when it gets invalidated.

Yes.

> tb_invalidate_phys_page_range__locked goes to some effort to check if
> the current TB is being invalidated and restart the TB, but as far as
> I can see the test can only work for the current core, and won't
> restart the TB on other cores.

Yes.

The assumption with any of these sorts of races is that it is "as if" the other thread has 
already passed the location of the write within that block.  But by the time this thread 
has finished do_tb_phys_invalidate, any other thread cannot execute the same block *again*.

There's a race here, and now that I think about it, there's been mail about it in the past:

https://lore.kernel.org/qemu-devel/cebad06c-48f2-6dbd-6d7f-3a3cf5aebbe3@linaro.org/

We take care of the same race for user-only in translator_access, by ensuring that each 
translated page is read-only *before* performing the read for translation.  But for system 
mode we grab the page locks *after* the reads.  Which means there's a race.

The email above describes the race pretty clearly, with a new TB being generated before 
the write is even complete.

It'll be non-trivial fixing this, because not only do we need to grab the lock earlier, 
there are ordering issues for a TB that spans two pages, in that one must grab the two 
locks in the correct order lest we deadlock.


r~
