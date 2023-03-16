Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F54C6BD651
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 17:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbjCPQxR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 16 Mar 2023 12:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbjCPQxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 12:53:15 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3043D3A8F;
        Thu, 16 Mar 2023 09:53:12 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1pcqqj-002053-ND; Thu, 16 Mar 2023 17:53:09 +0100
Received: from tmo-119-223.customers.d1-online.com ([80.187.119.223] helo=smtpclient.apple)
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1pcqqj-000aVF-GJ; Thu, 16 Mar 2023 17:53:09 +0100
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 5/7 v4] sh: remove sh5/sh64 last fragments
Date:   Thu, 16 Mar 2023 17:52:58 +0100
Message-Id: <A8D501D3-68ED-4112-BDA7-EE67357A2E28@physik.fu-berlin.de>
References: <ef8fbda8-cace-1db3-9161-abd2e75dcf13@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>, Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org
In-Reply-To: <ef8fbda8-cace-1db3-9161-abd2e75dcf13@infradead.org>
To:     Randy Dunlap <rdunlap@infradead.org>
X-Mailer: iPhone Mail (20D67)
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 80.187.119.223
X-ZEDAT-Hint: PO
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 16, 2023, at 5:45 PM, Randy Dunlap <rdunlap@infradead.org> wrote:
> 
> ﻿Hi--
> 
>> On 3/16/23 06:23, John Paul Adrian Glaubitz wrote:
>> Hi Randy!
>> 
>>> On Sun, 2023-03-05 at 20:00 -0800, Randy Dunlap wrote:
>>> A previous patch removed most of the sh5 (sh64) support from the
>>> kernel tree. Now remove the last stragglers.
>>> 
>>> Fixes: 37744feebc08 ("sh: remove sh5 support")
>>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>>> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
>>> Cc: Arnd Bergmann <arnd@arndb.de>
>>> Cc: Rich Felker <dalias@libc.org>
>>> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
>>> Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
>>> Cc: linux-sh@vger.kernel.org
>>> Acked-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
>>> ---
>>> v2: update after adding the parisc64 alias to kbuild.rst
>>> v3: skipped
>>> v4: refresh & resend
>>> 
>>> Documentation/kbuild/kbuild.rst                           |    1 -
>>> Documentation/scheduler/sched-arch.rst                    |    2 --
>>> Documentation/translations/zh_CN/scheduler/sched-arch.rst |    2 --
>>> scripts/checkstack.pl                                     |    7 -------
>>> tools/perf/arch/common.c                                  |    2 --
>>> tools/scripts/Makefile.arch                               |    5 -----
>>> tools/testing/selftests/mm/Makefile                       |    2 +-
>>> tools/testing/selftests/mm/run_vmtests.sh                 |    2 +-
>>> 8 files changed, 2 insertions(+), 21 deletions(-)
>>> 
>>> diff -- a/Documentation/kbuild/kbuild.rst b/Documentation/kbuild/kbuild.rst
>>> --- a/Documentation/kbuild/kbuild.rst
>>> +++ b/Documentation/kbuild/kbuild.rst
>>> @@ -161,7 +161,6 @@ But some architectures such as x86 and s
>>> 
>>> - x86: i386 for 32 bit, x86_64 for 64 bit
>>> - parisc: parisc64 for 64 bit
>>> -- sh: sh for 32 bit, sh64 for 64 bit
>>> - sparc: sparc32 for 32 bit, sparc64 for 64 bit
>>> 
>>> CROSS_COMPILE
>> 
>> This hunk doesn't apply anymore since the parisc part has been dropped although I can't
>> find the commit for that. Could you rebase your patch, please?
> 
> The parisc part has not been dropped. It's in linux-next but not yet in mainline.
> (commit 49deed336ef9a)
> 
> Do you want this patch to apply to mainline? (I created it in linux-next.)
> I can do that in a few hours. I'm busy ATM.
> 
> I suppose there will be a merge conflict between parisc and SH.

Oops, sorry. My bad. I will use the proper tree.

Adrian
