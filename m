Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6D26712257
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 10:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242741AbjEZIge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 04:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242184AbjEZIgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 04:36:32 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E51F12F;
        Fri, 26 May 2023 01:36:28 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2F34B6606E83;
        Fri, 26 May 2023 09:36:26 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685090187;
        bh=Y+IJxiWc633XOBZbB2+BJidraljDp8EXXiUQb5yaXZU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kpszq4hXIKce8PXvPTFmhLX/QqAmnkIe2GlYur04oNEP2DB+Ty24ObhrS9VHyNi3f
         jvPhgysl5tFu9/L/tA5WQQq+iYFKmPnirKuzSetjd7j1x1VE2eUStQkfnCHxkputL7
         B13Ve7LfYoMADZslX7CQrB8U08I+vDZ15MrHQQtfmgeGjC6fRO5jYkC4vreXnY6q2u
         UISI0P0JCQOYYCf8os8otZ9K81NSeX6/N5K2aLr0bthLzegi0fmqtqrB9467rdOUQ3
         OrIZZucUTGg3otczqteuOumrR6oNUmi21vmfZDCX9sC3j48qhE02QlmP6nUx7c1hxq
         Mb1TGrXiu7mjg==
Message-ID: <17ac612b-4464-4a97-4e4d-5e053b760130@collabora.com>
Date:   Fri, 26 May 2023 10:36:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2 2/8] iio: adc: rockchip_saradc: Add support for RK3588
Content-Language: en-US
To:     Shreeya Patel <shreeya.patel@collabora.com>, jic23@kernel.org,
        lars@metafoo.de, heiko@sntech.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sebastian.reichel@collabora.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, gustavo.padovan@collabora.com,
        serge.broslavsky@collabora.com, Simon Xue <xxm@rock-chips.com>
References: <20230525212712.255406-1-shreeya.patel@collabora.com>
 <20230525212712.255406-3-shreeya.patel@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230525212712.255406-3-shreeya.patel@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 25/05/23 23:27, Shreeya Patel ha scritto:
> From: Simon Xue <xxm@rock-chips.com>
> 
> Add new start and read functions to support rk3588 device.
> Also, add a device compatible string for the same.
> 
> Signed-off-by: Simon Xue <xxm@rock-chips.com>
> Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
> ---
> 
> Changes in v2
>    - Add a from address.
>    - Create separate patches for adding new device support and changes to
>      the old device code.
>    - Make use of FIELD_PREP.
> 
>   drivers/iio/adc/rockchip_saradc.c | 69 +++++++++++++++++++++++++++++++
>   1 file changed, 69 insertions(+)
> 
> diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
> index 21f9d92a6af4..31637440be83 100644
> --- a/drivers/iio/adc/rockchip_saradc.c
> +++ b/drivers/iio/adc/rockchip_saradc.c

You're missing a header...

#include <linux/bitfield.h>

after adding that, you can get my

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


Cheers,
Angelo
