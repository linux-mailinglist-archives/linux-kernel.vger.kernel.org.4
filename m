Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CFE66510A6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 17:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbiLSQon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 11:44:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbiLSQol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 11:44:41 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3677A25D2;
        Mon, 19 Dec 2022 08:44:40 -0800 (PST)
Received: from [IPV6:2a01:e0a:120:3210:f69c:5603:d4ce:7aa2] (unknown [IPv6:2a01:e0a:120:3210:f69c:5603:d4ce:7aa2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9A2EA660037C;
        Mon, 19 Dec 2022 16:44:38 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1671468279;
        bh=E0r3d2ox1oE9eTKDNfe4pYrofvO/8Q+8UC+WxtJKOUE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=DuGMS5QH7ZJSZPLa55sJEBRHIeiLRJgrJoH29Aij2zShuTiq5+P/mBsQnx/GroFKV
         gLqu+BpsXOSxrA1cFhHdsoedC9oxlxFaK+mU4seAXg5R7KrOs6FRkVmt88/DNPdzST
         u/nmCae7I3YT8cKE7S6s+hkubloGxnFlzviMHjYu5SUXvt9lRTUcLAXRRP9mvrH9a3
         TglSlRJ8o5EsfZ1EKOBJJ3L+KV2+o/WJX0tloCDcdS0MPuQXmhEQ0kNfRb8/wd5/n1
         c16c3FN/sBIG2rd3qXimaIyZJOvSNr0lWrwkJd9Jcu1TDsQDNBfsg2HA1ClCEZVwvt
         zXSKiWS29wDEQ==
Message-ID: <ec38d798-1b7b-2fc2-5be8-30ef28330760@collabora.com>
Date:   Mon, 19 Dec 2022 17:44:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v1 1/9] dt-bindings: media: rockchip-vpu: Add rk3588 vpu
 compatible
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        daniel.almeida@collabora.com, nicolas.dufresne@collabora.co.uk
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20221219155616.848690-1-benjamin.gaignard@collabora.com>
 <20221219155616.848690-2-benjamin.gaignard@collabora.com>
 <15146b26-438b-698a-9e17-cb4ef2318420@linaro.org>
Content-Language: en-US
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <15146b26-438b-698a-9e17-cb4ef2318420@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 19/12/2022 à 17:06, Krzysztof Kozlowski a écrit :
> On 19/12/2022 16:56, Benjamin Gaignard wrote:
>> Add compatible for rk3588 AV1 vpu decoder.
>>
>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>> ---
>>   Documentation/devicetree/bindings/media/rockchip-vpu.yaml | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/media/rockchip-vpu.yaml b/Documentation/devicetree/bindings/media/rockchip-vpu.yaml
>> index 6cc4d3e5a61d..8454df53f5cb 100644
>> --- a/Documentation/devicetree/bindings/media/rockchip-vpu.yaml
>> +++ b/Documentation/devicetree/bindings/media/rockchip-vpu.yaml
>> @@ -24,6 +24,7 @@ properties:
>>             - rockchip,rk3399-vpu
>>             - rockchip,px30-vpu
>>             - rockchip,rk3568-vpu
>> +          - rockchip,rk3588-av1-vpu
> Why "av1" suffix? Is there another type (different device, different
> programming model) expected on rk3588?

Yes there is 4 different vpu on rk3588.
This one only does av1.

>
> Best regards,
> Krzysztof
>
