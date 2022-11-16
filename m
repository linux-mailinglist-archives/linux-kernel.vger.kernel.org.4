Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06BB262C62A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 18:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238421AbiKPRSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 12:18:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238258AbiKPRRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 12:17:50 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C6505B589
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 09:17:42 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id j16so30530849lfe.12
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 09:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=alqzp5129GtCh9bfVu6PcgTAJMBaIsGH0ackHVO6iH4=;
        b=qZWZIXfg5ZtVsKnQJEm1i+qCEHB5ZZR3oxuzQzrKnTBhySsPuP9nPu/gv+d1b2GGaI
         wv8fqDNDVAHGaKX8vmyM/Pt0EAv+9ecr+Gu9MRMP4oXQ+cnQfPNgjahAfatb+Me/P70f
         X2Ac+9ee8/x6z7z9GIj46tTnXTGUnWvz888h5MvOKaQMgRo66lG/pPrAlCDeukhXVL/W
         CAlG+PepnPBUOx2WngwDKe6IvgJzqOmINKMM5tk9nBJxtoQjveOXugCyAXFJmlqv68xt
         yITI4w6Xm5IckeErkPbymu6W12DsgaH8VMpH+ziNO5DAvJRmo79kd1iwlVJzHJw6Zk+X
         GlgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=alqzp5129GtCh9bfVu6PcgTAJMBaIsGH0ackHVO6iH4=;
        b=w31xudU5gFYFil9qOt/ykSmfC5fxx4DKIvd9lyvgmcG1ad+v4i+f9ak95Jbac8ZnDz
         sK3KfY738So7JrjCoqy/l7I4AUqZMBi1FLCNJpbfiJ8PFIUa1RtZSDPvENddPvj4Mpvc
         mWTgXEnrCMA4mofDz3P0QijerTN3bVTt4bTiI+b4Pm4LBCi/A+JUPH/bj5lV00R6Y2NS
         XK7/47iQAUIeQw0jLA+aqayi1c4rTIDTLOllp4cLgWIhxqpt6DzPQe67UkPsV9V6eZ+Z
         nkZ246q75pHN/VBDHPCqZG8JXmnsaqkOebJKGIrmzy+UIbtz5Dd25Okka2EFi0hlJyxI
         xm1g==
X-Gm-Message-State: ANoB5pme/uWZZEwPCIi7dwsz/LMSJSuUupjyikRvHDT3VMCd1ctpXIxF
        NPJWVIZbxvYyWOThNnL3vQeh6w==
X-Google-Smtp-Source: AA0mqf4mfYWXPJm86CEx1/xbuui/eMMe7ixvXSC7/8Z4o78CunYpWzPT5PCGccvvhS3LhXyLaSTjIg==
X-Received: by 2002:a05:6512:1dc:b0:4a2:8836:c07d with SMTP id f28-20020a05651201dc00b004a28836c07dmr7123987lfp.661.1668619060360;
        Wed, 16 Nov 2022 09:17:40 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id s8-20020ac25fe8000000b00492b0d23d24sm2678048lfg.247.2022.11.16.09.17.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 09:17:39 -0800 (PST)
Message-ID: <e91a904b-6c86-5904-0c5e-030bed2ed533@linaro.org>
Date:   Wed, 16 Nov 2022 18:17:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/8] dt-bindings: arm: qcom: document new msm8953-family
 devices
Content-Language: en-US
To:     Luca Weiss <luca@z3ntu.xyz>, linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221116145616.17884-1-luca@z3ntu.xyz>
 <20221116145616.17884-2-luca@z3ntu.xyz>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221116145616.17884-2-luca@z3ntu.xyz>
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

On 16/11/2022 15:56, Luca Weiss wrote:
> Document the various phones added in upcoming patches.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

... but you miss to update the list of exceptions for board-id and msm-id.

Best regards,
Krzysztof

