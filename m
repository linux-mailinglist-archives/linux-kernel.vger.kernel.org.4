Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29D0A6010A7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 15:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbiJQN7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 09:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbiJQN7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 09:59:42 -0400
Received: from p3plwbeout21-06.prod.phx3.secureserver.net (p3plsmtp21-06-2.prod.phx3.secureserver.net [68.178.252.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2917115826
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 06:59:36 -0700 (PDT)
Received: from mailex.mailcore.me ([94.136.40.142])
        by :WBEOUT: with ESMTP
        id kQeVouKSUuLoYkQeVovcMh; Mon, 17 Oct 2022 06:59:36 -0700
X-CMAE-Analysis: v=2.4 cv=ftAZ2H0f c=1 sm=1 tr=0 ts=634d5fc8
 a=s1hRAmXuQnGNrIj+3lWWVA==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=ggZhUymU-5wA:10 a=IkcTkHD0fZMA:10 a=Qawa6l4ZSaYA:10
 a=fpeuKshbL5jpNNzCeCIA:9 a=QEXdDO2ut3YA:10
X-SECURESERVER-ACCT: phillip@squashfs.org.uk  
X-SID:  kQeVouKSUuLoY
Received: from 82-69-79-175.dsl.in-addr.zen.co.uk ([82.69.79.175] helo=[192.168.178.33])
        by smtp13.mailcore.me with esmtpa (Exim 4.94.2)
        (envelope-from <phillip@squashfs.org.uk>)
        id 1okQeU-0001Qg-EZ; Mon, 17 Oct 2022 14:59:34 +0100
Message-ID: <e6a42b36-aed0-88a0-4a9e-d042aa7f990a@squashfs.org.uk>
Date:   Mon, 17 Oct 2022 14:59:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: BISECT result: 6.0.0-RC kernels trigger Firefox snap bug with
 6.0.0-rc3 through 6.0.0-rc7
To:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
        regressions@leemhuis.info
Cc:     bagasdotme@gmail.com, linux-kernel@vger.kernel.org,
        marcmiltenberger@gmail.com, regressions@lists.linux.dev,
        srw@sladewatkins.net, phillip.lougher@gmail.com
References: <8702a833-e66c-e63a-bfc8-1007174c5b3d@leemhuis.info>
 <20221015205936.5735-1-phillip@squashfs.org.uk>
 <ff2b901d-9491-c886-5330-a244101978ab@alu.unizg.hr>
 <b71f4e2d-23bb-3eb4-3928-fe66c4357e5b@squashfs.org.uk>
 <cdf16572-1206-50b8-1ffe-48746cde00a4@alu.unizg.hr>
From:   Phillip Lougher <phillip@squashfs.org.uk>
In-Reply-To: <cdf16572-1206-50b8-1ffe-48746cde00a4@alu.unizg.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailcore-Auth: 439999529
X-Mailcore-Domain: 1394945
X-123-reg-Authenticated:  phillip@squashfs.org.uk  
X-Originating-IP: 82.69.79.175
X-CMAE-Envelope: MS4xfAAZ+fWKmkx/H2fpUcMAAZF+LmU+ELJxPKXBTcQA5AstmXSbb9uFTfl6A8Bup2yVNgNfA+d7A24VJz5hZRrChOljU1YRXAKtWWumrzyzh1F3b/XF5Tv2
 J0fvk7gpF0zRPOQlpx0iAqBZ59rH43KPeKURuEwUckNb2Sj7vbdrLVXLxBxsOjj6uAD81Nxrx7QarOjhg8/WkCxe2qd4DulTdf0=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/10/2022 14:22, Mirsad Goran Todorovac wrote:
> 
> On 16.10.2022. 21:55, Phillip Lougher wrote:
>> On 16/10/2022 16:55, Mirsad Goran Todorovac wrote:
>>> On 15. 10. 2022. 22:59, Phillip Lougher wrote:
>>
>> Tracking down bugs of this sort is always a process of elimination,
>> and gathering information to pinpoint the exact circumstances of why
>> it is triggering.
>>
>> Next step is to download the exact snap(s) where the problems are 
>> occurring, as this may provide some insights.
>>
>> I don't run Ubuntu, and I don't use snaps.  Can you provide the
>> download link(s) of the snap(s) that cause problems?  If there's
>> any firefox snaps that don't cause problems those will be useful
>> too.
>>
>> You don't mention if there's any errors present in "dmesg" when
>> this happens, and so I'm assuming there aren't any?
>>
>> Phillip
> 
> Snaps are originated in Ubuntu, and they heavily rely on snapd, and 
> squashfs for decompressing executables.
> Naturally, this also affects Linux Mint as Ubuntu's fork.
> 
> Those two comprise a large share of the Linux distros, and Firefox is 
> exclusively distributed in snaps.

I know you meant well, but, don't talk to me as if I'm the village
idiot.

I said I don't run snaps or Ubuntu, which is nothing to do with lack of
understanding (*)

I'll contact a couple of people in Canonical to obtain what I need.

(*) I worked as a kernel maintainer for Canonical (Ubuntu) from 2007/8
and I worked as a kernel maintainer for Redhat on RHEL (which Centos
is a free version) from 2011 - 2019.  This is addition to writing and
maintaining Squashfs in the upstream kernel.


