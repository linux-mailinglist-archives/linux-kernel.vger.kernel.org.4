Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B23045EBBCE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 09:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbiI0HoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 03:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbiI0HoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 03:44:09 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9834E9C7CA
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 00:44:08 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1od5G9-0003aB-VD; Tue, 27 Sep 2022 09:44:06 +0200
Message-ID: <9c76f7eb-64f5-ceac-cc4a-610db79c8233@leemhuis.info>
Date:   Tue, 27 Sep 2022 09:44:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Content-Language: en-US, de-DE
To:     David Chen <david.chen@nutanix.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>,
        Josh Poimboeuf <jpoimboe@kernel.org>
References: <BYAPR02MB4488D9DBFE310C9227906E9994529@BYAPR02MB4488.namprd02.prod.outlook.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: "BUG at kernel/entry/common.c:407!" on 5.10.133+
In-Reply-To: <BYAPR02MB4488D9DBFE310C9227906E9994529@BYAPR02MB4488.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1664264648;ccbe30d5;
X-HE-SMSGID: 1od5G9-0003aB-VD
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this is your Linux kernel regression tracker.

On 26.09.22 19:57, David Chen wrote:
> 
> On 5.10 branch starting from 5.10.133, if I do:
> 
>   echo 1 > /proc/sys/kernel/stack_tracer_enabled
> 
> The system will lock up, and the console will keep spewing
> "BUG at kernel/entry/common.c:407!" indefinitely.
> 
> I bisect this issue down to "c9eb5dc x86: Use return-thunk in asm code".
> Though interestingly, when I tried this on 5.19.11 which also contains the
> change, the issue didn't occur. Also this issue happens on both KVM guest and
> Virtualbox guest. I'm not sure if this affects non-VM for not.
> 
> Any help is appreciated.

Quick question: what was the latest version you tried to reproduce this
on? There were a few ftrace fixes that went into 5.10.144 (released one
week ago).

Ciao, Thorsten
