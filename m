Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6F25B6531
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 03:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbiIMBrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 21:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbiIMBri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 21:47:38 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA33B4F676
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 18:47:36 -0700 (PDT)
Received: from kwepemi500011.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MRR9M1P5ZznVFq;
        Tue, 13 Sep 2022 09:44:55 +0800 (CST)
Received: from [10.67.102.125] (10.67.102.125) by
 kwepemi500011.china.huawei.com (7.221.188.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 13 Sep 2022 09:47:34 +0800
Message-ID: <631FE136.6020409@hisilicon.com>
Date:   Tue, 13 Sep 2022 09:47:34 +0800
From:   Wei Xu <xuwei5@hisilicon.com>
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To:     John Garry <john.garry@huawei.com>
CC:     <andriy.shevchenko@linux.intel.com>, <linuxarm@huawei.com>,
        <rafael.j.wysocki@intel.com>, <linux-kernel@vger.kernel.org>,
        <soc@kernel.org>, <yangyingliang@huawei.com>,
        <xuwei5@hisilicon.com>
Subject: Re: [PATCH v3 0/5] Misc hisi_lpc changes
References: <1662366186-233933-1-git-send-email-john.garry@huawei.com>
In-Reply-To: <1662366186-233933-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.125]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500011.china.huawei.com (7.221.188.124)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On 2022/9/5 16:23, John Garry wrote:
> Hi Xu Wei,
> 
> This is a series of small improvements to the driver from Andy
> and myself.
> 
> Andy sent his patches originally in the following:
> https://lore.kernel.org/lkml/20220708210859.6774-1-andriy.shevchenko@linux.intel.com/
> 
> Please consider sending through the arm-soc tree for v6.1 .
> 
> Based on v6.0-rc3.
> 
> Differences to v2:
> - Fix handling of platform_device_register_full() error (Andy)
> - Add Andy's RB tag (thanks!)
> 
> Differences to v1:
> - remove blank lines in patch 5/5, as requested by Andy
> 
> Thanks,
> John
> 
> Andy Shevchenko (4):
>   bus: hisi_lpc: Don't dereference fwnode handle
>   bus: hisi_lpc: Use devm_platform_ioremap_resource
>   bus: hisi_lpc: Correct error code for timeout
>   bus: hisi_lpc: Don't guard ACPI IDs with ACPI_PTR()
> 
> John Garry (1):
>   bus: hisi_lpc: Use platform_device_register_full()
> 
>  drivers/bus/hisi_lpc.c | 96 +++++++++++++++++++-----------------------
>  1 file changed, 44 insertions(+), 52 deletions(-)
> 

Thanks!
Series applied to the hisilicon driver tree.

Best Regards,
Wei
