Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF4C9629AB9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 14:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238293AbiKONjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 08:39:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238294AbiKONi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 08:38:57 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9BD13CDB
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 05:38:56 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id b9so17550940ljr.5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 05:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2CpA277xmc3TicpaEpZnhMOiKh9Ta2fws73LbvJb9po=;
        b=HYtTbhykeOpyfp1CWHIRuXtxh9TDpTyRPig7PwTLVYkGWVURu/9aMJC4r/fjrECHM2
         yl/wI62Aic7i2zXu0RCZHFht5vl6ouHHSvPlBaqWa2ZOaFZeQN9Ov8sKK0IiVaWBAmOj
         qQlPAPBTvciwHFGt1SgQfWjil7+hGqSc/RPUCL4ODfITASsYfN65DX/yThlIU9NsJJoW
         AZqL6DDxc6FYD8cGUqI2gnV2AOAC7yEt/RMb6BsDH+5ZDXl7Q3Kfj14YHSk78jfeg7uY
         arGz7RYIUp9SXd2+xBZbtHHsYanAMotE1vF/fSbxRDzla4ahhgqeR+A/pQZEKcEz0PVv
         8LQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2CpA277xmc3TicpaEpZnhMOiKh9Ta2fws73LbvJb9po=;
        b=pKVBaOTLbH0c0kmKCAQLNaPIJbJwW2nBSzrgutGtuhe7oAGav/BO26eUnS988rJ9Xt
         Y/3ZWT2A8BBoNZwpGMQW735Vu+j/NM0ZDEa8lsFkL5b9o2gdPQi/3kTre+9Atq2MFV8v
         NCdl+Db4c2+lQ+cPmprPXQmyAlSL/bdLbsJEjiJdVU6FY9yUag++f17oA+oBHhkI/ngd
         U4adegbPw550dGhgaxdDsPedmS45hXPoTxMPdAfn7gKhNeZRn0ZPyHT4KDSBObzERiFW
         0jMb3lu00rD+K0+9A4NfRj8EBWVO/soDl9mN88iTqOOXxlxNApj+Wu/tm3yrJ5YmLnjT
         knbg==
X-Gm-Message-State: ANoB5pn7Aqu1bF+lKTIEs1/UUk/5LcJHGWrymruJ1mCFKG4eJ2QeHL28
        xx6pcNb12Vh8jUPgK1dSNfplBA==
X-Google-Smtp-Source: AA0mqf4MKBH635VXC2jV4FG0ROe4MyyQ6PGcweo05qjZ5o8A1G8micaVYdR5ZVNm7fgnNjWFt8Ot7Q==
X-Received: by 2002:a05:651c:32f:b0:277:1e9b:2b07 with SMTP id b15-20020a05651c032f00b002771e9b2b07mr6345597ljp.242.1668519535130;
        Tue, 15 Nov 2022 05:38:55 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id k11-20020a05651210cb00b004a1e592837esm2215324lfg.140.2022.11.15.05.38.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 05:38:54 -0800 (PST)
Message-ID: <77c27fa4-5c3d-7e5e-058d-24ea6fc449a2@linaro.org>
Date:   Tue, 15 Nov 2022 14:38:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/3] dt-bindings: phy: qcom,sc8280xp-qmp-usb3-uni: drop
 reference-clock source
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221111093857.11360-1-johan+linaro@kernel.org>
 <20221111093857.11360-2-johan+linaro@kernel.org>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221111093857.11360-2-johan+linaro@kernel.org>
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

On 11/11/2022 10:38, Johan Hovold wrote:
> The source clock for the reference clock is not used by the PHY directly
> and should not be included in the devicetree binding.
> 
> Fixes: e8e58e29a0c9 ("dt-bindings: phy: qcom,qmp-usb: fix sc8280xp binding")
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

