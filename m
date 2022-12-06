Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57DAA644FBA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 00:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiLFXi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 18:38:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiLFXi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 18:38:56 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC8E43AE1
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 15:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1670369935; x=1701905935;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=e7yjDpav0mLVbYXpW3dWfrLRtjlWgdbRjrwEkpByyBs=;
  b=NVkNqMT1cB29cwcefItO/+ButB82+H9vHzlNjuTzYVA4hxuXNTTGSx9Y
   cRqGrXmcbSUmIJXhc1aNlJnl5dMyHjS1mT9ZMF9SO55aRSGgA2ztARtmD
   7H/ta/28phaZcoMORnETrS+xl1PeAD/W7VwoJHqznthkCYidIwYwghQix
   ThVvj1W/B3T4PHwKTMSpvf/YjQCAkmyGH6lucZ9okFKxFBXrrXJB62ru5
   dSwsHzCPnveY2HWjU0skTm6y3EQnCnbOobqo1SVkkztD2bTDPhdP6lvLv
   ChE1vEC+l8kz/Pcs17Nni6LAfo/+JHhnGGkJSWi1opWwkB2qWECzwVtue
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,223,1665417600"; 
   d="scan'208";a="223200600"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Dec 2022 07:38:54 +0800
IronPort-SDR: TAPYkzkHKQb8NRO05Vcd3w0cenVAUJyGW8uNOUpDEWeZy4I8VmqKajDYXWsWacG+64FkD6OgkD
 CUXw/fS5ClNmW9eZXenNpvbp1PJ0O3asuF8rXX3q8S3qGMZ5JAlxifqxP4yGC/HZf7I8VQCnYy
 TRl7MzqgAEXyqvbAZZjYandl5A/WXicf6Uzig5rHjL1hsUhEqaejUSl37lF3s/cZstvmO7jETo
 6GK9UhUGLdqEi50TqpimLt3DGN5zrFTIyo+3HBisV2lAdUiGgkwZYhZeBfvw1WTnjW/0zWmZKA
 0GQ=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Dec 2022 14:57:26 -0800
IronPort-SDR: XnRZo95Hx6HMcl7sOGlXCFXtOj+24EwNbnDjivxbElYL4CzSn65WJgJ+DeAf3s2F/+lJwwbzH1
 5uZuPpQGmmLsaIoxHbUYByRSJcZoVo+4shJ1BWasSSWK25PtDzXN8Vek8jF3XwEqKS6vkOVdCq
 aanCfnuvzusUqtxsWWSs5J2+ZiSWcBAJ/M75CSb+CjVlTArqaxbZ8rmtrES06l8PQ05U2k+hdx
 aayfywuWLATcFpxOmG2oCiAWJkk34nNetBVSIMoxpmFiiMA1mDoCuGbgnq2bDooM09+zoINqta
 ylY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Dec 2022 15:38:54 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NRcLk3jbqz1Rwt8
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 15:38:54 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1670369933; x=1672961934; bh=e7yjDpav0mLVbYXpW3dWfrLRtjlWgdbRjrw
        EkpByyBs=; b=p53Mb4r0jRY7rJqL7Nso5628sm/spfsrsjPktCOutpmxtesSdeJ
        uj9o33IeD86z2TuoSnOARUlLy+V82zpocXva9IzagN1NY3SjDsi1PIqtcCYroXUK
        VraeGASN69GZeRUfYMoqPvYbay3veBMJzcSWsgVx0q/PJhSsdrVeWr8nch6jqVx9
        qmQHXGuGOMROjMQuFv11qryi8dckuVwigwmbJEmkS4SXDPl8g+/nyfe/W6c2XASI
        /rRBh3VKfVX19q5pifJIz/huqXxUuPAbQv7uoD4j8xP3/Jb3SGhpTtbIfd2HSawL
        aEj08ftSeA7chCJZ8BUQSg/iNB05xhIR1Ow==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id hNgehGV3Pa7m for <linux-kernel@vger.kernel.org>;
        Tue,  6 Dec 2022 15:38:53 -0800 (PST)
