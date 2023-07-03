Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32D697455B6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 09:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbjGCHEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 03:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbjGCHED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 03:04:03 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A63D1;
        Mon,  3 Jul 2023 00:04:00 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id EAF6E60174;
        Mon,  3 Jul 2023 09:03:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1688367827; bh=fTkNvNkC3bfADJTtHrYMWZPvdHPtIONvisUsl8eELX4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GraudTOQKeqXAqjbHkfZyD0UDKV1F87M/pxF8SVONRpI3+BFrbr/foqDs770cS2rK
         nfacrS9b8bqYrGt3K6O3eAPrI8RQknKy6M5jAgXnzU2BhD2T+mq3MVSJk90y8jv78Z
         TCeWCSnPrZNgXZPvUgcyMp6GEveJEcq4pfX/3LDwOHrf44a19m/kkAAaQcifbyiwNX
         qcPA6UrcXPrNkv0A5UTHVwBnTC0R4kpIryzbei6x+QiUp/jtEIQIK0jU6M+/7f4yzw
         MwgDNfjVx3HsGOURR+kul/xlcQeQjjdBGjgzH4w8IO0BGsR7Q/WXhvZpBVj992WJCA
         MbOaqSnvtDl0A==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id BcVV5PcK91mB; Mon,  3 Jul 2023 09:03:45 +0200 (CEST)
Received: from [10.0.2.76] (grf-nat.grf.hr [161.53.83.23])
        by domac.alu.hr (Postfix) with ESMTPSA id DEC9E60173;
        Mon,  3 Jul 2023 09:03:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1688367825; bh=fTkNvNkC3bfADJTtHrYMWZPvdHPtIONvisUsl8eELX4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=x9zfkzo8tnfYDsWS8YCC5k1UW5CLJwCXhRt6CWRfT/P2DL+gjDYXJOdPzea3+QcjI
         H7h2mMVEN5QysCdGAZHSn56iLXcam5NEShN1uxuRKISAxQ/G+Mf5uwWxMPyybc6gKg
         NXwHWX5flheEB5teyvGloa9/HCNjsZ30W4eDJqF89eaNmwW7dHEueTNME5SLbqy4OJ
         POcomGS+dpnLNF80kf9Ld/yG1E3K82iQMLV0jTvypjvRoNA10O+e8/qUy148oGHEid
         vzgWtQXjt03lsVXVqB/k3HRzkNIBNtEvK2E63fkRcxhvpVv+t6vWStfkijwGnXh0Aw
         yZkRh6swc/akw==
Message-ID: <ed3e4315-b149-2f9e-70d4-45d7f83b9922@alu.unizg.hr>
Date:   Mon, 3 Jul 2023 09:03:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [CRASH][BISECTED] 6.4.1 crash in boot
To:     Kees Cook <keescook@chromium.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux LLVM <llvm@lists.linux.dev>,
        linux-kbuild@vger.kernel.org,
        Linux Regressions <regressions@lists.linux.dev>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
References: <9a8e34ad-8a8b-3830-4878-3c2c82e69dd9@alu.unizg.hr>
 <ZKIoBVzrjZ+Ybxy9@debian.me> <202307022018.B26F5795@keescook>
 <625e951e-9922-d15d-5520-e8cd5eba1995@roeck-us.net>
 <4fa56264-f188-46f9-cc77-117b469b3328@roeck-us.net>
 <2b1a4f49-ba18-0246-af09-4e4133814411@alu.unizg.hr>
 <202307022230.6121D6896@keescook>
Content-Language: en-US, hr
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <202307022230.6121D6896@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3.7.2023. 7:41, Kees Cook wrote:
> On Mon, Jul 03, 2023 at 07:18:57AM +0200, Mirsad Goran Todorovac wrote:
>> I apologise for confusion. In fact, I have cloned the Torvalds tree after
>> 6.4.1 was released, but I actually cloned the Torvalds tree, not the 6.4.1
>> from the stable branch as the Subject line might have misled.
> 
> Thanks, no worries! I got myself confused too. :)
> 
> The config you sent looks like I'd expect now too. Questions for you, if
> you have time to diagnose further:
> 
> - Are you able to catch the very beginning of the crash, where the Oops
>    starts?

It scrolls up very quickly. Couldn't catch that with the camera.

> - Does pstore work for you to catch the crash?

Haven't tried that yet. I will have to do some homework.

> - Can you try booting with this patch applied?
>    https://lore.kernel.org/lkml/20230629190900.never.787-kees@kernel.org/

Sure, but after 4 PM UTC+02 I suppose.

> I'll try to see if I can figure out anything more from the images you
> posted.

I really couldn't figure out myself what went wrong with this one?

Best regards,
Mirsad Todorovac


