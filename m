Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3B966EB7F4
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 10:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjDVIJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 04:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDVIJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 04:09:15 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16481981;
        Sat, 22 Apr 2023 01:09:14 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pq8Iy-0005eX-Sj; Sat, 22 Apr 2023 10:09:12 +0200
Message-ID: <834c05ee-287d-e5bf-be07-dec0d6f4b4b4@leemhuis.info>
Date:   Sat, 22 Apr 2023 10:09:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [REGRESSION] Bug 217353 - Logitech MX Anywhere 3 scroll wheel
 works incorrectly over USB dongle
Content-Language: en-US, de-DE
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     Bastien Nocera <hadess@hadess.net>
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux kernel regressions list <regressions@lists.linux.dev>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>,
          Linux regressions mailing list 
          <regressions@lists.linux.dev>
References: <5fa67291-98d0-c8d5-ca71-5a86b9adff41@leemhuis.info>
In-Reply-To: <5fa67291-98d0-c8d5-ca71-5a86b9adff41@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1682150954;660c1b54;
X-HE-SMSGID: 1pq8Iy-0005eX-Sj
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lo!

On 21.04.23 11:11, Linux regression tracking (Thorsten Leemhuis) wrote:
> 
> Bastien, from the bug report it to me sounds like it might be another
> case caused by 908d325e166 ("HID: logitech-hidpp: Detect hi-res
> scrolling support"), but I might be totally wrong with that (and the
> reporter didn't even explicitly state that it's a regression, but it
> sounds like one). If I got something wrong I apologize in advance.
> 
> Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=217353 :

Ignore that mail, user in between noticed it's a userspace problem.
Sorry for the noise.

#regzbot resolved: userspace problem according to the reporter
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.




