Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0E076540B4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 13:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235830AbiLVMHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 07:07:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235923AbiLVMG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 07:06:58 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E3C7303DF
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 03:58:13 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id a19so1705601ljk.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 03:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xDC5xCKfkDa/LgM6w3krjqzwgZw98EUeXEhxRPwXjAY=;
        b=HySmqpo4d05os5Aqbd0yTRiPgZA40Rqz86blpJG8oF9ARciWS77jnz/uqGywbxaXU1
         FYobQi+TsRrrMzIKDoBM7lf1ePuixuJFkYsDuHMyMXLT4YE/6rLJMVnT/ngjp72CaoI4
         HVgkUnuCKbrnTvxVwiZjZIKlTXdCFCqQRNvHFqvWLhu8fnkDLED3d97oMJn518g45wpH
         4T0ptVE5Kg9pYO2UCGe6DafpKb9/12fb93EoWAbpHtVuvDb54KJ+xk3m/1DwRtTu5efd
         QMh3qOkjBS7yeIdboDA23WwrDVSRLXVYI9k4iyKyjFXGGeS32W8AL3xK7LL6XnvMjow3
         aqFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xDC5xCKfkDa/LgM6w3krjqzwgZw98EUeXEhxRPwXjAY=;
        b=ilS+gqX/VNnkOuHRBrG7W0MqqR8BNKcPCHD+ZLwVUNPdEznEpvm02o472kY99ewlR4
         YXXE7Wox3nDF1dFZzM9LslFe14/z2sKx2iFzpC6iJDiBOAAV+s5WIJxEkVxWgpQ4ggqd
         IktNapgo1/ZcTwTlvEa3oxMJ2Ix9XQdv7qwGIIoUihs79lQxtAPuEu2XTmYcZPt+1SHL
         vZnzjoQOKxV10rDwnGXlRHzCb1oyzhX5ZiI2x7lGma/ubwUlLCwYm1J5r7GV4Ji28WH8
         hBgIE+KMaYGp/JSp4Kt1kc8eKHYu3Q99MXGuphu3AEpbIRLlwD8clNo492OFTr8MFhXo
         LKJg==
X-Gm-Message-State: AFqh2kouRvz+vEPb+t+ZTRmkYC/S4D+on7seDnlXSV3frqk+K+CPmgXp
        qakD//AthWStUrE/pDqnbGSMzA==
X-Google-Smtp-Source: AMrXdXuDLZCR1aKFnCjSyyj+uMWF/mFNPNJjQEVkOD6wR4u7x2Pirb7Qf2RMA8Cwez0TSlfJOHFB+g==
X-Received: by 2002:a2e:a26c:0:b0:277:4a25:7ccd with SMTP id k12-20020a2ea26c000000b002774a257ccdmr1461554ljm.53.1671710266657;
        Thu, 22 Dec 2022 03:57:46 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id 17-20020a2eb951000000b002777a07f48esm29267ljs.12.2022.12.22.03.57.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Dec 2022 03:57:46 -0800 (PST)
Message-ID: <0193f5fd-6f79-3c56-d16f-465119d3d3db@linaro.org>
Date:   Thu, 22 Dec 2022 12:57:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v5 10/21] dt-bindings: display/msm: Update MDSS dsi compat
 strings
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org
Cc:     robdclark@gmail.com, quic_abhinavk@quicinc.com,
        dmitry.baryshkov@linaro.org, sean@poorly.run, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org, dianders@chromium.org,
        david@ixit.cz, krzysztof.kozlowski+dt@linaro.org,
        swboyd@chromium.org, konrad.dybcio@somainline.org,
        agross@kernel.org, andersson@kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20221220123634.382970-1-bryan.odonoghue@linaro.org>
 <20221220123634.382970-11-bryan.odonoghue@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221220123634.382970-11-bryan.odonoghue@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/12/2022 13:36, Bryan O'Donoghue wrote:
> Several MDSS yaml files exist which document the dsi sub-node.
> For each existing SoC MDSS yaml, provide the right dsi compat string.
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

Same concerns about bisectability.

Best regards,
Krzysztof

