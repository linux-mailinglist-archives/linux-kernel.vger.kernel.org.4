Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A57F6D9F00
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 19:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239451AbjDFRko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 13:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjDFRkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 13:40:42 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8403F49CE;
        Thu,  6 Apr 2023 10:40:41 -0700 (PDT)
Received: from [192.168.1.90] (unknown [188.27.34.213])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9DEA566031C3;
        Thu,  6 Apr 2023 18:40:39 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680802840;
        bh=i9yX2DGk4T8IBDLkJ0LdT+X0+bt5zNDBNa+H0C5qr4o=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=MuGkj1xg7PXFt6lGaIluynmcE5Fzs4tAVXEJbJtuQdOQz8deUcEdzf7lCC6T1Z8tB
         LhnHK99Xy1VppLmB8G760TdsDOiwFjIuVwcqJ4nqim5eJIUxabKUkNV4xE33lWIvdg
         dDyTKGYJY5RNfmvwmtNjRh1lDWgxHPq6nrhlvl9d11gdgwhaRgGBL+yYvw7UcdTYzt
         f6CT5xDf9h0N+p6WSKw8rOje8Du93cp3ZXVJXFPv/m9QrZJjOVN1MomDG+FGl76EBQ
         GQhQK6QnN3j6mV7C+GXZE0+7q4+gYxJlbGD2/KLisWx9FFnzzQDkg/KtOJV9abSnw5
         4fLKndyp0AVrw==
Message-ID: <7b4617a5-7daf-818e-5a72-b4fc7ea4c4f5@collabora.com>
Date:   Thu, 6 Apr 2023 20:40:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 8/8] regulator: fan53555: Add support for RK860X
Content-Language: en-US
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Joseph Chen <chenjh@rock-chips.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kernel@collabora.com
References: <20230405194721.821536-1-cristian.ciocaltea@collabora.com>
 <20230405194721.821536-9-cristian.ciocaltea@collabora.com>
 <4115e47e-b64b-391a-493c-701c8de0565b@linaro.org>
 <53c803ce-2607-6fd1-485e-e19eb961fd08@collabora.com>
 <231b72cd-352c-10a9-8695-a04f61e36568@linaro.org>
 <8fc46929-6d73-ea75-f44f-b83820c0e5df@collabora.com>
In-Reply-To: <8fc46929-6d73-ea75-f44f-b83820c0e5df@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/6/23 14:15, Cristian Ciocaltea wrote:
> On 4/6/23 14:03, Krzysztof Kozlowski wrote:
>> On 06/04/2023 12:08, Cristian Ciocaltea wrote:
>>>>> +	}, {
>>>>> +		.name = "rk8602",
>>>>> +		.driver_data = RK8602_VENDOR_ROCKCHIP
>>>>> +	}, {
>>>>> +		.name = "rk8603",
>>>>> +		.driver_data = RK8602_VENDOR_ROCKCHIP
>>>>
>>>> Why do you need this entry match data if it is the same as rk8602?
>>>
>>> This is consistent with the handling of syr827 and syr828:
>>>
>>> 		.name = "syr827",
>>> 		.driver_data = FAN53555_VENDOR_SILERGY
>>> 	}, {
>>> 		.name = "syr828",
>>> 		.driver_data = FAN53555_VENDOR_SILERGY
>>
>> Yeah, I understand, but it's not necessarily the pattern we want to
>> continue. Unless these devices are not really compatible?
> 
> They are compatible, so should I simply drop the rk8601 and rk8603 entries?

I dropped the entries in [v2] and updated the binding in PATCH 1/8.
Note I didn't add the "Acked-by" for the latter, since the changes are 
significant and require a new review.

Thanks,
Cristian

v2: https://lore.kernel.org/lkml/20230406171806.948290-1-cristian.ciocaltea@collabora.com/
