Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9E665BCE7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 10:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237003AbjACJQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 04:16:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236970AbjACJQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 04:16:29 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D80BDE
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 01:16:27 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id bf43so44830300lfb.6
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 01:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aHAhdeX4spokrw/Ouo2T+2RtceeUsZl6B2PQr9gjCPc=;
        b=y1Z7soR2DoOs6lAl9pR6mZi/aQW8BsSrqXeTXjcM98wnC7M3Id5ixz7G0ogw05qZk9
         2S+/nGDxkfFmEWbYqCyEuOgg4tFTjz6mIe1bjT7r5JnKlJSk5fu3HOyqxACg1sJkrngg
         JxChNtsbL0kR2menJGdLfm5Nj5crZJUWHPRrkqsIfkj3//vCvbjs4tivEQVU7+i9w3vC
         4UP8lHhrpjgI9Dz420mtrUWCaxoz4pbNzDJKddxMlzHNPhuhbP7nvZKpfTWzAtpdvzZX
         pgLqeUYzud5Oy439xat9Xg0nua1FaF3ZZhC1ITNx1iJfj8jTYT+Y6AAx23ttC57M8jji
         r3ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aHAhdeX4spokrw/Ouo2T+2RtceeUsZl6B2PQr9gjCPc=;
        b=m7QMKIlNvKcuPfooCpAgHyzzJXRgzWj7pUm5M4lBesvXCCOxd7+FOsfvC1poz07UT/
         cT1YyU51hgBd8fHL5l5jMeuKE2NDrb00ZmTQZLly1CmsH4h/JWyNhOFWJML5bQ52uWai
         grLl/G+qjf3CIRKsv/O5y53Jp53RScKFVedBjrGWzqQuGQTHQGg4I/UWVDefx/zkkj/9
         ph9dkz59ApQKfWFfUWFES2S7qZUg+77RWLiN/BcFdE7oE7gFaigdNgvU4vAd94Xsm6Yx
         i8LpqsFNF4zZKHE+By4YynMO2XVGxd+NaCOrHJIkXsckeFRo5zQn0m3CisggSOzUQw37
         xcOA==
X-Gm-Message-State: AFqh2kqBjGUR8h2qGSNzfdkf+gZsJNosx1u2iAxthLrZiWGCWk/0mwe4
        a2bvIFgNE3xFIEk32Fo7RuReZQ==
X-Google-Smtp-Source: AMrXdXsUoRFkLZAiOh/l36EE0FLuJFNa1s70BSvZH8+0tatBW3cqoocgGz0gIJvz1X93bkXgUjESvA==
X-Received: by 2002:a05:6512:3a8f:b0:4a4:68b8:f4e1 with SMTP id q15-20020a0565123a8f00b004a468b8f4e1mr13515431lfu.39.1672737386349;
        Tue, 03 Jan 2023 01:16:26 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id o20-20020ac25e34000000b004b4b69af17dsm4814253lfg.214.2023.01.03.01.16.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jan 2023 01:16:25 -0800 (PST)
Message-ID: <d76a1798-72c8-7df7-4700-cc982cfd485e@linaro.org>
Date:   Tue, 3 Jan 2023 10:16:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 4/7] arm64: dts: qcom: Add msm8939 SoC
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, djakov@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        benl@squareup.com, shawn.guo@linaro.org, fabien.parent@linaro.org,
        leo.yan@linaro.org, dmitry.baryshkov@linaro.org,
        Jun Nie <jun.nie@linaro.org>,
        James Willcox <jwillcox@squareup.com>,
        Joseph Gates <jgates@squareup.com>,
        Max Chen <mchen@squareup.com>, Zac Crosby <zac@squareup.com>,
        Vincent Knecht <vincent.knecht@mailoo.org>,
        Stephan Gerhold <stephan@gerhold.net>
References: <20230103010904.3201835-1-bryan.odonoghue@linaro.org>
 <20230103010904.3201835-5-bryan.odonoghue@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230103010904.3201835-5-bryan.odonoghue@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/01/2023 02:09, Bryan O'Donoghue wrote:
> Add msm8939 a derivative SoC of msm8916. This SoC contains a number of key
> differences to msm8916.
> 
> - big.LITTLE Octa Core - quad 1.5GHz + quad 1.0GHz
> - DRAM 1x800 LPDDR3
> - Camera 4+4 lane CSI
> - Venus @ 1080p60 HEVC
> - DSI x 2
> - Adreno A405
> - WiFi wcn3660/wcn3680b 802.11ac
> 
> Co-developed-by: Shawn Guo <shawn.guo@linaro.org>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Co-developed-by: Jun Nie <jun.nie@linaro.org>
> Signed-off-by: Jun Nie <jun.nie@linaro.org>
> Co-developed-by: Benjamin Li <benl@squareup.com>
> Signed-off-by: Benjamin Li <benl@squareup.com>
> Co-developed-by: James Willcox <jwillcox@squareup.com>
> Signed-off-by: James Willcox <jwillcox@squareup.com>
> Co-developed-by: Leo Yan <leo.yan@linaro.org>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> Co-developed-by: Joseph Gates <jgates@squareup.com>
> Signed-off-by: Joseph Gates <jgates@squareup.com>
> Co-developed-by: Max Chen <mchen@squareup.com>
> Signed-off-by: Max Chen <mchen@squareup.com>
> Co-developed-by: Zac Crosby <zac@squareup.com>
> Signed-off-by: Zac Crosby <zac@squareup.com>
> Co-developed-by: Vincent Knecht <vincent.knecht@mailoo.org>
> Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>
> Co-developed-by: Stephan Gerhold <stephan@gerhold.net>
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/msm8939.dtsi | 2470 +++++++++++++++++++++++++
>  1 file changed, 2470 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/msm8939.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8939.dtsi b/arch/arm64/boot/dts/qcom/msm8939.dtsi
> new file mode 100644
> index 0000000000000..03714cdb8b69e
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/msm8939.dtsi
> @@ -0,0 +1,2470 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2013-2015, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2020-2023, Linaro Limited
> + */
> +
> +#include <dt-bindings/clock/qcom,gcc-msm8939.h>
> +#include <dt-bindings/clock/qcom,rpmcc.h>
> +#include <dt-bindings/interconnect/qcom,msm8939.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/power/qcom-rpmpd.h>
> +#include <dt-bindings/reset/qcom,gcc-msm8939.h>
> +#include <dt-bindings/thermal/thermal.h>
> +
> +/ {
> +	qcom,msm-id = <239 0>, <239 0x30000>, <241 0x30000>, <263 0x30000>;

This is also property of the board.

Best regards,
Krzysztof

