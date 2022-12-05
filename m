Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31197642862
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 13:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbiLEMZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 07:25:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbiLEMZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 07:25:57 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42AD763BE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 04:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1670243156; x=1701779156;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=neMU4Ok0awO5Rq5skIsVHn5TxIHDupVu3e9O7MCpojQ=;
  b=pTDUK1wUz7tmxn0Cd/iIQNWCHZzCyHTNl+sepQNL4JrtcOGWg+Qy1/S5
   oZY8AwetLFlE4G9DE/oyACmxo4tYHU1kZwy+KDIu7nBgOv5jP+L8seF3W
   RUp3Q8hyAH1GnqMhjh+zy7X85FSyRIB4KnubsjIAYU06bG9p05fuPhczJ
   9MRdLZF6J4aIsC5lVI7mpCFZvQNk+4Xj1TnS9J4uJqMKaNkrDYQdjMk5G
   G3YCuv2T9Pery9m/owL3QzOrjp/jElPP3KDGGEoE9GhtwQ8tqGaT3qahZ
   rMWZxZZl2teVmOXziYtpFQl04JH7kKOVgpPB7rZCM9Mt/BebjzwvkUJfG
   g==;
X-IronPort-AV: E=Sophos;i="5.96,219,1665417600"; 
   d="scan'208";a="330010009"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 05 Dec 2022 20:25:55 +0800
IronPort-SDR: t0TBNtJ1ixCUr7i5lP8b6mFGFv1RlOLYASdL10zawhkWEiw/PvTmB46PKHu7VFUPT7px+YmlN+
 /m/V+p6bH2kNGg9RThbpaVlGFXL9evhXY/8tRVTzXZC6b30pOK1utdkrZiHNGUxJO3vk/p2J3W
 DCaqr7ktNdGpGb3+BdvSC6md/YSqQtbaRvwWbVVgxTetrnaXzKmKepy99g/o1ifPl7Ux5Kk0Yc
 d/AHf1na0WQW0aSXElmMWZ9z7u+xF9reStUSzyfmbV67m2FBBbu4F4OvmiMHt11BpDImGlPxfV
 Y1Y=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Dec 2022 03:38:45 -0800
IronPort-SDR: RS2c9f8HzNKezlusL2nDZ7kyJc8v2Wrlo12R0XfMgNVnF16T8IgWBDSP34Yw4phRuQUdaDF4u+
 AGkqFC6ODkuiLx8HiagzEDd/LnapIOCwSxEBRDtzCJkkcfKaebtb08W/FyniLyuE0pEDJg5TQR
 kfj1KFJEHCuHj3MB3j+tzREBuYYT18VoeTx59a0sG2CxSXSIHJshUHv7UuVXuh7A80rI6Gk3KY
 WQIT4z1JKpNiLkiGBsAeB5AtVd1OkGkSE9kPsdRUE8TUA0dLSr9rCGLVfR8dfAKWYcK1Mk1GEl
 PEc=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Dec 2022 04:25:56 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NQjSg3Nzsz1Rwrq
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 04:25:55 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:content-language:references:to
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1670243153; x=1672835154; bh=neMU4Ok0awO5Rq5skIsVHn5TxIHDupVu3e9
        O7MCpojQ=; b=hLPMbnYEZZc1sD43hh+tarQWN21QTPeRtHy0AzFV4v4psQ2nsc1
        q8+gV8DYQs70y+rtMU/IKMX7WLT+kyZ2rQQdnx/Rs1CHsi4t9dK6R+f2wvZOxGHh
        wOJ7eo+S3X1N+38s0lj05mgkKh6NqX6T4EkRW/RwSAvlh0L87N+ib3UyOltTMCdI
        wVkKNCoFDL2AcmumZkksgTfSRYJ32AdFvvL8SRiRdWebk01E/ivFVoFxfgjLPmiE
        PlE9xHcMgyNE6PIOhjMjcTZz2ygBD1zlU+JpmcisE4C17GwpJFUCzXDXTxwLR7NF
        EgofFXKEnf3ZdXOYHrIuKDQiEr4pji88eVw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id c_qJjTjvay33 for <linux-kernel@vger.kernel.org>;
        Mon,  5 Dec 2022 04:25:53 -0800 (PST)
Received: from [10.225.163.74] (unknown [10.225.163.74])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NQjSW6BW3z1RvLy;
        Mon,  5 Dec 2022 04:25:47 -0800 (PST)
Message-ID: <e62bc865-3b6f-2790-3dbf-6485cb233c4e@opensource.wdc.com>
Date:   Mon, 5 Dec 2022 21:25:45 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 12/12] mm, slob: rename CONFIG_SLOB to
 CONFIG_SLOB_DEPRECATED
To:     Palmer Dabbelt <palmer@dabbelt.com>, vbabka@suse.cz
Cc:     cl@linux.com, rientjes@google.com, iamjoonsoo.kim@lge.com,
        penberg@kernel.org, 42.hyeyoo@gmail.com, roman.gushchin@linux.dev,
        akpm@linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        willy@infradead.org, patches@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux@armlinux.org.uk,
        aaro.koskinen@iki.fi, jmkrzyszt@gmail.com, tony@atomide.com,
        jonas@southpole.se, stefan.kristiansson@saunalahti.fi,
        shorne@gmail.com, ysato@users.sourceforge.jp, dalias@libc.org,
        Arnd Bergmann <arnd@arndb.de>, josh@joshtriplett.org,
        Conor Dooley <conor@kernel.org>, christophe.leroy@csgroup.eu,
        geert@linux-m68k.org, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org, openrisc@lists.librecores.org,
        linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org
References: <mhng-b0214281-7ee5-4698-a158-980427a97472@palmer-ri-x1c9a>
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <mhng-b0214281-7ee5-4698-a158-980427a97472@palmer-ri-x1c9a>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/3/22 02:59, Palmer Dabbelt wrote:
[...]
>> diff --git a/arch/riscv/configs/nommu_virt_defconfig b/arch/riscv/configs/nommu_virt_defconfig
>> index 1a56eda5ce46..4cf0f297091e 100644
>> --- a/arch/riscv/configs/nommu_virt_defconfig
>> +++ b/arch/riscv/configs/nommu_virt_defconfig
>> @@ -22,7 +22,8 @@ CONFIG_EXPERT=y
>>  # CONFIG_KALLSYMS is not set
>>  # CONFIG_VM_EVENT_COUNTERS is not set
>>  # CONFIG_COMPAT_BRK is not set
>> -CONFIG_SLOB=y
>> +CONFIG_SLUB=y
>> +CONFIG_SLUB_TINY=y
>>  # CONFIG_MMU is not set
>>  CONFIG_SOC_VIRT=y
>>  CONFIG_NONPORTABLE=y
> 
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> 
> Though I don't have a K210 to test against, maybe Damien still does?

I did test and it is OK.

-- 
Damien Le Moal
Western Digital Research

