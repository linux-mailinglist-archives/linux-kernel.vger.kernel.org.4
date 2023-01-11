Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 865206664A9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 21:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235815AbjAKUQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 15:16:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233744AbjAKUQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 15:16:31 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D182606
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 12:16:30 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pFhWO-0004YL-9c; Wed, 11 Jan 2023 21:16:28 +0100
Message-ID: <edc4191e-7912-3e53-c1b4-249713d5ab2b@leemhuis.info>
Date:   Wed, 11 Jan 2023 21:16:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: =?UTF-8?Q?Re=3a_=5bRegression=5d_Bug=c2=a0216911_-_get=5funmapped?=
 =?UTF-8?Q?=5farea_returns_addresses_below_mmap=5fmin=5faddr?=
Content-Language: en-US, de-DE
To:     Liam Howlett <liam.howlett@oracle.com>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Amanieu d'Antras <amanieu@gmail.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <0b9f5425-08d4-8013-aa4c-e620c3b10bb2@leemhuis.info>
 <df59eaf6-ae77-adb7-295a-15997950f1f5@leemhuis.info>
 <20230111192217.mgiliyxfh3jt2jvt@revolver>
From:   "Linux kernel regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <20230111192217.mgiliyxfh3jt2jvt@revolver>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1673468191;3f219c7d;
X-HE-SMSGID: 1pFhWO-0004YL-9c
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.01.23 20:22, Liam Howlett wrote:
> * Linux kernel regression tracking (Thorsten Leemhuis) <regressions@leemhuis.info> [230111 05:54]:

> [...]
> Thanks Thorsten.

yw

> [...]
> I'll send out a patch shortly.

Great, thx!

>>> BTW, let me use this mail to also add the report to the list of tracked
>>> regressions to ensure it's doesn't fall through the cracks:
>>>
>>> #regzbot introduced: d4af56c5c7c6..3499a13168da
>>> https://bugzilla.kernel.org/show_bug.cgi?id=216911
>>> #regzbot title: mm: get_unmapped_area returns addresses below mmap_min_addr
>>> #regzbot ignore-activity
> 
> Just a note that the fixes tag will be outside the above introduced
> range. It will be 54a611b60590 ("Maple Tree: add new data structure")
> 
> I hope this doesn't cause issues with the bots.

Not at all. Regzbot currently[1] only looks out for Link: tags to the
report; in this case both a link to the start of this thread or the
bugzilla ticket will automatically be associated with the report, which
will be automatically marked as resolved by regzbot once a patch with
such a Link: tag lands in mainline.

Ciao, Thorsten

[1] a lot of people forget to place those Link: tags, that's why I at
some point will likely change regzbot to also consider patches as a
related where both the Reported-by and the commit id (in case it's a
fully bisected regression) match a tracked report.
