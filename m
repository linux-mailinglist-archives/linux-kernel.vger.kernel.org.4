Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECB056DE528
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 21:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjDKT7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 15:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjDKT7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 15:59:15 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9CB449C
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 12:59:13 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id m4so11695307lfj.13
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 12:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681243151;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YGquEeXVbkvJ/pjYgSu5IRfkUFUUSGPMLUNyd+676Zw=;
        b=lHvUhPPca9Bie5uxi0VZJlh6YqEu88ELyrACrrKD8hqS7uqeeF/PAf9KCjj90yXweO
         lzb7zI3gvRLWNwnjpoNBfysJMQARe54SLqDsAMQQGLEAZrIF100LkHm94Logm5Usrxiu
         UKBYoT6LZb0D4EASajb0jJiddE30NhGXtNMLJmR9IHlVwNpiHy9gVDZ9XBfY8vv8ThtO
         nqySdmk2SUnYp2K0Cjyv2EWVdlw1R8I+tR6qlcwdf78fGDC9CWF0VTmKBatlkh778Pdb
         9pDXOUNsxE5Aff1hFjUQ4vu1mbPIbB/QZTcRRY+9U01CpfCSMX8c36zaIkrfXo08sH8J
         hp7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681243151;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YGquEeXVbkvJ/pjYgSu5IRfkUFUUSGPMLUNyd+676Zw=;
        b=x9GtXE+3HEboNfo6FRuSOz2zqAgMflhlx3z/+fm8b++wTTC23yerPUWjhQWZl3LrTb
         y5rLHt9ci3ZcpQslJJaL2PPEfp7epGxEjvD2grmYXS/EliIgP4+XzCmwmBfDCpQVTzBf
         l23mU5fUJQ8SYnIyX9S05VaPp559nVjXJPjFzwY+1JXSBZs/Zu+cGjQ4Qvpc99sKEeJ4
         wrizvUz7z5geXJmJrsmYkYTdgs/wKhMv0mZtMZrzcKP1E+Y2zbwS+56C2qPftSceCjyv
         qBNVAat/7iuhwW20/uAhzRO/GtHi2cfziegyZF3YucqLGJ6O5TKujspA0BqLOK6c+f4O
         SO9w==
X-Gm-Message-State: AAQBX9di7Kgi/yIuBLULgasKHAbJXgOH5+K2i13594pQlw2mcuNeeBKh
        m8IoctctBkM5NfeQrkHz5v+oeA==
X-Google-Smtp-Source: AKy350anl32bVFzS4/dw+9FZFzkBkofKoVS9aL368apBUkQ9gDiOIWo73QVHAbH3X2cGyL9rq5Yv9g==
X-Received: by 2002:ac2:550b:0:b0:4eb:cbb:790f with SMTP id j11-20020ac2550b000000b004eb0cbb790fmr5018318lfk.66.1681243151583;
        Tue, 11 Apr 2023 12:59:11 -0700 (PDT)
Received: from [192.168.1.101] (abxj23.neoplus.adsl.tpnet.pl. [83.9.3.23])
        by smtp.gmail.com with ESMTPSA id g1-20020a19ee01000000b004db3900da02sm2652951lfb.73.2023.04.11.12.59.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 12:59:11 -0700 (PDT)
Message-ID: <cd531beb-69f4-a2e8-299f-c85d8593673c@linaro.org>
Date:   Tue, 11 Apr 2023 21:58:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 4/5] arm64: dts: qcom: sdm845-xiaomi-beryllium-ebbg:
 introduce support for fts touchscreen
Content-Language: en-US
To:     Joel Selvaraj <joelselvaraj.oss@gmail.com>,
        Caleb Connolly <caleb@connolly.tech>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Jeff LaBundy <jeff@labundy.com>,
        Markuss Broks <markuss.broks@gmail.com>,
        Jean Delvare <jdelvare@suse.de>,
        Job Noorman <job@noorman.info>,
        Alistair Francis <alistair@alistair23.me>,
        Chris Morgan <macromorgan@hotmail.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <20230410160200.57261-1-joelselvaraj.oss@gmail.com>
 <20230410160200.57261-5-joelselvaraj.oss@gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230410160200.57261-5-joelselvaraj.oss@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10.04.2023 18:01, Joel Selvaraj wrote:
> The Poco F1 EBBG variant uses Focaltech FTS8719 touchscreen. Introduce
> support for it.
> 
> Signed-off-by: Joel Selvaraj <joelselvaraj.oss@gmail.com>
> ---
>  .../dts/qcom/sdm845-xiaomi-beryllium-ebbg.dts | 26 +++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-ebbg.dts b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-ebbg.dts
> index 76931ebad065..f857ed3e2df4 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-ebbg.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-ebbg.dts
> @@ -13,3 +13,29 @@ &display_panel {
>  	compatible = "ebbg,ft8719";
>  	status = "okay";
>  };
> +
> +&i2c14 {
> +	status = "okay";
> +
> +	dmas =  <&gpi_dma1 0 6 QCOM_GPI_I2C>,
> +		<&gpi_dma1 1 6 QCOM_GPI_I2C>;
> +	dma-names = "tx", "rx";
That's totally in sdm845.dtsi already!

> +
> +	touchscreen@38 {
> +		compatible = "focaltech,fts8719";
> +		reg = <0x38>;
> +
> +		interrupt-parent = <&tlmm>;
> +		interrupts = <31 IRQ_TYPE_EDGE_FALLING>;
interrupts-extended

> +		reset-gpios = <&tlmm 32 GPIO_ACTIVE_LOW>;
> +
> +		vddio-supply = <&vreg_l14a_1p8>;
> +
> +		pinctrl-names = "default", "sleep";
> +		pinctrl-0 = <&ts_int_default &ts_reset_default>;
> +		pinctrl-1 = <&ts_int_sleep &ts_reset_sleep>;
property
property-names

Konrad
> +
> +		touchscreen-size-x = <1080>;
> +		touchscreen-size-y = <2246>;
> +	};
> +};
