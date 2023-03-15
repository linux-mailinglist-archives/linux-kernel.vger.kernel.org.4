Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E98376BACA2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 10:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232211AbjCOJwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 05:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbjCOJvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 05:51:23 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92597305E2;
        Wed, 15 Mar 2023 02:50:48 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pcNmQ-0003Yj-Vu; Wed, 15 Mar 2023 10:50:47 +0100
Message-ID: <b7de0060-8555-65f7-c687-1326a5762929@leemhuis.info>
Date:   Wed, 15 Mar 2023 10:50:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [regression] Bug 217182 - Dell Latitude E7450 Trackpoint not
 working as expected
Content-Language: en-US, de-DE
From:   Thorsten Leemhuis <regressions@leemhuis.info>
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
Cc:     Steffen <wiesenbergsteffen+lxkernel@gmail.com>,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, lanelone@gmail.com
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
References: <6625ee0a-31a7-9fef-d299-457c0f98f5a0@leemhuis.info>
In-Reply-To: <6625ee0a-31a7-9fef-d299-457c0f98f5a0@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1678873848;90018fba;
X-HE-SMSGID: 1pcNmQ-0003Yj-Vu
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.03.23 11:20, Linux regression tracking (Thorsten Leemhuis) wrote:
> 
> Hi, Thorsten here, the Linux kernel's regression tracker.
> 
> I noticed a regression report in bugzilla.kernel.org. As many (most?)
> kernel developer don't keep an eye on it, I decided to forward it by
> mail. Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=217182 :
> 
>>  Steffen 2023-03-12 11:17:02 UTC
>>
>> Hi,
>> I'm new to this bug tracking system and just a user, not a developer.
>>
>> I use a Dell Latitude E7450 running with the Debian unstable based
>> distribution Siduction.
>> After upgrading to Linux kernel 6.2.x the Trackpoint does not work
>> anymore as expected. It uses an Alps PS/2 DualPoint Stick.
>> Even slight touches in any direction send the cursor to the top right
>> corner of the screen where it stays regardless of actual pointer
>> movement. This also appears in console mode. One can retrieve the
>> pointer again with the touchpad, but I'm more precise with the
>> Trackpoint and prefer using that.
>> The Trackpoint works well in kernel 6.1.14
>> Can somebody help?
> 
> See the ticket for more details.

FWIW, another user reported seeing the same problem on a different machine:

```
 Radek 2023-03-14 08:00:31 UTC

I am experiencing the same issue with kernel >6.2.x on Toshiba Z30
with Alps PS/2 DualPoint trackpoint / touchpad. The cursor jumps top
right even with the lowest sensitivity settings. It works just fine
with 6.1 or lower.
```

Pali, or anybody else: anyone any idea what's might be wrong there?
There afaics is only one recent commit to the alps driver (292a089d78d3
("treewide: Convert del_timer*() to timer_shutdown*()")); it it maybe
worth trying to revert it?

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.
