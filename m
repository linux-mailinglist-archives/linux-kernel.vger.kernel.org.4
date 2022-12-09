Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75132647DCF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 07:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbiLIGej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 01:34:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiLIGeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 01:34:36 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2312E6BC87;
        Thu,  8 Dec 2022 22:34:36 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1p3Wxu-0000EU-L7; Fri, 09 Dec 2022 07:34:34 +0100
Message-ID: <94dc3a77-738f-d801-9e5a-e3a61498e43b@leemhuis.info>
Date:   Fri, 9 Dec 2022 07:34:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [Regression] Logitech BT mouse unusable after commit 532223c8ac57
 (still in 6.1-rc8) #forregzbot
Content-Language: en-US, de-DE
From:   Thorsten Leemhuis <regressions@leemhuis.info>
To:     "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Cc:     linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <2262737.ElGaqSPkdT@kreacher>
 <abf9b7a0-8de4-76e9-bbbf-4630932949e9@leemhuis.info>
In-Reply-To: <abf9b7a0-8de4-76e9-bbbf-4630932949e9@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1670567676;e4a82d5f;
X-HE-SMSGID: 1p3Wxu-0000EU-L7
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.12.22 08:03, Thorsten Leemhuis wrote:
> [Note: this mail contains only information for Linux kernel regression
> tracking. Mails like these contain '#forregzbot' in the subject to make
> then easy to spot and filter out. The author also tried to remove most
> or all individuals from the list of recipients to spare them the hassle.]
> 
> On 06.12.22 15:58, Rafael J. Wysocki wrote:
>>
>> Commit 532223c8ac57 ("HID: logitech-hidpp: Enable HID++ for all the Logitech
>> Bluetooth devices") caused my Logitech Bluetooth mouse to become unusable.
>> [...]
> 
> Thanks for the report. To be sure below issue doesn't fall through the
> cracks unnoticed, I'm adding it to regzbot, my Linux kernel regression
> tracking bot:
> 
> #regzbot ^introduced 532223c8ac57
> #regzbot title hid: Logitech BT mouse unusable
> #regzbot monitor:
> https://lore.kernel.org/all/20221207142433.1158329-1-benjamin.tissoires@redhat.com/
> #regzbot ignore-activity

#regzbot fix: a9d9e46c755a1
