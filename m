Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB73D7409F0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 09:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbjF1Hyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 03:54:46 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:21995 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbjF1Hxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 03:53:43 -0400
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QrYHN0XPDzlWQn;
        Wed, 28 Jun 2023 15:34:08 +0800 (CST)
Received: from [10.67.102.37] (10.67.102.37) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 28 Jun
 2023 15:36:52 +0800
Subject: Re: [PATCH net-next 06/10] net: hns: Remove unnecessary (void*)
 conversions
To:     wuych <yunchuan@nfschina.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
References: <20230628024501.1440419-1-yunchuan@nfschina.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
From:   Hao Lan <lanhao@huawei.com>
Message-ID: <df1d47c1-9f0a-7f27-f161-811e1695955f@huawei.com>
Date:   Wed, 28 Jun 2023 15:36:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20230628024501.1440419-1-yunchuan@nfschina.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.37]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/6/28 10:45, wuych wrote:
> Pointer variables of void * type do not require type cast.
> 
> Signed-off-by: wuych <yunchuan@nfschina.com>
> ---
>  drivers/net/ethernet/hisilicon/hns_mdio.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 

Hi wuych,
Thank you for your patch.

Reviewed-by: Hao Lan <lanhao@huawei.com>

Yours,
Hao Lan
