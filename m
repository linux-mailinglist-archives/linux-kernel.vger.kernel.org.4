Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0D56D8AEF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 01:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbjDEXIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 19:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjDEXIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 19:08:41 -0400
X-Greylist: delayed 2452 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 05 Apr 2023 16:08:39 PDT
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B646A70
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 16:08:39 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:39600)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1pkBbV-008v2g-KD; Wed, 05 Apr 2023 16:27:45 -0600
Received: from ip68-110-29-46.om.om.cox.net ([68.110.29.46]:46118 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1pkBbU-004WST-D4; Wed, 05 Apr 2023 16:27:45 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Joey Gouly <joey.gouly@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Mark Brown <broonie@kernel.org>
In-Reply-To: <e32ea9a03d0797ce2b8e7a82ed59c0dad9431f2b.1680407255.git.josh@joshtriplett.org>
        (Josh Triplett's message of "Sun, 2 Apr 2023 12:57:29 +0900")
References: <e32ea9a03d0797ce2b8e7a82ed59c0dad9431f2b.1680407255.git.josh@joshtriplett.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Date:   Wed, 05 Apr 2023 17:27:12 -0500
Message-ID: <87mt3m7ynz.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1pkBbU-004WST-D4;;;mid=<87mt3m7ynz.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.110.29.46;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX18J9Tx7+ZV2bmyhX5ZwHODntPigXyeDGIU=
X-SA-Exim-Connect-IP: 68.110.29.46
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-0.7 required=5.0 tests=RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Josh Triplett <josh@joshtriplett.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 623 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 15 (2.4%), b_tie_ro: 11 (1.8%), parse: 1.56
        (0.3%), extract_message_metadata: 19 (3.0%), get_uri_detail_list: 2.6
        (0.4%), tests_pri_-2000: 6 (1.0%), tests_pri_-1000: 3.4 (0.6%),
        tests_pri_-950: 1.64 (0.3%), tests_pri_-900: 1.31 (0.2%),
        tests_pri_-200: 1.13 (0.2%), tests_pri_-100: 6 (0.9%), tests_pri_-90:
        61 (9.9%), check_bayes: 60 (9.6%), b_tokenize: 10 (1.5%),
        b_tok_get_all: 9 (1.5%), b_comp_prob: 3.2 (0.5%), b_tok_touch_all: 34
        (5.5%), b_finish: 0.94 (0.2%), tests_pri_0: 329 (52.8%),
        check_dkim_signature: 0.66 (0.1%), check_dkim_adsp: 2.6 (0.4%),
        poll_dns_idle: 152 (24.5%), tests_pri_10: 2.6 (0.4%), tests_pri_500:
        171 (27.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] sysinfo: Saturate 16-bit procs rather than wrapping
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Josh Triplett <josh@joshtriplett.org> writes:

> struct sysinfo has a 16-bit field for the number of processes. Current
> systems can easily exceed this. Rather than wrapping around, saturate
> the value at U16_MAX. This is still incorrect, but more likely to
> help the user know what's going on; a caller can then (for instance)
> parse the full value out of /proc/loadavg.
>
> Signed-off-by: Josh Triplett <josh@joshtriplett.org>
> ---
>
> Not sure what tree changes to kernel/sys.c should flow through. Andrew,
> could you take this through your tree (assuming you agree with it), or
> suggest what tree it should go through instead?


Mind if I ask what the motivation for this is?

I looked at debian code search and there are a lot of uses of the
sysinfo system call.  Most of the uses were for load average or memory
occupancy.  The only use of procs that I could find was in samba.  I did
not trace the code far enough but it clearly had an embedded assumption
that 16 bits was enough to report the number of processes on a linux
system.

I looked at glibc and if I read things correctly the sysinfo system
call is just a pass through to the kernel.


I looked because just saturating the 16bit field feels like a hack
that will continue to encourage buggy programs to stay buggy.

If there is real value in sysinfo returning a this information someone
could go through the work and update the kernel to return the high
bits of the process count in info->pad that is immediately after
info->procs, and then update the apps or libc to find those high bits.

Otherwise I think it makes most sense to encourage programs to
use /proc/loadavg, where this information has always been returned
correctly as it is a text file.  We could do it like:

	/*
	 * Reliably fail when there are more than 64k processes.
         * Userspace should use /proc/loadavg instead.
         */
	info->procs = (nr_threads <= U16_MAX) ? nr_threads : 0;

If saturating does make sense can we please have a comment documenting
why saturating and encouraging confused userspace programs to stay
confused makes sense?


Eric


> diff --git a/kernel/sys.c b/kernel/sys.c
> index 495cd87d9bf4..ba05fca26927 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -2699,7 +2699,7 @@ static int do_sysinfo(struct sysinfo *info)
>  
>  	get_avenrun(info->loads, 0, SI_LOAD_SHIFT - FSHIFT);
>  
> -	info->procs = nr_threads;
> +	info->procs = min_t(typeof(nr_threads), nr_threads, U16_MAX);
>  
>  	si_meminfo(info);
>  	si_swapinfo(info);
