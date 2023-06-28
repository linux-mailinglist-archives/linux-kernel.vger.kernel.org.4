Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD062740A4F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 10:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232318AbjF1IBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 04:01:55 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:44128 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232758AbjF1H7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 03:59:49 -0400
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QrYNB6tBxzMpWw;
        Wed, 28 Jun 2023 15:38:18 +0800 (CST)
Received: from [10.67.102.37] (10.67.102.37) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 28 Jun
 2023 15:41:29 +0800
Subject: Re: [PATCH net-next 00/10] Remove unnecessary (void*) conversions
To:     wuych <yunchuan@nfschina.com>, <andrew@lunn.ch>,
        <f.fainelli@gmail.com>, <olteanv@gmail.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <irusskikh@marvell.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <jesse.brandeburg@intel.com>,
        <anthony.l.nguyen@intel.com>, <steve.glendinning@shawell.net>,
        <iyappan@os.amperecomputing.com>, <keyur@os.amperecomputing.com>,
        <quan@os.amperecomputing.com>, <hkallweit1@gmail.com>,
        <linux@armlinux.org.uk>, <mostrows@earthlink.net>, <xeb@mail.ru>,
        <qiang.zhao@nxp.com>
References: <20230628024121.1439149-1-yunchuan@nfschina.com>
CC:     <yangyingliang@huawei.com>, <linux@rempel-privat.de>,
        <ansuelsmth@gmail.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <intel-wired-lan@lists.osuosl.org>,
        <linuxppc-dev@lists.ozlabs.org>, <kernel-janitors@vger.kernel.org>
From:   Hao Lan <lanhao@huawei.com>
Message-ID: <1f5652f7-7eb2-11f0-4a07-c87f2992e509@huawei.com>
Date:   Wed, 28 Jun 2023 15:41:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20230628024121.1439149-1-yunchuan@nfschina.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.37]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/6/28 10:41, wuych wrote:
> Remove (void*) conversions under "drivers/net" directory.
> According to the suggestion[1] of Jakub Kicinski, send these patches
> in series of 10. 
> 
> wuych (10):
>   net: dsa: ar9331: remove unnecessary (void*) conversions
>   net: dsa: qca8k: remove unnecessary (void*) conversions
>   atlantic:hw_atl2:hw_atl2_utils_fw: Remove unnecessary (void*)
>     conversions
>   ice: Remove unnecessary (void*) conversions
>   ethernet: smsc: remove unnecessary (void*) conversions
>   net: hns: Remove unnecessary (void*) conversions
>   net: hns3: remove unnecessary (void*) conversions
>   net: mdio: Remove unnecessary (void*) conversions
>   net: ppp: remove unnecessary (void*) conversions
>   net: wan: Remove unnecessary (void*) conversions
> 

Hi wuych,
Thank you for your patch.
The following two patches conflict with the net-next branch, and others have modified the related code.
Please compile your series in net and net-next branch and upload your series again.
  net: dsa: ar9331: remove unnecessary (void*) conversions
  net: dsa: qca8k: remove unnecessary (void*) conversions

Yours,
Hao Lan
