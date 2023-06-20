Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36AE973626E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 05:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjFTD6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 23:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjFTD6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 23:58:30 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA31133;
        Mon, 19 Jun 2023 20:58:28 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4QlXt23tD4z1HBPc;
        Tue, 20 Jun 2023 11:58:18 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 20 Jun 2023 11:58:08 +0800
Subject: Re: [PATCH] ACPI: APEI: mark some functions __init
To:     Shuai Xue <xueshuai@linux.alibaba.com>, <rafael@kernel.org>
CC:     <lenb@kernel.org>, <james.morse@arm.com>, <tony.luck@intel.com>,
        <bp@alien8.de>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230617080708.2002287-1-linmiaohe@huawei.com>
 <638b32ce-d2a8-2686-dda1-26abb0778bae@linux.alibaba.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <557d3e68-f291-132a-adc5-d8234fb2d379@huawei.com>
Date:   Tue, 20 Jun 2023 11:58:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <638b32ce-d2a8-2686-dda1-26abb0778bae@linux.alibaba.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/6/20 11:43, Shuai Xue wrote:
> 
> 
> On 2023/6/17 16:07, Miaohe Lin wrote:
>> hest_esrc_len() and apei_hest_parse() are only called inside __init
>> section. So mark them __init too.
> 
> Hi, Miaohe,
> 
> should ghes_estatus_pool_init also be marked with __init?

Yes, I think so. It's only called within __init section too. And it's in fact on my plan
in another patch. Thanks for your comment.

> 
> Thanks.
> 
> Best Regards,
> Shuai
> 
> 
