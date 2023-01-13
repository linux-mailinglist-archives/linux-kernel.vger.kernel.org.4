Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 507BD66A50A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 22:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjAMVUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 16:20:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbjAMVTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 16:19:54 -0500
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99BF80AEB;
        Fri, 13 Jan 2023 13:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1673644790;
        bh=1ePr5/9/hpdk8ZNP/fLzQHeSBYrINMgfTNk9jaNeHJo=;
        h=Date:To:From:Subject:From;
        b=UcrXebDqr75hEGbA8OgZScDK5rqBtb5/QBKuGsgD0XV0ptggC9HFLuva2FTFY3pZf
         yaGXO1YejIpMF9r1jiPXCIW8OHrqhORlX31p/MOp9QYRq1E15yeH7Lbt//t+HNZ2Zd
         +qu0GVC3RYwtsyqPgHQ8xULrxzxyw06qurzqb6UDy4m5v2CFCrXG59pFtPhAF1LFra
         P0GaMsgC+411+8crWZwuNntoH924WIpGOaP6eIeXAT12F3C+apXIQtre7jk2CKf6Or
         e1ZgTmbd0OC5IR3q1ebNSdS9/QVifZ5s7yWCKKv8QR+lgUSeLerGd/CyN43h386Flt
         ZJVWPGUao1OaA==
Received: from [10.1.0.205] (192-222-188-97.qc.cable.ebox.net [192.222.188.97])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4NtvSk161FzgMN;
        Fri, 13 Jan 2023 16:19:50 -0500 (EST)
Message-ID: <d8cf45aa-936c-90e7-61c4-cef6f7fe0006@efficios.com>
Date:   Fri, 13 Jan 2023 16:20:23 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To:     lttng-dev@lists.lttng.org,
        diamon-discuss@lists.linuxfoundation.org,
        linux-trace-users@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng-modules 2.12.12 and 2.13.8 (Linux kernel tracer)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Those are stable release updates of the LTTng modules project.

The most relevant change is that the 2.13.8 version introduces
support for the 6.1 Linux kernel, kernel version ranges updates
for the RHEL kernels, and a kallsyms wrapper fix on ppc64el.

The LTTng modules provide Linux kernel tracing capability to the LTTng
tracer toolset.

* New in these releases:

2023-01-13 (National Sticker Day) LTTng modules 2.13.8
         * fix: jbd2: use the correct print format
         * Fix: in_x32_syscall was introduced in v4.7.0
         * Explicitly skip tracing x32 system calls
         * fix: kallsyms wrapper on ppc64el
         * fix: Adjust ranges for RHEL 8.6 kernels
         * fix: kvm-x86 requires CONFIG_KALLSYMS_ALL
         * fix: mm/slab_common: drop kmem_alloc & avoid dereferencing fields when not using (v6.1)

2023-01-13 (National Sticker Day) LTTng modules 2.12.12
         * fix: jbd2: use the correct print format
         * Fix: in_x32_syscall was introduced in v4.7.0
         * Explicitly skip tracing x32 system calls
         * fix: kallsyms wrapper on ppc64el
         * fix: Adjust ranges for RHEL 8.6 kernels
         * fix: kvm-x86 requires CONFIG_KALLSYMS_ALL

Project website: https://lttng.org
Documentation: https://lttng.org/docs
Download link: https://lttng.org/download

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
