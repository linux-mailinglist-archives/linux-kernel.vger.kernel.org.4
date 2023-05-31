Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF18718A14
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 21:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjEaTVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 15:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjEaTVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 15:21:32 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DDC2129
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 12:21:31 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9707313e32eso1131888066b.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 12:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685560889; x=1688152889;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=euJrgCKwkiyjhiMxI+ubH3oD9UXVTFWeoNPUv882XB8=;
        b=OvlHEOGE5DlDQkWLp9hwBlb7BNEkyE+zAdSvgvpckWbEBmXUEIsrxAhgK2Tykq/zcp
         tUKuQXUEPzAx37XQzc4zC3hSsWKZZPLOJ0Mfu8+Gt6qIafea5zN7PyqdyVGMXz5Pkj5r
         xchFqtVPaxTP6ghGHlL45BsGlGSDtanD10+uanebJl+/dnxM0QUXhJPT6Gdl+QrCkwB3
         kL6ad51TomQUXcUA+mNXZMlnyD+iVxsmLq8GnfsRQvphl8NWt94jSXFmszkUfrvzXlCG
         0KKayV76d6Pwh7bqo7GPFD2mMnt7UvWXE8k5NG7TNloj0GRY83y1txE2qPB4IZi12biM
         fpVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685560889; x=1688152889;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=euJrgCKwkiyjhiMxI+ubH3oD9UXVTFWeoNPUv882XB8=;
        b=UuC/6o3hY0NgX8XaoJS6o8cdNcgePkwgRGtLP2rBLMs1334OBgAFR3udJC3f20DMoS
         PC1iRJGI0d2pdNUXN0GGXE6L9JVz1ZTctCEwV855QRxjqfa0gXD416ZyTiJrJ042RNaN
         ZXi821AvUv/azUtxSI/5XfC+XXGMmzLi0H2qq4/YHtpuTpJhnHX5GHB0pt0/rd2RCiHr
         gA2AVPQmNMYo8HmioQVU5LBmIJDq3yPdnWqukspaXkvLMLaDl29pa1rUCDJciMthwAf4
         m90y3U1VI65W4eGSH5e8nrzeVqfGyV9PbeKnJxGb58AhXFm+8zUnnscDECwnwsuiJZC+
         UXVw==
X-Gm-Message-State: AC+VfDxnon0EGCMpuPiG0nN4G3BHm/IOy7VktP+cXBxN/MlzzG3AuDsb
        fvgk3NDVlTeBUIZUEQ4b/ioUbw==
X-Google-Smtp-Source: ACHHUZ7K2J36QDgprdxLRgHsGRzNJVdmXo+wyftNE2ma6LStjGJBua2pcpdP2afycP4yxJc+XhaR9Q==
X-Received: by 2002:a17:907:9305:b0:974:1c90:b3d3 with SMTP id bu5-20020a170907930500b009741c90b3d3mr6372234ejc.12.1685560889557;
        Wed, 31 May 2023 12:21:29 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id bq13-20020a170906d0cd00b00965c6c63ea3sm9423154ejb.35.2023.05.31.12.21.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 12:21:29 -0700 (PDT)
Message-ID: <12e3cb86-45e2-6f7a-eb8a-d1674e138b1a@linaro.org>
Date:   Wed, 31 May 2023 21:21:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V2 1/6] dt-bindings: clock: qcom: Add SM8550 camera clock
 controller
Content-Language: en-US
To:     Jagadeesh Kona <quic_jkona@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Taniya Das <quic_tdas@quicinc.com>,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>
References: <20230525172142.9039-1-quic_jkona@quicinc.com>
 <20230525172142.9039-2-quic_jkona@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230525172142.9039-2-quic_jkona@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/05/2023 19:21, Jagadeesh Kona wrote:
> Add device tree bindings for the camera clock controller on
> Qualcomm SM8550 platform.
> 
> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
> ---
> Changes since V1:
>  - Removed new YAML file and reused SM8450 CAMCC YAML file for SM8550

Assuming Bryan does not object after my comment:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

