Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89621609431
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 17:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbiJWPBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 11:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiJWPBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 11:01:10 -0400
X-Greylist: delayed 599 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 23 Oct 2022 08:01:05 PDT
Received: from sphereful.davidgow.net (sphereful.davidgow.net [IPv6:2404:9400:4:0:216:3eff:fee2:5328])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11ADE6DFB9;
        Sun, 23 Oct 2022 08:01:04 -0700 (PDT)
Received: by sphereful.davidgow.net (Postfix, from userid 119)
        id DDD841C034B; Sun, 23 Oct 2022 22:44:31 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=davidgow.net;
        s=201606; t=1666536271;
        bh=0N3kW6+aW6yf731DNq7Jvf9k5028oUiR6Y+A1mOBVuM=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=qZQMZXNJVI8cu2fqJ8s+VifEjTH7T+mB7MZIvCMXHV/StTln2AnZaPhSEDAc1k2t7
         UN3GwmE4P48z8HXtfUt/F7uhCZ0o/FLz58Zso+Wd61BZYmmy8kivq5SNlSb2xDFKoG
         gADKguUBGhzY5AyEwQnGdwMB3c2VzeJLZhYg0gyc8vr4U2FoHush59qAyAXy7CMjFH
         efZ2g9yySnZI8P9XuOftRSHN3/5lcoKphDyCSyIM0U1r5B1Hw3r7FF3dXhsnxxpb6S
         C81CPnIqYghAzvknZWIWMnTxWA0umNsttWzA91SOWRTOVTN4eZwrJPNUz90UV52Euh
         528fAt44KzE8I/kOLDfoElLPg+f9aaY5VCTMfCZwMZ7NBbVQM/OnlXyBR2R6T0lGt9
         C3gWiGmdJcdZnfzv+HiWzYL8VaMQLXfsT4F8nzDz5GaE/6sBk85rXTSf2O+imZxMyK
         Dl4I6XjgvmRjgmG57vn75g7ss4ogXT6KynLOnLJC4Ns0lKPDFUyY0vdduKiQtHFA02
         I8jLb2K5yRij+04jE7jhEyt9/MVk+mSZwnxW+YzgypQADGBQOlo1uqH4fMp0UFvUI+
         7YcWlgoqk+Hhu5BYMkTRJoicvLfGWSCYutKBhzUSFzedo+zSxwDs4dppNpVIJqq4qO
         5s/6YivG5sKDuefiPG+s4rqg=
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Received: from [IPV6:2001:8003:8d1e:3000::a57] (unknown [IPv6:2001:8003:8d1e:3000::a57])
        by sphereful.davidgow.net (Postfix) with ESMTPSA id 9108C1C032E;
        Sun, 23 Oct 2022 22:44:26 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=davidgow.net;
        s=201606; t=1666536266;
        bh=0N3kW6+aW6yf731DNq7Jvf9k5028oUiR6Y+A1mOBVuM=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=J1AOaqB/mQVVbj4/+5Cemtg6Iksw+0uW+e/SPZ0sD7G9xudOd6WV0NctrHT9LKsuN
         WGEYXbQLI+p/3ArcshYYjJkdMys8iHcL4zVc3hESxSYOCHceSk9eJU4NiTW77rXwWK
         lqyymSi7n7SOB3Rm+RdjCvi/C3c0SksUYfwop0nzgrvpKp8KQB/icLPNl8+z332T2x
         U0uNM/C6sGhd5dvlvJ0VfJhXstm/JPZ3pdm3FgV27pUlLmEd09hVMh8BeizDn6frQg
         5W+bK15gzCMIhopvDlCeZeOWDyuP09Vx2qviCZ7acHWL+LVl8iyMgJiI6foZe9FTHx
         LXEbt9jaUekl4vA+kdB0m3vKEsushptELPPmz4lAbSy6M9eezsl0wGVkXc7Kv64sg9
         LZrUhi9AqtvYReZBKU2FFxJIiOz2WMvIrifxOajkdcTRl3yt1vdLH+aGdpQzZ3fdMr
         Rw1eCf2T0FiozSqekcDZelbUnUNZj3FI6jSc89yVgdWP7Ed+yQQQ6Y4jAdxPFj0IUv
         Ino5abpnEbe0OTA3FotIj/TjafZ3rT+abac6Ks68xMOVkGZLaydFU9E7/0X8t32CD+
         SRVZr3AW/dQSO3/5LZQK0U3Y5zEp592DDa3bIdh0lFhZDaVaRfqYtL5gfq7NRh/j+A
         1aID6ZM69pPk+Bf6akmP+ilw=
