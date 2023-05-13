Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17069701645
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 13:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235208AbjEMLFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 07:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232557AbjEMLFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 07:05:20 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715D83C25;
        Sat, 13 May 2023 04:05:19 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pxn3s-0005a8-PR; Sat, 13 May 2023 13:05:16 +0200
Message-ID: <09d649a7-6245-2689-7791-ba173e8ac852@leemhuis.info>
Date:   Sat, 13 May 2023 13:05:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [regression] Bug 217122 - "Transfer event TRB DMA ptr not part of
 current TD" messages since 6.1
Content-Language: en-US, de-DE
From:   "Linux regression tracking #update (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     Linux kernel regressions list <regressions@lists.linux.dev>
Cc:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>,
          Linux regressions mailing list 
          <regressions@lists.linux.dev>
References: <72579321-2cc9-2de1-d28c-0c56562f3a28@leemhuis.info>
In-Reply-To: <72579321-2cc9-2de1-d28c-0c56562f3a28@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1683975919;f3d4928a;
X-HE-SMSGID: 1pxn3s-0005a8-PR
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[TLDR: This mail in primarily relevant for Linux kernel regression
tracking. See link in footer if these mails annoy you.]

On 05.03.23 10:18, Linux regression tracking (Thorsten Leemhuis) wrote:

> I noticed a regression report in bugzilla.kernel.org. As many (most?)
> kernel developer don't keep an eye on it, I decided to forward it by
> mail. Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=217122 :
> 
>>  Jürgen Herrmann 2023-03-03 19:53:55 UTC
>>
>> Created attachment 303837 [details]
>> collection of txt files with various hardware/software states
>>
>> Occasionally this error happens:
>>
>> [94467.984745] xhci_hcd 0000:05:00.4: ERROR Transfer event TRB DMA ptr not part of current TD ep_index 3 comp_code 1
>> [94467.984751] xhci_hcd 0000:05:00.4: Looking for event-dma 000000010f10c730 trb-start 000000010f10c740 trb-end 000000010f10c740 seg-start 000000010f10
>> c000 seg-end 000000010f10cff0

#regzbot introduced: b006c439d58d
#regzbot fix: f1324bbc401
#regzbot ignore-activity

For details see bugzilla

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.
