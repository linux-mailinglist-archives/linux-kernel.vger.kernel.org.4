Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3E96E214F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 12:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbjDNKyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 06:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjDNKyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 06:54:02 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2542719;
        Fri, 14 Apr 2023 03:54:01 -0700 (PDT)
Received: from [192.168.1.90] (unknown [188.27.34.213])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7E0F5660321F;
        Fri, 14 Apr 2023 11:53:59 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681469640;
        bh=+5VJd3RWjLm3EX7CJr3/WYFLAQ8x6Xt5f2VD+oJiw4o=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Mwdklb+hf1FBuaMCpqWnS+2EjcPRbbunJoxjubrnY6nYElsYcJmUqkxgsHKKO3rlN
         +/8TvupjfLl0cx6SPytCU3X/SGKylleDOiMCZkgkgZAA7d4uUIWA4UqF8fFJGWOkG1
         hPwjkCTVCkncVpV1Me9NBe+8Wv1VMaZvuKhsAecTxiEoQErQkrVeQ7qvkQzcHb7phS
         iY/O2dUXfZFCf0SyN53V63Y41alvPwokHaaTKYnLk9eGfTf64eIwHUmVZo/DLpNdzT
         CAa8VrMKRFVrhjjhvaUJsYcC1e7hsm0DtngjIYTe3STUJN2w+/Y7neU0wbjDqOZHOf
         p7bUUR0Q8PSiw==
Message-ID: <4d66fb01-76da-be30-26dd-908ee1a22eb1@collabora.com>
Date:   Fri, 14 Apr 2023 13:53:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/3] arm64: dts: rockchip: Use generic name for es8316 on
 rk3588-rock-5b
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Christopher Obbard <chris.obbard@collabora.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Shreeya Patel <shreeya.patel@collabora.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20230414093411.113787-1-cristian.ciocaltea@collabora.com>
 <20230414093411.113787-3-cristian.ciocaltea@collabora.com>
 <fe746692-fed3-6635-8658-4e91d30f2aa8@linaro.org>
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <fe746692-fed3-6635-8658-4e91d30f2aa8@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/14/23 13:26, Krzysztof Kozlowski wrote:
> On 14/04/2023 11:34, Cristian Ciocaltea wrote:
>> Use generic 'audio-codec' name for es8316 node on Rock 5B board.
>>
>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>> ---
>>  arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
>> index 62750beb12aa..8cc97d146a73 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
>> +++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
>> @@ -72,7 +72,7 @@ hym8563: rtc@51 {
>>  &i2c7 {
>>  	status = "okay";
>>  
>> -	es8316: es8316@11 {
>> +	es8316: audio-codec@11 {
> 
> This is a trivial change. Fix all instances in all subarch/platform DTS.
> Not board-per-board.

Looks like only the rockchip DTS are affected, but not quite sure how to 
proceed in the case of 'es8316: codec@', should I change them to 
'es8316: audio-codec@' as well?

arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts:   es8316: es8316@11 {
arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi:     es8316: codec@11 {
arch/arm64/boot/dts/rockchip/rk3399-rockpro64-v2.dts:   es8316: codec@10 {
arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts:      es8316: codec@11 {
