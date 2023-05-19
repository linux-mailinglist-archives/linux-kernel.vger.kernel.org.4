Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB5570904B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 09:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbjESHTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 03:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjESHTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 03:19:14 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D52E58;
        Fri, 19 May 2023 00:19:13 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4QMylY0HLTz18KJl;
        Fri, 19 May 2023 15:14:49 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 19 May
 2023 15:19:11 +0800
Subject: Re: [PATCH net-next v3] octeontx2-pf: Add support for page pool
To:     Ratheesh Kannoth <rkannoth@marvell.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <sgoutham@marvell.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <sbhatta@marvell.com>, <gakula@marvell.com>, <schalla@marvell.com>,
        <hkelam@marvell.com>
References: <20230519071352.3967986-1-rkannoth@marvell.com>
From:   Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <4e89de93-3b82-a448-0c31-871ad09e40a0@huawei.com>
Date:   Fri, 19 May 2023 15:19:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20230519071352.3967986-1-rkannoth@marvell.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/5/19 15:13, Ratheesh Kannoth wrote:
> Page pool for each rx queue enhance rx side performance
> by reclaiming buffers back to each queue specific pool. DMA
> mapping is done only for first allocation of buffers.
> As subsequent buffers allocation avoid DMA mapping,
> it results in performance improvement.
> 
> Image        |  Performance
> ------------ | ------------
> Vannila      |   3Mpps
>              |
> with this    |   42Mpps
> change	     |
> ---------------------------

LGTM.
Reviewed-by: Yunsheng Lin <linyunsheng@huawei.com>

> 
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
> ---

