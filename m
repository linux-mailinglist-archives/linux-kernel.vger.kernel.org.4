Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32CDC6D9F37
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 19:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239910AbjDFRwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 13:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjDFRv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 13:51:58 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144F649CA
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 10:51:56 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id a11so41475447lji.6
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 10:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680803514;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bq9b3SpmIaCDckBxKGIDfJYxtz2GfshCynnt6cyFiq4=;
        b=BBoX9+gyQPgls+HXFwBZ/S/4fNWOj55jfego5Ec/HRu+jdBaVStOrqv7Z6ZL/rSCMS
         q0T7No9QVhCDnvXyIQMac01WN9zfbEIordniS2IKIEm8jtk6pTuj+w8xm3VTNyCwNPGV
         RMDwSeaZ0kEql35oN4RdI79t3efJfkDi6AYnl3T+ZHutkFCYLHHZZa4dQuFqcKRlFzZA
         ugEI2Q8/j68NPmyHFGwUHWTKPXfc5g92/kdG+sf863/RfIj2yzMQDvM27io/0DBiLFFS
         2Pof3zAIcXZcp3f4sOUg/0IpS3LrKMR+IJEEoDX2AFPcyY9zngFhOTjiousHY16Vshlg
         Gu3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680803514;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bq9b3SpmIaCDckBxKGIDfJYxtz2GfshCynnt6cyFiq4=;
        b=JXcC84BgX012AtzQ5jEKsbH2I2S3rM7bRJXqocHGqVUOECvN+a6qbcR3woT/9+RJ2m
         8A2sFi6Mn4MqtpgZCSTLLkgra8gEMHbKeaN3Y6BHmHppO4qrJnp+3HW9w1yDufZw3Epu
         7EyWzWFe8mu/Av/VluU5NfTYW2ypf/tm1EOkdvGwjcWt5S73Ia1iPFLmOVlMFKcc9MN9
         ic46y+HRUJXhj51dxTDn/lNrFik2W8Nw9exzZp5ZO2RgD/YEGzHDGU5jPm0GmFtuthxF
         2LzqIEVmhQ72FVaTqnsvlnL9/Nzg1D9MrGiLUllu1vbxHkLFo8mxGYxzrNrDkjpd2VNi
         +rIg==
X-Gm-Message-State: AAQBX9dx4NjrfYXYFgLCikC8D4xZ6/fW4JPe6nO+8bFpGTodG/k6cNWF
        leeTClpHpZX6eopjSyhKWVmIDQ==
X-Google-Smtp-Source: AKy350bn7ULVtyYX2IfRkOBqBI6RtqJlOXSPRii12jsGg31/ocnTf8n4QDUllCVVrtb96DsKZKnc6w==
X-Received: by 2002:a2e:7d0f:0:b0:298:ad8e:e65 with SMTP id y15-20020a2e7d0f000000b00298ad8e0e65mr2950196ljc.21.1680803514458;
        Thu, 06 Apr 2023 10:51:54 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id f11-20020a2e950b000000b002a6027dd591sm371261ljh.28.2023.04.06.10.51.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 10:51:54 -0700 (PDT)
Message-ID: <c05ec286-3a74-d824-f5fc-e5581efbb35c@linaro.org>
Date:   Thu, 6 Apr 2023 20:51:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 3/4] arm64: dts: qcom: sm6115p-j606f: Enable remoteprocs
Content-Language: en-GB
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20230406-topic-lenovo_features-v1-0-c73a5180e48e@linaro.org>
 <20230406-topic-lenovo_features-v1-3-c73a5180e48e@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230406-topic-lenovo_features-v1-3-c73a5180e48e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 06/04/2023 18:25, Konrad Dybcio wrote:
> Enable the [AC]DSP and MPSS and specify the firmware paths.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

