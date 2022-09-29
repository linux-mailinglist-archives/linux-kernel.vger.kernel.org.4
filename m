Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4B8D5EF145
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 11:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235243AbiI2JGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 05:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235242AbiI2JGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 05:06:09 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2CB511E0DC
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 02:06:05 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1odpUY-0003Js-F5; Thu, 29 Sep 2022 11:06:02 +0200
Message-ID: <98f62903-3d6f-30b4-82ef-3b0460824907@leemhuis.info>
Date:   Thu, 29 Sep 2022 11:06:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Content-Language: en-US, de-DE
To:     Conor Dooley <conor@kernel.org>
References: <Yy3dsSgpDnovBdEn@spud> <YzR8fzyjhggO+/tT@spud>
Cc:     pmladek@suse.com, senozhatsky@chromium.org, rostedt@goodmis.org,
        john.ogness@linutronix.de, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev
From:   Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: [resend][bug] low-probability console lockups since 5.19
In-Reply-To: <YzR8fzyjhggO+/tT@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1664442365;1ac16640;
X-HE-SMSGID: 1odpUY-0003Js-F5
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor

On 28.09.22 18:55, Conor Dooley wrote:
> On Fri, Sep 23, 2022 at 05:24:17PM +0100, Conor Dooley wrote:
>>
>> Been bisecting a bug that is causing a boot failure in my CI & have
>> ended up here.. The bug in question is a low(ish) probability lock up
>> of the serial console, I would estimate about 1-in-5 chance on the
>> boards I could actually trigger it on which it has taken me so long
>> to realise that this was an actual problem. Thinking back on it, there
>> were other failures that I would retroactively attribute to this
>> problem too, but I had earlycon disabled
> [...]
> #regzbot introduced: 5831788afb17b89c5b531fb60cbd798613ccbb63 ^
> Hopefully I did this correctly...

Yes, you did, thx for this. I already had been watching this thread
manually and was a bit unsure what to do with it.

> I picked that commit as that's where things start going haywire.

There is one thing I wonder when skimming this thread: was there maybe
some other change somewhere in the kernel between the introduction and
the revert of the printk console kthreads patches that is the real
culprit here that makes existing, older races easier to hit? But I guess
in the end that would be very hard to find and it's easier to fix the
problem in the console driver... :-/

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.

#regzbot backburner: tricky situation that might take some time to get
resolved
