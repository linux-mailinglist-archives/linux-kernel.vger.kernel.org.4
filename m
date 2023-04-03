Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1786D4FB2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 19:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbjDCR4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 13:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232691AbjDCR4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 13:56:44 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D758C2134;
        Mon,  3 Apr 2023 10:56:29 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id o15-20020a4ae58f000000b00538c0ec9567so4764408oov.1;
        Mon, 03 Apr 2023 10:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680544589;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QOuaiQSK3BoOYX4eQwnchP+qwhM2uvpCv45NT7W1aF0=;
        b=NyQ061Xfwh7ujD4Nquc2Xty31UPDwgSkekIesimXAwJc3AhrdwLqIGb/1Tlw2eS03u
         cDgi8YK0T5RmATq+a0qDe1HbgBccR2xOiWf6vZ+3bweFqkYQyeywvXaEYyXc4meKs22D
         0mx8oGXsS02q+YyRshJARiNKrhjnkxunt73e7dkwphXtJ9UrJFIFXTCVuAmm5BfN+teh
         qiXBmbEk3pQYHZ6/tyxkBEIKBK7bhVTAauTFVCfA/c7decEOmU2XqdGcqGXkjNaJTJeQ
         31eABqsZ0WDDIdHRIMmIvDg4E4fG7gQYSkG2ysYrtZrkSE8MblBkInPi99rPLFYa2eJR
         2KLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680544589;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QOuaiQSK3BoOYX4eQwnchP+qwhM2uvpCv45NT7W1aF0=;
        b=3XAW9SiN4fuzl3gmq/LjPXXVSgeTKo4/12Tc5LECgjB2qLewmkjCY/h5Ym78ZpugX7
         Z9CFgiTDmgjAFfQIGziHlWkLknCDZirF+EJnFv4Ak2UMy00pEIrpwslIX25aYFoUn32W
         lfGVG0OYFg9nPuGxH2qRabVyGTw9NaALdsgQZxuuvW64QnACcWv1sWQaUnSmgG/82wrM
         n0EkyCmE1tjTtfSVAQfc/QT49KBRWi5EQRWLtSomP64aAIxpqFXRIuFENhTNSL/teEQY
         Mmamsbhq6z/Uq58NVkZwPHSKsjclNxit2uk4qA5AW2zgDZ6w6ZaG+vAXNhubDtp/wbGk
         ARyQ==
X-Gm-Message-State: AAQBX9dmcWnjFiRxv1B1zZrTEXubzOvLNLk2mqv1IYXbDQnnmHS+6KEO
        URGGUiOZAKou5J4NBK0doJA=
X-Google-Smtp-Source: AKy350bTyHc8XmxyYvCTHyDh/t3yPqen0MsWVzSeXuNTibNZnT59EGNTGp0cUJyIAlW8qY9G1SQS5Q==
X-Received: by 2002:a4a:4152:0:b0:53e:55a8:2a69 with SMTP id x79-20020a4a4152000000b0053e55a82a69mr248695ooa.3.1680544588900;
        Mon, 03 Apr 2023 10:56:28 -0700 (PDT)
Received: from neuromancer. (76-244-6-13.lightspeed.rcsntx.sbcglobal.net. [76.244.6.13])
        by smtp.gmail.com with ESMTPSA id h38-20020a4a9429000000b0051a6cb524b6sm4291364ooi.2.2023.04.03.10.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 10:56:28 -0700 (PDT)
Message-ID: <642b134c.4a0a0220.1d01a.5990@mx.google.com>
X-Google-Original-Message-ID: <ZCsTSskt2cU+VClg@neuromancer.>
Date:   Mon, 3 Apr 2023 12:56:26 -0500
From:   Chris Morgan <macroalpha82@gmail.com>
To:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: rk3588-rock-5b: Add pwm-fan
References: <20230403105052.426135-1-cristian.ciocaltea@collabora.com>
 <20230403105052.426135-3-cristian.ciocaltea@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403105052.426135-3-cristian.ciocaltea@collabora.com>
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 03, 2023 at 01:50:52PM +0300, Cristian Ciocaltea wrote:
> Add the necessary DT changes for the Rock 5B board to enable support for
> the PWM controlled heat sink fan.

Honest question, but should we be adding this to the board file if not
every device has a PWM fan (they all have the socket for the fan, but
not the fan)? For example I have a passively cooled case that doesn't
include a fan.

Thank you,
Chris Morgan.

> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> index 95805cb0adfa..bd74d9da2c17 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> @@ -17,6 +17,14 @@ chosen {
>  		stdout-path = "serial2:1500000n8";
>  	};
>  
> +	fan: pwm-fan {
> +		compatible = "pwm-fan";
> +		cooling-levels = <0 95 145 195 255>;
> +		fan-supply = <&vcc5v0_sys>;
> +		pwms = <&pwm1 0 50000 0>;
> +		#cooling-cells = <2>;
> +	};
> +
>  	vcc5v0_sys: vcc5v0-sys-regulator {
>  		compatible = "regulator-fixed";
>  		regulator-name = "vcc5v0_sys";
> @@ -27,6 +35,10 @@ vcc5v0_sys: vcc5v0-sys-regulator {
>  	};
>  };
>  
> +&pwm1 {
> +	status = "okay";
> +};
> +
>  &sdhci {
>  	bus-width = <8>;
>  	no-sdio;
> -- 
> 2.40.0
> 
