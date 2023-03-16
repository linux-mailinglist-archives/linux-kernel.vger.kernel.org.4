Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9596BCF52
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 13:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbjCPMWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 08:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjCPMWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 08:22:15 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82BB198EB6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 05:22:13 -0700 (PDT)
Received: from kwepemi500011.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PcmXH61zKznX0N;
        Thu, 16 Mar 2023 20:19:11 +0800 (CST)
Received: from [10.67.103.39] (10.67.103.39) by kwepemi500011.china.huawei.com
 (7.221.188.124) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 16 Mar
 2023 20:22:10 +0800
Message-ID: <641309F2.8050503@hisilicon.com>
Date:   Thu, 16 Mar 2023 20:22:10 +0800
From:   Wei Xu <xuwei5@hisilicon.com>
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To:     David Yang <mmyangfl@gmail.com>
CC:     Russell King <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <xuwei5@hisilicon.com>
Subject: Re: [PATCH 0/3] ARM: hisi: Support Hi3798 SoC
References: <20230316051936.1775033-1-mmyangfl@gmail.com>
In-Reply-To: <20230316051936.1775033-1-mmyangfl@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.39]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500011.china.huawei.com (7.221.188.124)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On 2023/3/16 13:19, David Yang wrote:
> This series enables booting Hi3798 SoCs.
> 
> David Yang (3):
>   ARM: hisi: Add S40 IO map
>   ARM: hisi: Add S5 IO map
>   ARM: hisi: Support Hi3798 SoC
> 
>  arch/arm/mach-hisi/Makefile    |   2 +-
>  arch/arm/mach-hisi/core.h      |   6 ++
>  arch/arm/mach-hisi/headsmp.S   |  36 ++++++++++
>  arch/arm/mach-hisi/hisilicon.c |  70 ++++++++++++++++++
>  arch/arm/mach-hisi/hotplug.c   | 120 +++++++++++++++++++++++++++++--
>  arch/arm/mach-hisi/platsmp.c   | 128 +++++++++++++++++++++++++++++++++
>  6 files changed, 357 insertions(+), 5 deletions(-)
>  create mode 100644 arch/arm/mach-hisi/headsmp.S
> 

Thanks!
Series are fine to me.
Please add the device tree as well.
And I am not sure whether the ARMv7 based Hi3798 SoCs are out of support or not.
I checked our website and it seems current generation SoCs are based on ARMv8.

Best Regards,
Wei
