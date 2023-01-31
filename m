Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 850E1682AE4
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 11:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjAaKyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 05:54:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjAaKyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 05:54:51 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B08A251
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 02:54:50 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id q10so13809574wrm.4
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 02:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7OYEwxTaqjtlGjvqbHJHN/en6Xpq8Ykki5vkrB21KOQ=;
        b=kGZYXNRVfKrXuVZiSbzJTqRr6TC8WN3FpQle90s6u1QN8F5g8sI8U/7qkGomlzsnBy
         ziS5sR9MEYLzcmGin/3FRXCE87cjz2ACN9r8UTG3EQPZRtyMK5S+4pnUCFzZCgS+Eu5G
         CvkigsGaxmBgz7sFT3dJsMZzW2XNkxadOYX1TlWWGDvoj44EiilMspHj8ITHuF7JvZEb
         JTiyhviWoA1iHqqtjIXvYx/tZvTjjOtt45N3QPfQnWkFJctnbmuzJ3I9FKj14OFIkecZ
         O05tgLW/NaMB6ifP0BCXYTTHHuD61+2MGmbI+CqzURlp6ozSH9Jb1KSnebG+XGtHcc/k
         2D7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7OYEwxTaqjtlGjvqbHJHN/en6Xpq8Ykki5vkrB21KOQ=;
        b=bHFH/3Vy5gwUEHeE8/x9HpvyxUd3LTibtjFtPjA8q10+qrJ6ZHMoH2LO+bu9+YppLa
         r/heJi5xAf6wrkJ2hmUIfxwYN7pCJlWAjH3xzUsStiC1CaDVhZo42VRgHoZpzHgZizlO
         uz+O7pbSZI4iJHrQ0Y9yfDBnSKGc8Hzb1dDPT/hkXObmISXmXIxjzuf7P8UqGauPuqNl
         yMVZk27NhvXkNyW3A2ir+IhBjUr04G7PyGXfz1htMRLNR6NhpNqnf13pL2yUUv6yfjyW
         nxQSpFlMcJwW2xH99fySXkKTyOvCF69dihTewsFvlA6TCnmqOTgWP5a1zU76uErKlRoh
         D42A==
X-Gm-Message-State: AO0yUKWYZZyblzVnRdvQDBmHqgn3qc+y1D8+7Ovk3bvkjGztDtFQ+SKY
        lL6f9AjnS5QzUM2SX34039Jafw==
X-Google-Smtp-Source: AK7set8yGv0W3fTh/34Gl9/VtI2q+tEtUrPw0o9c7WAhiS/iqRH503gaIshhxxf4qN+vLSA+xsrz8w==
X-Received: by 2002:a5d:59c1:0:b0:2c1:2a1c:a8d2 with SMTP id v1-20020a5d59c1000000b002c12a1ca8d2mr2781235wry.27.1675162489014;
        Tue, 31 Jan 2023 02:54:49 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id b11-20020adfd1cb000000b002bcaa47bf78sm15338247wrd.26.2023.01.31.02.54.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 02:54:48 -0800 (PST)
Message-ID: <39751511-3f06-7c39-9c21-208d4c272113@linaro.org>
Date:   Tue, 31 Jan 2023 10:54:47 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH] arm64: dts: qcom: sdm845-db845c: Mark cont splash memory
 region as reserved
Content-Language: en-US
To:     Amit Pundir <amit.pundir@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Caleb Connolly <caleb.connolly@linaro.org>
Cc:     linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dt <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
References: <20230124182857.1524912-1-amit.pundir@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20230124182857.1524912-1-amit.pundir@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/01/2023 18:28, Amit Pundir wrote:
> Put cont splash memory region under the reserved-memory
> as confirmed by the downstream code as well.
> 
> Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/sdm845-db845c.dts | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
> index f41c6d600ea8..2ae59432cbda 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
> @@ -100,6 +100,14 @@ hdmi_con: endpoint {
>   		};
>   	};
>   
> +	reserved-memory {
> +		/* Cont splash region set up by the bootloader */
> +		cont_splash_mem: framebuffer@9d400000 {
> +			reg = <0x0 0x9d400000 0x0 0x2400000>;
> +			no-map;
> +		};
> +	};
> +
>   	lt9611_1v8: lt9611-vdd18-regulator {
>   		compatible = "regulator-fixed";
>   		regulator-name = "LT9611_1V8";

Doesn't this mean we loose 0x2400000 of DRAM for all rb3 platforms 
though ? About what 37 megabytes.. ?

IMO it would be better to have a bootloader that cares about continuous 
splash to apply a dtb overlay or simply to add a separate dts 
sdm845-db845c-continuous-spash.dts.

---
bod
