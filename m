Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC2E7186A4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 17:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233641AbjEaPqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 11:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbjEaPqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 11:46:01 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2340D8E;
        Wed, 31 May 2023 08:46:00 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QWYTK03h2z67nFJ;
        Wed, 31 May 2023 23:43:48 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 31 May
 2023 16:45:56 +0100
Date:   Wed, 31 May 2023 16:45:56 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Junhao He <hejunhao3@huawei.com>
CC:     <will@kernel.org>, <linux-kernel@vger.kernel.org>,
        <mark.rutland@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-doc@vger.kernel.org>, <linuxarm@huawei.com>,
        <yangyicong@huawei.com>, <shenyang39@huawei.com>,
        <prime.zeng@hisilicon.com>
Subject: Re: [PATCH v2 1/3] drivers/perf: hisi: Add support for HiSilicon
 H60PA and PAv3 PMU driver
Message-ID: <20230531164556.000027e9@Huawei.com>
In-Reply-To: <20230531104625.18296-2-hejunhao3@huawei.com>
References: <20230531104625.18296-1-hejunhao3@huawei.com>
        <20230531104625.18296-2-hejunhao3@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
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

On Wed, 31 May 2023 18:46:23 +0800
Junhao He <hejunhao3@huawei.com> wrote:

> Compared to the original PA device, H60PA offers higher bandwidth.
> The H60PA is a new device and we use HID to differentiate them.
> 
> The events supported by PAv3 and PAv2 are different. They use the
> same HID. The PMU version register is used in the driver to
> distinguish different versions.
> 
> For each H60PA PMU, except for the overflow interrupt register, other
> functions of the H60PA PMU are the same as the original PA PMU module.
> It has 8-programable counters and each counter is free-running.
> Interrupt is supported to handle counter (64-bits) overflow.
> 
> Signed-off-by: Junhao He <hejunhao3@huawei.com>

Hi,

I would have slightly preferred to see the refactoring done as a first
patch and then the new device supported added in a second, but as that
second patch would only be a few lines I don't mind that much.

The result looks fine to me.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

