Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6A9867F850
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 14:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233206AbjA1N4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 08:56:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbjA1N4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 08:56:06 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C4A4C0A
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 05:56:02 -0800 (PST)
Received: from [2a02:8108:963f:de38:4bc7:2566:28bd:b73c]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pLlgV-0002Kg-12; Sat, 28 Jan 2023 14:55:59 +0100
Message-ID: <d4871e70-c7c9-e638-d7c0-304ec8aea77b@leemhuis.info>
Date:   Sat, 28 Jan 2023 14:55:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: Failure during Stack Depot allocating hash table of 1048576
 entries with kvcalloc
Content-Language: en-US, de-DE
To:     Borislav Petkov <bp@alien8.de>,
        Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-mm <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>
References: <Y8Fq5m0CLfcFLCOY@zn.tnic>
 <07e42002-e78d-7947-19a7-0dd035466f50@alu.unizg.hr>
 <Y9UBFNwBeuePPsk3@zn.tnic>
From:   "Linux kernel regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <Y9UBFNwBeuePPsk3@zn.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1674914162;a5c37dae;
X-HE-SMSGID: 1pLlgV-0002Kg-12
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.01.23 12:03, Borislav Petkov wrote:
> On Sat, Jan 28, 2023 at 03:41:50AM +0100, Mirsad Goran Todorovac wrote:
>> This appears to be a duplicate of the report:
>> https://lore.kernel.org/linux-mm/2c677d85-820c-d41a-fc98-7d3974b49e42@alu.unizg.hr/raw
> 
> Yah, looks like
> 
> 56a61617dd22 ("mm: use stack_depot for recording kmemleak's backtrace")
> 
> needs to be reverted.

Unless I'm missing something (which might easily be the case) there is a
patch for that issue in -mm already:

https://lore.kernel.org/all/20230119224022.80752C433F0@smtp.kernel.org/

Or where two different issues discussed in the thread Mirsad mentioned
above?

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.
