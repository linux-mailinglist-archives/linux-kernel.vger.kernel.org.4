Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE26A5F0B0F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 13:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiI3LwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 07:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbiI3Lvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 07:51:44 -0400
X-Greylist: delayed 393 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 30 Sep 2022 04:50:45 PDT
Received: from domac.alu.hr (domac.alu.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A79CAE31B6
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 04:50:45 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id D59A8604F7;
        Fri, 30 Sep 2022 13:44:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.hr; s=mail;
        t=1664538250; bh=DQVD5irSEqLKQjGDxVLYTtyWgdNpYFkJYP0kLe/mzw8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=fzhJSGA7OFrcoQ5DkNyeQSiwrgEoCdllv76gdhBFoKsm1i+VFi72a+JgFKZQl4FEg
         eq7VTfPdZfTWO6igBED0AC8/pT812FyjZCIdpXzr5WIXbwHxWhDyfFnKNbjuDqgShj
         TtVFA3N6BEahdV/WR3U8s6GSYYYxbf6WOpg5LWF/Wfu3hoGHf7VV56aR2WKX65V1cH
         MSAUmgWuoAlHcrXJzgjHhlMSkGeFHJcB52rjg6AdM+4emS5NstvlYLkx0rQaRAggv0
         fbMpgVkhgDFIiVh5OuOYl/0n8SfuiexHHqgp0sPAkGEFaW3ro94eEjbdOaeBH4RFPk
         8f3XGEzGNq5RQ==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ee-n8xRgLOHM; Fri, 30 Sep 2022 13:44:08 +0200 (CEST)
Received: from [193.198.186.200] (PC-MTODOROV.slava.alu.hr [193.198.186.200])
        by domac.alu.hr (Postfix) with ESMTPSA id ADC7A604F5;
        Fri, 30 Sep 2022 13:44:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.hr; s=mail;
        t=1664538248; bh=DQVD5irSEqLKQjGDxVLYTtyWgdNpYFkJYP0kLe/mzw8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=HNhPSIp5dJOWvGY8Y3lu6FsrpDB+131VfI1VWr726qdmDiYtOksvCcAboz02ov2xJ
         sRYaZ66RTC0NVAt4aFBlqFWF2eG/p9otkT2eOItD/7nZGEmN3j3TZMRIaKIUBHoWHG
         tnDmLmEykj4FAltAOPwt9f/U5whnjyEKMY4R5jFmFyhzOyNqiQ6rTcTOK5DlVg2awB
         5c8vUfMerW/6kmfhazMrDajLa35pdgvcz75ZGbSj9QFPeSBPrsJ1nzUtXhpHcurUqi
         pTi0FfFNrR19lKmRtPkZkss7B4VQfc+HvJ5uZCqtkBnY7C7ct2kbfCXUCh4KCE+N7E
         XRUr3NthpU9VQ==
Message-ID: <77bc5046-7b69-6100-f991-60b4d53994ee@alu.hr>
Date:   Fri, 30 Sep 2022 13:44:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: BUG: 6.0.0-RC kernels trigger Firefox snap bug with 6.0.0-rc3
 through 6.0.0-rc7
To:     Slade Watkins <srw@sladewatkins.net>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <b0c258c3-6dcf-aade-efc4-d62a8b3a1ce2@alu.unizg.hr>
 <1266113f-75a1-b276-bb8c-3cdfcbabf043@alu.unizg.hr>
 <47CFBECB-AE3D-4252-972D-933D2DF4A8EB@sladewatkins.net>
Content-Language: en-US
From:   Mirsad Todorovac <mirsad.todorovac@alu.hr>
In-Reply-To: <47CFBECB-AE3D-4252-972D-933D2DF4A8EB@sladewatkins.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/30/2022 1:21 PM, Slade Watkins wrote:
> Hi,
>
>> On Sep 30, 2022, at 6:48 AM, Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr> wrote:
>>
>> Hi all,
>>
>> I can confirm this bug also on AlmaLinux (CentOS fork) with snapd version 105.0.1 of
>> Firefox.
>>
>> After some time, tabs started crashing, but restarting Firefox binary was after that
>> unsuccessful, giving the message:
>>
>> [marvin@pc-mtodorov ~]$ /snap/bin/firefox &
>> [1] 137734
>> [marvin@pc-mtodorov ~]$ /bin/bash: /lib/x86_64-linux-gnu/libdl.so.2: unsupported version 0 of Verdef record
>> /bin/bash: error while loading shared libraries: /lib/x86_64-linux-gnu/libdl.so.2: unsupported version 0 of Verneed record
>>
>> [1]+  Exit 127                /snap/bin/firefox
>> [marvin@pc-mtodorov ~]$
> Did you report this to the folks at Mozilla?
>
> Best,
>
> -srw

Hi Slade,

Thank you for your message.

No, I did not think that it was a problem with Firefox snap build 104.x 
or 105.0.1, because with the
older 5.19.x line of kernels it works perfectly, without any crashed 
tabs or refusing to start.

After a reboot of OS, Firefox works again, but only for a stochastic, 
undetermined amount of time.
Once it gets "Tabs crashed" errors, it is impossible to restart until 
the next reboot.

The non-snap Firefox 91.x esr so far did not exhibit this problem, but 
the testing results are insufficient.

Kind regards,
mt

-- 
Mirsad Todorovac
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu
--
System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb, Republic of Croatia
tel. +385 (0)1 3711 451
mob. +385 91 57 88 355

