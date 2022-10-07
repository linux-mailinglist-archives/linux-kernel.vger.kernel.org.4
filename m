Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD2695F771C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 12:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbiJGKzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 06:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiJGKzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 06:55:37 -0400
Received: from domac.alu.hr (domac.alu.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C36F61D9D
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 03:55:34 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 353636050A;
        Fri,  7 Oct 2022 12:55:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1665140132; bh=bXvdXMnm+InQRtRTG5bHcIKbt083Dd6570UwomJFk+M=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=d1FFpSRPyzksCpwfuMq5drYd4mDjg3p87EpfvXe3+dz36JRI5+rHhfKyw+gl5FleU
         jCpCcZsAJ2sK5YvDNWJUSxnuPSFNBJgego8vpsO0UDdluLMtqYFjYaZoLtGL9SWRCz
         tqlPtXUMOUll62zOaKtiVM0Hqqdnf7JlpziRZKKzYo4hHIsR3aY8lGi5bpGCQ/SzM2
         lUulVAns6pPdzq5/wefQJA6kx57Kur8maj6A+00XtJ6L78u/GHeWzuQs3M/EV191se
         uTgEBO246hTyGXwQDFqDlaU3GsSEaIvT8fTUzYe9jsMSqciHZ0tmmXICIGua4nc98Z
         rCAdhK24BR05Q==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id GDiupqYoVugF; Fri,  7 Oct 2022 12:55:30 +0200 (CEST)
Received: from [161.53.83.51] (pc-mtodorov.grf.hr [161.53.83.51])
        by domac.alu.hr (Postfix) with ESMTPSA id AFC556050E;
        Fri,  7 Oct 2022 12:55:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1665140130; bh=bXvdXMnm+InQRtRTG5bHcIKbt083Dd6570UwomJFk+M=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=xnjrEytFa38upDowIVzbcwUWrEUDarRqHd3J92kL9BShErryEAfktw1ET4DTpJIdF
         lAVigPH3k1M0LH39mM00Rd7MuMv0uZdBWYZi4xBJ6p0+DWtjO2eNf7pREq+ajArkEo
         O9jF2EMYgykjo5tO25+mK9Hzl0OiILombnekpG1o5vlI/QPBdZZ8LKEoY8+iSPozLE
         5FrqJQtuSAkPxYSHEclBKgBt0jCITAm4CWoqt4ZhHAkKvUKMdkb2aZMAsc1GI54+qL
         5lp5pZAsCTvRqoT1KY7m51YfrZRLHGD2THaQSJ76Qage+eFJDXYBfgCLlalMATq0qt
         YBvF6as8aPaFQ==
Message-ID: <f05158fe-50fd-fe95-70e7-3bcf42717099@alu.unizg.hr>
Date:   Fri, 7 Oct 2022 12:55:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: BUG: 6.0.0-RC kernels trigger Firefox snap bug with 6.0.0-rc3
 through 6.0.0-rc7
Content-Language: en-US
To:     Slade Watkins <srw@sladewatkins.net>
Cc:     LKML <linux-kernel@vger.kernel.org>, regressions@lists.linux.dev,
        regressions@leemhuis.info
References: <b0c258c3-6dcf-aade-efc4-d62a8b3a1ce2@alu.unizg.hr>
 <1266113f-75a1-b276-bb8c-3cdfcbabf043@alu.unizg.hr>
 <47CFBECB-AE3D-4252-972D-933D2DF4A8EB@sladewatkins.net>
 <77bc5046-7b69-6100-f991-60b4d53994ee@alu.hr>
 <0BD28445-7393-4153-B15C-59E5DA868E80@sladewatkins.net>
 <2F9EDCCA-AB85-44CE-AD9F-44394C8663B8@sladewatkins.net>
 <254f0b04-428e-cad8-02e3-0224b798b060@alu.unizg.hr>
 <43d5fd3c-dbe3-6090-8a56-c2ffb1f00e0d@sladewatkins.net>
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <43d5fd3c-dbe3-6090-8a56-c2ffb1f00e0d@sladewatkins.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Slate,

On 7.10.2022. 10:47, Slade Watkins wrote:
> Hey Mirsad,
>
> On 10/3/22 at 4:18 AM, Mirsad Goran Todorovac wrote:
>> I'm sorry you couldn't reproduce the bug. I will try to provide the list of the installed pkgs the
>> next time, for both configs
> So, I'm able to reproduce this now on Ubuntu 22.04 with 6.0 mainline. Unfortunately, I won't be able to bisect and send that info to Thorsten and the Regressions list until Monday afternoon most likely. Both are Cc'd on this update.

This is a very good peace of news.

To repeat for clarity, I made a build with Ubuntu's 
config-5.19.13-051913 and linux stable git pull from branch linux-6.0.y
and now it is running as I am trying to reproduce the bug as Thorsten 
recommended.

The bug usually isn't showing immediately, but after a couple of hours 
of running (especially with multimedia running inside Firefox).

It occurred also with FF 105.x snap on AlmaLinux with 6.0-rc7 mainline 
build, but not with 91.x esr version that runs from a rpm rather than snap.

Regards,
-mt

-- 
Mirsad Todorovac
System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb
Republic of Croatia, the European Union
--
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu

