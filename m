Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA2262DC14
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 13:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239241AbiKQM4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 07:56:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239307AbiKQMz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 07:55:58 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6113D22B3B
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 04:55:57 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id j16so2598175lfe.12
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 04:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=weF6twQ71pWpDxGcUzWzUjRuKt4zlvZJapX9428bGkM=;
        b=oMJaEUk7SN6S+W68VImxs6MzLOp4LRttAMZpSdPfxVM2JMza7JDFDWdZZaL0lO9Bx1
         M8T9iWspwsMr6SYy4ZdUH8T1EQjqBGNOYs9jfZd1kqrL3uBAEHL+e6n9nPOls2DMEwsu
         wvg1nvOKUUC20InGEspvMCFGtH7OJrPVVthCEovVTkGTnK8vw9BRU7EeZuK0rZ5/1AyO
         EKXWShLXBF48iiY4KC3ZEn8j7aIErKsaOzHZVLlMaw8d2oia8izerOMPXbNkxf/46jhz
         5piUjAecz3Nh2BxW5RRbZrNjPM6u51pvU+DDTdhdccIOFz0aDFLLpVskGANGCamJ3OIL
         up2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=weF6twQ71pWpDxGcUzWzUjRuKt4zlvZJapX9428bGkM=;
        b=iJ78W2rndJ/kfPKzY3N7WHq7mB+12KKpMYWuGbYIIy+pi6u3Ll3w7gq/Z5p7JR8Vr9
         GTwD1WXv+bMkZfX8PLTGVcyIyBt0OhOtLvadylcJfISgtiYq3QIPWX44uUc/G2zSV+IK
         vF/sbwG6ghX8Vzhr1ndeXumD8U3po/Ib/Be4+i6/278wNJ+kdXxJQUyJPJqjthxkMUsy
         UteaoWDY9LRSKNlx8t1mVo1UeMSf40mMHTMWq2BQD6WD/kb/DVI9A28sN9FTxjdNVWxH
         oZekxGKUXgtCORIMQMNP10AwdRTDSvRaTiVmUzKJQnmOg3UWFj1Gc5/DXRsw+ky9BbRz
         p14A==
X-Gm-Message-State: ANoB5pnFD9ck0DSB7igOUclTd6LtgQ3IXlZvy8O9vWZRbOJHILniDvr3
        GUYIwbXfyU4FWSbveHM49UFprA==
X-Google-Smtp-Source: AA0mqf6HTkt2Xy7pKPSB5hVlx+Bp1Kn+ts6vBant0J7vRFGKxCmfnqQF/qAUyQQ7iWJ9insch5v5nA==
X-Received: by 2002:a05:6512:3b12:b0:4b4:686b:4f7 with SMTP id f18-20020a0565123b1200b004b4686b04f7mr773502lfv.256.1668689755798;
        Thu, 17 Nov 2022 04:55:55 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id s3-20020a05651c048300b002770a9ed61bsm181805ljc.66.2022.11.17.04.55.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Nov 2022 04:55:55 -0800 (PST)
Message-ID: <77805b04-2724-dc93-eae7-21d9c7caf0a4@linaro.org>
Date:   Thu, 17 Nov 2022 13:55:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/2] dt-bindings: arm-smmu: Add SM6350 GPU SMMUv2
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     patches@linaro.org, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221117094422.11000-1-konrad.dybcio@linaro.org>
 <20221117094422.11000-2-konrad.dybcio@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221117094422.11000-2-konrad.dybcio@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/11/2022 10:44, Konrad Dybcio wrote:
> SM6350 has a qcom,smmu-v2-style SMMU just for Adreno and friends.
> Document it.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

(although this might need rebase later on Dmitry's refactoring)


Best regards,
Krzysztof

