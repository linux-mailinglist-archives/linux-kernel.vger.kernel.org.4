Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F32896FDF5F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 15:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237179AbjEJN6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 09:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236736AbjEJN6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 09:58:20 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 854A6D864
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 06:57:59 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-50bc075d6b2so13524215a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 06:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683727078; x=1686319078;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sp1rXB49Zfr24OMlLMKKbwnbFVME1qYysHUTaPTOohU=;
        b=NP3DVpVA/ox6CzRtCuRFAnFHzM4RGpI8t5TcM2rW23RvOVrYRXX+0PqkKsM/puBPzL
         CvTyAhfsXIGuxrDRmSVP3yUpTu722vePtrdHlAav1mk+Dx11bBvf0XeQTPIVrTKV3bun
         SSJPIVY09evCxiR5O96psomnmkm5bji1XxK9pRI9xe+y0PhoS1bUNZoMo+cQQsa1BI75
         qQruLWnK4zDeruqXWUXZW0r7TmCoQveG3fgECgUMjvABcNQb/+4IJFXCqfZyRG//ma+w
         YXRYzsb7gvj3nMRhHRtegUPU/OtTRVaoNlcoQxtQZuo4V244YaLx56vj+qQCJKxtOkvX
         /3bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683727078; x=1686319078;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sp1rXB49Zfr24OMlLMKKbwnbFVME1qYysHUTaPTOohU=;
        b=YefuU98DOL+AfH+zami8FVmndO89ulCP1q2w35d7Rvd/IZ34zn7/ayJDXy4R1RI7Gr
         UCER/QL35sVFxRkSjoBxYdIiadvsk5zO3+zXywhyY4M937ghgVuUsFCLUrWsOCjH8YIb
         Ju3wY1jkbb9FU9qecS6OAxRdKhEn8jI/zTeZWNV5XbDfPtQUIgEHACUAO7JjbG1cWdZN
         iuX5m0XUSlQ2fb4+ZEorU0KtnL2qguodDl6DH3+GXTZ4QKu/W5OMXJeDbZZEjZ8NLTwf
         4eGXBag79w2cMJ0rYPJbqwaZ+Hhna6II7XHuUwQK0j1kDL5A7fyYHoNYfSRO4Rd5aBJl
         81fQ==
X-Gm-Message-State: AC+VfDzceqhztslvESpnZlBsS5emusMu+ymRu58FKeuLeGaCRNOW3HrP
        59DPzaiKufo+WHcigX7ta5ZmiQ==
X-Google-Smtp-Source: ACHHUZ6ZgyBK3gUDyEXNUdF7BJRlwVSqDsHgCTVi/Hk9u5oRTWdUiwyIpdPrGHnVvPEnMKktUY8mVw==
X-Received: by 2002:a17:907:8a14:b0:8ae:11ca:81de with SMTP id sc20-20020a1709078a1400b008ae11ca81demr14524356ejc.34.1683727078123;
        Wed, 10 May 2023 06:57:58 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:c175:a0f9:6928:8c9d? ([2a02:810d:15c0:828:c175:a0f9:6928:8c9d])
        by smtp.gmail.com with ESMTPSA id jy27-20020a170907763b00b009663582a90bsm2763573ejc.19.2023.05.10.06.57.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 May 2023 06:57:57 -0700 (PDT)
Message-ID: <3e546d87-42ff-fbe1-da50-6f84460a10bf@linaro.org>
Date:   Wed, 10 May 2023 15:57:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/6] dt-bindings: thermal: tsens: Add compatible for
 MSM8226
Content-Language: en-US
To:     =?UTF-8?Q?Matti_Lehtim=c3=a4ki?= <matti.lehtimaki@gmail.com>,
        linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230507201225.89694-1-matti.lehtimaki@gmail.com>
 <20230507201225.89694-3-matti.lehtimaki@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230507201225.89694-3-matti.lehtimaki@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/05/2023 22:12, Matti Lehtimäki wrote:
> Qualcomm MSM8226 has tsens v0.1 block.
> 
> Signed-off-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Bot's errors can be ignored.

Best regards,
Krzysztof

