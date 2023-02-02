Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76A2C6877E2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 09:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbjBBIuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 03:50:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbjBBIur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 03:50:47 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE518663E
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 00:50:37 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id q10so998720wrm.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 00:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lWsS/bWtmzpN07I8KCqWUmAN50eHOe+8qZxUIv9ebfk=;
        b=DhE+qH2Jh0jcOidrifO6y3KFacKb/NTJtxQwmSfveojslNuY0ynUu/hmWt0zwGCl5j
         RwIdGLze1WSWVVjV7f1TgHiVfI11qs2KRaP5FwfCwCTPzoOg8nFexWn7AxSetvk6ILNM
         hzaxsAjh6Nxu+lBRdwDLnCkD9tNq5rrxZHfCUjoC4F+mbgGQ09sxZDNQUnrDBvrhJZW7
         qMfBGpToy9EUsu025mNOZWYh1QoZRXzGG6k2YIjkIRYrWITr+/YqCAB15BBnHG8+8k3b
         8wrFk6y+gzBQbtylAYs/jBG5R+zK01THylvRZocRcZgY6f6rQ6uQ8O7N56tWq6peDI4Q
         9erQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lWsS/bWtmzpN07I8KCqWUmAN50eHOe+8qZxUIv9ebfk=;
        b=dycAJjuz2pBZcw9M1E/wOBRkErmlwY1ObMh/TONFFli+Vnq7J9iMWB9ua2Z0hyTagV
         9jDnacB7ypPDDXlI4kptsZujoHJLVJiihEg0PxKEOIwEQzKeo+KK377QGdtZQ+N6L/XT
         ymmjcMkbbI/902gkHJ17m+7PeCv/5XNvUmLvUDkDYzehw3N6qBIHeuiy6MeEXy2D3DSc
         119i6yaoWxJs82jOBuJujLPTZmZLTXp69DPvo6+EtiQ2CbXAOXEEkoSGVUII3oyETkoA
         M31H99t+zNxLuMuZVcnrv7wUmq4iHxf981aMfktffllULWIIEwg7nWD80IuRAc2s1YhR
         H5Ww==
X-Gm-Message-State: AO0yUKWXfwwEb/lpamNsb8Zf2gZupovb28gOGz39RCBAIR79m6GSAy+c
        RfjO07tHGNv96oJiuSoRqehvgQ==
X-Google-Smtp-Source: AK7set9myootvaumTc3dok0xH8h+eb7NWBe3lMq35UW9l8J+0ooRSfnkXePoQFIOiooeOPeghyIV/Q==
X-Received: by 2002:adf:c713:0:b0:2bf:e9dc:5536 with SMTP id k19-20020adfc713000000b002bfe9dc5536mr5744516wrg.45.1675327835629;
        Thu, 02 Feb 2023 00:50:35 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id e10-20020a5d500a000000b002be0b1e556esm18993213wrt.59.2023.02.02.00.50.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 00:50:35 -0800 (PST)
Message-ID: <d046c9b3-3cd0-0e2c-4db4-50e8e772bfb0@linaro.org>
Date:   Thu, 2 Feb 2023 09:50:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 3/3] dt-bindings: iio: adc: Require generic adc-chan
 name for channel nodes
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        phone-devel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Jonathan Cameron <jic23@kernel.org>, iio@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20230201204447.542385-1-marijn.suijten@somainline.org>
 <20230201204447.542385-4-marijn.suijten@somainline.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230201204447.542385-4-marijn.suijten@somainline.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/02/2023 21:44, Marijn Suijten wrote:
> As discussed in [1] it is more convenient to use a generic adc-chan node
> name for ADC channels while storing a friendly - board-specific instead
> of PMIC-specific - name in the label, if/when desired to overwrite the
> channel description already contained (but previously unused) in the
> driver [2].
> 
> Replace the .* name pattern with the adc-chan literal, but leave the
> label property optional for bindings to choose to fall back a channel
> label hardcoded in the driver [2] instead.
> 
> [1]: https://lore.kernel.org/linux-arm-msm/20221106193018.270106-1-marijn.suijten@somainline.org/T/#u
> [2]: https://lore.kernel.org/linux-arm-msm/20230116220909.196926-4-marijn.suijten@somainline.org/
> 
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
>  .../bindings/iio/adc/qcom,spmi-vadc.yaml         | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

