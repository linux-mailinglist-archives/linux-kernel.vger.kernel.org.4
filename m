Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 560AA5BB514
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 02:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbiIQAuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 20:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiIQAul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 20:50:41 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C5752DFD
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 17:50:39 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a26so24223575ejc.4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 17:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date;
        bh=ovQ47vZovF8kMU8XowExonRrfnvEzMQFtu6wQPjgTpY=;
        b=S9pALlVHg0Hbx2iPGQFDjJWmaSsK3btrGX8KJi0u3C6QnzqRkZEzvdZltDg7IrSPDN
         BOgFkO90fpfZE2pB3y31iJ5kM/Y80uv49Wl3r5aAUAlbg8tlqjcrWIG55Mukv+OlHTOc
         q7ScK/6jbXuw+n7sfS+rmXdsglckcdAjsl1/MQdo8sTVMnkjI8eA6Y9YGnxUjDIj63Ep
         zvbduK9JP/cLCyvWtpXqAAma+kgQOG6BJcsye9J09c0htADEJjXZtXpDJMdag9nz+tCu
         fqZN2e4J/FkTHZhp1kIFYLPlipHyaxb6Op1QL5SDNo3KbOQDRMcIXFVwKJEgzZ8aVELI
         dimA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date;
        bh=ovQ47vZovF8kMU8XowExonRrfnvEzMQFtu6wQPjgTpY=;
        b=zJ5mUG+meFD+nCjPi7h9A+euEsQ5K0Cba3lNTEifutCTbthsR7EdlEL9tBD99pQLjo
         4WvqpE5G5Ue2CB+OKXkCciXpppj2jffdo78jfsOAGL5/aJNcr7fcRor0ox5yYeiLGCzC
         mtK4TIzXEljDNrvuXu+0ZEFHDh+Y6upyA1TPBE2AhUS1AZQEXV+Z0C61sVw33sfiu8sR
         Nc++mHHZkm54k8gKyZaHAC/V89MRXCbuiRdzu5hcM142YEWthF6cTr1SzCfel7axSaPc
         hctCBCcFDsrC9wqP2bLYSMo0aOa9jCEryGgoRqsIfXV6+aiuHZXHwjCHRMypXzTBJKlc
         bamw==
X-Gm-Message-State: ACrzQf3lgLajC0Ty3E90vnLuE8wJ93VbTDNvVNhM8RTq27bBiylRO8mR
        pXvm4q6D0uszXRz6wIhhpPG5/DHPWpZNxG7+Zjo=
X-Google-Smtp-Source: AMsMyM7bnOhLQ0FRAoq5I5fvpfy+AFBYNZS0HnBpN3hS9RcMyrJUC2DJ/kYe2R4HJFOuutvI1Tda6w==
X-Received: by 2002:a17:906:8a41:b0:780:a367:db50 with SMTP id gx1-20020a1709068a4100b00780a367db50mr3763706ejc.118.1663375837515;
        Fri, 16 Sep 2022 17:50:37 -0700 (PDT)
Received: from localhost ([185.176.138.242])
        by smtp.gmail.com with ESMTPSA id c26-20020a056402101a00b0044792480994sm14310975edu.68.2022.09.16.17.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 17:50:37 -0700 (PDT)
Date:   Fri, 16 Sep 2022 17:50:37 -0700 (PDT)
X-Google-Original-Date: Fri, 16 Sep 2022 17:50:25 PDT (-0700)
Subject:     Re: [GIT PULL] RISC-V Fixes for 6.0-rc6
In-Reply-To: <CAHk-=wihdDOSVVi1gBYo+rcJ7dG6tvN7mEU=XLir8WiEdR1kQQ@mail.gmail.com>
CC:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-725db1f2-5b60-44d5-8ed1-71f3e7cdd8a7@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Sep 2022 13:09:21 PDT (-0700), Linus Torvalds wrote:
> On Fri, Sep 16, 2022 at 8:31 AM Palmer Dabbelt <palmer@rivosinc.com> wrote:
>>
>> I have one merge conflict as a result of a treewide fix, I'm getting some odd
>> output from just showing the merge (it's showing some of the fix too), but I
>> think the merge itself is OK.  My fix is to keep the write lock
>>
>> -       mmap_read_lock(mm);
>> ++      mmap_write_lock(mm);
>>  +      ret = walk_page_range_novma(mm, start, end, &pageattr_ops, NULL,
>>  +                                  &masks);
>> -       mmap_read_unlock(mm);
>> ++      mmap_write_unlock(mm);
>
> Yes, thatr's the proper merge resolution.
>
> HOWEVER.
>
> Looking at the *callers* of this new __set_memory_mm(), this is all
> completely bogus and broken.
>
> In particular, fix_kernel_mem_early() does that call under rcu_read_lock().
>
> You can't do that. Not with the read-lock, and not with the
> write-lock. You simply cannot (and must not) block while in a
> read-side critical section, and trying to take any sleeping lock -
> whether for reading or for writing - is just completely wrong.
>
> So I'm not doing this pull. The merge resolution is trivial, but the
> code is simply wrong.

Sorry about that, it's pretty brain-dead.  I'd love to blame this one on 
the lack of sleep over the past week or two, but I'm a bit too tired to 
commit to that.  Either way I'll go sort it out, but not for this week 
-- I don't think anything else was super critical, so it shouldn't be 
that big of a problem.
