Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D54B7186E9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 18:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233785AbjEaQAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 12:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233823AbjEaQAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 12:00:17 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA4E194;
        Wed, 31 May 2023 09:00:04 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QWYkJ6M8tz6J7Sx;
        Wed, 31 May 2023 23:55:04 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 31 May
 2023 17:00:02 +0100
Date:   Wed, 31 May 2023 17:00:01 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Junhao He <hejunhao3@huawei.com>
CC:     <will@kernel.org>, <linux-kernel@vger.kernel.org>,
        <mark.rutland@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-doc@vger.kernel.org>, <linuxarm@huawei.com>,
        <yangyicong@huawei.com>, <shenyang39@huawei.com>,
        <prime.zeng@hisilicon.com>
Subject: Re: [PATCH v2 3/3] docs: perf: Add new description for HiSilicon UC
 PMU
Message-ID: <20230531170001.00005210@Huawei.com>
In-Reply-To: <20230531104625.18296-4-hejunhao3@huawei.com>
References: <20230531104625.18296-1-hejunhao3@huawei.com>
        <20230531104625.18296-4-hejunhao3@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 May 2023 18:46:25 +0800
Junhao He <hejunhao3@huawei.com> wrote:

> A new function is added on HiSilicon uncore UC PMU.
> 
> The UC PMU support to filter statistical information based on
> the specified tx request uring channel. Make user configuration
> through "uring_channel" parameter.
> Document them to provide guidance on how to use them.
> 
> Signed-off-by: Junhao He <hejunhao3@huawei.com>
Seems reasonable to me.
Reviewed-by: Jonathan Cameron <Jonthan.Cameron@huawei.com>

> ---
>  Documentation/admin-guide/perf/hisi-pmu.rst | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/admin-guide/perf/hisi-pmu.rst b/Documentation/admin-guide/perf/hisi-pmu.rst
> index 546979360513..939a524fa1d6 100644
> --- a/Documentation/admin-guide/perf/hisi-pmu.rst
> +++ b/Documentation/admin-guide/perf/hisi-pmu.rst
> @@ -98,6 +98,14 @@ CCL/ICL-ID. For I/O die, the ICL-ID is followed by:
>  5'b00011: HAC_ICL;
>  5'b10000: PCIe_ICL;
>  
> +(e) uring_channel: UC PMU events 0x47~0x59 supports filtering by tx request
> +uring channel. It is 2 bits. Some important codes are as follows:
> +2'b11: count the events which sent to the uring_ext (MATA) channel;
> +2'b01: is the same as 2'b11;
> +2'b10: count the events which sent to the uring (non-MATA) channel;
> +2'b00: default value, count the events which sent to the both uring and
> +       uring_ext channel;
> +
>  Users could configure IDs to count data come from specific CCL/ICL, by setting
>  srcid_cmd & srcid_msk, and data desitined for specific CCL/ICL by setting
>  tgtid_cmd & tgtid_msk. A set bit in srcid_msk/tgtid_msk means the PMU will not