Received: from [10.225.163.74] (unknown [10.225.163.74])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NRcLh5GBSz1RvLy;
        Tue,  6 Dec 2022 15:38:52 -0800 (PST)
Message-ID: <3f33faaf-bafe-8a4e-0011-c9ade9be2e49@opensource.wdc.com>
Date:   Wed, 7 Dec 2022 08:38:51 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] ata: libahci_platform: ahci_platform_find_clk: oops, NULL
 pointer
Content-Language: en-US
To:     Anders Roxell <anders.roxell@linaro.org>, hdegoede@redhat.com,
        axboe@kernel.dk
Cc:     Sergey.Semin@baikalelectronics.ru, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
References: <20221206083416.705111-1-anders.roxell@linaro.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221206083416.705111-1-anders.roxell@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/6/22 17:34, Anders Roxell wrote:
> When booting a arm 32-bit kernel with config CONFIG_AHCI_DWC enabled on
> a am57xx-evm board. This happens when the clock references are unnamed
> in DT, the strcmp() produces a NULL pointer dereference, see the
> following oops, NULL pointer dereference:
> 
> [    4.673950] Unable to handle kernel NULL pointer dereference at virtual address 00000000
> [    4.682098] [00000000] *pgd=00000000
> [    4.685699] Internal error: Oops: 5 [#1] SMP ARM
> [    4.690338] Modules linked in:
> [    4.693420] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.1.0-rc7 #1
> [    4.699615] Hardware name: Generic DRA74X (Flattened Device Tree)
> [    4.705749] PC is at strcmp+0x0/0x34
> [    4.709350] LR is at ahci_platform_find_clk+0x3c/0x5c
> [    4.714416] pc : [<c130c494>]    lr : [<c0c230e0>]    psr: 20000013
> [    4.720703] sp : f000dda8  ip : 00000001  fp : c29b1840
> [    4.725952] r10: 00000020  r9 : c1b23380  r8 : c1b23368
> [    4.731201] r7 : c1ab4cc4  r6 : 00000001  r5 : c3c66040  r4 : 00000000
> [    4.737762] r3 : 00000080  r2 : 00000080  r1 : c1ab4cc4  r0 : 00000000
> [...]
> [    4.998870]  strcmp from ahci_platform_find_clk+0x3c/0x5c
> [    5.004302]  ahci_platform_find_clk from ahci_dwc_probe+0x1f0/0x54c
> [    5.010589]  ahci_dwc_probe from platform_probe+0x64/0xc0
> [    5.016021]  platform_probe from really_probe+0xe8/0x41c
> [    5.021362]  really_probe from __driver_probe_device+0xa4/0x204
> [    5.027313]  __driver_probe_device from driver_probe_device+0x38/0xc8
> [    5.033782]  driver_probe_device from __driver_attach+0xb4/0x1ec
> [    5.039825]  __driver_attach from bus_for_each_dev+0x78/0xb8
> [    5.045532]  bus_for_each_dev from bus_add_driver+0x17c/0x220
> [    5.051300]  bus_add_driver from driver_register+0x90/0x124
> [    5.056915]  driver_register from do_one_initcall+0x48/0x1e8
> [    5.062591]  do_one_initcall from kernel_init_freeable+0x1cc/0x234
> [    5.068817]  kernel_init_freeable from kernel_init+0x20/0x13c
> [    5.074584]  kernel_init from ret_from_fork+0x14/0x2c
> [    5.079681] Exception stack(0xf000dfb0 to 0xf000dff8)
> [    5.084747] dfa0:                                     00000000 00000000 00000000 00000000
> [    5.092956] dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [    5.101165] dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
> [    5.107818] Code: e5e32001 e3520000 1afffffb e12fff1e (e4d03001)
> [    5.114013] ---[ end trace 0000000000000000 ]---
> 
> Add an extra check in the if-statement if hpriv-clks[i].id.
> 
> Fixes: 6ce73f3a6fc0 ("ata: libahci_platform: Add function returning a clock-handle by id")
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

Applied to for-6.1-fixes. Thanks !

-- 
Damien Le Moal
Western Digital Research

