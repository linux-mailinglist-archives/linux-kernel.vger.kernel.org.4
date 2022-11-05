Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B79961DEB5
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 22:40:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbiKEVj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 17:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbiKEVjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 17:39:54 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA6012D13
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 14:39:52 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id d20so11004284ljc.12
        for <linux-kernel@vger.kernel.org>; Sat, 05 Nov 2022 14:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wDcIJcBi6g/qTugxSJoaAlKPWTs30yKTjAwn5zyj53s=;
        b=ASDj/J9+wRrN00QLmymSnOx9IIJdjK5+0StudWW/LmTirKiy2F45mqhrLIVz1l9x/a
         dnDOfINvFkq0Y9bJlNGy0BIBcTgK6682rHySG69N8oVxuiEn6cYq6kHthqJOTsnlZt8+
         5P113RmeGEgZITcq1Goi6uvdmX61U8to5y3g0TjATI14ljcaq/HWmRBeqWTJph0cEUtU
         VRg9wtwh7P9ia1TjzPoHH0RAaMqlsg9s8ecU02y9WNVxeF94DuixW4IN8Ay6gURVF1vx
         WV6aKMj3PIgfNQwg+/NU03a+tMvQ4czhWIbRTJ63hUunZKrZDgqCUbUoWw9++Q6S9U/s
         QfUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wDcIJcBi6g/qTugxSJoaAlKPWTs30yKTjAwn5zyj53s=;
        b=1m5yal9RpQZZLxowvl3FxlfXTnD7Z2mkK6xSVDWg/0e0rxkIqEd4xjRIel0WEbE9wb
         +mjbQGM5myfi2wJjt0y35e4iK2Zk9dDWaMWhD/k1UMRlAHRgUYti4/ZWTscmMklw1U7C
         QiCtZIQifiH0eI60cB//1UYVXSt+p0JWd9iyLhk9OpE1oUQQsNoQJRzBiDQiN13S3Xao
         KcuPRiFL+q0bgL5AcP1HfiPqFkMaACRfBOMCR5ijbYAvxZu2vdQYJt9jIfYZhlJOr2US
         JB3GYRxynY0FAD2gAKA72dhIZqbG/oZ3kcfRjsF+sUSQmizYNr1yCYZzSXKua7uLvROu
         +JEQ==
X-Gm-Message-State: ANoB5pmHbsAS0hW3fxdDce60R5hpAeO5jIWO22B8o6+O4AFaABSLOM9H
        2HGdGGnM8WpXf3v4ITb7NBQbfA==
X-Google-Smtp-Source: AA0mqf4IKa3pR/UQQq2LsUdHHa3ZRD5v/r/aPDwmpGOTRKJqEPMiSadFo8MeoPeXSdY1rfyR10yAFw==
X-Received: by 2002:a2e:5c42:0:b0:277:9847:286a with SMTP id q63-20020a2e5c42000000b002779847286amr1123359ljb.309.1667684390373;
        Sat, 05 Nov 2022 14:39:50 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id b22-20020a056512305600b004a8f824466bsm423619lfb.188.2022.11.05.14.39.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Nov 2022 14:39:49 -0700 (PDT)
Message-ID: <2bee4c98-d8f3-69fd-4a1e-7a9abc4f7e3e@linaro.org>
Date:   Sun, 6 Nov 2022 00:39:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v5 08/16] phy: qcom-qmp-pcie: use shorter tables
 identifiers
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221105145939.20318-1-johan+linaro@kernel.org>
 <20221105145939.20318-9-johan+linaro@kernel.org>
Content-Language: en-GB
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221105145939.20318-9-johan+linaro@kernel.org>
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

On 05/11/2022 17:59, Johan Hovold wrote:
> The QMP drivers all use 'tbl' to refer to their register initialisation
> tables.
> 
> For consistency use 'tbls' rather than 'tables' to refer to the new
> aggregate table structures.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 90 ++++++++++++------------
>   1 file changed, 45 insertions(+), 45 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

