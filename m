Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23C7565A631
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 20:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbiLaTEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 14:04:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbiLaTEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 14:04:44 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1291D63E7
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 11:04:44 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id j17so26729612lfr.3
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 11:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H2x7vlJ/r/t48A2fS0cFl3vM2lobn1qHOctkO59mr1A=;
        b=w9pO3XGL0+bcbmhTUvCqxxF6PT8jfA2/uW1UejYN97XAsakhQgZt0J+AP9PAjg+tMR
         zAS/qDljaHZr5CgrbJHgIUQavRcP1HmK3S9JprAikvwoeyQbMobCswndqSgA6R87uKZn
         1vIdo5XVo7DFpl0GeydW5Tma/MS7YBJ40v4Ixab556kx5XqMaxyRlWaGg9jYNHZ38zOr
         qYl07Nr/4OKJw0OP2Mfb0xB1eUqqDYzOiyWuTjcjLNySHEPkD8qtBac4jaISoCftENLe
         d9jojvjfgMzv1iFZnASjR9RCOOGzPX3+3daB/5c6+6QUh59ZQNr1PnK14xbN96TEpNVV
         bkqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H2x7vlJ/r/t48A2fS0cFl3vM2lobn1qHOctkO59mr1A=;
        b=h102/gr2JDNnI37vR1yp//YGqK353mnx9mEZRMPT+nWOOhdGBK+PQKFARIlrGCN4OY
         fr7YTP7Fv/8XTxRnLQNRgHtm9HRgNLFsroqDPr8NhosKwEW9wT/ZsSMO/2rEld0Am5hr
         ld+2C82h1MVGZkFzYxIW8q9kbFh5ncR3Iu1vYQv2BDG7QyLNwnH8mpm3DhmutN+bDki0
         uHkYUaiGNpCBqIXy8cW9i2lH6Bg6B+OmDXS9WboQ9r1icgDBpIq7x2ER71DZns+jYvLh
         H+MuLZnfklKeuxCpta9WfQ4TGiUm88YvTvdO/8YkoNOcQCOwNx+f+VQdomGd8XOoRduK
         EEFQ==
X-Gm-Message-State: AFqh2kqZFem6iQPlGmDRdVLp500s9FSn4bOa70JiZupB2E2NJ+/hkl3k
        rV3ZFaJS4Y9coS0S3NU+0bcHhA==
X-Google-Smtp-Source: AMrXdXuGj/15H1U3cDdyxOFphvG1sWgD0wqjdcdB1LDJNjD8+//exRX2+5DG7kP+5jb2nvevLYxgVw==
X-Received: by 2002:a05:6512:3ba1:b0:4cb:f3d:c47f with SMTP id g33-20020a0565123ba100b004cb0f3dc47fmr6263464lfv.51.1672513482450;
        Sat, 31 Dec 2022 11:04:42 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id q8-20020ac25108000000b004aac23e0dd6sm3926300lfb.29.2022.12.31.11.04.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Dec 2022 11:04:41 -0800 (PST)
Message-ID: <791101f8-fdae-ab5d-fb67-1c6087539c28@linaro.org>
Date:   Sat, 31 Dec 2022 20:04:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 04/18] arm64: dts: qcom: ipq6018: Fix up some indentation
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     marijn.suijten@somainline.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221231125911.437599-1-konrad.dybcio@linaro.org>
 <20221231125911.437599-5-konrad.dybcio@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221231125911.437599-5-konrad.dybcio@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/12/2022 13:58, Konrad Dybcio wrote:
> Some properties were not indented consistently. Fix that.

I don't think it is worth to split indentation patches, so this should
be just merged with your patch #2.

Best regards,
Krzysztof

