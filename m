Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C38A268C643
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 19:57:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbjBFS5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 13:57:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjBFS5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 13:57:41 -0500
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE6FD13D50
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 10:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1675709859;
        bh=LYlocZFInM+OgHoIVyoc/ExCot/hdTqOT5UN8XsZlKY=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=s0vKM1f1D6reyaCqUFugTZXmg3jyJHypNQ5E+aRakyX/GYTCO4hk622T9joOEttJs
         1CFg2p18ncvz6JbJIpLGN8JSNKACiAKsr46mL0JNn9SFZ5PG/YbdhkcYv+EJ9D0dNn
         5o6QjdGQmvNodxFQ36G3VPWNRDQu+cZBDMM/a63PB1D0HtV0+x2iIb8R1cdUVBOH9O
         fLJqO+MdGqVEAu++82owgr2YFX7yxmpguHBnLEPqWftjFxuUDWZd+L3GuQxxvya/pq
         RWzjeQLk1w7ZEaTh8xd3rX7pUNQVZpMTsJU+H2ZY4lTNd6UKz74T7X+q/eTtvtL0bG
         X3/2ep1GzFAjg==
Received: from [10.1.0.205] (192-222-188-97.qc.cable.ebox.net [192.222.188.97])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4P9b9Z6HLbzjWp;
        Mon,  6 Feb 2023 13:57:38 -0500 (EST)
Message-ID: <0d52ddc1-7bd6-2a37-5fdf-d00ce42eae4f@efficios.com>
Date:   Mon, 6 Feb 2023 13:58:18 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: Request for contributor approval: Relicensing rseq selftests to
 MIT
Content-Language: en-US
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Shuah Khan <shuah@kernel.org>,
        Michael Jeanson <mjeanson@efficios.com>,
        Peter Oskolkov <posk@posk.io>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Paul Burton <paulburton@kernel.org>,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        Will Deacon <will@kernel.org>,
        Xingxing Su <suxingxing@loongson.cn>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
References: <da1bfb8a-5a88-5697-1c39-8e15c3c208a6@efficios.com>
In-Reply-To: <da1bfb8a-5a88-5697-1c39-8e15c3c208a6@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-02-06 13:36, Mathieu Desnoyers wrote:
> Hi,
> 
> I would like to get contributor approval to relicense the rseq selftests 
> within the Linux kernel and the librseq project to MIT. This will make 
> it easier to use librseq from statically built applications, and I wish 
> to continue sharing code between the kernel rseq selftests and librseq.
> 
> Allowing use of rseq application headers from statically built 
> applications was the intent from the beginning, but it turns out that 
> having the rseq.c initialization code under LGPL2.1 makes it harder than 
> it should be for users.
> 
> The current contributor summary commit-wise under
> tools/testing/selftests/rseq is:
> 
>     269  Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>       6  Michael Ellerman <mpe@ellerman.id.au>
>       5  Shuah Khan <skhan@linuxfoundation.org>
>       3  Michael Jeanson <mjeanson@efficios.com>
>       3  Peter Oskolkov <posk@google.com>
>       2  Martin Schwidefsky <schwidefsky@de.ibm.com>

I am having issues reaching Martin Schwidefsky. In this case it's a one-liner
contribution to a header which is going from LGPL2.1 OR MIT to MIT, which is
fine because it just removes one of the pre-allowed licenses, thus removing
some redundancy.

[ CCing Heiko Carstens ]

Rerefence:

commit 3d4d1f05bc990f240d66b0ffaf7121397e14df19
Author: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date:   Mon Apr 29 11:27:58 2019 -0400

     rseq/selftests: s390: use trap4 for RSEQ_SIG
     
     Use trap4 as the guard instruction for the restartable sequence abort
     handler.
     
     Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
     Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
     Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>

Thanks,

Mathieu

>       1  Masahiro Yamada <masahiroy@kernel.org>
>       1  Paul Burton <paulburton@kernel.org>
>       1  Sabyasachi Gupta <sabyasachi.linux@gmail.com>
>       1  Vasily Gorbik <gor@linux.ibm.com>
>       1  Vincent Chen <vincent.chen@sifive.com>
>       1  Will Deacon <will@kernel.org>
>       1  Xingxing Su <suxingxing@loongson.cn>
> 
> Header files are currently dual-licensed LGPL2.1/MIT, which is
> somewhat redundant with plain MIT.
> 
> rseq.c was licensed under LGPL2.1. Relicencing it to MIT will facilitate 
> its integration into statically built applications.
> 
> In order to facilitate eventual code sharing between tests and the
> library implementation, I would like to relicense the tests from LGPL2.1 
> to MIT as well.
> 
> Many of the contributions are trivial, but I prefer to kindly ask for 
> approval nevertheless.
> 
> Thanks,
> 
> Mathieu
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

