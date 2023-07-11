Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E015874EAD9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 11:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbjGKJjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 05:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbjGKJje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 05:39:34 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8712136
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 02:39:22 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qJ9pw-00047e-HN; Tue, 11 Jul 2023 11:39:12 +0200
Message-ID: <462e0e1e-98ea-0f3c-4aaa-8d44f0a8e664@leemhuis.info>
Date:   Tue, 11 Jul 2023 11:39:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Fwd: Need NVME QUIRK BOGUS for SAMSUNG MZ1WV480HCGL-000MV
 (Samsung SM-953 Datacenter SSD)
Content-Language: en-US, de-DE
To:     Pankaj Raghav <p.raghav@samsung.com>,
        Keith Busch <kbusch@kernel.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Clemens S." <cspringsguth@gmail.com>,
        Martin Belanger <martin.belanger@dell.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        John Meneghini <jmeneghi@redhat.com>,
        Hannes Reinecke <hare@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux NVMe <linux-nvme@lists.infradead.org>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Javier Gonzalez <javier.gonz@samsung.com>,
        =?UTF-8?B?67CV7KeE7ZmY?= <jh.i.park@samsung.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <d18d2a08-9d24-0209-c2cf-baf60bbf5048@gmail.com>
 <ZJsKBkPqoWzYyngS@kbusch-mbp.dhcp.thefacebook.com>
 <6f333133-2cc4-406a-d6c2-642ac6ccabca@leemhuis.info>
 <CGME20230710155902eucas1p2b464a29adc35e983c73b00d18ab5344c@eucas1p2.samsung.com>
 <ZKwqvTMPVmhnkZjS@kbusch-mbp.dhcp.thefacebook.com>
 <f0fdf86e-4293-8e07-835d-b5a866252068@samsung.com>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <f0fdf86e-4293-8e07-835d-b5a866252068@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1689068362;c61ff5f5;
X-HE-SMSGID: 1qJ9pw-00047e-HN
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[CCing Linus for the "whack a mole" aspect in the second half]

On 11.07.23 08:54, Pankaj Raghav wrote:
>>> I understand that, but I think we need middlemen for that, as I or Bagas
>>> don't have the contacts -- and it's IMHO also a bit much too ask us for
>>> in general, as regression tracking is hard enough already. At least
>>> unless this becomes something that happen regularly, then a list of
>>> persons we could contact would be fine I guess. But we simply can't deal
>>> with too many subsystem specific special cases.
>>
>> I'm not asking the Linux regression trackers to fill that role, though.

Well, during our work we often encounter those bugs -- often from people
that are no regular developers that already had a hard time
understanding the issue and reporting it to us somehow. Asking those to...

>> I'm asking people who experience these issues report it to their vendor

...find the right destination and format to report their Linux problems
to the vendors is unlikely to fly I suspect. And I'm not sure if that is
in our interest, as then it might take a lot longer to get those quirk
entries into the kernel source.

But whatever, the main reason why I write this mail is different:

>> directly because these device makers apparently have zero clue that
>> their spec non-compliance is causing painful experiences for their
>> customers and annoyance for maintainers. They keep pumping out more and
>> more devices with the same breakage.
>>
>> This particular vendor has been great at engaging with Linux, but that's
>> not necessarily normal among all device makers, and I don't have
>> contacts with the majority of the vendors we've had to quirk for this
>> issue.
>>
>> We did complain to the NVMe spec workgroup that their complaince cert
>> suite is not testing for this. There was a little initial interest in
>> fixing that gap, but it fizzled out...

Preface: this is not my area of expertise, and maybe I should keep my
mouth shut. But whatever.

Well, that "They keep pumping out more and more devices with the same
breakage" and the "new device" comment from Pankaj below bear the
question: should we stop trying to play "whack a mole" with all those
quirk entries and handle devices with duplicate ids just like Windows does?

That would "make things just work"(tm).

And yes, I suspect there are good reasons why we went down the "quirk"
route or why abandoning it might be hard. But maybe it's time to
reconsider that path, as from my outside point of view things sound a
lot like they are somewhat similar to the ACPI problems we dealt with
~15 years ago: we learned that we have to deal with broken ACPI
implementations and somehow use them in a way similar to how Windows
uses them, as that's the OS the machine was designed for and tested with.

Ciao, Thorsten

>>> Another request came in today, even with a pseudo-patch:
>>> https://bugzilla.kernel.org/show_bug.cgi?id=217649
>>>
>>> To quote:
>>> ```
>>> As with numerous NVMe controllers these days, Samsung's
>>> MZAL41T0HBLB-00BL2, which Lenovo builds into their 16ARP8 also suffers
>>> from invalid IDs, breaking suspend and hibernate also on the latest
>>> kernel 6.4.2.
> [...]
>> Panjaj, okay with this one too?
> 
> This looks a like a new device that might have a firmware update. I will ping
> internally first.
> 
> As you mentioned, the recent addition of globally unique ID check
> is breaking a lot of devices because of non-compliant firmware. I will try to create
> some awareness about this issue internally as well.
