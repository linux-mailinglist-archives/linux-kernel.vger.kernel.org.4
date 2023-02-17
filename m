Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1E169AA77
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 12:32:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbjBQLcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 06:32:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjBQLcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 06:32:43 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24626656A7
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 03:32:41 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id h14so3367291edz.10
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 03:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NtPn4/xI7yqwIazolPw3ofvX5Wxk5SKUsFzeYA/r32E=;
        b=RZeDDAOH1v2odGYn1MOT4kO87CCkqtIyEfxoyFbqhVsY0tTLifsGibEavhmGVW//oP
         I/1Y5ctYALK7mJWpspSupQm3cng2RtspN7JCZcgNAS0gbdsg0wSQyPc0nwOMVAdXio8q
         c5FB4gpz+MCJ5K8wY7f9/u2wtNttXSwTmcg6DdCkJ/8z1J5HGLSLYdx/XjhpITQ83Di2
         9tCMAvpNiifSk6yQ+eS1qdGoi4g1HCk5OO9G0nXW0AbvpCvZMQUp/nqayoS72VcUtte8
         HR3GQ8CROa0rMYzZYkTVClREfAWgp92+34jI/nxPKGLV/dFqKjTGiXvn92FPGuyC1I64
         IerQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NtPn4/xI7yqwIazolPw3ofvX5Wxk5SKUsFzeYA/r32E=;
        b=XelTglT8XInEPP0sAJKhc0tUMIH2Lza+dBMFGlIuD1bKnTvJar3H7FJ9rEsNeSXUw1
         XI4dX4iHXHpJGyHjq+9/xoMrNNKi82imFnPNF9JABHHAxc4PiJkbEx9ruLfXKePT+ACE
         Fi5qW8uGp/7nTpPTfLhod0AjRqEScl68dM1jgOJNdntnKaHeR3dtRBM6NRgLVeE/Mco3
         K4s170Ea6MdjZwcJifrbpNo1bYaBS8sclgnzwMpkNnBM7uFL5522rHZk+IEv75j76Jr2
         X1PVfUqPgPDsHgUArbXIlOVHKaxiBNYZoP8er80s3oY+jkWTeUqOZuuNGHXlQKZyJgwr
         psPQ==
X-Gm-Message-State: AO0yUKX7N2nFvjvyv5+TE/rcAAT70PiTS0qzJrk0gkYa/hEnx6ky1lWR
        emkkz4NDvnUM0tbxi0LgTUL9+A==
X-Google-Smtp-Source: AK7set/dqNc4nmO8m/2hHFKBF6unWkZ80c7V4zsZlNnh2hhZVhuDW3B41WGCN/0b02DqNXV82H0zfQ==
X-Received: by 2002:a17:906:3418:b0:884:ab29:bd0b with SMTP id c24-20020a170906341800b00884ab29bd0bmr8819322ejb.69.1676633559377;
        Fri, 17 Feb 2023 03:32:39 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id u28-20020a50a41c000000b004a0e2fe619esm2162487edb.39.2023.02.17.03.32.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Feb 2023 03:32:38 -0800 (PST)
Message-ID: <c594a426-9ad3-1f67-8261-4d2d68272870@linaro.org>
Date:   Fri, 17 Feb 2023 12:32:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] ARM: dts: aspeed: mtmitchell: Enable NCSI
Content-Language: en-US
To:     Chanh Nguyen <chanh@os.amperecomputing.com>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20230217102122.16547-1-chanh@os.amperecomputing.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230217102122.16547-1-chanh@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/02/2023 11:21, Chanh Nguyen wrote:
> Support the mac3 (RGMII4) as an NC-SI stack instead of an MDIO PHY.
> 
> The OCP slot #0 and OCP slot #1 use a common the BMC_NCSI signal,
> so we use only one of them at the same time. The OCP slot #0 will
> be enabled by PCA9539's setting by default.
> 
> Also, enable the OCP Auxiliary Power during booting.
> 
> Signed-off-by: Chanh Nguyen <chanh@os.amperecomputing.com>
> ---
>  .../boot/dts/aspeed-bmc-ampere-mtmitchell.dts | 37 ++++++++++++++++++-
>  1 file changed, 36 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts b/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts
> index 4b91600eaf62..e8a6b1f08d6a 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts
> @@ -251,6 +251,14 @@
>  	pinctrl-0 = <&pinctrl_rgmii1_default>;
>  };
>  
> +&mac3 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_rmii4_default>;
> +	clock-names = "MACCLK", "RCLK";
> +	use-ncsi;
> +};
> +
>  &fmc {
>  	status = "okay";
>  	flash@0 {
> @@ -439,6 +447,26 @@
>  	status = "okay";
>  };
>  
> +&i2c8 {
> +	status = "okay";
> +
> +	pca9539@77 {

Node names should be generic, so I believe this is "gpio".
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

Best regards,
Krzysztof

