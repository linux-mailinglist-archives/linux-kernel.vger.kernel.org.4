Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFC2968C5E2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 19:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjBFSfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 13:35:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbjBFSfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 13:35:46 -0500
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154622E80A
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 10:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1675708539;
        bh=HT/CLlOL31a8/tdXohJU3lcshcKbsWPw/7B6bTV6kcA=;
        h=Date:To:Cc:From:Subject:From;
        b=gSAvmQ+vwXcEROk0oISGjldtUZF/CohAxQ5voxzXJFRGhxrETzkLRstNwYduDgoOS
         Jshn26E+eg/e0KRNODPsHUUMt0jVJQGU6/kqeLlyl/sECaHkpgHzsUKv6FyqlLFCbY
         TtOjujU3wAkhctBoUQuhvfSmRT+JKatIhVPwZQwBcQtbJgNvx86C7KiXmgIavp01ir
         zgryZW+h8NFxuNNFR5Ajx4iioz4P9Xm7J6XveaMWkjG9E0guFmXD4sagkApHpvK5aB
         fMCikjL58Vr3gfKuLyZGjIxi9R/irHHulWFQACobuATyOjMzKlygkQgtKeASoLzu4W
         E4s1JlPmXhUQQ==
Received: from [10.1.0.205] (192-222-188-97.qc.cable.ebox.net [192.222.188.97])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4P9ZhC3kZDzkfL;
        Mon,  6 Feb 2023 13:35:39 -0500 (EST)
Message-ID: <da1bfb8a-5a88-5697-1c39-8e15c3c208a6@efficios.com>
Date:   Mon, 6 Feb 2023 13:36:19 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
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
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Request for contributor approval: Relicensing rseq selftests to MIT
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I would like to get contributor approval to relicense the rseq selftests 
within the Linux kernel and the librseq project to MIT. This will make 
it easier to use librseq from statically built applications, and I wish 
to continue sharing code between the kernel rseq selftests and librseq.

Allowing use of rseq application headers from statically built 
applications was the intent from the beginning, but it turns out that 
having the rseq.c initialization code under LGPL2.1 makes it harder than 
it should be for users.

The current contributor summary commit-wise under
tools/testing/selftests/rseq is:

    269  Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
      6  Michael Ellerman <mpe@ellerman.id.au>
      5  Shuah Khan <skhan@linuxfoundation.org>
      3  Michael Jeanson <mjeanson@efficios.com>
      3  Peter Oskolkov <posk@google.com>
      2  Martin Schwidefsky <schwidefsky@de.ibm.com>
      1  Masahiro Yamada <masahiroy@kernel.org>
      1  Paul Burton <paulburton@kernel.org>
      1  Sabyasachi Gupta <sabyasachi.linux@gmail.com>
      1  Vasily Gorbik <gor@linux.ibm.com>
      1  Vincent Chen <vincent.chen@sifive.com>
      1  Will Deacon <will@kernel.org>
      1  Xingxing Su <suxingxing@loongson.cn>

Header files are currently dual-licensed LGPL2.1/MIT, which is
somewhat redundant with plain MIT.

rseq.c was licensed under LGPL2.1. Relicencing it to MIT will facilitate 
its integration into statically built applications.

In order to facilitate eventual code sharing between tests and the
library implementation, I would like to relicense the tests from LGPL2.1 
to MIT as well.

Many of the contributions are trivial, but I prefer to kindly ask for 
approval nevertheless.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
