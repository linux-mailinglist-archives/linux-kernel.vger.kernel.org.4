Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B77EF69965B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 14:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjBPNvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 08:51:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjBPNvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 08:51:32 -0500
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5ED53B0C2;
        Thu, 16 Feb 2023 05:51:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1676555471; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=n3e6V0OoPliLCxnynkYX1BT0oz7+TNyIk8cvea0eiqe4uhM7lO/JuA1xYU4LF6Pmu849emz0P83ccBnCu9I8xfoeNLdO31As5D7so3LUl6ajWqeLvaYfNll8kW6Am9AQVQ7oAMehd5swybxSegfKpfRmCOzHxAt3eC8p6j+9NYc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1676555471; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=oLQJFu/YeHJZ+e6PfLY6thqunBy9QxUaZpPGg1FO/6c=; 
        b=TZjmtyk4aNX8lmMDa8z05GXFEswC/XBFhHCG7FcGwH+yGYwufq4MqXV1qUL3rJvrt+cbW0eITS/EX9lqq/1YARtTPQ08KQXu/wvpzqS+mgA4we6WbNKGoUbK9Ca+ZY5atYQCyRGVuL7dRuPaoxJkd1YvmBgcYfkKdgHme+J6jqM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1676555471;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=oLQJFu/YeHJZ+e6PfLY6thqunBy9QxUaZpPGg1FO/6c=;
        b=gpemIUQvj1NFOsbN+oIYoYJhtN85CpnezhoiwOevE2FgZUTT82C5P0v41oOomAth
        5+e/V+j7szwyaemk5Z0DndHE5YFJt0orAMRyHIdwzjg3Kk/kAnY/hXCXTYV3x1X9Rne
        zbN+TM9mUbHjGtk1euDfw9IYlekPufisbh5I22b0=
Received: from [10.10.10.3] (37.120.152.236 [37.120.152.236]) by mx.zohomail.com
        with SMTPS id 1676555466955976.4479803295967; Thu, 16 Feb 2023 05:51:06 -0800 (PST)
Message-ID: <88ef812b-b8e8-f640-f9f7-a1579ea69d31@arinc9.com>
Date:   Thu, 16 Feb 2023 16:50:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 2/2] pinctrl: add mt7981 pinctrl driver
To:     Daniel Golle <daniel@makrotopia.org>, linux-gpio@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sean Wang <sean.wang@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Miles Chen <miles.chen@mediatek.com>,
        Edward-JW Yang <edward-jw.yang@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>,
        Sam Shih <sam.shih@mediatek.com>,
        Jianhui Zhao <zhaojh329@gmail.com>
References: <cover.1674693008.git.daniel@makrotopia.org>
 <ef5112946d16cacc67e65e439ba7b52a9950c1bb.1674693008.git.daniel@makrotopia.org>
Content-Language: en-US
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <ef5112946d16cacc67e65e439ba7b52a9950c1bb.1674693008.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On 26.01.2023 03:34, Daniel Golle wrote:
> Add pinctrl driver for the MediaTek MT7981 SoC, based on the driver
> which can also be found the SDK.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>   drivers/pinctrl/mediatek/Kconfig          |    5 +
>   drivers/pinctrl/mediatek/Makefile         |    1 +
>   drivers/pinctrl/mediatek/pinctrl-mt7981.c | 1048 +++++++++++++++++++++
>   3 files changed, 1054 insertions(+)
>   create mode 100644 drivers/pinctrl/mediatek/pinctrl-mt7981.c
> 
> diff --git a/drivers/pinctrl/mediatek/Kconfig b/drivers/pinctrl/mediatek/Kconfig
> index fed02c6fea062..f20c28334bcbf 100644
> --- a/drivers/pinctrl/mediatek/Kconfig
> +++ b/drivers/pinctrl/mediatek/Kconfig
> @@ -127,6 +127,11 @@ config PINCTRL_MT7622
>   	default ARM64 && ARCH_MEDIATEK
>   	select PINCTRL_MTK_MOORE
>   
> +config PINCTRL_MT7981
> +	bool "Mediatek MT7981 pin control"
> +	depends on OF
> +	select PINCTRL_MTK_MOORE
> +

Is there a reason why you removed these lines from v1?

+	depends on ARM64 || COMPILE_TEST
+	default ARM64 && ARCH_MEDIATEK

Arınç
