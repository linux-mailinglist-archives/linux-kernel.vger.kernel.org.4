Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C4F6A80B0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 12:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjCBLHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 06:07:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjCBLHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 06:07:08 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75FD918D;
        Thu,  2 Mar 2023 03:07:03 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id az36so10435999wmb.1;
        Thu, 02 Mar 2023 03:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677755222;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ti6yggdPsNOIPGXfO2UGItrftMezYx+P9sftKU+qmUA=;
        b=ogeMmyPlp+ux1bh8ePIj9tjnZ9OyV99vPTnFYiv+uMZwKp5HtnUJJD7gO/h+KuGXgQ
         2qmTHQ2hh+O+VSWueO+T7XjElqQ8akIKpBV56Veov8Wd71Z+16tONPex+tKsIPJcrBG5
         MP0kiNPjjBde5dP0I42a4o7ExYcnChE8yymqJXpmfPOkM/HKZAnIFlYFW5ln7OvFZ14g
         cHErnwIj2YCLCdzOrX9AO8QGYgKR0qY87WOU2XrWw9NRDBygTv2g2xdGY4cQwSKYMZTs
         LEr8W1eVVoxkXNeMZFPN44AiE35J8kNMVduu90IP38nc0tJ9Vy/FVZtMpQhJasOf517d
         yoOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677755222;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ti6yggdPsNOIPGXfO2UGItrftMezYx+P9sftKU+qmUA=;
        b=Ix7P78jsKTRgkzlRU+xqjrVyBNySxxLOlin4zEnmG3PeL3/099X1rU4yoSDjInU3ZM
         eGu5hlAQwSSGcT6BlE6+4gIe5AoglJ0/MSqem5op68V6g0uZrMMh3g8zT2lAEVet91g+
         aXeO8M7AsOIhQR6ZwMXZR2IL0ewhFLwbjyposgS5+n5R1v9E60hZjnyjVArdiqt5anLM
         M73PdV58Xcjd/JCINGU/WN22jE8u/Q0L18yDynYvjDyB5xXG1wEdBAR0Zu2TPeffJ4Lc
         O5BEjJW4QgMXnnrgl8eYy310ndxxsZ788DgTHTL+oTt3DiWiiOr6UrU7OBac60NhfBn0
         iUwg==
X-Gm-Message-State: AO0yUKUeop032HcK68MdVIhQQfNB42502d+4jr1W0rFjEiIkFeXsInIq
        zWfDO9dTocAQeQDQGpJDVTY=
X-Google-Smtp-Source: AK7set+yVpXtDFapduhsB0nccsgHCdavaSYmvTKCXeQKdTLPsNpVFb/bbrhQF8nu1ZSwpum2tkVRQw==
X-Received: by 2002:a05:600c:1894:b0:3e1:fc61:e0e5 with SMTP id x20-20020a05600c189400b003e1fc61e0e5mr7220130wmp.33.1677755221954;
        Thu, 02 Mar 2023 03:07:01 -0800 (PST)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id u9-20020a5d5149000000b002c54c92e125sm15122249wrt.46.2023.03.02.03.07.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Mar 2023 03:07:01 -0800 (PST)
Message-ID: <380b32fc-6e9b-6f7d-e8ff-063346ee1d27@gmail.com>
Date:   Thu, 2 Mar 2023 12:07:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v1 3/4] arm64: dts: mt8195: Align vppsys node to dtschema
Content-Language: en-US
To:     matthias.bgg@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        angelogioacchino.delregno@collabora.com
References: <20230209160357.19307-1-matthias.bgg@kernel.org>
 <20230209160357.19307-3-matthias.bgg@kernel.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230209160357.19307-3-matthias.bgg@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/02/2023 17:03, matthias.bgg@kernel.org wrote:
> From: Matthias Brugger <matthias.bgg@gmail.com>
> 
> As the node is a syscon, this has to be reflected in the compatible and
> the node name.
> 
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>

A similar patch is already in v6.3-tmp/dts64:
168136cbef9c ("arm64: dts: mediatek: mt8195: add MMSYS configuration for VPPSYS")

I'll drop this one as well.
My bad, I should have noticed that earlier.

Regards,
Matthias

> ---
> 
>   arch/arm64/boot/dts/mediatek/mt8195.dtsi | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> index 8f1264d5290bf..5261367031426 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> @@ -1795,8 +1795,8 @@ mfgcfg: clock-controller@13fbf000 {
>   			#clock-cells = <1>;
>   		};
>   
> -		vppsys0: clock-controller@14000000 {
> -			compatible = "mediatek,mt8195-vppsys0";
> +		vppsys0: syscon@14000000 {
> +			compatible = "mediatek,mt8195-vppsys0", "syscon";
>   			reg = <0 0x14000000 0 0x1000>;
>   			#clock-cells = <1>;
>   		};
> @@ -1900,8 +1900,8 @@ larb8: larb@14e05000 {
>   			power-domains = <&spm MT8195_POWER_DOMAIN_WPESYS>;
>   		};
>   
> -		vppsys1: clock-controller@14f00000 {
> -			compatible = "mediatek,mt8195-vppsys1";
> +		vppsys1: syscon@14f00000 {
> +			compatible = "mediatek,mt8195-vppsys1", "syscon";
>   			reg = <0 0x14f00000 0 0x1000>;
>   			#clock-cells = <1>;
>   		};
