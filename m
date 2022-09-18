Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA9315BBDBE
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 14:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbiIRMSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 08:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbiIRMR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 08:17:56 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A240426ACF;
        Sun, 18 Sep 2022 05:17:52 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1oZtF8-0000lT-4T; Sun, 18 Sep 2022 14:17:50 +0200
Message-ID: <4deaa04b-f103-9cc4-7946-9ea69afd94d0@leemhuis.info>
Date:   Sun, 18 Sep 2022 14:17:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Content-Language: en-US, de-DE
Cc:     Mikhail Rudenko <mike.rudenko@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Eric Biggers <ebiggers@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        linux-crypto@vger.kernel.org
From:   Thorsten Leemhuis <regressions@leemhuis.info>
Subject: [REGESSION] Bug 216502 - slow crng initialization on Rockchip 3399
 (Friendyarm NanoPi M4)
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1663503472;61b6c5f6;
X-HE-SMSGID: 1oZtF8-0000lT-4T
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this is your Linux kernel regression tracker speaking.

I noticed a regression report in bugzilla.kernel.org. As many (most?)
kernel developer don't keep an eye on it, I decided to forward it my
mail. Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=216502 :

> Crng initialization time has significantly increased on Rockchip
> 3399-based Friendyarm NanoPi M4 in v6.0.0-rc5 compared to v5.18.0 (from
> 2.36s since rootfs mounted to 8.55s since rootfs mounted). Bisection
> points at 78c768e619fb ("random: vary jitter iterations based on cycle
> counter speed"). Manually reverting that commit on top of v6.0.0-rc5
> fixes the issue. Attached dmesg logs correspond to vanilla v6.0.0-rc5
> ("bad") and v6.0.0-rc5 with 78c768e619fb reverted ("good").
See the ticket for more details. Apologies if I forwarded it to the
wrong folks, I cover a lot of ground and thus sometimes get things
wrong. :-/

BTW, I'd also like to add the report to the list of tracked regressions
to ensure it's doesn't fall through the cracks in the end:

#regzbot introduced: 78c768e619fb
https://bugzilla.kernel.org/show_bug.cgi?id=216502
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.
