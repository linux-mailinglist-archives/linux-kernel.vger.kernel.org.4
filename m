Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 939A165D4DE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 15:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239274AbjADOCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 09:02:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234327AbjADOCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 09:02:10 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0CA1E1;
        Wed,  4 Jan 2023 06:02:09 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pD4LI-0002Kl-EC; Wed, 04 Jan 2023 15:02:08 +0100
Message-ID: <818ec46b-d058-d294-8b22-cea427c2911a@leemhuis.info>
Date:   Wed, 4 Jan 2023 15:02:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: 6.2 nvme-pci: something wrong #forregzbot
Content-Language: en-US, de-DE
From:   Thorsten Leemhuis <regressions@leemhuis.info>
To:     "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <572cfcc0-197a-9ead-9cb-3c5bf5e735@google.com>
 <dedcb972-e934-53c2-f933-c25afa5c65a4@leemhuis.info>
In-Reply-To: <dedcb972-e934-53c2-f933-c25afa5c65a4@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1672840929;63b491ab;
X-HE-SMSGID: 1pD4LI-0002Kl-EC
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[TLDR: This mail in primarily relevant for Linux kernel regression
tracking. See link in footer if these mails annoy you.]

On 24.12.22 08:52, Thorsten Leemhuis wrote:
> [Note: this mail contains only information for Linux kernel regression
> tracking. Mails like these contain '#forregzbot' in the subject to make
> then easy to spot and filter out. The author also tried to remove most
> or all individuals from the list of recipients to spare them the hassle.]
> 
> On 24.12.22 06:24, Hugh Dickins wrote:
>>
>> There's something wrong with the nvme-pci heading for 6.2-rc1:
>> no problem booting here on this Lenovo ThinkPad X1 Carbon 5th,
>> but under load...> [...]
>> Bisection points to your
>> 0da7feaa5913 ("nvme-pci: use the tagset alloc/free helpers")
>> And that does revert cleanly, giving a kernel which shows no problem.
>> [...]
> 
> Thanks for the report. To be sure below issue doesn't fall through the
> cracks unnoticed, I'm adding it to regzbot, my Linux kernel regression
> tracking bot:
> 
> #regzbot ^introduced 0da7feaa5913
> #regzbot title nvme-pci: problems under load
> #regzbot ignore-activity

#regzbot fix: 88d356ca41ba1c3effc2d4208dfbd43

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.
