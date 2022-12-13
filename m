Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39CFB64ADA3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 03:34:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233757AbiLMCe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 21:34:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbiLMCe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 21:34:26 -0500
X-Greylist: delayed 573 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 12 Dec 2022 18:34:25 PST
Received: from mail-m11880.qiye.163.com (mail-m11880.qiye.163.com [115.236.118.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54099BF40;
        Mon, 12 Dec 2022 18:34:25 -0800 (PST)
Received: from [172.16.12.69] (unknown [58.22.7.114])
        by mail-m11880.qiye.163.com (Hmail) with ESMTPA id 9E6AA2020F;
        Tue, 13 Dec 2022 10:24:43 +0800 (CST)
Message-ID: <faea4932-add6-fc51-836d-b113e8c9a194@rock-chips.com>
Date:   Tue, 13 Dec 2022 10:24:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Cc:     shawn.lin@rock-chips.com, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v1 2/3] mmc: starfive: Add sdio/emmc driver support
Content-Language: en-GB
To:     William Qiu <william.qiu@starfivetech.com>
References: <20221207131731.1291517-1-william.qiu@starfivetech.com>
 <20221207131731.1291517-3-william.qiu@starfivetech.com>
From:   Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20221207131731.1291517-3-william.qiu@starfivetech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFJSktLSjdXWS1ZQUlXWQ8JGhUIEh9ZQVkaTENCVh5DHUgdTRlCHUMdQ1UTARMWGhIXJB
        QOD1lXWRgSC1lBWU5DVUlJVUxVSkpPWVdZFhoPEhUdFFlBWU9LSFVKSktISkxVSktLVUtZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Oj46Shw*Vj0vAk4OGTgeIiw5
        LUsaCzRVSlVKTUxLQ0JDSUNPSElIVTMWGhIXVQgTGgwVVRcSFTsJFBgQVhgTEgsIVRgUFkVZV1kS
        C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUlCQ0g3Bg++
X-HM-Tid: 0a85094c758b2eb6kusn9e6aa2020f
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 2022/12/7 21:17, William Qiu wrote:
> Add sdio/emmc driver support for StarFive JH7110 soc.
> 
> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> ---
>   MAINTAINERS                        |   6 +
>   drivers/mmc/host/Kconfig           |  10 ++
>   drivers/mmc/host/Makefile          |   1 +
>   drivers/mmc/host/dw_mmc-starfive.c | 197 +++++++++++++++++++++++++++++
>   4 files changed, 214 insertions(+)
>   create mode 100644 drivers/mmc/host/dw_mmc-starfive.c
> 

...

> +
> +static unsigned long dw_mci_starfive_caps[] = {
> +	MMC_CAP_CMD23,
> +	MMC_CAP_CMD23,
> +	MMC_CAP_CMD23
> +};
> +

....

> +	host->priv = priv;
> +
> +	return 0;
> +}
> +
> +static const struct dw_mci_drv_data starfive_data = {
> +	.caps = dw_mci_starfive_caps,
> +	.num_caps = ARRAY_SIZE(dw_mci_starfive_caps),

use ".common_caps = MMC_CAP_CMD23" instead.

> +	.set_ios = dw_mci_starfive_set_ios,
> +	.parse_dt = dw_mci_starfive_parse_dt,
> +	.execute_tuning = dw_mci_starfive_execute_tuning,
> +};
> +
> +static const struct of_device_id dw_mci_starfive_match[] = {

