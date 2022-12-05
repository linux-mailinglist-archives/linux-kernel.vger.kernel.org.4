Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE46764222F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 05:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbiLEEKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 23:10:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbiLEEKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 23:10:42 -0500
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1AFEFCE6;
        Sun,  4 Dec 2022 20:10:40 -0800 (PST)
Received: by nautica.notk.org (Postfix, from userid 108)
        id B97CAC01C; Mon,  5 Dec 2022 05:10:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1670213447; bh=zVvTWWTak2J92NoVfqZskSPDDhkfL4JCCKRfplZnf6Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YgK2mMYTgebYhvhLszbHajKnkAsvVqF9RobSLcUFZXqGMqxcfdfMRMcUl7vdyy8bC
         vTMgPwFqkyur69GM2MCnPfjdGcY/sXJMUv6fRhE+C9xoelK29QMWHJzvByp+MT0szj
         SpCp0QybaW2/k7ymf9eaQV4zanfjRqWMMm/p+Z+3Wnpdd74lnGdqjxJ8TEHU6cEenT
         HR/NKfsbYIa/SY3F1h0+x6cu4jOd+vAxBB2do+Sw2suquHC6z259ez2OyEnUpcv927
         n7EBNlF7EvFmKj5S0jKQXOeQG/2v4hzYURxlug+KCRnOG4ws0nRWaqDMJ2T8ab9PVS
         BFhw9pc7aedVw==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id C26E5C009;
        Mon,  5 Dec 2022 05:10:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1670213447; bh=zVvTWWTak2J92NoVfqZskSPDDhkfL4JCCKRfplZnf6Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YgK2mMYTgebYhvhLszbHajKnkAsvVqF9RobSLcUFZXqGMqxcfdfMRMcUl7vdyy8bC
         vTMgPwFqkyur69GM2MCnPfjdGcY/sXJMUv6fRhE+C9xoelK29QMWHJzvByp+MT0szj
         SpCp0QybaW2/k7ymf9eaQV4zanfjRqWMMm/p+Z+3Wnpdd74lnGdqjxJ8TEHU6cEenT
         HR/NKfsbYIa/SY3F1h0+x6cu4jOd+vAxBB2do+Sw2suquHC6z259ez2OyEnUpcv927
         n7EBNlF7EvFmKj5S0jKQXOeQG/2v4hzYURxlug+KCRnOG4ws0nRWaqDMJ2T8ab9PVS
         BFhw9pc7aedVw==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 5f69962f;
        Mon, 5 Dec 2022 04:10:33 +0000 (UTC)
Date:   Mon, 5 Dec 2022 13:10:18 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Christian Schoenebeck <linux_oss@crudebyte.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the v9fs tree
Message-ID: <Y41vKkaH9tvRXCfv@codewreck.org>
References: <20221205150316.6fac25f2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221205150316.6fac25f2@canb.auug.org.au>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell wrote on Mon, Dec 05, 2022 at 03:03:16PM +1100:
> After merging the v9fs tree, today's linux-next build (i386 defconfig)
> failed like this:
> 
> In file included from include/linux/kernel.h:29,
>                  from arch/x86/include/asm/percpu.h:27,
>                  from arch/x86/include/asm/nospec-branch.h:14,
>                  from arch/x86/include/asm/paravirt_types.h:27,
>                  from arch/x86/include/asm/ptrace.h:97,
>                  from arch/x86/include/asm/math_emu.h:5,
>                  from arch/x86/include/asm/processor.h:13,
>                  from arch/x86/include/asm/timex.h:5,
>                  from include/linux/timex.h:67,
>                  from include/linux/time32.h:13,
>                  from include/linux/time.h:60,
>                  from include/linux/stat.h:19,
>                  from include/linux/module.h:13,
>                  from net/9p/client.c:11:
> net/9p/client.c: In function 'p9_check_errors':
> include/linux/kern_levels.h:5:25: error: format '%ld' expects argument of type 'long int', but argument 3 has type 'size_t' {aka 'unsigned int'} [-Werror=format=]
>     5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
>       |                         ^~~~~~
> include/linux/printk.h:429:25: note: in definition of macro 'printk_index_wrap'
>   429 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
>       |                         ^~~~
> include/linux/printk.h:500:9: note: in expansion of macro 'printk'
>   500 |         printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
>       |         ^~~~~~
> include/linux/kern_levels.h:11:25: note: in expansion of macro 'KERN_SOH'
>    11 | #define KERN_ERR        KERN_SOH "3"    /* error conditions */
>       |                         ^~~~~~~~
> include/linux/printk.h:500:16: note: in expansion of macro 'KERN_ERR'
>   500 |         printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
>       |                ^~~~~~~~
> net/9p/client.c:523:17: note: in expansion of macro 'pr_err'
>   523 |                 pr_err(
>       |                 ^~~~~~
> cc1: all warnings being treated as errors
> 
> Caused by commit
> 
>   36cd2f80abf8 ("net/9p: fix response size check in p9_check_errors()")
> 
> I have applied the following patch for today:

Thank you!
I guess I should start building one 32bit kernel somewhere...

I've amended the bad commit with this and added a note to the patch
thanking you (not quite sure how to express that with xx-by: like tags,
it's just words -- if you care and have a suggestion feel free)

-- 
Dominique
