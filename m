Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 176CB61F497
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 14:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbiKGNoF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 7 Nov 2022 08:44:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbiKGNoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 08:44:00 -0500
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E089D6B
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 05:43:59 -0800 (PST)
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay05.hostedemail.com (Postfix) with ESMTP id EE66D40ED8;
        Mon,  7 Nov 2022 13:43:57 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id 227262002D;
        Mon,  7 Nov 2022 13:43:33 +0000 (UTC)
Date:   Mon, 07 Nov 2022 05:43:54 -0800
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Julia Lawall <Julia.Lawall@inria.fr>
Subject: =?US-ASCII?Q?Re=3A_=5Bfor-linus=5D=5BPATCH_4/5=5D_ti?= =?US-ASCII?Q?mers=3A_Add_timer=5Fshutdown=5Fsync?= =?US-ASCII?Q?=28=29_and_timer=5Fshutdown=28=29_to_be?= =?US-ASCII?Q?_called_before_freeing_timers?=
User-Agent: K-9 Mail for Android
In-Reply-To: <87mt93vwv4.ffs@tglx>
References: <20221106233037.815236769@goodmis.org> <20221106233434.425162916@goodmis.org> <87sfivvy91.ffs@tglx> <87mt93vwv4.ffs@tglx>
Message-ID: <F93A06C1-6188-4787-9563-8F5676A5A098@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Rspamd-Queue-Id: 227262002D
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Stat-Signature: q3sznmjbghgkfz37wchc7hgr7fb8d6nb
X-Rspamd-Server: rspamout08
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX198xRTPZZYf651PoRQnZbufA/cIJg//1is=
X-HE-Tag: 1667828613-469696
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On November 7, 2022 3:15:43 AM PST, Thomas Gleixner <tglx@linutronix.de> wrote:
>On Mon, Nov 07 2022 at 11:45, Thomas Gleixner wrote:
>> On Sun, Nov 06 2022 at 18:30, Steven Rostedt wrote:
>>>
>>> Link: https://lore.kernel.org/all/87pmlrkgi3.ffs@tglx/
>>> Link: https://lkml.kernel.org/r/20221106212702.363575800@goodmis.org
>>> Link: https://lore.kernel.org/all/20221105060024.598488967@goodmis.org/
>>>
>>> Cc: Linus Torvalds <torvalds@linux-foundation.org>
>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>> Cc: Stephen Boyd <sboyd@kernel.org>
>>> Cc: Anna-Maria Gleixner <anna-maria@linutronix.de>
>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>> Cc: Julia Lawall <Julia.Lawall@inria.fr>
>>> Tested-by: Guenter Roeck <linux@roeck-us.net>
>>> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
>>
>> And please follow the guidelines of the tip tree for changelogs and tags.
>>
>> I'll just grab it from the list and let my scripts run over it.
>
>Duh. This thing is unreviewable.
>
>Can you please split it up into pieces which are digestable?

Sure, but I'm traveling this week and may not get to it until Friday.

-- Steve


>
>Thanks,
>
>        tglx

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity and top posting.
