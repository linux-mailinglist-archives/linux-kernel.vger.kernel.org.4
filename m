Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5BC1668FC8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 08:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238783AbjAMH7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 02:59:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240721AbjAMH6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 02:58:54 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0FFF40C12
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 23:58:52 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so13358237wma.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 23:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2CYFqovSzVHBxFSUaQCsOuxkiPS8Ixm67dj6DWus2UU=;
        b=kUmMbJ/Fcrf7xVVomeL/NuF0+/87TSUrJx7IhyBajtZCxR4X9z5IIZDPVNbu+yVy0V
         0b6YrTSNExx2IDhWfQulO5E5l6tiCvIoVW5FwdrfKNluudVTTH7ZOLVTemY9tbm5NzrY
         zYMD0sO51E2tylfpkuIT8Z5SCTR/pgcJRIZKbvYYZKHWk2bfM+1EFBVwTl/IyR0+6BWg
         O64miOEcXq6gVaA4SJG1l+x0FS2q2g1yfhrw5Ts3gYFd9p9QORkdV46JX66csMqP8iya
         zHKnUuOc7VdYFzSuKNN5mWK/urd3wrHQUYMZDUHZnUglefwpaOgtzVEIDd84mtyYYKmE
         O6Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2CYFqovSzVHBxFSUaQCsOuxkiPS8Ixm67dj6DWus2UU=;
        b=TLkY2hsyFjZ5oUOPXWl7f8h47zefWgUWNV4IDpn3MHodPYeIYDG1CV7WJ+OsFIuuvz
         lVP4gyOfzJWtQ72B3LgWZ4rTwkbo7AwmPOzjmcE0Wj315PQH+aXAfWzX0R0sqI9Z2Q3j
         uTZl5JWxOXH+tht95GoZ7Le8MGwq7fr9d+ffgl7zs4Nw8D/K9OJkJmtKFCeN/qYJoWKp
         WwR2IjXsbCqd2CWBvQ/9mLkpZcPV75zL7DgPS+AWJ5OTC0Afmsd/+Ljo5303Y0Knlo0s
         kfSWaFT5bNMxzyLWeBXHbaaQ8zUVzTiR71fMb5D1yRK75g5/fTWFrIyjVl2sROSEdIz2
         8vyw==
X-Gm-Message-State: AFqh2krTP4VyJCXAg69MvBn9z5TfKN6c64lY/eE1QtTat7egUjy8a3gW
        LW/+qeDWpDtrQrJtFAMfqOJpTQ==
X-Google-Smtp-Source: AMrXdXsdpE1ttuWm9jTS4AtyOfLNQsH/mYReqqftIQmPvZVg/2G0n3Rdg+fcjuHifn7a/oT8XK3BtA==
X-Received: by 2002:a05:600c:4e44:b0:3d3:3c60:b2bb with SMTP id e4-20020a05600c4e4400b003d33c60b2bbmr23716743wmq.23.1673596731509;
        Thu, 12 Jan 2023 23:58:51 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:8660:aed9:5ce2:6bbb? ([2a01:e0a:982:cbb0:8660:aed9:5ce2:6bbb])
        by smtp.gmail.com with ESMTPSA id iv14-20020a05600c548e00b003b47b80cec3sm33156346wmb.42.2023.01.12.23.58.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 23:58:51 -0800 (PST)
Message-ID: <adb5145f-a084-af03-9ba7-5d5fc2a4d6b8@linaro.org>
Date:   Fri, 13 Jan 2023 08:58:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 2/6] arm64: dts: meson-gxl: jethub-j80: Fix Bluetooth
 MAC node name
Content-Language: en-US
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, jbrunet@baylibre.com,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, Vyacheslav Bocharov <adeep@lexina.in>
References: <20230111211350.1461860-1-martin.blumenstingl@googlemail.com>
 <20230111211350.1461860-3-martin.blumenstingl@googlemail.com>
Organization: Linaro Developer Services
In-Reply-To: <20230111211350.1461860-3-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/01/2023 22:13, Martin Blumenstingl wrote:
> Node names should use hyphens instead of underscores to not cause
> warnings.
> 
> Fixes: abfaae24ecf3 ("arm64: dts: meson-gxl: add support for JetHub H1")
> Suggested-by: Vyacheslav Bocharov <adeep@lexina.in>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
> changes from v1 -> v2:
> - new patch
> 
>   .../boot/dts/amlogic/meson-gxl-s905w-jethome-jethub-j80.dts     | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905w-jethome-jethub-j80.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905w-jethome-jethub-j80.dts
> index 270483e007bc..bb7412070cb2 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905w-jethome-jethub-j80.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905w-jethome-jethub-j80.dts
> @@ -86,7 +86,7 @@ sdio_pwrseq: sdio-pwrseq {
>   };
>   
>   &efuse {
> -	bt_mac: bt_mac@6 {
> +	bt_mac: bt-mac@6 {
>   		reg = <0x6 0x6>;
>   	};
>   

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
