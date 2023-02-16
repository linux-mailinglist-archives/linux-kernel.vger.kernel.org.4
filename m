Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE22069976A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 15:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjBPO3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 09:29:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbjBPO3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 09:29:30 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A37148E30
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 06:29:25 -0800 (PST)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pSfGF-00063v-VU; Thu, 16 Feb 2023 15:29:24 +0100
Message-ID: <a99262c4-6348-0bf5-ac50-1ba4a23f96d7@leemhuis.info>
Date:   Thu, 16 Feb 2023 15:29:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: commit 3497b9a5 (usb: dwc3: add power down scale setting) breaks
 imx8mp
Content-Language: en-US, de-DE
From:   "Linux regression tracking #update (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Li Jun <jun.li@nxp.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Reply-To: Thorsten Leemhuis <regressions@leemhuis.info>,
          Linux regressions mailing list 
          <regressions@lists.linux.dev>
References: <5ae757aa-5b0e-be81-e87c-134e2ba5205d@prevas.dk>
 <a6a1c4db-39dd-4ca2-2e48-816bd7876a27@leemhuis.info>
In-Reply-To: <a6a1c4db-39dd-4ca2-2e48-816bd7876a27@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1676557765;cc53e25a;
X-HE-SMSGID: 1pSfGF-00063v-VU
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[TLDR: This mail in primarily relevant for Linux kernel regression
tracking. See link in footer if these mails annoy you.]

On 06.01.23 13:05, Linux kernel regression tracking (#adding) wrote:

> On 06.01.23 12:54, Rasmus Villemoes wrote:
>> We have an imx8mp board with a lan7801 usb ethernet chip hardwired on
>> the PCB, which is used as the host port for a Microchip KSZ9567 switch.
>>
>> While trying to update the kernel to 6.1.y, I found something quite
>> weird: When the switch was being probed for the second time (the first
>> ends with a standard -EPROBE_DEFER), the board would spontaneously reset.
> #regzbot ^introduced 3497b9a5c8c
> #regzbot title usb: dwc3: imx8mp broken
> #regzbot ignore-activity

#regzbot fix: 8a1ed98fe0f2e76
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.


