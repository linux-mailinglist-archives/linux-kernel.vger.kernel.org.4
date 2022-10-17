Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8920E600CE1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 12:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbiJQKvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 06:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbiJQKvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 06:51:53 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C395F9B9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 03:51:52 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1okNin-0000rH-GA; Mon, 17 Oct 2022 12:51:49 +0200
Message-ID: <402ab0ef-8bea-6210-1585-2e0e217a2e08@leemhuis.info>
Date:   Mon, 17 Oct 2022 12:51:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: Bug 216581 - Kernel panic on /init as busybox symbolic link with
 xen efi
Content-Language: en-US, de-DE
To:     =?UTF-8?Q?Marek_Marczykowski-G=c3=b3recki?= 
        <marmarek@invisiblethingslab.com>
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Denis Chancogne <denis.chancogne@free.fr>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
References: <e2cf3207-e9e9-5585-1a6e-9b39d96b4b54@leemhuis.info>
 <Y0ygiO3kuazXWSfZ@mail-itl>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <Y0ygiO3kuazXWSfZ@mail-itl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1666003912;9497aca0;
X-HE-SMSGID: 1okNin-0000rH-GA
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.10.22 02:23, Marek Marczykowski-Górecki wrote:
> On Sun, Oct 16, 2022 at 01:08:53PM +0200, Thorsten Leemhuis wrote:

>>>  Denis Chancogne 2022-10-13 22:00:19 UTC
>>>
>>> when I start Xen 4.15.3 in efi with kernel 5.18.19, all works well;
>>> but since kernel 5.19, I have a kernel panic on my /init process as
>>> busybox symbolic link inside initramfs.
>>>
>>> This is the kernel log :
> [...]
> 
> Thanks for forwarding.
> 
> This is already fixed on the Xen side: https://xenbits.xen.org/gitweb/?p=xen.git;a=commit;h=c3bd0b83ea5b7c0da6542687436042eeea1e7909
> The commit is also in 4.15 branch already:
> https://xenbits.xen.org/gitweb/?p=xen.git;a=commit;h=7923ea47e578bca30a6e45951a9da09e827ff028,
> to be included in 4.15.4 rather soon.

Hmmm. Well, strictly speaking this is still a kernel regression that
should be fixed (or worked around) on the kernel level. But 5.19 is out
for a while already and this afaics was the first report of this problem
in kernel land. Maybe it's not worth it, so let's leave everything as it
is for now, if that's okay for Denis. We IMHO will need to reconsider if
more users run into this.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.

#regzbot introduced: 8ad7e8f69695
#regzbot invalid: it is a kernel regression, but one that can be worked
around by updating Xen hypervisor

