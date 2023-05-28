Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8C0714098
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 23:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjE1VZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 17:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjE1VZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 17:25:42 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE5F83;
        Sun, 28 May 2023 14:25:41 -0700 (PDT)
Received: from [IPV6:2405:201:0:21ea:e49:10dd:40c0:e842] (unknown [IPv6:2405:201:0:21ea:e49:10dd:40c0:e842])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: shreeya)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C6BA566028F5;
        Sun, 28 May 2023 22:25:37 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685309140;
        bh=WkZ6oYe+0LR8m4rMtcElrRUUrT+hfU8TiYr3DHMTugg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=RTBgXrB/mf3M7/iO+TLsMxUj1P4aQ83D1eWUFeIY78pLRXJO4lv6VIlq7X2tIhvJ/
         Juuor+larkNDkM7kSVgtvYIC61QZ690btJ2BT8hoQrY4jJPyC9l22GXdi1HP8eh1x9
         Z3EvLU6plFlc90o2NR+fpWkgRrKwM/DYeiXcOY9cBSVf9lSqQ1AiYQcTVRYUjeeB9j
         TxP7/Lxok82+4XW38tI41IdHLyEfBSS0FJSIkJCEd8KtVPPJa/XVMaoOub/9gFgNus
         JlavK+SQbcL2U29r+5S8JFjzB1KTtWa+tPP+HPnS5682w7vH5vEpwmUob8LXx0LAD5
         /JGAzhsmYbgxg==
Message-ID: <b11c2009-754d-6ca2-6d0e-9c303f4da9e8@collabora.com>
Date:   Mon, 29 May 2023 02:55:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 0/8] RK3588 ADC support
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     lars@metafoo.de, heiko@sntech.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sebastian.reichel@collabora.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, gustavo.padovan@collabora.com,
        serge.broslavsky@collabora.com
References: <20230525212712.255406-1-shreeya.patel@collabora.com>
 <20230528174614.4dc5cd01@jic23-huawei>
From:   Shreeya Patel <shreeya.patel@collabora.com>
In-Reply-To: <20230528174614.4dc5cd01@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 28/05/23 22:16, Jonathan Cameron wrote:
> On Fri, 26 May 2023 02:57:04 +0530
> Shreeya Patel <shreeya.patel@collabora.com> wrote:
>
>> This patch series adds ADC support for RK3588 and updates
>> the DT bindings for the same.
>>
>> To test ADC support on Rock 5B board, a voltage divider circuit
>> was created using the gpio pin 22 ( SARADC_IN4 ) and few more
>> tests were ran for testing the buffer and trigger support using
>> the iio_generic_buffer tool.
>>
> FWIW I don't have any additional comments on this beyond agreeing
> those made by others need addressing.
>
> Fingers crossed for v3.

Thanks Jonathan, I'll send a v3 after making the changes mentioned by 
Dmitry and Angelo.


Regards,
Shreeya Patel

>
> Jonathan
>
>> Changes in v2
>>    - Add from address in patches 1 and 2.
>>    - Create separate patches for adding new device support and changes to
>>      the old device code.
>>    - Make use of FIELD_PREP in patch 2.
>>    - Move the enablement of clocks at it's original position in patch 3
>>    - Add Reviewed-by tag in patches 4 and 5.
>>    - Add an Acked-by tag in patch 8.
>>
>> Shreeya Patel (8):
>>    iio: adc: rockchip_saradc: Add callback functions
>>    iio: adc: rockchip_saradc: Add support for RK3588
>>    iio: adc: rockchip_saradc: Make use of devm_clk_get_enabled
>>    iio: adc: rockchip_saradc: Use of_device_get_match_data
>>    iio: adc: rockchip_saradc: Match alignment with open parenthesis
>>    iio: adc: rockchip_saradc: Use dev_err_probe
>>    arm64: dts: rockchip: Add DT node for ADC support in RK3588
>>    dt-bindings: iio: adc: Add rockchip,rk3588-saradc string
>>
>>   .../bindings/iio/adc/rockchip-saradc.yaml     |   1 +
>>   arch/arm64/boot/dts/rockchip/rk3588s.dtsi     |  12 +
>>   drivers/iio/adc/rockchip_saradc.c             | 262 +++++++++++-------
>>   3 files changed, 168 insertions(+), 107 deletions(-)
>>
>
