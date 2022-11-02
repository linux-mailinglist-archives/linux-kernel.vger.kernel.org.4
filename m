Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D397616E4C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 21:07:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbiKBUHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 16:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbiKBUHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 16:07:46 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4DF2DE8
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 13:07:42 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id o8so13248446qvw.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 13:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yScNRjarivKfDtqMlxJNO+tYRVEciZkZDOJ/r9eV9sI=;
        b=iG8TqQzC0L8eoK+iDHeEF4G0s4j+YcoMQTXpMOr2DWCJ3rk/aDRZEtxvayYnRuFx48
         aoJ41dSKWetNuTW2VWmRWkenK3g7r79kfr5HrKEJ9Q7TlTg31lu3PF3dHM+0FG5z9dvD
         Q9KMsJTSiMqBNcCBm9IBP9/m88Yk2VP0rMhXGQpgYl/303T0Mo4wJI3MhD0UcUmDVdIP
         iYLGxa2fVKTJh7XeSKM+C1j07XAyzctYRAJEyZELe7D9D22PFxxzGpDlYuWFfbZwjdr/
         fYECDSavMPomakOJM9x0LDXlJqut3LaUteId1WonwPyHJHWYP6INwVucqzqexGnwpeKB
         7KNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yScNRjarivKfDtqMlxJNO+tYRVEciZkZDOJ/r9eV9sI=;
        b=1Ak5luZr6YRuxwAXGdiQRhJ1zK95VXtKwuGp6ga7KNiO0ND+9WahLanNa4shBR9koa
         ow5MPoaImkb7fDoRhIiphu+ohIWidmVw03nuU5hVRIiiOxVBoXV3YgynPm8J0MDcDTjU
         /tdVkf7e8f7Ea9Y0CFJtIX2vgjhrI1oTMwIlkGpY2uT0k0xuVCHJXblnz1c+fbdTbn8g
         QMtXy0C2xP4CbM1EX38KvU8HwmLAUqRVagnX9t2ZT8bPjLwgCo53z2kP61ydjDbOiInS
         vWfOYfk/uwfeuzDmYDtiHOSTK9ubkB+x4UnYDBKXlZPqofqtvnvAIUY4ioENv1Imrfg2
         YNJA==
X-Gm-Message-State: ACrzQf3EkAvCN5hTsI6ZdONJyeXhVpsUop/vKn5rN9QkB7O334/SlHVV
        JndlpuIk+x9TGpMCn4YwyezJ2w==
X-Google-Smtp-Source: AMsMyM4kcZ+Bef8rAzp/gRnLKi34Q5h8gBnn5aCI4lcEwkQOufM341KFcDIfjfHBqxdQq29eqTErMw==
X-Received: by 2002:a05:6214:5004:b0:4bb:f292:6fbc with SMTP id jo4-20020a056214500400b004bbf2926fbcmr17028076qvb.53.1667419661499;
        Wed, 02 Nov 2022 13:07:41 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:28d9:4790:bc16:cc93? ([2601:586:5000:570:28d9:4790:bc16:cc93])
        by smtp.gmail.com with ESMTPSA id h1-20020a05620a244100b006eeb3165554sm9358091qkn.19.2022.11.02.13.07.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 13:07:41 -0700 (PDT)
Message-ID: <4ed110e5-925c-77f9-e33f-efdc6dc82edb@linaro.org>
Date:   Wed, 2 Nov 2022 16:07:39 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v2 08/12] arm64: dts: qcom: sc8280xp-x13s: Add PMK8280
 VADC channels
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        andersson@kernel.org
Cc:     konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, johan+linaro@kernel.org,
        quic_jprakash@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        steev@kali.org
References: <20221029051449.30678-1-manivannan.sadhasivam@linaro.org>
 <20221029051449.30678-9-manivannan.sadhasivam@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221029051449.30678-9-manivannan.sadhasivam@linaro.org>
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

On 29/10/2022 01:14, Manivannan Sadhasivam wrote:
> Add VADC channels for measuring the on-chip die temperature and external
> crystal osciallator temperature of PMK8280.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

