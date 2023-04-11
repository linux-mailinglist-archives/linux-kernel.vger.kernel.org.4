Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A65136DE183
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 18:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjDKQxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 12:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbjDKQxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 12:53:09 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF97040E3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 09:53:05 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id dm2so22148004ejc.8
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 09:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681231984;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ko41vrD9KbTzdwmwXur/3oq4iOAKnfjP+f6zFzEQLpE=;
        b=B0TShScBPiEz2w8MEd7mw0DLKt3y2LY78FWeticyCMBj1Ix5JbpLQjUlbZSugS63Y4
         zGN35IQpGAsuW3fsWcA0pCzAz6HRCRnlTliFdWfJtD6arDyJlbVD7uaAX/9N2wZFwZd+
         LoMq+/w4XavyfQ0YucBRh9QfAT2cddM0hwpvbhnE/R/VuWTYRWsm5NNx/PKDEG4oC3HZ
         3Aw3V1IBxqnb5577gSdeLOOukFY0kH9eHR4suBF082CpYN0UZNuZnc5rfgpRPEDHOyJb
         3UZO3zSEkcmUTAwnod1ErIPjPIMsZmqiL+7PUiDXYv5nkROYYCZTLP3S1xUdt8+P80L8
         EBHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681231984;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ko41vrD9KbTzdwmwXur/3oq4iOAKnfjP+f6zFzEQLpE=;
        b=Vo6LvIWuO5vw29Sn6zvABZ6jTkuf4p0HD/B6YEKjHfKQqCiRVOe1lmUpY3cH3KiB6R
         zOQ0y7Tj4aTIq1xtgoEMUVjGz5UZUw1dN710t6E0HBO58EW2QWF+oIaLphCFQQ4dBAYl
         y0oeTLJRuUKH/kKqLXS9lw2F9dR9JaT3SY07YJMVeUaLfhpMhyZWVcCHNhRzt8/kdguW
         +JIBOyC1P9BotKyolDxRNtcHLkm2WoB0gamZlVG8dOv8n+mZFbKnC9lhTT9kcBpC31BL
         t36O9Wqp7Jba3nuhdzFEiL2YCi9IIzR7gQpyfaigZandUJwEnjQydfcQKAkXnQ8lubN9
         l7cA==
X-Gm-Message-State: AAQBX9cQPVLF3aA1YNJvdyRcU9vob2IF0ITaOLx+Qx0vSSyRUxwdLolY
        pjpnJpqy3+9t7/1RwqBXDs7dmw==
X-Google-Smtp-Source: AKy350Y7xYN7SYqspnovV/HzkT7cFYXlUKEB2P/lKm2tKJGCDSg/SBoG/2m0t0rb3js7VF4rfj11Yw==
X-Received: by 2002:a17:907:d07:b0:92b:69cd:34c7 with SMTP id gn7-20020a1709070d0700b0092b69cd34c7mr13515397ejc.40.1681231984156;
        Tue, 11 Apr 2023 09:53:04 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:f1da:c117:3657:c8a? ([2a02:810d:15c0:828:f1da:c117:3657:c8a])
        by smtp.gmail.com with ESMTPSA id u1-20020a17090617c100b00930b13f6abdsm6364830eje.98.2023.04.11.09.53.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 09:53:03 -0700 (PDT)
Message-ID: <3bb9bbf1-97d9-7cc9-479d-1ec93c11056b@linaro.org>
Date:   Tue, 11 Apr 2023 18:53:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 3/4] arm64: dts: qcom: sm8150-kumano: Set up camera fixed
 regulators
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230315-topic-kumano_dts0-v1-0-f1852c2a2378@linaro.org>
 <20230315-topic-kumano_dts0-v1-3-f1852c2a2378@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230315-topic-kumano_dts0-v1-3-f1852c2a2378@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/04/2023 15:49, Konrad Dybcio wrote:
> +	rgbc_ir_pwr_en: rgbc-ir-pwr-en-state {
> +		pins = "gpio29";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-disable;
> +		output-low;
> +	};
> +
> +	sub_cam_pwr_en: sub-cam-pwr-en-state {
> +		pins = "gpio79";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-pull-down;
> +		input-enable;

input-enable is not valid anymore.

Best regards,
Krzysztof

