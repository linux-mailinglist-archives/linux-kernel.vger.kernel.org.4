Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E74FC60F9F5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 16:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235615AbiJ0OCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 10:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235052AbiJ0OCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 10:02:05 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98BC1867AE
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 07:02:04 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id r19so1143134qtx.6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 07:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CSI134q3G18vUOM2R14o4I7JTrpKljdKg2N+dHw2UKg=;
        b=h/TyVcNyD90NOTJae72UiS5ijQQiCeQ62WFCUxoY/ro/nYIE/HxARb4Cusl7AZk+8r
         BUHhuOalv0zSaGXebJBCnr7LXp3iTruNKOFvhMQeTMpM51Sm3675hiVyW0X82RojRLYl
         jEhbg6gsAn1AsQrVwiWzgvpxyI0LTe9AHQKGGl4DsMBQfsgJzM91YrvMyPsOFBE2k1bm
         QLy5RdIkl2ZbPWieY6cj3gHzeBuvD1ManViJF6n56TMsFVxHPN+1yKa0C7hf8xgdgzvs
         V8TtQLA8WXvE7tAd+NV0pKIepzgpD+LTcTe1uKnt1sa2pom+6af3PQQpkNUd+gWSYevD
         Eyww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CSI134q3G18vUOM2R14o4I7JTrpKljdKg2N+dHw2UKg=;
        b=lf0MFQzlNFs+Y1MZB4IOklVt2z03TcRIWK5YeSjCvzsVuMEpSJ8A3ungvrK9R+gpSh
         Kz/oOQ1XqIFQT1tYZ7zLl0IVNaSufoD0PpEQhjr4vzJ9yX5/m0zU3cVp4EwmEN8AupHn
         D32v8/r1jXWpu/3ZCEwfrR1vPF6YS07eJYznOdCE2rHDyheYIVR1PMDiiV5C401md+jM
         Z/lnr5kXjxeC/rPAS98K3Ea4x91VaUI6i+xDeVOn6Fe1h20sb+AA2FgVBJy3f6GcmPZd
         RqmoJbSDuspV/I2jXoMBkTZrbhYNguOBQ+8EdqlfKMJkef+8f9YFX4Ox4RPYwyb9XGMW
         tyJQ==
X-Gm-Message-State: ACrzQf1KGSzDAhhxeBKP3GeWa+8HlkEyF898WwW4UVxsnwUTFTHlR2r0
        luxYmv8b74wUT3AiCxQyV8v5zuC9kLbtfw==
X-Google-Smtp-Source: AMsMyM5k6qFVt09+gePFQzp2veaHXo7bZ48hnaS7zc2NraR/t00V3L5VKDp6l+eJyEA7D69n1XkizQ==
X-Received: by 2002:a05:622a:1312:b0:39c:fbd3:6dbf with SMTP id v18-20020a05622a131200b0039cfbd36dbfmr37799641qtk.335.1666879313363;
        Thu, 27 Oct 2022 07:01:53 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id c5-20020ac80545000000b0039a610a04b1sm913975qth.37.2022.10.27.07.01.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 07:01:52 -0700 (PDT)
Message-ID: <088bd8a1-fcc7-820a-a100-9d4c62837a17@linaro.org>
Date:   Thu, 27 Oct 2022 10:01:51 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 07/11] arm64: dts: qcom: sc8280xp-x13s: Enable PMK8280
 RESIN input
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        andersson@kernel.org
Cc:     konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, johan+linaro@kernel.org,
        quic_jprakash@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221027063006.9056-1-manivannan.sadhasivam@linaro.org>
 <20221027063006.9056-8-manivannan.sadhasivam@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221027063006.9056-8-manivannan.sadhasivam@linaro.org>
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
> Enable resetting the PMK8280 through RESIN block in SC8280XP X13s.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

