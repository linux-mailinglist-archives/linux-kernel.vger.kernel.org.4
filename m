Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD0BF639A51
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 13:06:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiK0MGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 07:06:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiK0MGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 07:06:45 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748FEF015;
        Sun, 27 Nov 2022 04:06:44 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1ozGQk-0000dD-Id; Sun, 27 Nov 2022 13:06:42 +0100
Message-ID: <5880b4ec-dc1c-19da-50a5-182304bec261@leemhuis.info>
Date:   Sun, 27 Nov 2022 13:06:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v1] Revert "cpufreq: schedutil: Move max CPU capacity to
 sugov_policy" #forregzbot
Content-Language: en-US, de-DE
From:   Thorsten Leemhuis <regressions@leemhuis.info>
To:     "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221110195732.1382314-1-wusamuel@google.com>
 <ed7f56a9-e6b2-81e2-3068-30f600ca10bc@leemhuis.info>
In-Reply-To: <ed7f56a9-e6b2-81e2-3068-30f600ca10bc@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1669550804;309ff71f;
X-HE-SMSGID: 1ozGQk-0000dD-Id
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.11.22 19:07, Thorsten Leemhuis wrote:
> On 10.11.22 20:57, Sam Wu wrote:
>> This reverts commit 6d5afdc97ea71958287364a1f1d07e59ef151b11.
>>
>> On a Pixel 6 device, it is observed that this commit increases
>> latency by approximately 50ms, or 20%, in migrating a task
>> that requires full CPU utilization from a LITTLE CPU to Fmax
>> on a big CPU. Reverting this change restores the latency back
>> to its original baseline value.
>>
>> Fixes: 6d5afdc97ea7 ("cpufreq: schedutil: Move max CPU capacity to sugov_policy")
>> Cc: Lukasz Luba <lukasz.luba@arm.com>
>> Cc: Saravana Kannan <saravanak@google.com>
>> Cc: Isaac J. Manjarres <isaacmanjarres@google.com>
>> Signed-off-by: Sam Wu <wusamuel@google.com>
> 
> Thanks for the report. To be sure below issue doesn't fall through the
> cracks unnoticed, I'm adding it to regzbot, my Linux kernel regression
> tracking bot:
> 
> #regzbot ^introduced 6d5afdc97ea7
> #regzbot title cpufreq: schedutil: improved latency on Pixel 6
> #regzbot ignore-activity

#regzbot fixed-by: cdcc5ef26b3
