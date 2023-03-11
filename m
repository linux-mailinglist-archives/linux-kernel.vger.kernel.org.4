Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 742EC6B5E26
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 17:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjCKQxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 11:53:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjCKQw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 11:52:59 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3CEA13C
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 08:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:Cc:References:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=4f+5jyzSEbbObgrf6Hn1rkbRg4zTr+oj+dlkaLLEfbo=; b=zpVcVNej0fQXq2cHBpx+2tsqcu
        rDNolOOsXMZA7oYU6SZ4p2+ythe7ANg24SBIXA3TddnW5e+7ao7mCE+lhYoGH5qKN34nGD0FqS1dw
        HhMn1yuXWfvzWR1+Su+ergTGJXjJWW9HoVziKI0hPHd62bp7VBsl+IQQdzWjBUjLNhaUsa8Gp0eZH
        xHp04IvUvHz+cAIxHwNZiuuOT2fbTYvns6VroJXbgT00cLFj0keXxG+dVqYER9n9wvTwVSfo9rEnn
        CChOCdrpapJC9+5XlqbrF4encU0XcuXlxyPnIvM+0/MTFDpHH4ohDMg/g/0BnsS4/F298QhFagBj/
        3C3Cux6A==;
Received: from [2601:1c2:980:9ec0::df2f]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pb2Sl-000ukk-Ik; Sat, 11 Mar 2023 16:52:55 +0000
Message-ID: <b6530d49-074d-ee68-ed87-57c9d60d4847@infradead.org>
Date:   Sat, 11 Mar 2023 08:52:53 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: How to resolve "nptl-signals.h : no such file or directory"
Content-Language: en-US
To:     Ajay Garg <ajaygargnsit@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAHP4M8UEnLeTbrR1fZOJ2KkRAHLJLewjT2xg78AzzoXPYcz-hA@mail.gmail.com>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        kgdb-bugreport-request@lists.sourceforge.net
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAHP4M8UEnLeTbrR1fZOJ2KkRAHLJLewjT2xg78AzzoXPYcz-hA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+add some kernel gdb people + list

On 3/11/23 08:00, Ajay Garg wrote:
> Hi All.
> 
> (Sorry had to write to this list, as the subscription to
> gdb@sourcewave.org seemingly went successful, but never got the

Is that  @sourceware.org ?

> confirmation email. Even sending emails get bounced).
> 
> 
> I have been trying to analyze a core, but unable to receive the
> complete backtrace due to following error :
> 
> #######################################
> #0  0x0088ad6c in __libc_signal_restore_set (set=0xf48f2a78) at
> ../sysdeps/unix/sysv/linux/nptl-signals.h:79
> 79 ../sysdeps/unix/sysv/linux/nptl-signals.h: No such file or directory.
> #######################################
> 
> 
> Following is the (incomplete) backtrace :
> 
> #######################################
> [Current thread is 1 (LWP 7491)]
> (gdb) bt
> #0  0x0088ad6c in __libc_signal_restore_set (set=0xf48f2a78) at
> ../sysdeps/unix/sysv/linux/nptl-signals.h:79
> #1  __GI_raise (sig=sig@entry=6) at ../sysdeps/unix/sysv/linux/raise.c:48
> #2  0x0088cb78 in __GI_abort () at abort.c:89
> #3  <frame with modified names> 0x049b3a54 in func_1 (ffp=<optimized
> out>, base_name=<optimized out>, max_size=<optimized out>,
> file_type=<optimized out>)  at a/b/c/d/e:58
> #4  0x00000270 in ?? ()
> (gdb)
> #######################################
> 
> 
> Since GDB is able to find raise.c, I did a full base-machine search
> for it, via :
> 
> #######################################
> find / -name raise.c 2> /dev/null
> #######################################
> 
> but could not find raise.c either on the base-machine filesystem.
> 
> 
> So, following are my queries :
> 
> 1.
> Where are raise.c, nptl-signals.h etc. supposed to reside?
> 
> 2.
> How can we bring back the missing nptl-signals.h file?
> 
> 
> Will be grateful for pointers.
> 
> 
> Thanks and Regards,
> Ajay

-- 
~Randy
