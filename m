Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 822C360565F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 06:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbiJTEgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 00:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbiJTEgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 00:36:35 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02277161FCD
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 21:36:35 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id f9so753375plb.13
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 21:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hQl2xZYeQM+maPS5+wYcZN71xZnoLpUn4u2n9e80A1k=;
        b=VVCyCBne3egzpFuhrKEfIJkrp75Jz1ao+512Mq7obhK9H2gHLqxnb0fOSyHPyUCWPY
         H+pga1QGEb8LKqRW6F5bZ8oOGRgEPnHt3atLKn2x4swvheId21kGBqC7Xg3q8yaTPHfc
         M+mYcRu/ofWtNUyJvpeFFjquHqKNtAiXiQhfT2e5uTnjeyEzMVMMwuqcMp0F1exuspjV
         7gDs9b3vI/SbdTW44+/ZordSgddEgDQPAEPXaOH8R5dpTNFbDudY1EFC1vwaxxBZrQPL
         3N/LBQLk6Eil69yQ8IUTa3UkMzozOEpUA93eySIPuF8Lqbw/LnMx2aMykdMXiCfY5/0U
         nuAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hQl2xZYeQM+maPS5+wYcZN71xZnoLpUn4u2n9e80A1k=;
        b=VAHYeKdB+rgNcMxj4q/nbICC8URWNZfTfRYtFSb8861xS28eEnYUq5lORKbulaHXMa
         WphBf7ssJ4+sSPwETBjyhgjCC0b+UksyZAo3y0y+k9YbNLQw25Ig1renUVO6SOfHipI4
         4ZdzaXOfZDZwT8pLDowwh5mV6tgWbhZvpwvkudIgSG9Un5fWIo6WdSfd8Giub64Qb1W/
         v04EcbawuKmaU3BW22ZvQmv9WeoEvSJ4A1e124xXRTP3ErsURmLlIwmcplXiBfzUM26K
         YEOu6JTsek5T7HVGzO9EdQDzV5NCWocCMlpd8zyDZBU7jmppYjQRozMZ0xvNAr1ochNs
         gcIg==
X-Gm-Message-State: ACrzQf3fJBQS+gEe7RywsAqxKGZpfZIzOY3O+EJ/3Kb8cusItOPXawPK
        8tKDBQLZx6g6odZoZyY3H6pChw==
X-Google-Smtp-Source: AMsMyM5zzjWfS/DI9BhJnlbWYlBt7rgwoFs02MxbqPnbIHLzHL2X4Z2CL+tsFOb7bIpWQg9BvHojZg==
X-Received: by 2002:a17:902:7b95:b0:178:ab50:76b5 with SMTP id w21-20020a1709027b9500b00178ab5076b5mr12139210pll.161.1666240594345;
        Wed, 19 Oct 2022 21:36:34 -0700 (PDT)
Received: from localhost ([122.172.86.128])
        by smtp.gmail.com with ESMTPSA id y2-20020a170902864200b001754cfb5e21sm11614884plt.96.2022.10.19.21.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 21:36:33 -0700 (PDT)
Date:   Thu, 20 Oct 2022 10:06:32 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     =?utf-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>, soc@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH 5/6] arm: dts: spear600: Add ssp controller nodes
Message-ID: <20221020043632.cbofx5jvajhy4xba@vireshk-i7>
References: <20221019133208.319626-1-kory.maincent@bootlin.com>
 <20221019133208.319626-6-kory.maincent@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221019133208.319626-6-kory.maincent@bootlin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-10-22, 15:32, Köry Maincent wrote:
> From: Kory Maincent <kory.maincent@bootlin.com>
> 
> The SPEAr600 has three Synchronous serial port to enables synchronous
> serial communication with slave or master peripherals (SPI). Lets add these
> nodes to be able to use them.
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
>  arch/arm/boot/dts/spear600.dtsi | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/spear600.dtsi b/arch/arm/boot/dts/spear600.dtsi
> index 9d5a04a46b14..6b67c0ceaed9 100644
> --- a/arch/arm/boot/dts/spear600.dtsi
> +++ b/arch/arm/boot/dts/spear600.dtsi
> @@ -207,6 +207,36 @@ adc: adc@d820b000 {
>  				interrupts = <6>;
>  				status = "disabled";
>  			};
> +
> +			ssp1: spi@d0100000 {
> +				compatible = "arm,pl022", "arm,primecell";
> +				reg = <0xd0100000 0x1000>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				interrupt-parent = <&vic0>;
> +				interrupts = <26>;
> +				status = "disabled";
> +			};
> +
> +			ssp2: spi@d0180000 {
> +				compatible = "arm,pl022", "arm,primecell";
> +				reg = <0xd0180000 0x1000>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				interrupt-parent = <&vic0>;
> +				interrupts = <27>;
> +				status = "disabled";
> +			};
> +
> +			ssp3: spi@d8180000 {
> +				compatible = "arm,pl022", "arm,primecell";
> +				reg = <0xd8180000 0x1000>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				interrupt-parent = <&vic1>;
> +				interrupts = <5>;
> +				status = "disabled";
> +			};
>  		};
>  	};
>  };

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
