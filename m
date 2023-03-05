Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCE686AAEB3
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 10:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjCEJSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 04:18:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCEJSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 04:18:06 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C267FCA0C;
        Sun,  5 Mar 2023 01:18:04 -0800 (PST)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pYkVF-0000ff-L8; Sun, 05 Mar 2023 10:18:01 +0100
Message-ID: <72579321-2cc9-2de1-d28c-0c56562f3a28@leemhuis.info>
Date:   Sun, 5 Mar 2023 10:18:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US, de-DE
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     Mathias Nyman <mathias.nyman@intel.com>
Cc:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux kernel regressions list <regressions@lists.linux.dev>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: [regression] Bug 217122 - "Transfer event TRB DMA ptr not part of
 current TD" messages since 6.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1678007884;5f164182;
X-HE-SMSGID: 1pYkVF-0000ff-L8
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,WEIRD_PORT autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this is your Linux kernel regression tracker.

I noticed a regression report in bugzilla.kernel.org. As many (most?)
kernel developer don't keep an eye on it, I decided to forward it by
mail. Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=217122 :

>  Jürgen Herrmann 2023-03-03 19:53:55 UTC
> 
> Created attachment 303837 [details]
> collection of txt files with various hardware/software states
> 
> Occasionally this error happens:
> 
> [94467.984745] xhci_hcd 0000:05:00.4: ERROR Transfer event TRB DMA ptr not part of current TD ep_index 3 comp_code 1
> [94467.984751] xhci_hcd 0000:05:00.4: Looking for event-dma 000000010f10c730 trb-start 000000010f10c740 trb-end 000000010f10c740 seg-start 000000010f10
> c000 seg-end 000000010f10cff0
> 
> the playback software (camilladsp then reports an error:
> 
> 2023-03-03 05:41:37.010408 WARN [src/alsadevice.rs:260] Capture device failed while waiting for available frames, error: ALSA function 'snd_pcm_wait' f
> ailed with error 'EPIPE: Broken pipe'
> 2023-03-03 05:41:37.013214 ERROR [src/bin.rs:364] Capture error: ALSA function 'snd_pcm_wait' failed with error 'EPIPE: Broken pipe'
> 
> This did not occur in any 6.0 version and was introduced in 6.1, still present in 6.2
See the ticket for more details.


[TLDR for the rest of this mail: I'm adding this report to the list of
tracked Linux kernel regressions; the text you find below is based on a
few templates paragraphs you might have encountered already in similar
form.]

BTW, let me use this mail to also add the report to the list of tracked
regressions to ensure it's doesn't fall through the cracks:

#regzbot introduced: v6.0..v6.1
https://bugzilla.kernel.org/show_bug.cgi?id=217122
#regzbot title: usb: xhci: suddenly errors msg like "Transfer event TRB
DMA ptr not part of current TD"
#regzbot ignore-activity

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply and tell me -- ideally
while also telling regzbot about it, as explained by the page listed in
the footer of this mail.

Developers: When fixing the issue, remember to add 'Link:' tags pointing
to the report (e.g. the buzgzilla ticket and maybe this mail as well, if
this thread sees some discussion). See page linked in footer for details.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.
