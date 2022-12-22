Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FEAC653EF6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 12:21:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235564AbiLVLVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 06:21:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235544AbiLVLUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 06:20:34 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28562934E
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 03:20:00 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1p8JcD-00070o-D6; Thu, 22 Dec 2022 12:19:57 +0100
Message-ID: <0bee316d-8b9c-055b-4fdc-0abd151799d7@leemhuis.info>
Date:   Thu, 22 Dec 2022 12:19:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: regression: nfs mount (even idle) eventually hangs server
 #forregzbot
Content-Language: en-US, de-DE
To:     LKML <linux-kernel@vger.kernel.org>
References: <65ed34338c69cb034295f2c9cbe0af684d65d30f.camel@gmx.de>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     "regressions@lists.linux.dev" <regressions@lists.linux.dev>
In-Reply-To: <65ed34338c69cb034295f2c9cbe0af684d65d30f.camel@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1671708000;83b2292b;
X-HE-SMSGID: 1p8JcD-00070o-D6
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Note: this mail contains only information for Linux kernel regression
tracking. Mails like these contain '#forregzbot' in the subject to make
then easy to spot and filter out. The author also tried to remove most
or all individuals from the list of recipients to spare them the hassle.]

On 21.12.22 09:59, Mike Galbraith wrote:
> scenario: /home/mikeg of desktop box mounted by lappy, lappy sitting
> idle with user mikeg not even logged in.  Reclaim inducing activity on
> desktop box eventually leads to spew below.  I've hung the box three
> times in two days, twice with light client side activity, and below
> with none, ie with the mount point allegedly merely existing. Sans nfs
> mount, box seems perfectly fine. 6.1 didn't reproduce either, so it
> would appear to be a merge window bug.

Thanks for the report. To be sure below issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, my Linux kernel regression
tracking bot:

#regzbot ^introduced v5.19..v6.0
#regzbot title nfs: mount (even idle) eventually hangs server
#regzbot ignore-activity

From later in the thread it seems it unclear when it's started, for
tracking just go with Chuck's assumption

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.
