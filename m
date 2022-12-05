Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E26F642D81
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 17:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbiLEQtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 11:49:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbiLEQsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 11:48:35 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25BCD2E1
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 08:47:46 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id a7so14166874ljq.12
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 08:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yfNcDnQIXBHvzHnGf+xJsMK1hqs+Kpeg/edf77EtziQ=;
        b=UIGQUtI/FGywg/wlQU+zKDxWrRAkK023sHkOnS7/ALTtpFIWWf19eQdLPoWuPIdKyq
         8J/cW6tgPj2s0u0bwV6IGCWpvypx6U38/vETtt9Fd19GYmMBip0+n4+YePyRdPdUel1E
         e8sBp1kt6Zhsl69Mf8pPEhDj8OV4ZLS0G01O4rehEr7c+CHFoxsFObn2RBf+Rcm3HaRz
         oobM2WUo0XNw+8LmuuTAQLP4VyGULFVDvoO/dX0ZTfC54TFkYdzUdZXgWQIlVdE21jO7
         ULXoF7vi5lA3qA/nF9vbgvb7UU5cwCrlgbJzKmsvyU7GK0PXazGKQ5dETXqvgHhAawC5
         9b5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yfNcDnQIXBHvzHnGf+xJsMK1hqs+Kpeg/edf77EtziQ=;
        b=P+iKkjUuLKz6D/y4BFhMEC9RMzGplgLjLTV/sifsCAdRCk6QV1iA55ato+AnrJUv/Y
         lBRy+8R8L8b0nbXtHoqc8ycETN2A9VsDsRKuQ7Rc3G6gzKMF/behrGj8azFk/BhUamb/
         s2HJE2+NYc81Hczk8mdtKodTyfkiF2DTbJUB3rw1J1ZNxW9EbsNAwVeYCEylc6N17p8l
         ArO1xy11oLKCrpxVbOANp+m8fkaBziTYgdSfa83zi6FHnvZ2CIsKUhuqrGXHHqc2/lSK
         zcNSK8lreh4mAq3fff6fE2y1Fwu5RmJf5KxqfzWWuia4egZwMqhXkDzWSt4aVTMgjuJn
         igOw==
X-Gm-Message-State: ANoB5pmSi4AEYWguEPbnSkFesTQfNA7h3KqE4yrF6PCYPFccxYN4g+Dl
        X7VbpgZ0erSWKQsH1jxZ6LupDA==
X-Google-Smtp-Source: AA0mqf7iCfiosfAZqR500ANFZIqlekk62mqbnXBK8wPLMhjHsxiCQZZ6tfr5879JzOo6Wsi50/R4+Q==
X-Received: by 2002:a2e:bd81:0:b0:26f:9736:bd5f with SMTP id o1-20020a2ebd81000000b0026f9736bd5fmr25412078ljq.285.1670258865301;
        Mon, 05 Dec 2022 08:47:45 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id e1-20020a05651236c100b004b56bebdc4esm711999lfs.14.2022.12.05.08.47.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Dec 2022 08:47:44 -0800 (PST)
Message-ID: <ed8c6ca2-e4e1-52f5-0858-8c774819dd73@linaro.org>
Date:   Mon, 5 Dec 2022 17:47:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v3 11/11] arm64: dts: qcom: sm8350-hdk: Enable lt9611uxc
 dsi-hdmi bridge
Content-Language: en-US
To:     Robert Foss <robert.foss@linaro.org>, robdclark@gmail.com,
        quic_abhinavk@quicinc.com, dmitry.baryshkov@linaro.org,
        sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, quic_kalyant@quicinc.com,
        angelogioacchino.delregno@somainline.org, loic.poulain@linaro.org,
        swboyd@chromium.org, quic_vpolimer@quicinc.com, vkoul@kernel.org,
        dianders@chromium.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Marek <jonathan@marek.ca>, vinod.koul@linaro.org,
        quic_jesszhan@quicinc.com, andersson@kernel.org
References: <20221205163754.221139-1-robert.foss@linaro.org>
 <20221205163754.221139-12-robert.foss@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221205163754.221139-12-robert.foss@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/12/2022 17:37, Robert Foss wrote:
> The sm8350-hdk ships with the LT9611 UXC DSI/HDMI bridge chip.
> 
> In order to toggle the board to enable the HDMI output,
> switch #7 & #8 on the rightmost multi-switch package have
> to be toggled to On.
> 
> Signed-off-by: Robert Foss <robert.foss@linaro.org>

Thank you for your patch. There is something to discuss/improve.

> +
>  &slpi {
>  	status = "okay";
>  	firmware-name = "qcom/sm8350/slpi.mbn";
> @@ -544,4 +633,20 @@ usb_hub_enabled_state: usb-hub-enabled-state {
>  		drive-strength = <2>;
>  		output-low;
>  	};
> +
> +	lt9611_state: lt9611-state {
> +		lt9611_rst_pin {

No underscores in node names.

> +			pins = "gpio48";
> +			function = "normal";
> +
> +			output-high;
> +			input-disable;
> +		};
> +
> +		lt9611_irq_pin {

Ditto

> +			pins = "gpio50";
> +			function = "gpio";
> +			bias-disable;
> +		};
> +	};
>  };

Best regards,
Krzysztof

