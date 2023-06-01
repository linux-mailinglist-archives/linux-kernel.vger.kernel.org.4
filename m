Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 922E071930C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 08:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbjFAGPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 02:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbjFAGPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 02:15:00 -0400
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 821CCE2;
        Wed, 31 May 2023 23:14:58 -0700 (PDT)
Received: from [192.168.0.2] (ip5f5aef03.dynamic.kabel-deutschland.de [95.90.239.3])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 3AB5E61E4052B;
        Thu,  1 Jun 2023 08:14:15 +0200 (CEST)
Message-ID: <15af2a2f-2235-b9c5-b104-a09836f11dd9@molgen.mpg.de>
Date:   Thu, 1 Jun 2023 08:14:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [Intel-wired-lan] [PATCH] igb: Fix extts capture value format for
 82580/i354/i350
Content-Language: en-US
To:     Egg Car <eggcar.luan@gmail.com>
Cc:     jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
References: <20230531090805.3959-1-eggcar.luan@gmail.com>
 <92180324-fa55-5427-839e-d555ac5a6cd7@molgen.mpg.de>
 <CACMC4jY=c8kBwxRjLL++ro=Zz1O54h5Y6ADU6x+46pgN8XhkpA@mail.gmail.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <CACMC4jY=c8kBwxRjLL++ro=Zz1O54h5Y6ADU6x+46pgN8XhkpA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Dear Egg,


Thank you for your reply.

Am 01.06.23 um 07:55 schrieb egg car:

>> It’d be great, if you added a paragraph how to reproduce the
>> issue.
> 
> I have tested an i350 NIC with a 1PPS signal input to a SDP pin,
> running 'ts2phc' program from linuxptp project, and found that the
> 1PPS timestamps reading out are raw register value in resolution of
> 1ns and a maximum range of 2^40 ns, thus about 1099 s. It was
> supposed to be in TAI timestamp format.
> 
> Sorry I'm new to kernel development, should I make a new patch to add
> a paragraph in the commit information?

There is no hard rule about it, but I would appreciate it. In the end,
it’s the maintainers’ decision. You can amend the commit, and then 
regenerate the patch with `git format-patch -1 -v2`. Below the --- line 
you can add a short change-log, what you changed between the patch 
iterations.

>> I do not see the variable *flags* being used.
> 
> This patch has a typo, please ignore this one, I have submitted a new one
> that fixed this.

I have not seen this yet.

> I have tested the patch on a Ubuntu server 22.04 machine with kernel 
> version 5.19.17, then I generated the patch in the 'net-queue'
> development repo. I just handwritten the changes in the dev repo,
> made a silly mistake.
> 
> Apolot8ze for that, I'll be more careful next time.
No problem. This has happened to all of us. Congratulations on your 
first(?) Linux kernel contribution. Glad to have you and I am looking 
forward to your next improvements.


Kind regards,

Paul