Message-ID: <98a8be05-0882-fa8f-846d-b8f74f141041@davidgow.net>
Date:   Sun, 23 Oct 2022 22:44:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>, Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>, Tejun Heo <tj@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        page-reclaim@google.com, Brian Geffon <bgeffon@google.com>,
        Jan Alexander Steffens <heftig@archlinux.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Daniel Byrne <djbyrne@mtu.edu>,
        Donald Carr <d@chaos-reins.com>,
        =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Shuang Zhai <szhai2@cs.rochester.edu>,
        Sofia Trinh <sofia.trinh@edi.works>,
        Vaibhav Jain <vaibhav@linux.ibm.com>
References: <20220815071332.627393-1-yuzhao@google.com>
 <20220815071332.627393-9-yuzhao@google.com>
 <Y0go8wWtdcyH1+Ch@hirez.programming.kicks-ass.net>
 <CAOUHufa9+FTO3Pv-5jC-e3S5goPsUGu-5KcPVHa4bWb0X+d2ug@mail.gmail.com>
 <CAHk-=wj1rc2t5noMtVOgu8XXeTM4KiggEub9PdcexxeQrYPZvA@mail.gmail.com>
 <Y1FXpHdyvXjrjbLw@hirez.programming.kicks-ass.net>
 <CAHk-=whQchubuDpRGFabhmcZuzdt13OOF8wznXb+Dbi3GzBQhQ@mail.gmail.com>
 <Y1GZjPO+szk7X0wP@hirez.programming.kicks-ass.net>
 <CAHk-=wikUaRM5H_y1Bc+QyvGi40dKDL8fnCTyz7ECbwK7aHNPQ@mail.gmail.com>
 <Y1IUMDJFScAMrCS5@casper.infradead.org>
 <CAHk-=wjrpH1+6cQQjTO6p-96ndBMiOnNH098vhS2jLybxD+7gA@mail.gmail.com>
From:   David Gow <david@davidgow.net>
Subject: Re: [PATCH v14 08/14] mm: multi-gen LRU: support page table walks
In-Reply-To: <CAHk-=wjrpH1+6cQQjTO6p-96ndBMiOnNH098vhS2jLybxD+7gA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 22/10/22 à 00:50, Linus Torvalds a écrit :
> On Thu, Oct 20, 2022 at 8:38 PM Matthew Wilcox<willy@infradead.org>  wrote:
>> On Thu, Oct 20, 2022 at 07:10:46PM -0700, Linus Torvalds wrote:
>>> We got rid of i386 support back in 2012. Maybe it's time to get rid of
>>> i486 support in 2022?
>> Arnd suggested removing i486 last year and got a bit of pushback.
>> The most convincing to my mind was Maciej:
> Hmm. Maciej added to the cc.
> 
> I suspect we can just say "oh, well, use LTS kernels".
> 

To jump in early on the inevitable pile-on, I'm doing my occasional 
32-bit x86 KUnit test runs on an old 486 DX/2. Now, this is _mostly_ 
just a party trick -- and there are lots of people running 32-bit builds 
under QEMU et al -- but personally, the only non-amd64-capable x86 
machines I have lying around are all 486 class (including a new Vortex86 
board).

(But, at the very least, I can confirm that the latest torvalds/master 
does build, run, and pass KUnit tests on a real 486 at the moment.)

So while dropping i486 wouldn't affect anything particularly important 
for me, it'd be a minor inconvenience and make me a bit sad.

That being said, I have no objection to dropping support for 486SX CPUs 
and CONFIG_MATH_EMULATION.

Cheers,
-- David
