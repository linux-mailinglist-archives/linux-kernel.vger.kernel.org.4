Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 077D266B768
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 07:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbjAPGZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 01:25:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbjAPGZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 01:25:36 -0500
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5A3A270
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 22:25:34 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 0A108604F9;
        Mon, 16 Jan 2023 07:25:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1673850331; bh=4fyHc5VOsAd1432QK4qzvuO7WekTB/cFYJQKucHWvx4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=dQujljGnKPVXpBXow3AzaNtOWQzeQHTipo3m/9Qn2eavQD03LN3Jy0Ks5LEtYd8NG
         d5bHIGu1Ua+dLFb1sbCnKKv3Vav5ngRWYyWNsjvvVR1Snqi2IKy2jTU9oQNkKOnUY6
         Opee4OSLG7KSvHOXWsdFnn3/Xf+wSELYAc7zONIvT0w+SPeV5BoQpxJstye/Z5r5ol
         Tw3uG83cGbpUfKKhTvyTymkAIEdbyMmGexmFzN2fYaO6uIgmGWPGtJhCTGjaI6iURC
         co9bIf2ekcBdrUMyrdgREuQ0Fej/MHYWEgNxY1CX89denzUPKSbBXjFKSvIf3c0HNT
         ae7Rp9hKw+yRw==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0HF83dSFYgza; Mon, 16 Jan 2023 07:25:28 +0100 (CET)
Received: from [193.198.186.200] (pc-mtodorov.slava.alu.hr [193.198.186.200])
        by domac.alu.hr (Postfix) with ESMTPSA id D726A604F3;
        Mon, 16 Jan 2023 07:25:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1673850328; bh=4fyHc5VOsAd1432QK4qzvuO7WekTB/cFYJQKucHWvx4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=UYe0RUiZKBhIFc5CKLM5dzC04dG+P1VPNX+uL5sw6RH1MFmxiUB55Tzia7VWHEycq
         TqsBDt/SGgrob9260TAsU9oUjFtxIcSru+rMnObc3h57Cwpq+k4Lhyg+R+XO2Sz5FD
         ZmZRoWZd67GdHMfi9Wmud1q2lY4gQXIZI9kRR5dBaoTfEL8k9L1Ds/F6/b6Y9dVXBb
         YGgKCXhH7+r+DSkjOL+gAZ2iz9MjIFV9N3zwIB5MccUqr4ZCnpD6xO32DUV2XfTZgD
         0NXidwgeA4XxeMpkUm4MJM0fDwo8Ckrqr8wf1JScwCfYV45XfIeVwtiGWSN9pWfm/a
         YPy9+muGth+Ig==
Message-ID: <88aefaa2-8979-12e6-ee1e-5f770ccecaf7@alu.unizg.hr>
Date:   Mon, 16 Jan 2023 07:25:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: LOOKS GOOD: Possible regression in drm/i915 driver: memleak
To:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        intel-gfx@lists.freedesktop.org
References: <f849cc70-b21f-6476-ba26-08989d1243c2@alu.unizg.hr>
 <05424a5351a847786377a548dba0759917d8046c.camel@linux.intel.com>
 <15ef1bb9-7312-5d98-8bf0-0af1a37cfd2a@linux.intel.com>
 <619bdecc-cf87-60a4-f50d-836f4c073ea7@alu.unizg.hr>
 <8e080674-36ab-9260-046e-f4e3c931a3b9@alu.unizg.hr>
 <96661293-32d7-0bb4-fb0e-28086eaaecc3@linux.intel.com>
 <edab9da6-df81-7167-acdd-f2ea22c7ed90@alu.unizg.hr>
 <9c86dff0-e7f4-60b9-ed3e-6ad51cacaa01@linux.intel.com>
Content-Language: en-US, hr
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <9c86dff0-e7f4-60b9-ed3e-6ad51cacaa01@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/9/23 16:00, Tvrtko Ursulin wrote:
> 
> On 25/12/2022 22:48, Mirsad Goran Todorovac wrote:
>> On 22. 12. 2022. 09:04, Tvrtko Ursulin wrote:
>>>
>>> In the meantime definitely thanks a lot for testing this quickly and reporting back!
>>
>> Don't think much of it - anyone with CONFIG_KMEMLEAK enabled could have caught this bug.
>>
>> I was surprised that you found the fix in less than an hour without me having to bisect :)
> 
> Fix sadly has a problem handling shared buffers so different version will hopefully appear soon.

Bummer.

Ready to test the new version in the same environment.

-- 
Mirsad Goran Todorovac
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu

System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb, Republic of Croatia
