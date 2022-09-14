Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D357E5B81F2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 09:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbiINHTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 03:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiINHTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 03:19:50 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A21A1AF11
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 00:19:48 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MSBSh3ph9zlVn6;
        Wed, 14 Sep 2022 15:15:48 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 14 Sep 2022 15:19:45 +0800
Message-ID: <57857e40-503a-25af-2f5d-2e14b9117a5f@huawei.com>
Date:   Wed, 14 Sep 2022 15:19:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
From:   Ruan Jinjie <ruanjinjie@huawei.com>
Subject: Re: [PATCH -next] ARM: mmp: Make mmp2_resource_gpio static
To:     <lkundrak@v3.sk>, <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20220901004524.81383-1-ruanjinjie@huawei.com>
Content-Language: en-US
In-Reply-To: <20220901004524.81383-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping.

On 2022/9/1 8:45, ruanjinjie wrote:
> The symbol is not used outside of the file, so mark it static.
> 
> Fixes the following warning:
> 
> ./arch/arm/mach-mmp/mmp2.c:157:17: warning: symbol 'mmp2_resource_gpio' was not declared. Should it be static?
> 
> Signed-off-by: ruanjinjie <ruanjinjie@huawei.com>
> ---
>  arch/arm/mach-mmp/mmp2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-mmp/mmp2.c b/arch/arm/mach-mmp/mmp2.c
> index bbc4c2274de3..696bc1856e6d 100644
> --- a/arch/arm/mach-mmp/mmp2.c
> +++ b/arch/arm/mach-mmp/mmp2.c
> @@ -154,7 +154,7 @@ MMP2_DEVICE(asram, "asram", -1, NONE, 0xe0000000, 0x4000);
>  /* 0xd1000000 ~ 0xd101ffff is reserved for secure processor */
>  MMP2_DEVICE(isram, "isram", -1, NONE, 0xd1020000, 0x18000);
>  
> -struct resource mmp2_resource_gpio[] = {
> +static struct resource mmp2_resource_gpio[] = {
>  	{
>  		.start	= 0xd4019000,
>  		.end	= 0xd4019fff,
