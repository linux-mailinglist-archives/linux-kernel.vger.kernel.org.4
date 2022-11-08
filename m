Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A21C620E8F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 12:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233936AbiKHLUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 06:20:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234084AbiKHLUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 06:20:08 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F221A385;
        Tue,  8 Nov 2022 03:20:08 -0800 (PST)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4N65Gz49YJz15MQt;
        Tue,  8 Nov 2022 19:19:55 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 8 Nov 2022 19:20:06 +0800
CC:     <yangyicong@hisilicon.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-doc@vger.kernel.org>, <linuxarm@huawei.com>,
        <f.fangjian@huawei.com>, <prime.zeng@huawei.com>,
        "shenyang (M)" <shenyang39@huawei.com>
Subject: Re: [PATCH 0/3] Add TLP filter support and some fixes for HiSilicon
 PCIe PMU
To:     Shaokun Zhang <zhangshaokun@hisilicon.com>, <liuqi6124@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <jonathan.cameron@huawei.com>
References: <20221025113242.58271-1-yangyicong@huawei.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <75f9fdb7-cd2f-f208-5084-f47468a5f84c@huawei.com>
Date:   Tue, 8 Nov 2022 19:20:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20221025113242.58271-1-yangyicong@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

a gentle ping for this...

Thanks.

On 2022/10/25 19:32, Yicong Yang wrote:
> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> HiSilicon PCIe PMU support count the bandwidth of TLP headers, TLP payloads
> or both. Add support for it. User can set this through perf tool's
> 'len_mode' like:
> 
>   $# perf stat -e hisi_pcie0_core0/rx_mrd_flux,len_mode=0x1/ sleep 5
> 
> Also includes 2 fixes of both driver and documentation in this series.
> 
> Yicong Yang (3):
>   drivers/perf: hisi: Fix some event id for hisi-pcie-pmu
>   docs: perf: Fix PMU instance name of hisi-pcie-pmu
>   drivers/perf: hisi: Add TLP filter support
> 
>  .../admin-guide/perf/hisi-pcie-pmu.rst        | 42 ++++++++++++++-----
>  drivers/perf/hisilicon/hisi_pcie_pmu.c        | 22 +++++++---
>  2 files changed, 48 insertions(+), 16 deletions(-)
> 
