Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DEEE6BAAD0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 09:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbjCOIdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 04:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjCOIdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 04:33:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC7E83E9;
        Wed, 15 Mar 2023 01:33:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 57B8761B77;
        Wed, 15 Mar 2023 08:33:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E1A6C433D2;
        Wed, 15 Mar 2023 08:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678869180;
        bh=O6E2IOFT7Qo6yMnQvB/m7JajulqmQNBlEUHnHZxFKPY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pYRWPmTG2IWkcRZSgKf4n/QcI/FH5910wX+3Z0vmTqe0YSQP46H8P3BZNw6HEQRj8
         qUq4vtUeba2wxdWZLNB9uQ7OK1E09IqnQ+PbNKmoWGgllT9jNRcYabguZbcfFTz863
         1SldAVuMHjDKdqNDc9lTa7S+VK8juIz5cHW21LArrarzAvxszwFrewXqn7kQ499NIZ
         kHzgFwvi9OAZZk4s2R7QxjlJv+Cm1JcCT4/0xhWGv54WqEF9AC+OMUTA4d1qasNHxq
         mQZvsKousLR1sDrkRSGSELtscd9Pu+QCef0dWv3RX3cdopjUlIJwuHPaaxX2wh/IGy
         q6PTTR5onCzFw==
Date:   Wed, 15 Mar 2023 17:32:57 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux-trace-kernel@vger.kernel.org,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>
Subject: Re: selftests: ftrace: event filter function - test event filtering
 on functions [FAIL]
Message-Id: <20230315173257.1311e50729c73e0cb6e0aa0d@kernel.org>
In-Reply-To: <CA+G9fYtF-XEKi9YNGgR=Kf==7iRb2FrmEC7qtwAeQbfyah-UhA@mail.gmail.com>
References: <CA+G9fYtF-XEKi9YNGgR=Kf==7iRb2FrmEC7qtwAeQbfyah-UhA@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Naresh,

On Tue, 14 Mar 2023 15:52:44 +0530
Naresh Kamboju <naresh.kamboju@linaro.org> wrote:

> Results from Linaro’s test farm.
> 
> selftests ftrace failed on qemu-x86_64 and qemu-arm64.
> Please find the test log below.

Thanks for reporting!
Can you share the kernel config which you used for this build?
And the kernel is "next-20230314", is that correct?

> 
> Is this expected to fail ? Am I missing anything ?

No, it should be a bug. I would like to reproduce it.

Thank you,

> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> kselftest: Running tests in ftrace
> TAP version 13
> 1..1
> # selftests: ftrace: ftracetest
> # === Ftrace unit tests ===
> # [1] Basic trace file check [PASS]
> 
> ...
> 
> # [23] event filter function - test event filtering on functions [FAIL]
> 
> ...
> # [58] Kretprobe %return suffix test [PASS]
> # [59] Register/unregister many kprobe events
> [  431.662904] trace_kprobe: Could not probe notrace function startup_64
> [  431.669846] trace_kprobe: Could not probe notrace function _stext
> [  431.674104] trace_kprobe: Could not probe notrace function _text
> [  431.675908] trace_kprobe: Could not probe notrace function
> secondary_startup_64
> [  431.677876] trace_kprobe: Could not probe notrace function
> secondary_startup_64_no_verify
> [  431.679899] trace_kprobe: Could not probe notrace function __pfx_verify_cpu
> [  431.681738] trace_kprobe: Could not probe notrace function verify_cpu
> [  431.683667] trace_kprobe: Could not probe notrace function
> __pfx_sev_verify_cbit
> [  431.685594] trace_kprobe: Could not probe notrace function sev_verify_cbit
> [  431.687381] trace_kprobe: Could not probe notrace function start_cpu0
> [  431.689225] trace_kprobe: Could not probe notrace function __pfx___startup_64
> [  431.691223] trace_kprobe: Could not probe notrace function __startup_64
> [  431.693088] trace_kprobe: Could not probe notrace function
> __pfx_startup_64_setup_env
> [  431.695021] trace_kprobe: Could not probe notrace function
> startup_64_setup_env
> [  431.697012] trace_kprobe: Could not probe notrace function
> __pfx___traceiter_initcall_level
> [  431.700780] trace_kprobe: Could not probe notrace function
> __pfx___traceiter_initcall_start
> ...
> [  439.183587] trace_kprobe: Could not probe notrace function
> __pfx_hv_check_msr_access
> [  439.186192] trace_kprobe: Could not probe notrace function
> __pfx_kvm_hv_flush_tlb
> ...
> 
> # [106] (instance)  event filter function - test event filtering on
> functions [FAIL]
> 
> ...
> #
> # # of passed:  109
> # # of failed:  2
> # # of unresolved:  3
> # # of untested:  0
> # # of unsupported:  3
> # # of xfailed:  1
> # # of undefined(test bug):  0
> not ok 1 selftests: ftrace: ftracetest # exit=1
> 
> log link,
> https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230314/testrun/15564370/suite/kselftest-ftrace/test/ftrace_ftracetest/log
> 
> --
> Linaro LKFT
> https://lkft.linaro.org


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
