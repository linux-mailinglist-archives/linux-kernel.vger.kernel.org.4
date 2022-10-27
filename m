Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0925360FA2A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 16:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235757AbiJ0OL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 10:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235687AbiJ0OLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 10:11:22 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE28C1843E0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 07:11:19 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id n18so1350632qvt.11
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 07:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IEw4hNvQlJyxLY//kxdT/YXZEf32+Z0hEDG2ob9Hm+c=;
        b=v+9xqj/t6FAcnJCGIOx36Yvj7jRwgybck6cPU5EvyVOVe//JRa1bw+mip9cojQJM7J
         a6HMU058yYI+Jqlss6VKv+IZJQfktzPc5Vg2KpB0WT643ZNlHXftxYdEG/3wBXImon77
         Ww/40lzlx49LtbPVUPhLnt9VpL6aMnaBASQe0kBleW8rbnB5zucU70Z5SbVthLanZbfs
         WEspy7oKxkq+C8S56F5x+BiRVzsMIagJyuaKNDyjKFZT03y4ERp24uTFGprgonyjHlQZ
         bsmuJ7cpF3pu6evRKzOA4Bl2wX2igUxpM1x3j0vifdQTSEgElYMrDSNC/bSQxZyMtmem
         4p9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IEw4hNvQlJyxLY//kxdT/YXZEf32+Z0hEDG2ob9Hm+c=;
        b=3iRiiaHtDWSAn3JjM2s7/5sXVgJiHQz+u3eVBo3YP6KG9VNFJ2n5NqUdJxIAUnaqni
         fAmpeC5jufuNdzOfxoq6oyxjtt9cHKK3iUWUCBCxEm13xdrbKz8BHhJqCQfhXfhnZjiH
         zkYngYeA12oMbcVJu+GpnyJNeN0kZWjZV6tCEyG2ZS0jIKUSUfN6UqAN6jlVbOhGwo5q
         uQvKjpb/h0+nfjDDk6ZDVLr/6KNRuhJxum5Higpo4B8vdCPAojIduiEH0f6LcNy1TKTD
         mCR3jCDiF/R4/X0d1PR68WUoIa9dVoNdjZ34E58ypArSMYsY3NZzcFFoIAt90MxCwwk8
         dgsg==
X-Gm-Message-State: ACrzQf3nbplAitM50RoE9e6y8NkAl4g3rQViU7gX1w5/zDINW6VBuaoX
        YfmY70mCEtp6tejMLJWEsEM/rQ==
X-Google-Smtp-Source: AMsMyM72T02LHQeL5N8n098K7B3VL8oYiQPy7kp82Xn5EPH5OlbKrrnZKU9WZaEt2ljXTjTx4scwWA==
X-Received: by 2002:a05:6214:da2:b0:4b1:8a49:b492 with SMTP id h2-20020a0562140da200b004b18a49b492mr40500174qvh.8.1666879879054;
        Thu, 27 Oct 2022 07:11:19 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id bn14-20020a05622a1dce00b0039c37a7914csm913191qtb.23.2022.10.27.07.11.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 07:11:18 -0700 (PDT)
Message-ID: <d15f9071-4935-1359-8c9c-a8eac6f0aac6@linaro.org>
Date:   Thu, 27 Oct 2022 10:11:16 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 11/11] arm64: dts: qcom: sc8280xp-x13s: Add PM8280_{1/2}
 ADC_TM5 channels
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        andersson@kernel.org
Cc:     konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, johan+linaro@kernel.org,
        quic_jprakash@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221027063006.9056-1-manivannan.sadhasivam@linaro.org>
 <20221027063006.9056-12-manivannan.sadhasivam@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221027063006.9056-12-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/10/2022 02:30, Manivannan Sadhasivam wrote:
> Add ADC_TM5 channels of PM8280_{1/2} for monitoring the temperatures from
> external thermistors connected to AMUX pins. The temperture measurements

temperature

> are collected from the PMK8280's VADC channels that expose the
> mesasurements from slave PMICs PM8280_{1/2}.

measurements
slave->secondary

Other comments about node names stay as well, but it depends on the
previous discussion.

> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    | 68 +++++++++++++++++++
>  1 file changed, 68 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> index babf594384f2..fe6b75551ab9 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> @@ -259,6 +259,74 @@ pmr735a-die-temp@403 {
>  	};
>  };
>  
Best regards,
Krzysztof

