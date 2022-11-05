Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE64461D85C
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 08:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiKEHUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 03:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiKEHUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 03:20:48 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53342BF43;
        Sat,  5 Nov 2022 00:20:46 -0700 (PDT)
Received: from kwepemi500015.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4N486D4hrrz15MCj;
        Sat,  5 Nov 2022 15:20:36 +0800 (CST)
Received: from [10.40.188.234] (10.40.188.234) by
 kwepemi500015.china.huawei.com (7.221.188.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 5 Nov 2022 15:20:43 +0800
Subject: Re: [PATCH] spi: hisi-sfc-v3xx: Fix a typo ("duall")
To:     =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>,
        <linux-spi@vger.kernel.org>
CC:     John Garry <john.garry@huawei.com>,
        Mark Brown <broonie@kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221103190052.915755-1-j.neuschaefer@gmx.net>
From:   Jay Fang <f.fangjian@huawei.com>
Message-ID: <d585e334-6b27-4fc5-d0b4-d433780c548c@huawei.com>
Date:   Sat, 5 Nov 2022 15:20:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20221103190052.915755-1-j.neuschaefer@gmx.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.40.188.234]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500015.china.huawei.com (7.221.188.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/11/4 3:00, Jonathan Neuschäfer wrote:
> Simple typo, simple fix.
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> ---
>  drivers/spi/spi-hisi-sfc-v3xx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-hisi-sfc-v3xx.c b/drivers/spi/spi-hisi-sfc-v3xx.c
> index d3a23b1c2a4c5..f07d1045a30a2 100644
> --- a/drivers/spi/spi-hisi-sfc-v3xx.c
> +++ b/drivers/spi/spi-hisi-sfc-v3xx.c
> @@ -165,7 +165,7 @@ static int hisi_sfc_v3xx_adjust_op_size(struct spi_mem *mem,
>  }
> 
>  /*
> - * The controller only supports Standard SPI mode, Duall mode and
> + * The controller only supports Standard SPI mode, Dual mode and
>   * Quad mode. Double sanitize the ops here to avoid OOB access.
>   */
>  static bool hisi_sfc_v3xx_supports_op(struct spi_mem *mem,
> --
> 2.35.1
> 
> .
> 
Thanks

Acked-by: Jay Fang <f.fangjian@huawei.com>
