Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6B44675E6C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 20:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjATTvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 14:51:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjATTvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 14:51:09 -0500
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1365AD05
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 11:51:05 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 3D4D424044D
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 20:51:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1674244264; bh=DoLlNqdYYDrx3cWG1cEGhU8LlUk6QEkblKYrhTuVxnY=;
        h=Date:Subject:To:Cc:From:From;
        b=Dp6KwOK3pg/SHLzUXiUlMJtxMpCAO15SkGEDi2v6VcpevJaja5STBw4roTiISKvch
         XP3M6niaAiVcBRbAzApVj0q0tbYmLs2Kpqof1sJiz+TNpejk4Gp34wmCJiHlWJCBL1
         FJ9Zyafm2tnNryfheir7SMMUu6M2CfBdujeqfrhM53VkQ+nnOjzd043v2KSID26f+3
         takvrmZvxhjiA6EgUvWksWOA93PEFVC8A5SRLFXclQjfgkH/9ZRoMKiSU0gLRZrmLP
         iWtGrr2URPeak71sB1lDQYWVC5ULnrleGrGgZ2rup6q6+MYaPSQBAXTZ7ozTRJnDyH
         Th161fshnDr/A==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4Nz98y1p9pz9rxH;
        Fri, 20 Jan 2023 20:50:58 +0100 (CET)
Message-ID: <6fd769f9-da0e-c4a8-dc0e-a1e464c2d9fc@posteo.de>
Date:   Fri, 20 Jan 2023 19:50:57 +0000
MIME-Version: 1.0
Subject: Re: [PATCH v4 2/2] hwmon: (nct6775) B650/B660/X670 ASUS boards
 support
To:     Guenter Roeck <linux@roeck-us.net>,
        Denis Pauk <pauk.denis@gmail.com>
Cc:     ahmad@khalifa.ws, chunkeey@gmail.com, greg@krypto.org,
        hubert.banas@gmail.com, igor@svelig.com, jaap.dehaan@freenet.de,
        jdelvare@suse.com, jeroen@beerstra.org, jonfarr87@gmail.com,
        jwp@redhat.com, kdudka@redhat.com, kernel@melin.net,
        kpietrzak@disroot.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, me@rebtoor.com,
        metalcaedes@gmail.com, michael@theoddone.net,
        mikhail.v.gavrilov@gmail.com, mundanedefoliation@gmail.com,
        nephartyz@gmail.com, oleksandr@natalenko.name, pehlm@pekholm.org,
        renedis@hotmail.com, robert@swiecki.net,
        sahan.h.fernando@gmail.com, sst@poczta.fm, to.eivind@gmail.com,
        torvic9@mailbox.org
References: <20230111212241.7456-1-pauk.denis@gmail.com>
 <20230111212241.7456-2-pauk.denis@gmail.com>
 <20230115161224.GA1246527@roeck-us.net>
Content-Language: de-DE
From:   Sebastian Arnhold <sebastian.arnhold@posteo.de>
In-Reply-To: <20230115161224.GA1246527@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Is it just me, or is the support for my mainboard "TUF GAMING X670E-PLUS 
WIFI" now implemented into the latest "linux-next" kernel (I verified 
this by looking at the source code at /drivers/hwmon/nct6775-core.c), 
but the actual patch that contains the NCT6799D driver is still missing?

I had to patch my linux-next kernel with the patch from 
https://patchwork.kernel.org/project/linux-hwmon/patch/20221228135744.281752-1-linux@roeck-us.net/ 
to get it working.

Otherwise the nct6775 module refuses to recognize my sensor chip.

Thanks,
Sebastian

Am 15.01.23 um 17:12 schrieb Guenter Roeck:
> On Wed, Jan 11, 2023 at 11:22:41PM +0200, Denis Pauk wrote:
>> Boards such as:
>>    "EX-B660M-V5 PRO D4",
>>    "PRIME B650-PLUS",
>>    "PRIME B650M-A",
>>    "PRIME B650M-A AX",
>>    "PRIME B650M-A II",
>>    "PRIME B650M-A WIFI",
>>    "PRIME B650M-A WIFI II",
>>    "PRIME B660M-A D4",
>>    "PRIME B660M-A WIFI D4",
>>    "PRIME X670-P",
>>    "PRIME X670-P WIFI",
>>    "PRIME X670E-PRO WIFI",
>>    "Pro B660M-C-D4",
>>    "ProArt B660-CREATOR D4",
>>    "ProArt X670E-CREATOR WIFI",
>>    "ROG CROSSHAIR X670E EXTREME",
>>    "ROG CROSSHAIR X670E GENE",
>>    "ROG CROSSHAIR X670E HERO",
>>    "ROG MAXIMUS XIII EXTREME GLACIAL",
>>    "ROG MAXIMUS Z690 EXTREME",
>>    "ROG MAXIMUS Z690 EXTREME GLACIAL",
>>    "ROG STRIX B650-A GAMING WIFI",
>>    "ROG STRIX B650E-E GAMING WIFI",
>>    "ROG STRIX B650E-F GAMING WIFI",
>>    "ROG STRIX B650E-I GAMING WIFI",
>>    "ROG STRIX B660-A GAMING WIFI D4",
>>    "ROG STRIX B660-F GAMING WIFI",
>>    "ROG STRIX B660-G GAMING WIFI",
>>    "ROG STRIX B660-I GAMING WIFI",
>>    "ROG STRIX X670E-A GAMING WIFI",
>>    "ROG STRIX X670E-E GAMING WIFI",
>>    "ROG STRIX X670E-F GAMING WIFI",
>>    "ROG STRIX X670E-I GAMING WIFI",
>>    "ROG STRIX Z590-A GAMING WIFI II",
>>    "ROG STRIX Z690-A GAMING WIFI D4",
>>    "TUF GAMING B650-PLUS",
>>    "TUF GAMING B650-PLUS WIFI",
>>    "TUF GAMING B650M-PLUS",
>>    "TUF GAMING B650M-PLUS WIFI",
>>    "TUF GAMING B660M-PLUS WIFI",
>>    "TUF GAMING X670E-PLUS",
>>    "TUF GAMING X670E-PLUS WIFI",
>>    "TUF GAMING Z590-PLUS WIFI",
>> have got a NCT6799D chip, but by default there's no use of it
>> because of resource conflict with WMI method.
>>
>> This commit adds such boards to the monitoring list with new ACPI device
>> UID.
>>
>> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=204807
>> Signed-off-by: Denis Pauk <pauk.denis@gmail.com>
>> Co-developed-by: Ahmad Khalifa <ahmad@khalifa.ws>
>> Signed-off-by: Ahmad Khalifa <ahmad@khalifa.ws>
>> Tested-by: Jeroen Beerstra <jeroen@beerstra.org>
>> Tested-by: Slawomir Stepien <sst@poczta.fm>
> Applied to hwmon-next.
>
> Thanks,
> Guenter
