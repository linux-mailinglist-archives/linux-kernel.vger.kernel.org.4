Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6CD7655E4D
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Dec 2022 22:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbiLYVLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Dec 2022 16:11:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiLYVLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Dec 2022 16:11:48 -0500
Received: from domac.alu.hr (domac.alu.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC1225C5
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 13:11:46 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id D2EDF604F1;
        Sun, 25 Dec 2022 22:11:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1672002702; bh=7XAQuOpTkk04qwhyYlhxpDR5QWSb0hnYhMAf3LhBBq8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=tRqG2xDEgG4JAp4iUCDwi429V7yn9nuKA0vyERNfqktEFk2isrx/EdCctlntp0Hlt
         AWScxLAEHUmFckzb/UPRPzoHepxbxE689hHGT2AJFTcdMqHxPeX1t50nMpYfZ/R8Am
         9ySfmcd1JOdt8KgQTP2LbFMf6uk2qf1dqG586SSk1iBFuRAw/z0Ve8+CH1pNIVPIPO
         /yieHmG6BQkUfhf9yY0Swx0GmQwAoNol1PshNIP/nXY+R+q6x2tM+Enh0SyOdSn2KP
         yoxHHdOp97cUQNSAVSO29nLToIWP6X0Lo0bFev9+7m9aWY6N9aXO68r2MBeseEOIhq
         XHK/71uCtDLvQ==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ehGeV4IUWZcc; Sun, 25 Dec 2022 22:11:40 +0100 (CET)
Received: from [192.168.0.12] (unknown [188.252.198.170])
        by domac.alu.hr (Postfix) with ESMTPSA id DFA5E604F0;
        Sun, 25 Dec 2022 22:11:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1672002700; bh=7XAQuOpTkk04qwhyYlhxpDR5QWSb0hnYhMAf3LhBBq8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=od3K+iEDNmf81yDPaSiN1AB7r1nU8V2DBO9h4pO26HnHHBz6Ag1FRPxuX6qzXzT9+
         3StENUVTkISqcd1jnYb5SWkxSt2V7a6MUZ2Fs7uVXm0ySL50t3wrlbTDpVh41b2gVO
         P6ulcVmuhqdqCVOpCGsCZomgmaOMWownw7iEwWBOJLdI0U3PuuQ8In/39UydhrPcRw
         ps10ncJFWBfmDolZH4v7uTDVPVkwS3iE3lNuohbAAOzLLSDUfR69UDTLJw/q/qT60X
         oZr8Uu2hj1VDNxtioO/lRb5sSci1IGW0VJV8HsBmfV3YME/ONMg+of1Tt6xidDqlF6
         9iolBxrRoKLWQ==
Message-ID: <a8eeae5d-60ee-fad7-47ea-31fcd381d516@alu.unizg.hr>
Date:   Sun, 25 Dec 2022 22:11:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
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
 <d8d62c8a-32e0-9975-5ed5-b832bb8df549@alu.unizg.hr>
 <0095266f-1422-8be6-f4ac-5e561da1165a@linux.intel.com>
Content-Language: en-US
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <0095266f-1422-8be6-f4ac-5e561da1165a@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23. 12. 2022. 13:18, Tvrtko Ursulin wrote:
> 

>>> It is not forgotten - I was trying to reach out to the original author of the fixlet which worked for you. If that fails I will 
>>> take it up on myself, but need to set aside some time to get into the exact problem space before I can vouch for the fix and send 
>>> it on my own.

>> That's good news. Possibly with some assistance I could bisect on pre 4.16 kernels with the additional drivers.
> 
> Sorry, maybe I am confused, but from where does 4.16 come?

Sorry, I forgot to refer to the memstick_check() memleak in drivers/memstick/core/memstick.c,
also discovered through CONFIG_KMEMLEAK=y option enabled.

The 4.16 is the last kernel I managed to start on my Lenovo desktop box which only reproduced
the memstick_check() leak.

Needless to say, this is not a i915-related bug.

Sorry for imprecision in my paragraph.

Regards,
Mirsad

--
Mirsad Goran Todorovac
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu
-- 
System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb, Republic of Croatia
The European Union

