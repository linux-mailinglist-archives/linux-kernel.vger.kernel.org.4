Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65234665519
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 08:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235759AbjAKHYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 02:24:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbjAKHY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 02:24:27 -0500
X-Greylist: delayed 384 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 10 Jan 2023 23:24:26 PST
Received: from mx.msync.work (mx.msync.work [185.250.0.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8E4E026
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 23:24:26 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9654D31D6E;
        Wed, 11 Jan 2023 07:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
        t=1673421480; h=from:subject:date:message-id:to:cc:mime-version:content-type:
         content-transfer-encoding:content-language:in-reply-to:references;
        bh=ScS9I1WkTHrH68wa+bjFz7/gI6rsGdF7W9IQ42fA5kU=;
        b=T/COVboRlNrM8ORuqTLZsuNs7D1v04epZKPZeQV6Ap73BtxIZbarNhuMRDGudMO72U/EdV
        +UH+UonqRxtrj3oq1DJGG9U3/EzIELITMOwuPmJJhEJ2xKquluMLmgRHfvEO630mdiC25J
        7mGjGUBBBUdJfKnZVa7+ls6dzJpdo1RJarDgeXnBSxoYXTndKJ5kiRe+9Rkjy3I+NwxSFm
        dxy1U+AhNCfNXQTHwc4W5K0krXo+aZxUS7oho19m3uOIiX2ayKNXbjneKni8UIGe/giGjP
        IDOkVEyryxl0bIlYL6FL0vrgPjQ6ZlD0i9uHpdIcCv8NJGsYrC43wj3cPkN0Ng==
Message-ID: <e1213533-a0d7-5af5-b655-c30509a00f04@lexina.in>
Date:   Wed, 11 Jan 2023 10:17:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] arm64: dts: meson-gxl: jethub-j80: Fix WiFi MAC unit
 address
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, neil.armstrong@linaro.org,
        jbrunet@baylibre.com, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org
References: <20230110215926.1296650-1-martin.blumenstingl@googlemail.com>
Content-Language: en-US, ru, ru-RU
From:   Vyacheslav <adeep@lexina.in>
In-Reply-To: <20230110215926.1296650-1-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/01/2023 00.59, Martin Blumenstingl wrote:
> Unit addresses should be written using lower-case hex characters. Use
> wifi_mac@c to fix a yaml schema validation error once the eFuse
> dt-bindings have been converted to a yaml schema:
>    efuse: Unevaluated properties are not allowed ('wifi_mac@C' was
>    unexpected)
>
> Fixes: abfaae24ecf3 ("arm64: dts: meson-gxl: add support for JetHub H1")
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>   .../boot/dts/amlogic/meson-gxl-s905w-jethome-jethub-j80.dts     | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905w-jethome-jethub-j80.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905w-jethome-jethub-j80.dts
> index 6831137c5c10..4f742e1b9301 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905w-jethome-jethub-j80.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905w-jethome-jethub-j80.dts
> @@ -90,7 +90,7 @@ bt_mac: bt_mac@6 {
>   		reg = <0x6 0x6>;
>   	};
>   
> -	wifi_mac: wifi_mac@C {
> +	wifi_mac: wifi_mac@c {
>   		reg = <0xc 0x6>;
>   	};
>   };


Acked-by: Vyachesav Bocharov <adeep@lexina.in>



