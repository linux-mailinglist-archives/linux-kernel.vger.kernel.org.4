Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0704C6BFFC1
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 08:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjCSHVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 03:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjCSHVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 03:21:06 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671AE132DB;
        Sun, 19 Mar 2023 00:21:05 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pdnLf-0005MO-Hj; Sun, 19 Mar 2023 08:20:59 +0100
Message-ID: <53e8b4db-e8dd-4dfa-f873-7dcbeac09149@leemhuis.info>
Date:   Sun, 19 Mar 2023 08:20:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US, de-DE
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Bob Moore <robert.moore@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        acpica-devel@lists.linuxfoundation.org,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
References: <e6aaddb9-afec-e77d-be33-570f9f10a9c2@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: [regression] Bug 217069 - Wake on Lan is broken on r8169 since
 6.2
In-Reply-To: <e6aaddb9-afec-e77d-be33-570f9f10a9c2@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1679210465;b172227a;
X-HE-SMSGID: 1pdnLf-0005MO-Hj
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Thorsten here, the Linux kernel's regression tracker.

On 22.02.23 08:57, Thorsten Leemhuis wrote:
> 
> I noticed a regression report in bugzilla.kernel.org. As many (most?)
> kernel developer don't keep an eye on it, I decided to forward it by
> mail. Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=217069 :

An issue that looked like a network bug was now bisected and it turns
out it's cause by 5c62d5aab875 ("ACPICA: Events: Support fixed PCIe wake
event") which Huacai Chen provided. Could you take a look at the ticket
linked above?

FWIW, the whole story started like this:

>> Ivan Ivanich 2023-02-22 00:51:52 UTC
>>
>> After upgrade to 6.2 having issues with wake on lan on 2 systems: -
>> first is an old lenovo laptop from 2012(Ivy Bridge) with realtek
>> network adapter - second is a PC(Haswell refresh) with PCIE realtek
>> network adapter
>>
>> Both uses r8169 driver for network.
>>
>> On laptop it's not possible to wake on lan after poweroff On PC it's
>> not possible to wake on lan up after hibernate but works after
>> poweroff
>>
>> In both cases downgrade to 6.1.x kernel fixes the issue.

Meanwhile a few others that ran into the same problem with NICs from
different vendors joined the ticket

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.
