Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 788C45BC61B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 12:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiISKL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 06:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbiISKLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 06:11:52 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D9518E3D;
        Mon, 19 Sep 2022 03:11:48 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1oaDkg-0003PC-Oo; Mon, 19 Sep 2022 12:11:46 +0200
Message-ID: <b58be19a-7fa7-8b19-2f89-ed50056c5042@leemhuis.info>
Date:   Mon, 19 Sep 2022 12:11:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Content-Language: en-US, de-DE
From:   Thorsten Leemhuis <regressions@leemhuis.info>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     amirali <nasrollahiamirali@gmail.com>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: [regression] Bug 216479 - systems hangs after "kvm : exiting hardware
 virtualization" during reboot or shutdown
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1663582308;6242ded6;
X-HE-SMSGID: 1oaDkg-0003PC-Oo
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this is your Linux kernel regression tracker speaking.

I noticed a regression report in bugzilla.kernel.org. As many (most?)
kernel developer don't keep an eye on it, I decided to forward it by
mail. Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=216479 :

>  amirali 2022-09-13 13:08:44 UTC
> 
> hello
> i have a problem when kernels updated from 5.17 to 5.18 in my arch , my pc show this error or better says show report that it is prevent to power offing system
> 
> like this, i have same page when system to be reboot or shutdown => https://i.redd.it/ukqi6q6f8on41.jpg
> 
> even i have this problem in a new kernel (5.19) and in other distro.
> 
> This means that there is a problem with the kernel
> I don't have the technical knowledge of this matter, but I just know that I can't use the new versions of Linux
> 
> [reply] [−] Comment 1 amirali 2022-09-13 13:12:49 UTC
> 
> my system config is => 
> intel core i7 gen 10
> gpu => 2Gig amd readon and intel onboard
> 

See the ticket for more details. I chose to forward this to the power
management developers, as I assume the "kvm: exiting hardware
virtualization" is simply the last thing that's printed. Hope that
wasn't a stupid assumption.

BTW, let me use this mail to also add the report to the list of tracked
regressions to ensure it's doesn't fall through the cracks:

#regzbot introduced: v5.17..v5.18
https://bugzilla.kernel.org/show_bug.cgi?id=216479
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.
