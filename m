Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F98F65E677
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 09:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjAEIMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 03:12:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjAEIMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 03:12:16 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F8A3FA05;
        Thu,  5 Jan 2023 00:12:15 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pDLMC-0001qp-Dj; Thu, 05 Jan 2023 09:12:12 +0100
Message-ID: <1bb93259-1c9f-5335-a0bf-fc8641b26650@leemhuis.info>
Date:   Thu, 5 Jan 2023 09:12:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US, de-DE
From:   Thorsten Leemhuis <regressions@leemhuis.info>
To:     Bastien Nocera <hadess@hadess.net>
Cc:     David Roth <davidroth9@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?Q?=5bRegression=5d_Bug=c2=a0216885_-_HID++_Logitech_G903_ge?=
 =?UTF-8?Q?nerates_full_scroll_wheel_events_with_every_hi-res_tick_when_atta?=
 =?UTF-8?Q?ched_via_USB?=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1672906335;f737be4f;
X-HE-SMSGID: 1pDLMC-0001qp-Dj
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this is your Linux kernel regression tracker speaking.

I noticed a regression report in bugzilla.kernel.org. As many (most?)
kernel developer don't keep an eye on it, I decided to forward it by
mail. Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=216885 :

>  David Roth 2023-01-04 20:37:22 UTC
> 
> Created attachment 303526 [details]
> Libinput record with G903 attached directly to USB
> 
> Since
> https://lore.kernel.org/linux-input/20220914132146.6435-1-hadess@hadess.net/T/#u
> my Logitech G903 has gained hi res support. While normally a good
> thing, it seems that in this case it leads to generating one normal
> REL_WHEEL with each REL_WHEEL_HI_RES event instead of just a couple
> of REL_WHEEL_HI_RES, followed by the standard REL_WHEEL once a
> notch/tick is reached. This leads to overly sensitive scrolling and
> makes the wheel basically useless.
> 
> Interestingly this only happens when the mouse is connected directly via
> cable (PID:0xC091) and not via the Lightspeed wireless dongle
> (PID:0x4087) where it will lead to correctly applying the times 8
> multiplier and the relevant set of HI_RES and REL_WHEEL event once a
> notch is reached.
> 
> I originally thought about patching the module/adding a param to simple
> disable high res support in general, assuming this might be something
> people might want to configure, but seeing that this can be "fixed" that
> way I decided to hold off on the thought.
> 
> However it seems like we'd need to trade one set of quirks for another,
> so not sure what the correct approach might be.
> 
> I'll attach some libinput debug logs when the issue happens.

See the ticket for more details.

BTW, let me use this mail to also add the report to the list of tracked
regressions to ensure it's doesn't fall through the cracks:

#regzbot introduced: 908d325e1665
https://bugzilla.kernel.org/show_bug.cgi?id=216885
#regzbot title: hid: overly sensitive scrolling with Logitech G903 that
makes the wheel basically useless
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.
