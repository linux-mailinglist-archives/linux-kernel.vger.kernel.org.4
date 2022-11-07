Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B23361F624
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 15:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbiKGOej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 09:34:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232474AbiKGOeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 09:34:17 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FCF91DA74
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 06:33:57 -0800 (PST)
Received: from fraeml703-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4N5YXS1srQz6H6pP;
        Mon,  7 Nov 2022 22:29:44 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml703-chm.china.huawei.com (10.206.15.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.31; Mon, 7 Nov 2022 15:33:55 +0100
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 7 Nov
 2022 14:33:55 +0000
Date:   Mon, 7 Nov 2022 14:33:54 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Junhao He <hejunhao3@huawei.com>
CC:     <mathieu.poirier@linaro.org>, <suzuki.poulose@arm.com>,
        <mike.leach@linaro.org>, <leo.yan@linaro.org>,
        <john.garry@huawei.com>, <coresight@lists.linaro.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>,
        <rdunlap@infradead.org>, <liuqi115@huawei.com>,
        <f.fangjian@huawei.com>, <prime.zeng@hisilicon.com>,
        <yangyicong@huawei.com>, <shenyang39@huawei.com>
Subject: Re: [PATCH v11 2/2] Documentation: Add document for UltraSoc SMB
 drivers
Message-ID: <20221107143354.00001324@Huawei.com>
In-Reply-To: <20221107130624.59886-3-hejunhao3@huawei.com>
References: <20221107130624.59886-1-hejunhao3@huawei.com>
        <20221107130624.59886-3-hejunhao3@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
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

On Mon, 7 Nov 2022 21:06:24 +0800
Junhao He <hejunhao3@huawei.com> wrote:

> From: Qi Liu <liuqi115@huawei.com>
> 
> This patch bring in documentation for UltraSoc SMB drivers.
> It simply describes the device, sysfs interface and the
> firmware bindings.
> 
> Signed-off-by: Qi Liu <liuqi115@huawei.com>
> Signed-off-by: Junhao He <hejunhao3@huawei.com>
> ---
>  .../sysfs-bus-coresight-devices-ultra_smb     | 31 +++++++
>  .../trace/coresight/ultrasoc-smb.rst          | 80 +++++++++++++++++++
>  2 files changed, 111 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-coresight-devices-ultra_smb
>  create mode 100644 Documentation/trace/coresight/ultrasoc-smb.rst
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-ultra_smb b/Documentation/ABI/testing/sysfs-bus-coresight-devices-ultra_smb
> new file mode 100644
> index 000000000000..7804aef4b40b
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-ultra_smb
> @@ -0,0 +1,31 @@
> +What:		/sys/bus/coresight/devices/ultra_smb<N>/enable_sink
> +Date:		October 2022
> +KernelVersion:	6.1

Update to 6.2 as this will hopefully go in next merge window and it makes
life easier for the maintainer if they don't need to fix all these up.


> +Contact:	Junhao He <hejunhao3@huawei.com>
> +Description:	(RW) Add/remove a SMB device from a trace path. There can be
> +		multiple sources for a single SMB device.

Rest looks good to me, (not an expert on this stuff though!)

Jonathan
