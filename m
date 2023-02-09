Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 901EE69063C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 12:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjBILNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 06:13:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjBILMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 06:12:54 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA974C1F;
        Thu,  9 Feb 2023 03:12:51 -0800 (PST)
Received: from kwepemm600009.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4PCDgK1Fqsz16NVF;
        Thu,  9 Feb 2023 19:10:37 +0800 (CST)
Received: from [10.67.101.184] (10.67.101.184) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 9 Feb 2023 19:12:49 +0800
Subject: Re: [PATCH 2/5] crypto: hisilicon/qm - change data type in min_t
To:     Herbert Xu <herbert@gondor.apana.org.au>
References: <20230203093730.49314-1-qianweili@huawei.com>
 <20230203093730.49314-3-qianweili@huawei.com>
 <Y+S9kS8cElGRGysn@gondor.apana.org.au>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <liulongfang@huawei.com>
From:   Weili Qian <qianweili@huawei.com>
Message-ID: <658e62e1-2337-32df-3641-03a4789f30a0@huawei.com>
Date:   Thu, 9 Feb 2023 19:12:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <Y+S9kS8cElGRGysn@gondor.apana.org.au>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.101.184]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/2/9 17:32, Herbert Xu wrote:
> On Fri, Feb 03, 2023 at 05:37:27PM +0800, Weili Qian wrote:
>> 'act_q_num = min_t(int, act_q_num, max_qp_num)', 'act_q_num'
>> and 'max_qp_num' are 'u32' type, change min_t() to use 'u32'
>> type instead of 'int'.
> 
> If they are of the same type, why not just do min?
> 
> Thanks,
> 

Thanks for your reminder. I will fix it in next version.

Best regards,
Weili
