Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A47AD65755F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 11:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232767AbiL1Khc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 05:37:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232813AbiL1KhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 05:37:14 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85970101EF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 02:37:09 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id y25so23079024lfa.9
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 02:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eMzR93zP+dFBEJ+GNpqNw86ldxjfHZpuKwLVB+qsmz8=;
        b=atJAVq84Qr4MNOmDoxgh9c5GCnHkI5Qt5UzCqg9VDYcRTARsvzzvhD0a3v+ng8Vl/x
         JqwPdPoUn1VUj0aR2kg6VGdwTWzFRaG6pQ0ejWKkJRIi+Qrm3rIUZ++EkNo5wF7AcORh
         dzdkaYOnP6xlE7DkdYZ98znB22/iPDRs4gpjDamxoSioyucNxyJkv+P8t39g4b8ij7Pj
         bYPrdDObXbGaKVYsQ4+RkmoTKRjr30fVMk/oKZHBXz2rTaUT3+zc2rHauUO1WJ6y1Kbs
         jYyb48SeuQcRRUDDnYYkGB+U4kbUKRCyr4grUlpQ18nH+hxQ5Rn+MvlRGExeAGnAITlu
         sqrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eMzR93zP+dFBEJ+GNpqNw86ldxjfHZpuKwLVB+qsmz8=;
        b=h/Xynma5PxtOskaiNAzS1UeyLxwxbD/lzZAxggDo1JOITakB9So1hXYNncSbR2wql3
         CAgtXr3MlZlerTmc7FwwFDrjB+S8mYxl6N36KpAPhICTxFn2KotqkR6hA8Yi0hnJDXew
         spqtj+8/XfObU/chYBCg+qUS+lLDgbY0qiJ7r7wUWWqVGbbe60f/I57NThpk8Rxhx2sn
         bBBFsGGBaGNrRlGnDIM5lLLcSBptoIVU/wukER4tnjE6W2/4+9RLtIwUftpRThyBX3F4
         HCxBhYQKL5qSeZ128qA429QmXO2Ei/9njU/OlvkkzYqoDz2GMzaGGhgHGCPfeog0YUXL
         J4GA==
X-Gm-Message-State: AFqh2koytIwX5WsYLCbkPW7Hs86H3g5BoVXiYvvg8iqWVUsdsQcMsONa
        neyiMnRIP3NZFGo4LxaVv0XfTQ==
X-Google-Smtp-Source: AMrXdXuW/rMK0LTP9vvTQ+TXMMllq4ywWs+fNRTxKGAaz/uPjoIjhLwSzQEK5ySK/Nkb5pddHATYHg==
X-Received: by 2002:a05:6512:15a7:b0:4ae:8476:2df with SMTP id bp39-20020a05651215a700b004ae847602dfmr9615943lfb.10.1672223827947;
        Wed, 28 Dec 2022 02:37:07 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id i19-20020a0565123e1300b0048af9576d30sm2600905lfv.83.2022.12.28.02.37.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Dec 2022 02:37:07 -0800 (PST)
Message-ID: <14b0237d-6511-4a1f-3bda-e0e72b442a56@linaro.org>
Date:   Wed, 28 Dec 2022 11:37:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3] regulator: dt-bindings: qcom,rpmh: Indicate
 regulator-allow-set-load dependencies
Content-Language: en-US
To:     Andrew Halaney <ahalaney@redhat.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@somainline.org,
        lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dianders@chromium.org,
        johan@kernel.org, Johan Hovold <johan+kernel@kernel.org>
References: <20220907204924.173030-1-ahalaney@redhat.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220907204924.173030-1-ahalaney@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/2022 22:49, Andrew Halaney wrote:
> For RPMH regulators it doesn't make sense to indicate
> regulator-allow-set-load without saying what modes you can switch to,
> so be sure to indicate a dependency on regulator-allowed-modes.
> 
> In general this is true for any regulators that are setting modes
> instead of setting a load directly, for example RPMH regulators. A
> counter example would be RPM based regulators, which set a load
> change directly instead of a mode change. In the RPM case
> regulator-allow-set-load alone is sufficient to describe the regulator
> (the regulator can change its output current, here's the new load),
> but in the RPMH case what valid operating modes exist must also be
> stated to properly describe the regulator (the new load is this, what
> is the optimum mode for this regulator with that load, let's change to
> that mode now).
> 
> With this in place devicetree validation can catch issues like this:
> 
>     /mnt/extrassd/git/linux-next/arch/arm64/boot/dts/qcom/sm8350-hdk.dtb: pm8350-rpmh-regulators: ldo5: 'regulator-allowed-modes' is a dependency of 'regulator-allow-set-load'
>             From schema: /mnt/extrassd/git/linux-next/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml

Andrew,

This patch was merged therefore we started seeing such warnings. Any
plans to actually fix them?

Best regards,
Krzysztof

