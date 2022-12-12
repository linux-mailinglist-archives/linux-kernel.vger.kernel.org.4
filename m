Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4C9B64A828
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 20:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233235AbiLLThL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 14:37:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbiLLThK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 14:37:10 -0500
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD626317;
        Mon, 12 Dec 2022 11:37:08 -0800 (PST)
Received: from in02.mta.xmission.com ([166.70.13.52]:50572)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1p4obo-00HK3I-RT; Mon, 12 Dec 2022 12:37:04 -0700
Received: from ip68-110-29-46.om.om.cox.net ([68.110.29.46]:60428 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1p4obl-005oSK-V8; Mon, 12 Dec 2022 12:37:04 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     stsp <stsp2@yandex.ru>
Cc:     linux-kernel@vger.kernel.org, linux-x86_64@vger.kernel.org,
        luto@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Al Viro <viro@ZenIV.linux.org.uk>
References: <85ca9ae1-d319-ee77-4a71-bc9c7874f2cb@yandex.ru>
Date:   Mon, 12 Dec 2022 13:36:18 -0600
In-Reply-To: <85ca9ae1-d319-ee77-4a71-bc9c7874f2cb@yandex.ru> (stsp's message
        of "Sat, 10 Dec 2022 14:08:21 +0500")
Message-ID: <87iligo1n1.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1p4obl-005oSK-V8;;;mid=<87iligo1n1.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.110.29.46;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1859nH1HUvlN2Uc4GpOZeUHkeuzqcWY4HI=
X-SA-Exim-Connect-IP: 68.110.29.46
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Virus: No
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *******;stsp <stsp2@yandex.ru>
X-Spam-Relay-Country: 
X-Spam-Timing: total 2207 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 4.0 (0.2%), b_tie_ro: 2.8 (0.1%), parse: 0.79
        (0.0%), extract_message_metadata: 11 (0.5%), get_uri_detail_list: 2.5
        (0.1%), tests_pri_-2000: 7 (0.3%), tests_pri_-1000: 2.0 (0.1%),
        tests_pri_-950: 1.06 (0.0%), tests_pri_-900: 0.83 (0.0%),
        tests_pri_-200: 0.70 (0.0%), tests_pri_-100: 16 (0.7%), tests_pri_-90:
        93 (4.2%), check_bayes: 91 (4.1%), b_tokenize: 10 (0.4%),
        b_tok_get_all: 11 (0.5%), b_comp_prob: 3.9 (0.2%), b_tok_touch_all: 62
        (2.8%), b_finish: 0.76 (0.0%), tests_pri_0: 418 (18.9%),
        check_dkim_signature: 0.66 (0.0%), check_dkim_adsp: 3.6 (0.2%),
        poll_dns_idle: 1633 (74.0%), tests_pri_10: 1.70 (0.1%), tests_pri_500:
        1648 (74.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: strange behavior with sigreturn() to 32bit
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Stas,

in your github report you mention that you believe this is a regression
https://github.com/dosemu2/dosemu2/pull/1830.

Can you tell us the last kernel this worked on?  Which kernel you tested
that this fails on?  It would be awesome if you could bisect this to the
commit that is broken but at least knowing kernel's you have tried that
work and don't work would be very useful.

As everything doesemu and vm86 does is pretty x86 centric I have added
the overall x86 maintainers as well as Al Viro in the hopes of this
getting routed to someone who has a bit more time then I do at the
moment.  I remember Al looking quite a bit at the architecture specific
signal handling bits.

Regressions where things used to work, but no longer work are much
more interesting than a simple bug report in a compatibility layer.

We have old bugs where 32bit compatibility code on 64bit kernels have
didn't always give the correct siginfo that I think I have fixed in
recent years.  I don't know if we have similar issues for sigcontext
which it seems that you are dealing with.

Dosemu is old enough that anything it has down historically that no
longer works certainly counts as a regression and should be fixed.

stsp <stsp2@yandex.ru> writes:

> I am playing with 32bit compatibility segments,
> and I am observing something very strange.
> To demonstrate the problem, I did the change
> to the kernel sigreturn test-case, and it is attached.
> The change just moves the magic value to EAX
> and calls an interrupt that produces a SIGSEGV.
> The SIGSEGV handler prints the needed regs.
> This patch intentionally adds 0x100000000 to
> the RIP register, because AFAIK the high part
> or 64bit regs are irrelevant in compatibility mode.
> Now with high part of RIP non-zero, we see this:
> $ ./sigreturn_64
> err=0 trapno=d ax=0 ip=100000003
>
> OK, obviously our asm code didn't execute -
> why is so? How does the high part of RIP
> affect compatibility mode?
> Then lets start the same example under gdb:
> Program received signal SIGSEGV, Segmentation fault.
> 0x0000000000403008 in int31 ()
> (gdb)
> Continuing.
> err=18a trapno=d ax=a5f3 ip=403008
>
> Wow! Much better now: error code is correct,
> ax is correct, but ip is invalid.
>
> Now lets remove that high-part trashing from
> source and recompile, then run again:
> $ ./sigreturn_64
> err=0 trapno=d ax=a5f3 ip=6
>
> This time error code is incorrect! All other
> values are good.
> Lets see under gdb:
> err=18a trapno=d ax=a5f3 ip=403008
>
> Cool, under gdb the err code fixed itself but
> IP is wrong...
>
> Can anyone make any sense out of this? :)
> To me it seems completely chaotic and I
> suspect both sigreturn() and ptrace() are
> somehow "broken" here.
>
> diff --git a/tools/testing/selftests/x86/sigreturn.c b/tools/testing/selftests/x86/sigreturn.c
> index 5d7961a5f7f6..6c8f2431d77d 100644
> --- a/tools/testing/selftests/x86/sigreturn.c
> +++ b/tools/testing/selftests/x86/sigreturn.c
> @@ -101,9 +101,14 @@ asm (".pushsection .text\n\t"
>       "mov %ss,%ecx\n\t"
>       "int3\n\t"
>       ".size int3, . - int3\n\t"
> +     ".type int31, @function\n\t"
> +     "int31:\n\t"
> +     "movl $0xa5f3, %eax\n\t"
> +     "int $0x31\n\t"
>       ".align 4096, 0xcc\n\t"
>       ".popsection");
>  extern char int3[4096];
> +extern char int31[];
>  
>  /*
>   * At startup, we prepapre:
> @@ -296,6 +301,7 @@ static volatile sig_atomic_t sig_corrupt_final_ss;
>  # define REG_IP REG_RIP
>  # define REG_SP REG_RSP
>  # define REG_CX REG_RCX
> +# define REG_AX REG_RAX
>  
>  struct selectors {
>  	unsigned short cs, gs, fs, ss;
> @@ -316,6 +322,7 @@ static unsigned short *csptr(ucontext_t *ctx)
>  # define REG_IP REG_EIP
>  # define REG_SP REG_ESP
>  # define REG_CX REG_ECX
> +# define REG_AX REG_EAX
>  
>  static greg_t *ssptr(ucontext_t *ctx)
>  {
> @@ -444,9 +451,12 @@ static void sigusr1(int sig, siginfo_t *info, void *ctx_void)
>  	*ssptr(ctx) = sig_ss;
>  
>  	ctx->uc_mcontext.gregs[REG_IP] =
> -		sig_cs == code16_sel ? 0 : (unsigned long)&int3;
> +		sig_cs == code16_sel ? ((unsigned long)&int31 -
> +			(unsigned long)&int3) | 0x100000000 :
> +		(unsigned long)&int3;
>  	ctx->uc_mcontext.gregs[REG_SP] = (unsigned long)0x8badf00d5aadc0deULL;
>  	ctx->uc_mcontext.gregs[REG_CX] = 0;
> +	ctx->uc_mcontext.gregs[REG_AX] = 0;
>  
>  #ifdef __i386__
>  	/*
> @@ -515,6 +525,20 @@ static void sigtrap(int sig, siginfo_t *info, void *ctx_void)
>  	sig_trapped = sig;
>  }
>  
> +static void sigsegv(int sig, siginfo_t *info, void *ctx_void)
> +{
> +	ucontext_t *ctx = (ucontext_t*)ctx_void;
> +
> +	validate_signal_ss(sig, ctx);
> +
> +	sig_err = ctx->uc_mcontext.gregs[REG_ERR];
> +	sig_trapno = ctx->uc_mcontext.gregs[REG_TRAPNO];
> +	printf("err=%x trapno=%x ax=%x ip=%llx\n", sig_err, sig_trapno,
> +		(unsigned)ctx->uc_mcontext.gregs[REG_AX],
> +		(unsigned long long)ctx->uc_mcontext.gregs[REG_IP]);
> +	_exit(0);
> +}
> +
>  #ifdef __x86_64__
>  /* Tests recovery if !UC_STRICT_RESTORE_SS */
>  static void sigusr2(int sig, siginfo_t *info, void *ctx_void)
> @@ -777,6 +801,7 @@ int main()
>  
>  	sethandler(SIGUSR1, sigusr1, 0);
>  	sethandler(SIGTRAP, sigtrap, SA_ONSTACK);
> +	sethandler(SIGSEGV, sigsegv, SA_ONSTACK);
>  
>  	/* Easy cases: return to a 32-bit SS in each possible CS bitness. */
>  	total_nerrs += test_valid_sigreturn(64, false, -1);

Eric
