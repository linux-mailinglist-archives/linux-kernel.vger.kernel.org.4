Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF30600549
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 04:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbiJQCmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 22:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231203AbiJQCmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 22:42:07 -0400
Received: from domac.alu.hr (domac.alu.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE29246201
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 19:42:05 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 2038E604EC;
        Mon, 17 Oct 2022 04:42:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1665974523; bh=erSoy5SaBxVryCw8k7y6X6+A9fdXZfKrQRCn6TGYkqY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=RgbBVm6eDpp5rMKOtWHuxBna08qipqb2iWMVaAZv2ND9DiuLpEtNcbTB8hlwQrHzS
         cRrlkSK9LIxT+URrw5dG/eTFKNi6Qbk0gbqIIeMHtaXY50zj/5us/5NqtR5/zxJWQs
         JGuU94335VrizUMuK0rpNclxgrygtc3el2qxgfIt/IG9y/azsNv62AIdtGHAJHFM+A
         1eie9s9loxsHsutq9JmHsAy2TE4seyAIKrF5S15DEE56KvyUL3DuvEqzMoQ0GVqJF2
         UOoDkIkfArR3ojrM36Hil9Q4uObo9M1ww1SAhXfrrYwQboATjmhepRrN+E1sMCgF18
         eGYMvBlB5DdPA==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id oGZEn_Q9rtPw; Mon, 17 Oct 2022 04:42:00 +0200 (CEST)
Received: from [192.168.0.12] (unknown [188.252.197.215])
        by domac.alu.hr (Postfix) with ESMTPSA id EDDF2604E6;
        Mon, 17 Oct 2022 04:41:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1665974520; bh=erSoy5SaBxVryCw8k7y6X6+A9fdXZfKrQRCn6TGYkqY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mWhy+4Xzd0dfseSPrSu9wyKxv/v6b1mMSkd4CU9+TjqKBT4+9UQ8h9CHFKXYQB0gp
         ms0rLOZzbmGHWvbivEVJMCXoqfl0ffE/MXYxp+enDzwFamI67yHEjPWAlhaKw0XpIT
         CfMItZiEaBXJU0IEko1hKUXOGMgu8G+1SMQmWBmaZoM9tPIcoC7CQn4juR6NWxswrZ
         p/X8Ix+dPWCm3AFf+hKeuwkrkUF6FERoTLFZO/SKczcBy33lxb/btqSsAVvqWLOmc2
         IYD3tKTH1Kk47pgg9fsYzuTuhLpiBxzQSMknESDwIVSuH7YvCRGEHs0yD1HJRXW5Zi
         tkwspAacyPqZw==
Message-ID: <b7aefbcb-0038-d044-a1ea-64ad5b4d8888@alu.unizg.hr>
Date:   Mon, 17 Oct 2022 04:41:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: BISECT result: 6.0.0-RC kernels trigger Firefox snap bug with
 6.0.0-rc3 through 6.0.0-rc7
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        regressions@leemhuis.info
Cc:     linux-kernel@vger.kernel.org, marcmiltenberger@gmail.com,
        regressions@lists.linux.dev, srw@sladewatkins.net,
        phillip.lougher@gmail.com
References: <8702a833-e66c-e63a-bfc8-1007174c5b3d@leemhuis.info>
 <20221015205936.5735-1-phillip@squashfs.org.uk>
 <ff2b901d-9491-c886-5330-a244101978ab@alu.unizg.hr>
 <b71f4e2d-23bb-3eb4-3928-fe66c4357e5b@squashfs.org.uk>
 <beba6259-6049-4f5b-6e54-a9c1faba0d5f@squashfs.org.uk>
 <32ee551f-5642-4efb-02a0-500e7c92be5f@gmail.com>
Content-Language: en-US
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <32ee551f-5642-4efb-02a0-500e7c92be5f@gmail.com>
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

On 17. 10. 2022. 04:03, Bagas Sanjaya wrote:

> On 10/17/22 03:19, Phillip Lougher wrote:
>> On 16/10/2022 20:55, Phillip Lougher wrote:
>>> Tracking down bugs of this sort is always a process of elimination,
>>> and gathering information to pinpoint the exact circumstances of why
>>> it is triggering.
>>>
>>> Next step is to download the exact snap(s) where the problems are occurring, as this may provide some insights.
>>>
>>> I don't run Ubuntu, and I don't use snaps.  Can you provide the
>>> download link(s) of the snap(s) that cause problems?  If there's
>>> any firefox snaps that don't cause problems those will be useful
>>> too.
>>>
>> It appears there's a searchable "Snap Store" https://snapcraft.io,
>> but, it doesn't give any download links to the actual snaps which
>> is rather annoying.
>>
>> Does anyone know how to get the download link?  I have not run
>> Ubuntu for over 14 years and have absolutely no wish to do so
>> now either.
> You need to have snapd installed, unfortunately.
>
> You can start the testing with hello-world snap, which can be installed
> with `snap install hello-world`. Then run the snap with `snap run
> hello-world`. After that, reboot and repeat until the regression
> occurs.
>
> You can also try other snaps. For GUI applications, try krita, gimp,
> gitkraken, and libreoffice. For server applications, try spinning up
> containers with lxd or store data with nextcloud.
>
> My guess is that the problem is in snapd when trying to execute
> snaps, hence all snaps are affected.

I can only report that bug persisted in 6.1-rc1 with the latest 
Phillip's squashfs patch.

Have a nice day.

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

