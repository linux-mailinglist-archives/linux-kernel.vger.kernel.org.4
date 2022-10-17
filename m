Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C19486008BA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 10:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbiJQIck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 04:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbiJQIcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 04:32:36 -0400
Received: from domac.alu.hr (domac.alu.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29A84054A
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 01:32:33 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 52DD4604F0;
        Mon, 17 Oct 2022 10:32:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1665995550; bh=tx2zwgoCiDgmqkb74Wkp7XzquXj4ueJzAzOzUuGymiQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=H9jqWMGf34gPJhzqT87lwGJpR03I8kqmiKwrBDctRsxsdKGMqeCMw9Cj+gn0mW5W8
         GX7Mx6+3ITKMxeDfQaSDGvLbrpw+/PwoYXH0AFQ8PdrpEzZ0c3jzTKs3vyFEzSoHoo
         mShPJKAHOTW5ADa24HZurqJSmuZNHSZ2fIguJOq2vhg22GMKamfoaYMJJbxkFMLSyv
         aXys9fjsJsp4qrt/OW3JpRTi/Pmw2AX+r+C4S/sv8tg/pmYh0tI43Ki77PWAfOU3TS
         YPq5CsnPeujRrRGUqJpuoZ7YR1yLtmD6Q5oZHKhCgDyhFL3tWj2+kC/pkSP658hBog
         njqG/1spapYLw==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id FFPpFb9euCZK; Mon, 17 Oct 2022 10:32:28 +0200 (CEST)
Received: from [161.53.83.51] (pc-mtodorov.grf.hr [161.53.83.51])
        by domac.alu.hr (Postfix) with ESMTPSA id 7AE37604EF;
        Mon, 17 Oct 2022 10:32:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1665995548; bh=tx2zwgoCiDgmqkb74Wkp7XzquXj4ueJzAzOzUuGymiQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZjknIjTcK6rJGADLYjt5VYLWpZy4uXvg14T5GRoluoGXuWuxIujpSGCOlLgvmOrHt
         EXOrMtAMZjErXdlNRwg3FGif2oWAMFtZz6Lnpz/NA//QOQAdiEa2J0bdHwSJFzBUx3
         sLnpHNRvZrctFWgPCnUckJvaOaQnGS3aML6s5Db4UDm4BRgIs/f/nb9tGPzoekOgJP
         IemVL4EjGMIN0c2HLCUbpwi8nOal4hCS73NpE6BExKGPCtbGFW4JM9heppjZsrWhvN
         3XuMCqItFPLD2E4iEz+Cm0yiqcynM8p+r6p6Xo1fgAh+YC6PLrzVrWECIGCMuTBw1D
         jVjZKPF2zALBg==
Message-ID: <147e8cb6-d99e-e53b-cfff-258bc957cf9e@alu.unizg.hr>
Date:   Mon, 17 Oct 2022 10:32:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: BISECT result: 6.0.0-RC kernels trigger Firefox snap bug with
 6.0.0-rc3 through 6.0.0-rc7
Content-Language: en-US
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
 <b7aefbcb-0038-d044-a1ea-64ad5b4d8888@alu.unizg.hr>
 <928b701c-b35f-a621-b32f-edf9d8bf6696@gmail.com>
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <928b701c-b35f-a621-b32f-edf9d8bf6696@gmail.com>
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

On 17.10.2022. 6:15, Bagas Sanjaya wrote:

> On 10/17/22 09:41, Mirsad Goran Todorovac wrote:
>> I can only report that bug persisted in 6.1-rc1 with the latest Phillip's squashfs patch.
> So the regression isn't solved yet with the patch, right?

Apparently not, or not yet. The patch obviously solves some problems, 
though.

The pre-regression fs/squashfs/file.c has completely different version 
of the squash readahead code than
this introduced with the commit b09a7a036d2035b14636cd4c4c69518d73770f65.

I could lament on this, but I am not clever enough to see what is wrong. :(

Mirsad

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

