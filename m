Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9875E84B8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 23:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232795AbiIWVPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 17:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiIWVP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 17:15:28 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5146810974A;
        Fri, 23 Sep 2022 14:15:26 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:41498)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1obq16-00E7wF-5r; Fri, 23 Sep 2022 15:15:24 -0600
Received: from ip68-110-29-46.om.om.cox.net ([68.110.29.46]:42904 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1obq15-002Iu9-9s; Fri, 23 Sep 2022 15:15:23 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Cambda Zhu <cambda@linux.alibaba.com>
Cc:     Florian Weimer <fweimer@redhat.com>, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Dust Li <dust.li@linux.alibaba.com>,
        Tony Lu <tonylu@linux.alibaba.com>
References: <69E17223-F0CA-4A4C-AAD7-065D6E6266D9@linux.alibaba.com>
        <87pmfn5tu1.fsf@email.froward.int.ebiederm.org>
        <87r102ejwo.fsf@oldenburg.str.redhat.com>
        <0CC7D0E7-71C5-4DAC-8A01-F9E13659F864@linux.alibaba.com>
        <87illeedc5.fsf@oldenburg.str.redhat.com>
        <613994F7-054D-4992-A159-96D34B17BC7F@linux.alibaba.com>
Date:   Fri, 23 Sep 2022 16:15:17 -0500
In-Reply-To: <613994F7-054D-4992-A159-96D34B17BC7F@linux.alibaba.com> (Cambda
        Zhu's message of "Fri, 23 Sep 2022 16:40:15 +0800")
Message-ID: <87illd4wt6.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1obq15-002Iu9-9s;;;mid=<87illd4wt6.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.110.29.46;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1/4VcLV1GEezk2s9ZhUWxWg4vG40jA8jlg=
X-SA-Exim-Connect-IP: 68.110.29.46
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Virus: No
X-Spam-DCC: ; sa02 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Cambda Zhu <cambda@linux.alibaba.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 349 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 3.8 (1.1%), b_tie_ro: 2.6 (0.7%), parse: 0.68
        (0.2%), extract_message_metadata: 2.4 (0.7%), get_uri_detail_list:
        0.98 (0.3%), tests_pri_-1000: 2.8 (0.8%), tests_pri_-950: 1.07 (0.3%),
        tests_pri_-900: 0.83 (0.2%), tests_pri_-90: 111 (31.9%), check_bayes:
        110 (31.5%), b_tokenize: 4.7 (1.3%), b_tok_get_all: 6 (1.6%),
        b_comp_prob: 1.38 (0.4%), b_tok_touch_all: 96 (27.4%), b_finish: 0.68
        (0.2%), tests_pri_0: 213 (61.0%), check_dkim_signature: 0.38 (0.1%),
        check_dkim_adsp: 1.63 (0.5%), poll_dns_idle: 0.25 (0.1%),
        tests_pri_10: 1.79 (0.5%), tests_pri_500: 6 (1.7%), rewrite_mail: 0.00
        (0.0%)
Subject: Re: Syscall kill() can send signal to thread ID
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cambda Zhu <cambda@linux.alibaba.com> writes:

>> On Sep 23, 2022, at 15:53, Florian Weimer <fweimer@redhat.com> wrote:
>> 
>>> I don't quite understand what you mean, sorry. But if kill() returns
>>> -ESRCH for tid which is not equal to tgid, kill() can only send signal
>>> to thread group via main thread id, that is what BSD did and manual
>>> said. It seems not odd?
>> 
>> It's still odd because there's one TID per process that's valid for
>> kill by accident.  That's all.

> As far as I know, there is no rule forbidding 'process ID'(TGID on Linux)
> equals to main thread ID, is it right?

There is an unfortunate guarantee that glibc depends upon that after
exec TGID == TID for the initial thread in a process.  I say unfortunate
because maintaining that guarantee when another thread in the process
calls exec is a bit painful.

> If one wants to send signal to a specific thread, tgkill() can do
> that. As far as I understand, the difference between kill() and
> tgkill() is whether the signal is set on shared_pending, whatever the
> ID is a process ID or a thread ID. For Linux, the main thread ID just
> equals to the process ID.

Correct.  kill and tgkill uses different signal queues.  Kill is global
to the destination process and tgkill is always thread local.

> So the meaning of kill(main_tid, sig) is sending signal to a process,
> of which the PID equals to the first argument. It's not odd, I think.

Yes, the oddity is the TGID and TID share the same value, nothing else.

Eric
