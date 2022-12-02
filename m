Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EAB4640E99
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 20:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234812AbiLBThx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 14:37:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234651AbiLBTht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 14:37:49 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F1A1FCF2
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 11:37:48 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1p1Bqv-00011t-6i; Fri, 02 Dec 2022 20:37:41 +0100
Message-ID: <46196508-aaab-b31c-9ecf-5dfbb729dd68@leemhuis.info>
Date:   Fri, 2 Dec 2022 20:37:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [mm] f35b5d7d67: will-it-scale.per_process_ops -95.5% regression
Content-Language: en-US, de-DE
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Rik van Riel <riel@surriel.com>, Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        kernel test robot <yujie.liu@intel.com>, lkp@lists.01.org,
        lkp@intel.com, Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        feng.tang@intel.com, zhengjun.xing@linux.intel.com,
        fengwei.yin@intel.com, Nathan Chancellor <nathan@kernel.org>
References: <202210181535.7144dd15-yujie.liu@intel.com>
 <87edv4r2ip.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <Y1DNQaoPWxE+rGce@dev-arch.thelio-3990X>
 <871qr3nkw2.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <366045a27a96e01d0526d63fd78d4f3c5d1f530b.camel@surriel.com>
 <Y1GCYXGtEVZbcv/5@dev-arch.thelio-3990X>
 <Y4RX+JZLddDHrLuQ@dev-arch.thelio-3990X>
 <e919e5a3-1118-043e-8bbd-5ee35f2ab411@leemhuis.info>
 <07adee081a70c2b4b44d9bf93a0ad3142e091086.camel@surriel.com>
 <20221201132237.c55c4bd07ba44463b146882e@linux-foundation.org>
 <f792d1d3-7181-8a17-5cf6-1ea13e84bb9b@leemhuis.info>
 <20221202104406.a0f85df9fdc33d0cfc6eb4a4@linux-foundation.org>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <20221202104406.a0f85df9fdc33d0cfc6eb4a4@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1670009868;42c665cd;
X-HE-SMSGID: 1p1Bqv-00011t-6i
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.12.22 19:44, Andrew Morton wrote:
> On Fri, 2 Dec 2022 09:46:48 +0100 Thorsten Leemhuis <regressions@leemhuis.info> wrote:
> 
>> What beverage of choice do I have to offer you to make you in the future
>> include 'Link:' tags linking to the report(s) when you add reverts like
>> the one for this issue?
> 
> $10 supermarket pinot seems to be my tipple.

/me will make a note

> I can do that. 

Great, many thx!

> Any Reported-by: requires a Link:, OK?

Yup, that's how it is, except for a few corner cases (say someone
reported something on IRC or on a hallway).

Ciao, Thorsten

