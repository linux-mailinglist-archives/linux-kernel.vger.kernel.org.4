Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 767AC6C7BD8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 10:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbjCXJrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 05:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231503AbjCXJqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 05:46:46 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7196F28D17;
        Fri, 24 Mar 2023 02:46:44 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pfe0M-0003PS-Sx; Fri, 24 Mar 2023 10:46:38 +0100
Message-ID: <3089214d-292b-885d-9bc1-c81d0101d5f0@leemhuis.info>
Date:   Fri, 24 Mar 2023 10:46:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
From:   Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: [regression] Bug 217069 - Wake on Lan is broken on r8169 since
 6.2
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
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
 <53e8b4db-e8dd-4dfa-f873-7dcbeac09149@leemhuis.info>
Content-Language: en-US, de-DE
In-Reply-To: <53e8b4db-e8dd-4dfa-f873-7dcbeac09149@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1679651204;7e336529;
X-HE-SMSGID: 1pfe0M-0003PS-Sx
X-Spam-Status: No, score=-0.0 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.03.23 08:20, Linux regression tracking (Thorsten Leemhuis) wrote:
> Hi, Thorsten here, the Linux kernel's regression tracker.
> 
> On 22.02.23 08:57, Thorsten Leemhuis wrote:
>>
>> I noticed a regression report in bugzilla.kernel.org. As many (most?)
>> kernel developer don't keep an eye on it, I decided to forward it by
>> mail. Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=217069 :
> 
> An issue that looked like a network bug was now bisected and it turns
> out it's cause by 5c62d5aab875 ("ACPICA: Events: Support fixed PCIe wake
> event") which Huacai Chen provided. Could you take a look at the ticket
> linked above?

Huacai Chen, did you look into this? Would be good to have this
regression fixed rather sooner than later, as it seems to annoy quite a
few people.

Should we maybe simply revert the problematic change for now and reapply
it later once the root-issue was found and fixed?

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke

> FWIW, the whole story started like this:
> 
>>> Ivan Ivanich 2023-02-22 00:51:52 UTC
>>>
>>> After upgrade to 6.2 having issues with wake on lan on 2 systems: -
>>> first is an old lenovo laptop from 2012(Ivy Bridge) with realtek
>>> network adapter - second is a PC(Haswell refresh) with PCIE realtek
>>> network adapter
>>>
>>> Both uses r8169 driver for network.
>>>
>>> On laptop it's not possible to wake on lan after poweroff On PC it's
>>> not possible to wake on lan up after hibernate but works after
>>> poweroff
>>>
>>> In both cases downgrade to 6.1.x kernel fixes the issue.
> 
> Meanwhile a few others that ran into the same problem with NICs from
> different vendors joined the ticket
> 
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.
