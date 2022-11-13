Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78EBC627163
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 18:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235390AbiKMR4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 12:56:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233792AbiKMR4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 12:56:21 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB80DEC5;
        Sun, 13 Nov 2022 09:56:20 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1ouHDO-0004wj-TZ; Sun, 13 Nov 2022 18:56:18 +0100
Message-ID: <c16e9614-70b5-3242-2977-8f3426960aa9@leemhuis.info>
Date:   Sun, 13 Nov 2022 18:56:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: dpkg fails on sparc64 (was: [PATCH v4 4/7] mm/thp: Carry over
 dirty bit when thp splits on pmd) #forregzbot
Content-Language: en-US, de-DE
From:   Thorsten Leemhuis <regressions@leemhuis.info>
To:     "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        sparclinux@vger.kernel.org
References: <20220811161331.37055-1-peterx@redhat.com>
 <20220811161331.37055-5-peterx@redhat.com>
 <20221021160603.GA23307@u164.east.ru>
 <6a02e9d4-690e-1f71-066a-c2d8bd811a0c@leemhuis.info>
 <7cf21691-b01b-4316-63a5-7625753f2ac3@leemhuis.info>
In-Reply-To: <7cf21691-b01b-4316-63a5-7625753f2ac3@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1668362180;f26f07cb;
X-HE-SMSGID: 1ouHDO-0004wj-TZ
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04.11.22 11:39, Thorsten Leemhuis wrote:
> On 23.10.22 15:33, Thorsten Leemhuis wrote:
>> On 21.10.22 18:06, Anatoly Pugachev wrote:
>>> Tried to update my debian sparc64 sid (unstable) linux distro to latest
>>> version of available packages, got dpkg segfault... 
>> #regzbot ^introduced 0ccf7f168e17bb7
>> #regzbot title mm: sparc64: dpkg fails on sparc64 since "mm/thp: Carry
>> over dirty bit when thp splits on pmd)"
>> #regzbot ignore-activity
> 
> #regzbot fixed-by: 434e3d15d92b

#regzbot fixed-by: 624a2c94f5b7
