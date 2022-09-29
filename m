Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 886135EF716
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 16:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235103AbiI2ODD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 10:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235485AbiI2ODB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 10:03:01 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2061591CA;
        Thu, 29 Sep 2022 07:02:59 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1odu7t-0007ZW-A8; Thu, 29 Sep 2022 16:02:57 +0200
Message-ID: <4f704d2f-12b5-8d6a-357e-d79b1e871ed7@leemhuis.info>
Date:   Thu, 29 Sep 2022 16:02:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Content-Language: en-US, de-DE
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        "Artem S. Tashkinov" <aros@gmx.com>, workflows@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        ksummit@lists.linux.dev
References: <aa876027-1038-3e4a-b16a-c144f674c0b0@leemhuis.info>
 <05d149a0-e3de-8b09-ecc0-3ea73e080be3@leemhuis.info>
 <20220929094753.6bba89d8@gandalf.local.home>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: Planned changes for bugzilla.kernel.org to reduce the "Bugzilla
 blues"
In-Reply-To: <20220929094753.6bba89d8@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1664460180;fe8703b0;
X-HE-SMSGID: 1odu7t-0007ZW-A8
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.09.22 15:47, Steven Rostedt wrote:
> On Thu, 29 Sep 2022 13:33:53 +0200
> Thorsten Leemhuis <linux@leemhuis.info> wrote:
> 
> Thanks Thorsten for doing this.

Thx for saying this, as I fear it in the end will again be more work
then anticipated -- but well, that's how life often is :-D

>>>  * In the kernel summit sessions (recording:
>>> https://youtu.be/e2SZoUPhDRg?t=5370 ) Len Brown stated that he and
>>> fellow ACPI/PM developers rely on bugzilla.kernel.org and would need
>>> some replacement if it's decommissioned.
> 
> I also use bugzilla.kernel.org with trace-cmd/kernelshark and the
> libraries, although I don't really use it for the Linux tracing subsystem
> (but I probably should :-/).
> 
> That is, the tools portion of bugzilla is not part of the MAINTAINERS file
> (that I know of), so probably shouldn't be affected by this.

Ohh, yeah, sorry, should have mentioned this. Don't worry, I'm aware of
this particular and a few similar products/components in bugzilla. I
don't plan changing any of them, unless something unforeseen or a very
good reason comes up (for example if they're obviously unused for years
or something like that).

Ciao, Thorsten

