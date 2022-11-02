Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C411E616E5B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 21:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbiKBULH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 16:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbiKBULF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 16:11:05 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C0FD20F
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 13:11:04 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id x21so6346360qkj.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 13:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PUVAtCGY+L5ZZOK2imxO2wh6PqMe7F28+kHnTcIOl7g=;
        b=DwBYnkurDl7pjse/WoKnApGon6wbppx/aI0L7Wv5FtaAM/SwvB5uaY+ZuLmHhTzLbv
         l5n0Lgz86Wiaq6tx0foTyXtUWdgRiDR7eJSakpXbMoZoHP6xQVlaNdc6+FR8XGP6bufs
         MDDWZVq+465WisDvL78NRw5sj97vf3Kz6pyCbK/wj2Zmv3HXwtEXaQJCVHcRyJNwGt/Q
         OA54HQ6vhdU8CGuN/ov+FW4xawusmVvkdFsk3feqbcWBrdIkSkjpZRm9gXIChrwBFPjX
         hAnLXaO4oHHMKP5k8RD9OtB90YXF2XkR7DlqmH9SJ+dLhDiQKoA4+MBbAB5J3frzsAZl
         xXpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PUVAtCGY+L5ZZOK2imxO2wh6PqMe7F28+kHnTcIOl7g=;
        b=w8YHiRLkcTVLllXv+BtQuLOxzGoH81faWf8hKDDfpZKOgCkHL3Be0KQ1B+gf7WBiP7
         Bt5NKHa8t0urHnYmIA5MMvF3E5DBBuGJkXKSG9uqtWIQg6ByIJqDovxwAprIPY+cY9I2
         agN9IzrWYok0Awfq3W+8A/HlOe44c+Fy7pr1h67f6oLCR8k/w0AkyVzCiguJYxYAtNb4
         9VeqguYt1G/2ncNbilhWSDbi8h2IyolR9pwvgrydBkV+jPeiCiZDHx7svfeogwoRCj8d
         i6+sCc1ExjPQN2nn0RD6iDhvMggp5T9YTCC1YB/9R8zZq67qha8fkTuTQ4g9yAGlloMi
         sz+Q==
X-Gm-Message-State: ACrzQf2UGtDt+sXffjXV2A8nnKix3G9ax4ll9Sc+6SPBRJAVrEPdAFit
        xjeXBogi1cZt7d/PLAS50q3pZA==
X-Google-Smtp-Source: AMsMyM4kQD6sgPCwQN6KrZN0u+qZwTvWQV5PAY4FU2x51ffz0zDxA1SJpqdvBV1G1A/DXPSWO9GF3A==
X-Received: by 2002:a05:620a:b14:b0:6fa:5e0b:d9fe with SMTP id t20-20020a05620a0b1400b006fa5e0bd9femr3796025qkg.594.1667419863399;
        Wed, 02 Nov 2022 13:11:03 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:28d9:4790:bc16:cc93? ([2601:586:5000:570:28d9:4790:bc16:cc93])
        by smtp.gmail.com with ESMTPSA id w16-20020a05620a425000b006e54251993esm9236040qko.97.2022.11.02.13.11.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 13:11:03 -0700 (PDT)
Message-ID: <0ad7ab3d-5eb7-b2f0-e75a-40c4743ae8a7@linaro.org>
Date:   Wed, 2 Nov 2022 16:11:02 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v2 1/1] arm64: dts: qcom: Add MSM8976 device tree
Content-Language: en-US
To:     Adam Skladowski <a39.skl@gmail.com>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221101191659.172416-1-a39.skl@gmail.com>
 <20221101191659.172416-2-a39.skl@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221101191659.172416-2-a39.skl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/11/2022 15:16, Adam Skladowski wrote:
> Add a base DT for MSM8976 SoC.
> 
> Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
> ---
>  arch/arm64/boot/dts/qcom/msm8976.dtsi | 1310 +++++++++++++++++++++++++
>  1 file changed, 1310 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/msm8976.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8976.dtsi b/arch/arm64/boot/dts/qcom/msm8976.dtsi
> new file mode 100644
> index 0000000000000..c073f16faa7ee
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/msm8976.dtsi
> @@ -0,0 +1,1310 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/* Copyright (c) 2022, The Linux Foundation. All rights reserved. */
> +
> +#include <dt-bindings/clock/qcom,gcc-msm8976.h>
> +#include <dt-bindings/clock/qcom,rpmcc.h>
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/power/qcom-rpmpd.h>
> +#include <dt-bindings/thermal/thermal.h>
> +
> +/ {
> +	interrupt-parent = <&intc>;
> +
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	chosen { };
> +
> +	clocks {

You missed here Rob's feedback.

> +		xo_board_clk: xo_board_clk {

And for some reason this got worse from v1...


Best regards,
Krzysztof

