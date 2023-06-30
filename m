Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 306AE7431FC
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 02:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbjF3Az2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 20:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjF3Az0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 20:55:26 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472E12D4A
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 17:55:25 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QscL003GJzqTTn;
        Fri, 30 Jun 2023 08:55:04 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 30 Jun 2023 08:55:22 +0800
Message-ID: <71073ef2-8646-7cdb-d301-af72b4997751@huawei.com>
Date:   Fri, 30 Jun 2023 08:55:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 2/2] mm: make show_free_areas() static
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     <oe-kbuild-all@lists.linux.dev>,
        Linux Memory Management List <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
References: <20230629104357.35455-2-wangkefeng.wang@huawei.com>
 <202306292240.Rj0DlHfI-lkp@intel.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <202306292240.Rj0DlHfI-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm100001.china.huawei.com (7.185.36.93)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

On 2023/6/29 23:00, kernel test robot wrote:
> Hi Kefeng,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on akpm-mm/mm-everything]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Kefeng-Wang/mm-make-show_free_areas-static/20230629-182958
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> patch link:    https://lore.kernel.org/r/20230629104357.35455-2-wangkefeng.wang%40huawei.com
> patch subject: [PATCH 2/2] mm: make show_free_areas() static
> config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20230629/202306292240.Rj0DlHfI-lkp@intel.com/config)
> compiler: sh4-linux-gcc (GCC) 12.3.0
> reproduce: (https://download.01.org/0day-ci/archive/20230629/202306292240.Rj0DlHfI-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202306292240.Rj0DlHfI-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>     mm/nommu.c: In function 'do_mmap':
>>> mm/nommu.c:1239:9: error: implicit declaration of function 'show_free_areas' [-Werror=implicit-function-declaration]
>      1239 |         show_free_areas(0, NULL);
>           |         ^~~~~~~~~~~~~~~
>     cc1: some warnings being treated as errors
> 
> 

Missing this one in patch-1, will update

> vim +/show_free_areas +1239 mm/nommu.c
> 
