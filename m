Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C67463B150
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 19:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234288AbiK1SaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 13:30:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234277AbiK1S3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 13:29:46 -0500
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2491910FD
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 10:22:50 -0800 (PST)
Received: from in02.mta.xmission.com ([166.70.13.52]:58492)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1ozimF-00G7EZ-57; Mon, 28 Nov 2022 11:22:47 -0700
Received: from ip68-110-29-46.om.om.cox.net ([68.110.29.46]:45584 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1ozimD-005gjD-Rt; Mon, 28 Nov 2022 11:22:46 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "Intel-gfx@lists.freedesktop.org" <Intel-gfx@lists.freedesktop.org>,
        linux-kernel@vger.kernel.org, sultan@kerneltoast.com
References: <0029af41-bf24-9972-10ac-f52e1bdcbf08@linux.intel.com>
        <CAHmME9o25v0kZUV-7qEY=6XXAyOA7q0sG8gpQfxHgr3sSVdsWw@mail.gmail.com>
        <41455798-1dcb-135f-516d-25ab9a8082f5@linux.intel.com>
        <Y1A+9kN6bwfXeqVt@zx2c4.com>
        <8acc3e4a-abbc-32bc-626e-7a216f6755c3@linux.intel.com>
        <Y1Bby6FEEWiFIjjD@zx2c4.com>
        <d47b30e9-5619-c631-aa92-f5d89e88a909@linux.intel.com>
Date:   Mon, 28 Nov 2022 12:22:39 -0600
In-Reply-To: <d47b30e9-5619-c631-aa92-f5d89e88a909@linux.intel.com> (Tvrtko
        Ursulin's message of "Thu, 20 Oct 2022 14:45:49 +0100")
Message-ID: <87a64brlao.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1ozimD-005gjD-Rt;;;mid=<87a64brlao.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.110.29.46;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX18H+V2VRM40WCdfRIizymPk+iWBMRfIDyU=
X-SA-Exim-Connect-IP: 68.110.29.46
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 746 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 11 (1.5%), b_tie_ro: 9 (1.3%), parse: 0.81 (0.1%),
         extract_message_metadata: 11 (1.4%), get_uri_detail_list: 1.42 (0.2%),
         tests_pri_-1000: 4.4 (0.6%), tests_pri_-950: 1.08 (0.1%),
        tests_pri_-900: 0.85 (0.1%), tests_pri_-200: 0.72 (0.1%),
        tests_pri_-100: 3.4 (0.5%), tests_pri_-90: 340 (45.6%), check_bayes:
        330 (44.2%), b_tokenize: 6 (0.8%), b_tok_get_all: 203 (27.3%),
        b_comp_prob: 2.7 (0.4%), b_tok_touch_all: 113 (15.2%), b_finish: 1.34
        (0.2%), tests_pri_0: 350 (46.8%), check_dkim_signature: 0.80 (0.1%),
        check_dkim_adsp: 4.7 (0.6%), poll_dns_idle: 11 (1.5%), tests_pri_10:
        1.86 (0.2%), tests_pri_500: 19 (2.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [Intel-gfx] signal: break out of wait loops on kthread_stop()
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com> writes:

> On 19/10/2022 21:19, Jason A. Donenfeld wrote:
>> On Wed, Oct 19, 2022 at 09:09:28PM +0100, Tvrtko Ursulin wrote:
>>> Hm why is kthread_stop() after kthread_run() abuse? I don't see it in
>>> kerneldoc that it must not be used for stopping threads.
>> Because you don't want it to stop. You want to wait until it's done. If
>> you call stop right after run, it will even stop it before it even
>> begins to run. That's why you wind up sprinkling your msleeps
>> everywhere, indicating that clearly this is not meant to work that way.
> Not after kthread_run which wakes it up already. If the kerneldoc for
> kthread_stop() is correct at least... In which case I really do think 
> that the yields are pointless/red herring. Perhaps they predate kthread_run and
> then they were even wrong.
>
>>> Yep the yields and sleeps are horrible and will go. But they are also
>>> not relevant for the topic at hand.
>> Except they very much are. The reason you need these is because you're
>> using kthread_stop() for something it's not meant to do.
>
> It is supposed to assert kthread_should_stop() which thread can look at as when
> to exit. Except that now it can fail to get to that controlled exit
> point. Granted that argument is moot since it implies incomplete error handling
> in the thread anyway.
>
> Btw there are actually two use cases in our code base. One is thread controls
> the exit, second is caller controls the exit. Anyway...
>
>>> Never mind, I was not looking for anything more than a suggestion on how
>>> to maybe work around it in piece as someone is dealing with the affected
>>> call sites.
>> Sultan's kthread_work idea is probably the right direction. This would
>> seem to have what you need.
>
> ... yes, it can be converted. Even though for one of the two use cases we need
> explicit signalling. There now isn't anything which would assert
> kthread_should_stop() without also asserting the signal, right?. Neither 
> I found that the thread work API can do it.
>
> Fingers crossed we were the only "abusers" of the API. There's a quite a number
> of kthread_stop callers and it would be a large job to audit them all.


I have been out and am coming to this late.   Did this get resolved?


I really don't expect this affected much of anything else as the code
sat in linux-next for an entire development cycle before being merged.

But I would like to make certain problems with this change were resolved.

Thank you,
Eric
