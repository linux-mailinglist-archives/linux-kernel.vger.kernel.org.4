Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 658116F4F82
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 06:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjECEqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 00:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjECEqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 00:46:23 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 114101FF9
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 21:46:22 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pu4Ng-0007IN-0A; Wed, 03 May 2023 06:46:20 +0200
Message-ID: <ebb280e4-d381-0bf8-d134-0318c5cfdf83@leemhuis.info>
Date:   Wed, 3 May 2023 06:46:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Hang loading initrd since last Friday.
Content-Language: en-US, de-DE
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Ben Greear <greearb@candelatech.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>
References: <9d87defc-5376-d690-b483-bc314e4f568b@candelatech.com>
 <ZFHHh/m0pkOYIzo7@debian.me>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <ZFHHh/m0pkOYIzo7@debian.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1683089182;c7db01d3;
X-HE-SMSGID: 1pu4Ng-0007IN-0A
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.05.23 04:31, Bagas Sanjaya wrote:
> On Tue, May 02, 2023 at 02:03:33PM -0700, Ben Greear wrote:
>>
>> Pulling today's upstream 6.3+ tree, my system now hangs loading initrd.

Just to understand this properly: you mean after the boot loader said it
loaded the initramfs, not when the kernel starts using it?

>>  Nothing useful is seen on
>> serial console after that.  This was working late last week.  Other older kernels boot OK, so
>> I think is is related to the kernel.
> 
> What is your setup (especially kernel config)?
> 
> Is v6.3 works for you? I haven't seen this regression on my computer
> using v6.3.

Ben, you just to be sure might want to check if a kernel image that
currently works still boots if you regenerate its initramfs: maybe the
initramfs generator or something it uses changed recently and is causing
your problem. I've seen a case or two where that was the case.

>> I have not yet started bisect, curious if this is already know problem.
> Certainly you should try bisection.

Yeah.

BTW: What kind of platform is this?

Ciao, Thorsten
