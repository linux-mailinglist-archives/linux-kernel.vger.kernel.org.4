Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 314B47345DF
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 13:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbjFRLAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 07:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjFRK77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 06:59:59 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7ADEE
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 03:59:58 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qAq8P-0001Ly-D2; Sun, 18 Jun 2023 12:59:53 +0200
Message-ID: <d8e0e211-6e2c-6aba-9ffd-84833872f559@leemhuis.info>
Date:   Sun, 18 Jun 2023 12:59:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: [linus:master] [mm] f95bdb700b: stress-ng.ramfs.ops_per_sec
 -88.8% regression
Content-Language: en-US, de-DE
To:     kernel test robot <yujie.liu@intel.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Kirill Tkhai <tkhai@ya.ru>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        David Hildenbrand <david@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <shy828301@gmail.com>, linux-mm@kvack.org,
        ying.huang@intel.com, feng.tang@intel.com, fengwei.yin@intel.com,
        Linux kernel regressions list <regressions@lists.linux.dev>
References: <202305230837.db2c233f-yujie.liu@intel.com>
From:   "Linux regression tracking #adding (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
In-Reply-To: <202305230837.db2c233f-yujie.liu@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1687085998;c33207e6;
X-HE-SMSGID: 1qAq8P-0001Ly-D2
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[TLDR: I'm adding this report to the list of tracked Linux kernel
regressions; the text you find below is based on a few templates
paragraphs you might have encountered already in similar form.
See link in footer if these mails annoy you.]

On 23.05.23 03:35, kernel test robot wrote:
> Hello,
> 
> kernel test robot noticed a -88.8% regression of stress-ng.ramfs.ops_per_sec on:
> 
> commit: f95bdb700bc6bb74e1199b1f5f90c613e152cfa7 ("mm: vmscan: make global slab shrink lockless")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

To be sure Linus is aware of the pending revert before releasing -rc7,
let me add this to the list of tracked regressions:

#regzbot ^introduced f95bdb700bc6bb74e1199b1f5f90c613e152cfa7.
#regzbot title mm: problems with the SRCU changeover (two reverts pending)
#regzbot monitor:
https://lore.kernel.org/all/ZH6K0McWBeCjaf16@dread.disaster.area/
#regzbot fix: Revert "mm: vmscan: make global slab shrink lockless"
#regzbot ignore-activity

Side note: "Revert "mm: vmscan: add shrinker_srcu_generation"" (also in
mm-hotfixes-unstable/next) is related. See
https://lore.kernel.org/all/51cbf269-daff-d7b8-653f-7ba388475ab8@linux.dev/

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.
