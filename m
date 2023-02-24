Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC3536A20E5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 18:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjBXRxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 12:53:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjBXRxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 12:53:30 -0500
Received: from libero.it (smtp-34-i2.italiaonline.it [213.209.12.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED401514E
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 09:53:28 -0800 (PST)
Received: from [192.168.1.176] ([87.6.129.129])
        by smtp-34.iol.local with ESMTPA
        id VcG7pVo55VfPJVcG7pbwMH; Fri, 24 Feb 2023 18:53:27 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
        t=1677261207; bh=aclZZHV+dKC+hofKEZ4XGCH00M56yYIjZcLzhq1n5Bw=;
        h=From;
        b=oSU1C9q1SPZqXSvtikhBBtayq9HBIocEv65tXHqda1zzNuVcshpoxsSWglW0cMabC
         Rrp6kbQ+aFgQEfGT6+51eREcuULDEPRBQdyjudb7d7jA0Q2mawR7gRTv/bMMqY0jHv
         WIxvzy2EYgWtaqwS7lfaw8g9beXWZQedEZuQ5IGVHioXjygUSebtFq0+DgAhXtAxqA
         R1EqrpwauihN4TqLUz+HYlPX+S3LzRYahS/V4wuRnxgVQwvB0DWQlvY4gmF/aHPThu
         TE0W4VTeJXdIU5NgWEEM6AQ1rIdchHZL7p/SbUXsgKwr3XcXxqj0NmpRSadx7/efaS
         vfwR9UTDKqrPw==
X-CNFS-Analysis: v=2.4 cv=EKfAkXVC c=1 sm=1 tr=0 ts=63f8f997 cx=a_exe
 a=ZxqhrVAgG8YdQk3VCnDUFw==:117 a=ZxqhrVAgG8YdQk3VCnDUFw==:17
 a=IkcTkHD0fZMA:10 a=VwQbUJbxAAAA:8 a=m-Ce3_WPumuQnsOGroMA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22
Message-ID: <e49d167f-f418-f2a5-ffb0-6c7f7ea5b74f@inwind.it>
Date:   Fri, 24 Feb 2023 18:53:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: Bugzilla 217083
To:     linux-kernel@vger.kernel.org
References: <f4d6ddad-90c7-8a59-4f1f-334ae5e38463@inwind.it>
 <Y/j1qPOZm90d7Oi1@1wt.eu>
From:   Valerio Vanni <valerio.vanni@inwind.it>
In-Reply-To: <Y/j1qPOZm90d7Oi1@1wt.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Antivirus: AVG (VPS 230224-4, 24/2/2023), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4xfLlvXlO/+XuGvwC+LEu2EUQAgC/zFP0P/r1iHTroRHHxisK3G+CP4kC3y/JBkZdwoJ7Pn/JFX22V4S2Obj5bqw+JK9zXyJiHHFQsz8orlL6MiRxj1eA7
 EBLWbKCnp6BXM1PFHzxZwwWT+L3D+COjWHmcF63W+Alt80WVt0f+0Ummvf+P519Qb9ji+DnK0lKZ09fm14vNAX7qk9Je4n2lL/A=
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 24/02/2023 18:36, Willy Tarreau ha scritto:
> On Fri, Feb 24, 2023 at 06:30:27PM +0100, Valerio Vanni wrote:
>> https://bugzilla.kernel.org/show_bug.cgi?id=217083
> 
> Placing a descriptive subject and a summary here will certainly
> encourage more readers to read your report. You should repost
> with the subject you used there:
> 
>     Kernel panic - not syncing: Attempted to kill init! exitcode=0x00007f00
> 
> and it's useful to mention the version ranges you've spotted (4.19-5.10).

Thank you, I reposted. I don't report bugs often, so I probably miss 
something. Now I'll try other versions, collect more data etc, but it 
will be enough to update bugzilla case or should I update also mailing list?


