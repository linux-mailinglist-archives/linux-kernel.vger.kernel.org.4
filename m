Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C96ED6DAA10
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 10:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233084AbjDGI1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 04:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232430AbjDGI1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 04:27:45 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA028A6D
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 01:27:43 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id g18so6902155ejj.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 01:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680856062;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EOxBeWYxQ8XZ4tdMHB/PL/AFlnITgyGbSOH6JFHFiqs=;
        b=dR9Ryb8hOtnrXIAs9iDm0N8f9QOg9UZSiYHrUWZcqnVpq9BM6hK/hf/5LwG3x2k2D0
         tx6GSsTPdttJCW3EKDfg7S1N+uvHU14Y+6/EsV8Z/7MxMRdCMwzP6XRlqJ9B214k5gjL
         LwvZ84LH/I3SYBg68618sjbnR45zKKFlvdypr7H8gc6VO9BReT3HoNYAh83BRKu279jl
         yvZGR9HzDOn2KA56l03rvnEBeAMhWQK6EI7xgpxyx3HfoXwcfMV6LloffDgl4kzLV8F7
         iZI8oejGZyj/pXyujjj1xlIxwLAIhGM8i2HxYko5oSHgV8lNuCeuVGZh7lXLFTtXteVG
         iPGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680856062;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EOxBeWYxQ8XZ4tdMHB/PL/AFlnITgyGbSOH6JFHFiqs=;
        b=NtUgd/OlseRN0dktQitvcJEWihyiEN/JRT9Uo9vdV8fmWo1ewYWxlBx3gTJaV+80U7
         pCL+4IdOz7kr2LjsafJ3heqhIf4SJigcWBGk11deUsuunSYLCvAcE9pt3MncC+OC+Yma
         UoBEAA28Gdb/nO/9UJ8O90MfxsGkvVaK2Y5GzQhM0lDYxX4BIujNq/nYu+hMciIsTeuT
         PJRE+1MFDTDkvn2ypGsmjp6ls8ZMJEhD5gn/uaKBS+8UaXdN2z5K2rE3EqmuJukAFaJV
         kaPL8yDjVvtkNq1gElZuumsVOJjxT20nVWunrOxa4LevCp19GEnJNsQTLpiutxtnNJ6E
         JxCA==
X-Gm-Message-State: AAQBX9c6nZs66r6AwVWkzR4Q3VAgrG6jTiX/5CjcALmOhp7fRFazhIh4
        Un8LYrz6X+fx10/07DUKybtm1w==
X-Google-Smtp-Source: AKy350Y2IAv/DaY8eKeXOsM95YhNdt0YYyfsH8iC5W7cYwp+ow3Up8CZkleLoYpRRgptZ5G5IGH1ug==
X-Received: by 2002:a17:906:9f0f:b0:947:9dd3:d750 with SMTP id fy15-20020a1709069f0f00b009479dd3d750mr1791844ejc.64.1680856062043;
        Fri, 07 Apr 2023 01:27:42 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:14a3:366:3172:3c37? ([2a02:810d:15c0:828:14a3:366:3172:3c37])
        by smtp.gmail.com with ESMTPSA id jg17-20020a170907971100b009316783c92csm1832281ejc.12.2023.04.07.01.27.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Apr 2023 01:27:41 -0700 (PDT)
Message-ID: <f52524da-719b-790f-ad2c-0c3f313d9fe9@linaro.org>
Date:   Fri, 7 Apr 2023 10:27:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 2/2] arm64: dts: qcom: pm7250b: make SID configurable
To:     Luca Weiss <luca.weiss@fairphone.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230407-pm7250b-sid-v1-0-fc648478cc25@fairphone.com>
 <20230407-pm7250b-sid-v1-2-fc648478cc25@fairphone.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230407-pm7250b-sid-v1-2-fc648478cc25@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/2023 09:45, Luca Weiss wrote:
> Like other Qualcomm PMICs the PM7250B can be used on different addresses
> on the SPMI bus. Use similar defines like the PMK8350 to make this
> possible.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  arch/arm64/boot/dts/qcom/pm7250b.dtsi | 23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/pm7250b.dtsi b/arch/arm64/boot/dts/qcom/pm7250b.dtsi
> index daa6f1d30efa..eeb476edc79a 100644
> --- a/arch/arm64/boot/dts/qcom/pm7250b.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pm7250b.dtsi
> @@ -7,6 +7,15 @@
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/spmi/spmi.h>
>  
> +/* This PMIC can be configured to be at different SIDs */
> +#ifndef PM7250B_SID
> +	#define PM7250B_SID 2

Drop indentation, although anyway I am against this. Please don't bring
new patterns of this at least till we settle previous discussion.

https://lore.kernel.org/linux-arm-msm/46658cbb-fff5-e98b-fdad-88fa683a9c75@linaro.org/


Best regards,
Krzysztof

