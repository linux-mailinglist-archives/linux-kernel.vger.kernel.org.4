Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB7FA728140
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 15:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236709AbjFHNWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 09:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235659AbjFHNWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 09:22:40 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70CC2717;
        Thu,  8 Jun 2023 06:22:13 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QcPxY3cpGz6J7rT;
        Thu,  8 Jun 2023 21:21:37 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 8 Jun
 2023 14:22:01 +0100
Date:   Thu, 8 Jun 2023 14:22:00 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Junhao He <hejunhao3@huawei.com>
CC:     <will@kernel.org>, <linux-kernel@vger.kernel.org>,
        <mark.rutland@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-doc@vger.kernel.org>, <linuxarm@huawei.com>,
        <yangyicong@huawei.com>, <shenyang39@huawei.com>,
        <prime.zeng@hisilicon.com>
Subject: Re: [PATCH v3 2/3] drivers/perf: hisi: Add support for HiSilicon UC
 PMU driver
Message-ID: <20230608142200.0000753c@Huawei.com>
In-Reply-To: <20230608113719.27433-3-hejunhao3@huawei.com>
References: <20230608113719.27433-1-hejunhao3@huawei.com>
        <20230608113719.27433-3-hejunhao3@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
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

On Thu, 8 Jun 2023 19:37:18 +0800
Junhao He <hejunhao3@huawei.com> wrote:


> On HiSilicon Hip09 platform, there is 4 UC (unified cache) module

are 4 UC (unified cache) modules

> on each chip CCL (CPU Cluster). UC is a cache that provides
> coherence between NUMA and UMA domains. It is located between L2
> and Memory System. And many PMU events are supported. Let's support

Many PMU events are supported.

> the UC PMU driver using the HiSilicon uncore PMU framework.
> 
> * rd_req_en : rd_req_en is the abbreviation of read request tracetag
> enable and allows user to count only read operations. Details are listed
> in the hisi-pmu document at Documentation/admin-guide/perf/hisi-pmu.rst
> 
> * srcid_en & srcid: Allows users to filter statistical information based
> on specific CPU/ICL by srcid.
> srcid_en depending on rd_req_en enabled.

srcid_en depends on rd_req_en being enabled.

> 
> * uring_channel: Allows users to filter statistical information based on
> the specified tx request uring channel.
> uring_channel only supported events: [0x47 ~ 0x59].
> 
> Signed-off-by: Junhao He <hejunhao3@huawei.com>
> Reviewed-by: Yicong Yang <yangyicong@hisilicon.com>

The editorial stuff above is trivial and original text can be easily 
understood. So maintainers may not care. If you happen to be re rolling
the patch then nice to clean it up.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
