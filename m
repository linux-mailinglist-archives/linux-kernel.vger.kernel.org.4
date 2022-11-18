Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87B9862F12C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 10:29:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241454AbiKRJ3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 04:29:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241247AbiKRJ3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 04:29:47 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC91712ABC
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 01:29:45 -0800 (PST)
Received: from frapeml500008.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NDBJL1ytrz6HJGs;
        Fri, 18 Nov 2022 17:27:14 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 18 Nov 2022 10:29:43 +0100
Received: from localhost (10.81.204.106) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 18 Nov
 2022 09:29:39 +0000
Date:   Fri, 18 Nov 2022 09:29:42 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Shaokun Zhang <zhangshaokun@hisilicon.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, "Qi Liu" <liuqi6124@gmail.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] MAINTAINERS: Update HiSilicon PMU maintainers
Message-ID: <20221118092942.000055c3@Huawei.com>
In-Reply-To: <20221118065400.48836-1-zhangshaokun@hisilicon.com>
References: <20221118065400.48836-1-zhangshaokun@hisilicon.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.204.106]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Nov 2022 14:54:00 +0800
Shaokun Zhang <zhangshaokun@hisilicon.com> wrote:

> Now Qi Liu has left HiSilicon and will no longer access to the
> necessary hardware and document, remove the mail and thanks for
> her's work.
> While add the new maintainer Jonathan Cameron, He is skilled with
> kernel and enough knowledge of the driver.
> 
> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> Cc: Qi Liu <liuqi6124@gmail.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8ba29a308539..a6c2499b59af 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9248,7 +9248,7 @@ F:	drivers/misc/hisi_hikey_usb.c
>  
>  HISILICON PMU DRIVER
>  M:	Shaokun Zhang <zhangshaokun@hisilicon.com>
> -M:	Qi Liu <liuqi115@huawei.com>
> +M:	Jonathan Cameron <jonathan.cameron@huawei.com>
>  S:	Supported
>  W:	http://www.hisilicon.com
>  F:	Documentation/admin-guide/perf/hisi-pcie-pmu.rst

