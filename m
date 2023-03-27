Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA20A6CAED9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 21:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232544AbjC0Tgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 15:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232518AbjC0Tgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 15:36:49 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16C02727
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 12:36:47 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id eg48so40598472edb.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 12:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679945806;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VHZAF8mWZebdipp+vZd69LITS/zFgZnQWNA6h8nvR68=;
        b=SWdNQYG7aMFOUKHZw+yphu5JXC500Z6kubc8Cq2WYBHztb4Vgu4xzii3lcKSGgP6CX
         SNxtAt1aGLkv26P4dNraTCXVLlNV6qClqTpjjCmjxl8YE3kKFyHpxeVRx1iRsWKIUYk1
         U5Q8Z4p4bHS304f5MSte2gTgK5NyjJnIu9u1M+edjZweIpRj6lhyKgOAhMqFH00J3DMF
         xxFkjqsSSIFqhrEHxX+UndByeYE15LbhUln7EJDwqaqC39CelsYlIfmr2plYclQomife
         4kfhnKfxG1MY+/IaCys4p9dLY/Vk82foTP0JmH/PAzRraZuyYNV9Dw8h90N0hVF/Ori6
         iOZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679945806;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VHZAF8mWZebdipp+vZd69LITS/zFgZnQWNA6h8nvR68=;
        b=KyMiQfq4nIVrNCCzEXfel+WAwBga4kC6PNhSvV1LspHc+QNAICQoSceEzXIiaE/Uod
         ZIchyXBG48X50waMKjCqIoVEay0f7458gih6DS6zepUjTe1AsOdUrBPDXI+6bqkaHyik
         cXEvkKdM9GyEDsJXPSEGtVnC6j9qBwPZU2phoiR7a0GiygozvDFi8C3u6xOIngrKH4m0
         Q8akTlIoVpCgs25vK9ODH08MEK90pLO9h29ja0zWNOi/M6W92pDwGc/apNb2CwbXbArq
         3QOO1+rw5wAyTVdX6GNkQQl2IfViX3DNHUqcrUncHaQu2Z1p3jc43gktR+JqmiE/zBt4
         a0AA==
X-Gm-Message-State: AO0yUKUC8EcPU5s72cscZapU1y1LTzBOyBbDqJhiPu7vmc4XsT+7EcNa
        Byv2WduFPt0KLka1NfWawl3NsA==
X-Google-Smtp-Source: AK7set/hu5Ky92Am8vP5GLta/XhxYmcgR13f7XGemDpmz0mZIaI+rhZtTxgK28LfdzrPD10P/5E/bw==
X-Received: by 2002:a17:906:aed6:b0:8e9:afb1:65c6 with SMTP id me22-20020a170906aed600b008e9afb165c6mr20777136ejb.13.1679945806440;
        Mon, 27 Mar 2023 12:36:46 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:9314:a4b3:ce49:2c6b? ([2a02:810d:15c0:828:9314:a4b3:ce49:2c6b])
        by smtp.gmail.com with ESMTPSA id u23-20020a170906409700b009334a6ef3e8sm12362394ejj.141.2023.03.27.12.36.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 12:36:46 -0700 (PDT)
Message-ID: <5c8a7fbe-ce15-0918-7f82-a8058cdf15cb@linaro.org>
Date:   Mon, 27 Mar 2023 21:36:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 1/5] dts: arm64: qcom: sdm845: add SLPI remoteproc
Content-Language: en-US
To:     Dylan Van Assche <me@dylanvanassche.be>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <20230327184811.499553-1-me@dylanvanassche.be>
 <20230327184811.499553-2-me@dylanvanassche.be>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230327184811.499553-2-me@dylanvanassche.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/03/2023 20:48, Dylan Van Assche wrote:
> Add the SLPI remoteproc to the SDM845 Qualcomm SoC which is responsible
> for exposing the sensors connected to the SoC. The SLPI communicates
> over GLink edge 'dsps' and is similar to other DSPs e.g. ADSP or CDSP.
> This patch allows the SLPI to boot and expose itself over QRTR as
> service 400.
> 
> Signed-off-by: Dylan Van Assche <me@dylanvanassche.be>
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 36 ++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 2f32179c7d1b..3b547cb7aeb8 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -3311,6 +3311,42 @@ glink-edge {
>  			};
>  		};
>  
> +		slpi_pas: remoteproc@5c00000 {
> +			compatible = "qcom,sdm845-slpi-pas";

Undocumented compatible.

Best regards,
Krzysztof

