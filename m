Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB91A5F664A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 14:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbiJFMn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 08:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiJFMnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 08:43:55 -0400
X-Greylist: delayed 335 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 06 Oct 2022 05:43:53 PDT
Received: from domac.alu.hr (domac.alu.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760609C7D6
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 05:43:53 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 179676050B;
        Thu,  6 Oct 2022 14:43:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1665060232; bh=fs7KHqmHeiIFNPlBoUMGVosi8XckqJHSIRXbXj7UE1M=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=xXPczsMcdXAyu7phZOu3AUY4kgUkF41Ku/3EJjNQbYQZLn4ti0Mibiz9Uk07jfgpc
         kcpizeSPRaPjT31cwWlC4/JDWMyG/LUOJ8IBUI+VCGxmzXJx8/J5Xbn796utMe5Lyn
         1X6ewjG/6fh2JWcx88UQq8rO7lCoYJopdSmP0RByusqmu5Tkl8ijYEUmjKTeDpIry6
         TLNdO3wbHplLqgbD2lc27Rz20C6sty1LnjISGAB6dHr1Is7DjJhntCOyJiQCYL2TzP
         a5lQLsJoeYM5d8g5zI508PuD+7q7+kw4pGe2ECmfMMflXh+q2oJlBaJl/+uqHl4OB/
         x9yLwucfikKMQ==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id UUOdgQTbOGBq; Thu,  6 Oct 2022 14:43:49 +0200 (CEST)
Received: from [193.198.186.200] (pc-mtodorov.slava.alu.hr [193.198.186.200])
        by domac.alu.hr (Postfix) with ESMTPSA id CEC48604F9;
        Thu,  6 Oct 2022 14:43:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1665060229; bh=fs7KHqmHeiIFNPlBoUMGVosi8XckqJHSIRXbXj7UE1M=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ArTIOVtsOQGQ70PV5r90W0IsFZ27Yx/mqJ1omK4iOs6yvaUXp6blawZfrk1TkaKc/
         DeQCmiJ4AsLfD5l3/ALXzKozpLGFGF7U74Ruyu8CMOzRkTyqs77m1n5e6bNHXCaYmT
         XUjUxjFjozN0Mg50HaFWhSBBGNGY0Ul2J8dj5sFsg4CGdVOluGxVUgS3MkviI65vZ8
         1p0RYJdnUWp2OkB/c2qcXMLdwgyzrr88GYhaFR7+pywA/zfXcZXhJaYyt/yAl1Vy+G
         PuDWDJbPb5oQEUxE8SZmeBVXCbunSRCA7ipfoMm7rYwMHVIiawhAkTCyZKm7qn4o8y
         OWv/NDMGO9VcQ==
Message-ID: <bdab45d3-c893-42ff-dbb9-5fa93d0dff55@alu.unizg.hr>
Date:   Thu, 6 Oct 2022 14:43:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: 6.0.0-RC kernels trigger Firefox snap bug with 6.0.0-rc3 through
 6.0.0-rc7
Content-Language: en-US
To:     Thorsten Leemhuis <regressions@leemhuis.info>,
        linux-kernel@vger.kernel.org
Cc:     Marc Miltenberger <marcmiltenberger@gmail.com>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <b0c258c3-6dcf-aade-efc4-d62a8b3a1ce2@alu.unizg.hr>
 <5bb75cbc-a0db-537b-12d0-889230c865d8@leemhuis.info>
 <0fb2a9ff-df76-8af9-e54a-c2dc6bfd9478@leemhuis.info>
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <0fb2a9ff-df76-8af9-e54a-c2dc6bfd9478@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/6/22 14:25, Thorsten Leemhuis wrote:

> One more question:
>
> On 06.10.22 14:00, Thorsten Leemhuis wrote:
> Were those two vanilla kernels? I asked in #snappy on IRC and was told
> that "snapd simply expects some ubuntu bit in patched into the kernel if
> it detects that it runs on an official ubuntu install...". This was also
> suggested "it probably makes sense to file a but in LP to make the
> kernel team aware".
>
> Ciao, Thorsten
Yes, last time I tried it with git clone from linux_stable on kernel.org and
config-6.0.0-060000-generic from the official Ubuntu mainline build from 
the repo.
No changes to .config. (I have deliberately excluded KMEMLEAK and KASAN to
eliminate those.)

My build with Ubuntu config showed the tab crash|Verneed record problem,
while Ubuntu original 6.0.0 is still testing. I will know more when I 
come home.

Have a nice day,
mt

-- 

Mirsad Goran Todorovac
CARNet sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu
-- 
CARNet system engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb, Republic of Croatia
tel. +385 (0)1 3711 451
mob. +385 91 57 88 355

