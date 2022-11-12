Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0DD5626929
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 12:31:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234893AbiKLLbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 06:31:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234888AbiKLLbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 06:31:47 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61BA1192A5
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 03:31:46 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id z24so7233090ljn.4
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 03:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oCLzuadKXvrJKS83lIJy33fhLG63Dt8VFdnWa0UQSXQ=;
        b=FlbznqBGa9Cg7J104SWKs2A3VPhLSlgMhktLUVEol+sfegrPEZzBfLalWVuGaG8xke
         kKFt21gq8tZd0BCA0zlRUFbeG8JRK8BL15STtxJsNp/nHeHXACCthme2tf1isPOZ++Xf
         dA3OVX8Wt4XuLdg/feMw8b2Md5tbY+pLuLha1Yo/fUJ+/tSQurLDJgymAJnnbStlL8Vr
         rcQ23uG8WkbjZuXhxBj55qLJdK5KSFkwP2kyGcvSpeIvUFug8Gs6tK+patvkJ+2XNEuv
         xEOt+beI2aInyovSKS69yj0UvsRz+2qGvnn2r8OATocfadlnej64XDO2FBp+Yhq7sVRq
         AuVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oCLzuadKXvrJKS83lIJy33fhLG63Dt8VFdnWa0UQSXQ=;
        b=wR6ETVD4TV5AjKUQjLZaFZa763eCWcMjW8L/dL4xRcZ8WibCGaG04TheVMvqCYgBr5
         jucrxOvTJDZw5/7BpJWUBaJTqXTXMoeGjT/OwgKVShFNvmkWuL3dh+PY46cmEYiFcoam
         PKr+WTIEoX62c3CKMJZAkfe1PgyG/NBM/6+BjCPfMH2MvFXyuaMss7cqS8DMZ7YzI9MZ
         CsqUhpdWEzz0en3dFHGp1BcJHrM737JprZp6GdwcJiDBpaqjmq4yiXT3Qj4qXND8Bnh4
         OgEaIfCePz2Ak9CX1YjkrBDGQ786WKOribuppS4JEiUApbaROPz5r/jVGUk+BYFqgqtb
         l0Eg==
X-Gm-Message-State: ANoB5plCoIV6sw99h6SRNPCEzc5OZk6lEXAI+LdOT0ND3AGk2Hw8WmTD
        aL3eWBu0HcdyMoAP4lrenzIAeA==
X-Google-Smtp-Source: AA0mqf7e7UxcBza+uSIKrX0CbllRyLdTTat4ZXYJI92YxVafSRVGnLoJmE+UpDcutIOMR30P8mqFrw==
X-Received: by 2002:a2e:b706:0:b0:277:d75:f1de with SMTP id j6-20020a2eb706000000b002770d75f1demr1933927ljo.272.1668252704741;
        Sat, 12 Nov 2022 03:31:44 -0800 (PST)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id b9-20020a0565120b8900b004a4251c7f75sm829618lfv.202.2022.11.12.03.31.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Nov 2022 03:31:44 -0800 (PST)
Message-ID: <2f72e0b6-f082-5027-f42f-e0eeea77f033@linaro.org>
Date:   Sat, 12 Nov 2022 14:31:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 13/14] phy: qcom-qmp-combo: rename DP_PHY register pointer
Content-Language: en-GB
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221111092457.10546-1-johan+linaro@kernel.org>
 <20221111092457.10546-14-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221111092457.10546-14-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 11/11/2022 12:24, Johan Hovold wrote:
> The DP_PHY registers have erroneously been referred to as "PCS"
> registers since DisplayPort support was added to the QMP drivers
> (including in the devicetree binding).
> 
> Rename the corresponding pointer to match the register names.
> 
> Note that the repeated "dp" in the field name is intentional and this DP
> register block is called "DP_PHY" (not just "PHY").
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 139 +++++++++++-----------
>   1 file changed, 70 insertions(+), 69 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

