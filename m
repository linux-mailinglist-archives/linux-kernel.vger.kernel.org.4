Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6429A6B2FC7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 22:47:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbjCIVq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 16:46:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjCIVq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 16:46:57 -0500
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E58AF2094;
        Thu,  9 Mar 2023 13:46:55 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 839D9604FA;
        Thu,  9 Mar 2023 22:46:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1678398413; bh=pnFXe2FCx6h14wEuJV2ajCW8PO1UoWcPjFwkJ1k61e0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=dB9aD8PQ9imwmF7n5s42hL2vSVkEjjC/RaWMlivT0LzMBCVKJNQYphq/hy/RyYjvh
         m5uzJYo0+xq3aaywsVopdHotNyzQwCrlpb2Qc6mzt1d8VTNWxeMNCi2PXk2DqlmyoE
         ni3bkNtMLBVbzFgJLmZvI2ibR0fFp7kwcUu/s44Y5IqQpxpvcynggYeh5IHjDyjLtn
         ufziQTC2V1bf4rUqT3TxdNALiPphVHV6kyDbBz8PYXxhskr1/lbEoQroH2U/XOay0e
         saLade6Yjd5SOiYApJ33lkIMqJTkh1XSbOiUHL53yETbQxNVcXLv1IlZ1JxypIVkac
         JIHanQPPubeow==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id plCFe046Rd_q; Thu,  9 Mar 2023 22:46:51 +0100 (CET)
Received: from [192.168.1.4] (unknown [77.237.109.125])
        by domac.alu.hr (Postfix) with ESMTPSA id A712A604F9;
        Thu,  9 Mar 2023 22:46:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1678398411; bh=pnFXe2FCx6h14wEuJV2ajCW8PO1UoWcPjFwkJ1k61e0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=FsbV6Dzf6aNtBuRN63lrbg5jcl8qbH9G/aN1nWf/OFwMUqRdgn4ohUInE3sbjITB1
         Ix0Y2C4EGOYLs6n34a/7bUwLDFzEMdG5A+f5c8k4nBLUEflJ2k+W52TqKAh6X+bkiu
         JSUwmuSrX09A0l1YA7KJxeZA56NN1BDT1PcENUN9XJ/ALg6EsVVSpMhBpxm+/ijPpv
         YVtSwvl/QEfEE5Z3WtkHjXRgGI3zLsKp0Yh0Z431mlnfpywfzmk2yAYaycR8OCTFGv
         UVdUEUmtMx4Jp1lO4BIzuoQh/+04+R56yTydqL7qzhEBW/F2djFSi2PMynlgITd186
         qnI2qAW0PvXWQ==
Message-ID: <d10f18b4-56cf-8a55-b12f-79b1163d8841@alu.unizg.hr>
Date:   Thu, 9 Mar 2023 22:46:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] block: don't embed integrity_kobj into gendisk
Content-Language: en-US, hr
To:     =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20230309-kobj_release-gendisk_integrity-v1-1-a240f54eac60@weissschuh.net>
 <d85ba503-d93c-3483-25e1-6043d4af444f@alu.unizg.hr>
 <0ac9777c-7586-494f-bbc5-87f14f645b12@t-8ch.de>
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <0ac9777c-7586-494f-bbc5-87f14f645b12@t-8ch.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09. 03. 2023. 22:23, Thomas Weißschuh wrote:

Very well, but who then destroys the cache crated here:

security/integrity/iint.c:177-179
> 177         iint_cache =
> 178             kmem_cache_create("iint_cache", sizeof(struct integrity_iint_cache),
> 179                               0, SLAB_PANIC, init_once);

I assumed that it must have been done from iint.c because iint_cache is
static?

BTW, moving check for !ktype->release to kobject_init() is great for it
might make such problems noticed in dmesg, rather than taking screenshots.

Regards,

-- 
Mirsad Goran Todorovac
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu
 
System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb, Republic of Croatia
The European Union

