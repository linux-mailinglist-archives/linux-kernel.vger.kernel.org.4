Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4BC6E1A51
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 04:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbjDNC1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 22:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjDNC1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 22:27:43 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6907630D5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 19:27:42 -0700 (PDT)
Received: from dggpemm500006.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PyKzN1lFDzKyTr;
        Fri, 14 Apr 2023 10:25:04 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 14 Apr 2023 10:27:40 +0800
Subject: Re: [PATCH v5] arm64: kdump: simplify the reservation behaviour of
 crashkernel=,high
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Baoquan He <bhe@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <horms@kernel.org>,
        <John.p.donnelly@oracle.com>, <will@kernel.org>,
        <kexec@lists.infradead.org>, <linux-arm-kernel@lists.infradead.org>
References: <20230407022419.19412-1-bhe@redhat.com>
 <ZC+Axh1G/+NyIdwg@MiWiFi-R3L-srv> <ZDabRr/yyakrrDDO@arm.com>
 <ZDezLrWSg7qd5K08@MiWiFi-R3L-srv> <ZDgSCfLMtL9heS8J@arm.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <1ab19701-b72f-34f8-8feb-662a7dc59580@huawei.com>
Date:   Fri, 14 Apr 2023 10:27:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <ZDgSCfLMtL9heS8J@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/4/13 22:30, Catalin Marinas wrote:
> On Thu, Apr 13, 2023 at 03:45:50PM +0800, Baoquan He wrote:
>> I am OK with this version, or the version with min(SZ_4G,
>> arm64_dma_phys_limit), or v4. Please help point out if I got your idea
>> correctly. Thanks a lot.
> 
> I think we should stick to this patch. The disabling of the ZONE_DMA(32)
> is fairly specialised and you are right that we should not introduce an
> artificial 4GB crashkernel boundary on such systems. The slight
> confusion may be that ,high triggers a search above 4GB where there's
> not such boundary but this would match the documentation anyway.
> 

Agreed, so careful.

-- 
Regards,
  Zhen Lei
