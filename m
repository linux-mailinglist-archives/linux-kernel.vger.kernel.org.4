Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99DA2743B48
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 13:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232492AbjF3L5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 07:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232661AbjF3L5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 07:57:46 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A50B610F8;
        Fri, 30 Jun 2023 04:57:43 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QstzK4pYxzpSsn;
        Fri, 30 Jun 2023 19:54:53 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 30 Jun
 2023 19:57:40 +0800
Subject: Re: [PATCH v5 RFC 0/6] introduce page_pool_alloc() API
To:     Alexander Lobakin <aleksander.lobakin@intel.com>
CC:     <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, <bpf@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
References: <20230629120226.14854-1-linyunsheng@huawei.com>
 <32fa253c-b0ad-c988-5017-ecdcb9e1968c@intel.com>
From:   Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <e785ba9b-18b1-985b-10b0-63fbb4d474cd@huawei.com>
Date:   Fri, 30 Jun 2023 19:57:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <32fa253c-b0ad-c988-5017-ecdcb9e1968c@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/6/29 22:26, Alexander Lobakin wrote:
>> v5 RFC: add a new page_pool_cache_alloc() API, and other minor
>>         change as discussed in v4. As there seems to be three
>>         comsumers that might be made use of the new API, so
>>         repost it as RFC and CC the relevant authors to see
>>         if the new API fits their need.
> 
> Tested v5 against my latest tree, no regressions, perf is even a bit
> better than it was. That also might've come from that net-next pulled
> Linus' tree with a good bunch of PRs already merged, or from v4 -> v5
> update.

v4 -> v5 is mostly about adding the page pool cache API, so I believe the
perf improvement is from the net-next pull:)

> 
> Re consumers, I'm planning to send the RFC series with IAVF as a
> consumer on Monday (and a couple generic Page Pool improvements today,
> will see).

Thanks.
