Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E69D7125C2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 13:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243364AbjEZLlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 07:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243319AbjEZLk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 07:40:59 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 847E9194
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 04:40:57 -0700 (PDT)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QSNKJ47RvzTkSH;
        Fri, 26 May 2023 19:40:52 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 26 May 2023 19:40:54 +0800
Message-ID: <847b9b8a-d9d5-3ee9-41f3-1171a4f73434@huawei.com>
Date:   Fri, 26 May 2023 19:40:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH -next] memblock: unify memblock dump and debugfs show
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>, Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     <oe-kbuild-all@lists.linux.dev>,
        Linux Memory Management List <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <tsahu@linux.ibm.com>,
        <anshuman.khandual@arm.com>, <ssawgyw@gmail.com>
References: <20230525115856.124507-1-wangkefeng.wang@huawei.com>
 <202305261822.ZFRYZVQk-lkp@intel.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <202305261822.ZFRYZVQk-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/5/26 19:09, kernel test robot wrote:
> Hi Kefeng,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on next-20230525]
> 
Thank, I will drop __initdata_memblock .

> 
> 
> vim +1910 mm/memblock.c
> 
>    1909	
>> 1910	static const char * const flagname[] __initdata_memblock = {
>    1911		[ilog2(MEMBLOCK_HOTPLUG)]		= "HOTPLUG",
>    1912		[ilog2(MEMBLOCK_MIRROR)]		= "MIRROR",
>    1913		[ilog2(MEMBLOCK_NOMAP)]			= "NOMAP",
>    1914		[ilog2(MEMBLOCK_DRIVER_MANAGED)]	= "DRV_MNG",
>    1915		[ilog2(MEMBLOCK_MAX_UNKNOWN)]		= "UNKNOWN",
>    1916	};
>    1917	
> 
