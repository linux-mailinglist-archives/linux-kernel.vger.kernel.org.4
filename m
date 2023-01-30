Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00DEA680A81
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 11:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235876AbjA3KLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 05:11:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233298AbjA3KLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 05:11:22 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2EA26E8D
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 02:11:21 -0800 (PST)
Received: from [2a02:8108:963f:de38:4bc7:2566:28bd:b73c]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pMR8C-0003fC-8Y; Mon, 30 Jan 2023 11:11:20 +0100
Message-ID: <ee9518a8-64ce-142d-ecfd-f560978352b0@leemhuis.info>
Date:   Mon, 30 Jan 2023 11:11:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: Latest RC causing web browser crash
Content-Language: en-US, de-DE
To:     Chris McGimpsey-Jones <chrisjones.unixmen@gmail.com>
References: <CAPaMSD3MM2BTW0REi4onUCPCLzz1B=-x0j9Uuvf2NHUOSefQ-w@mail.gmail.com>
From:   "Linux kernel regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     linux-kernel@vger.kernel.org,
        Linux kernel regressions list <regressions@lists.linux.dev>
In-Reply-To: <CAPaMSD3MM2BTW0REi4onUCPCLzz1B=-x0j9Uuvf2NHUOSefQ-w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1675073481;f5254261;
X-HE-SMSGID: 1pMR8C-0003fC-8Y
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[CCing the regression list, as it should be in the loop for regressions:
https://docs.kernel.org/admin-guide/reporting-regressions.html]

Hi, this is your Linux kernel regression tracker.

On 28.01.23 02:14, Chris McGimpsey-Jones wrote:
> Is anyone else with the latest RC having issues with Google Chrome
> browser, causing it to crash after a couple of minutes?

FWIW, this is unlikely to get any traction: nearly nobody reads the LKML
anymore, hence it's unlikely that someone that can help will see it.

> I reverted (temporarily) back to Linux 6.1.0 and it's fine.
> Tested a couple of times, the issue can be reproduced.

Are there any crash dumps that might indicate what might cause the problem?

> I don't know of the relationship between the kernel and web browser
> and it seems odd the kernel would cause this problem, but there's no
> disputing it is the cause as I can reproduce the issue.

Well, things like this don't happen frequently, but they do happen.
Without more data it's just very hard to get to the root of this issue,
as it could be caused by all sorts of things (mm and drm are two most
likely suspects, but it could be something totally different).

Could you try to bisect the issue? There are various pages on the net
that explain how to do that.

Anyway for the rest of this mail:

[TLDR: I'm adding this report to the list of tracked Linux kernel
regressions; the text you find below is based on a few templates
paragraphs you might have encountered already in similar form.
See link in footer if these mails annoy you.]

Thanks for the report. To be sure the issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
tracking bot:

#regzbot ^introduced v6.1..v6.2-rc5
#regzbot title chrome crashes
#regzbot ignore-activity

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply and tell me -- ideally
while also telling regzbot about it, as explained by the page listed in
the footer of this mail.

Developers: When fixing the issue, remember to add 'Link:' tags pointing
to the report (the parent of this mail). See page linked in footer for
details.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.
