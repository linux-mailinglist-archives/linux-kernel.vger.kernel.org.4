Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28F856739AC
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 14:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbjASNMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 08:12:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbjASNM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 08:12:29 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB7E57C85A
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 05:10:55 -0800 (PST)
Received: from [2a02:8108:963f:de38:4bc7:2566:28bd:b73c]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pIUgA-0005xy-F9; Thu, 19 Jan 2023 14:10:06 +0100
Message-ID: <849c43bc-7488-72a6-f6fc-8700639b0c79@leemhuis.info>
Date:   Thu, 19 Jan 2023 14:10:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: regression on aarch64? panic on boot
Content-Language: en-US, de-DE
To:     Klaus Jensen <its@irrelevant.dk>, Christoph Hellwig <hch@lst.de>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux kernel regressions list <regressions@lists.linux.dev>
References: <Y8XINx8fpGPKudW6@cormorant.local>
From:   "Linux kernel regression tracking (#adding)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <Y8XINx8fpGPKudW6@cormorant.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1674133855;0087d679;
X-HE-SMSGID: 1pIUgA-0005xy-F9
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[TLDR: I'm adding this report to the list of tracked Linux kernel
regressions; the text you find below is based on a few templates
paragraphs you might have encountered already in similar form.
See link in footer if these mails annoy you.]

[CCing the regression list, as it should be in the loop for regressions:
https://docs.kernel.org/admin-guide/reporting-regressions.html]

On 16.01.23 22:57, Klaus Jensen wrote:
> 
> I'm getting panics when booting from a QEMU hw/nvme device on an aarch64
> guest in roughly 20% of boots on v6.2-rc4. Example panic below.
> 
> I've bisected it to commit eac3ef262941 ("nvme-pci: split the initial
> probe from the rest path").
> 
> I'm not seeing this on any other emulated platforms that I'm currently
> testing (x86_64, riscv32/64, mips32/64 and sparc64).
> [...]

Thanks for the report. To be sure the issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
tracking bot:

#regzbot ^introduced eac3ef262941
#regzbot title nvme: occasional boot problems due to the newly supported
async driver probe
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

