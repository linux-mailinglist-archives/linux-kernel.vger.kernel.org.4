Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 813937370FF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 17:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231994AbjFTPyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 11:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbjFTPyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 11:54:33 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFBD8F4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 08:54:32 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b4826ba943so28525081fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 08:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687276465; x=1689868465;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WbhRv9UOhzTRS8IfZ+DjpRP+3M40+c6Z45Ys8Eryg5E=;
        b=MLna89+/pbvcBfBabJOpohWlaeE4EZ37l3LWcSoehXJkIlcQGrkpcdWJXxUIznxEez
         d2ZnV1hYK830Cb7h3uyBVDeDqK15OFKzud1pJWIaWbHWK/6qeA2UW7tKNDCC9B4a44pz
         +e3h3IKuaqHrQ7m7ZjFeG65mqQgP1mFTA+YypZYhjSNbSAWKnceL73O+b3RuPqC0Sv+1
         DGAaZz2IsUOzB3owhdn5dyL6HAg2GN73gXGntEKOmNIV3WbHuPRi6DphnBvKkdJp3WyP
         qz3MW+QJoCc7j0q1R3buy/HpkClnvGduLFmdG69uMpMeQ3sIlJBQIahNVbO2eG0Z1rSu
         gpjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687276465; x=1689868465;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WbhRv9UOhzTRS8IfZ+DjpRP+3M40+c6Z45Ys8Eryg5E=;
        b=QQykIP4X++Ba2Canuus3F+MKg37WPTn9T8uzlFQ0R0u3wCJzLrcaZFQ7EnEEyb5Ku8
         EdPlsH0u3NFjKqMiQ9cGRgzdYFb1J4RwEJ/sGJjaA48zpsflJ3fq0NVU3f3YMSK4qg2A
         WgAJwccgwwER8b/ocRbCyVm9KvzEuECfxilP6SLYIl98QIuY3TNGTJ3IXlSxpdI8Lb1D
         2voVm/nkQmsmgShMTee+TsraDNCvLzwZmeNThUYRsvhtiePxpkSocDoUK0OBc3xT93Yn
         wT9Sq+0C3rhjnIo54c31LdW+qxTCsVcp2Llzu6thWpfwENlrruQG7zoDZqX6AEWMvWX3
         4ukQ==
X-Gm-Message-State: AC+VfDx3V9kw98vpFrpbMM7IF2jNBj5DJbPl0jlz5bYEGUi9UPi8Ejgk
        sOGoW0PKQnbTkn6s3WqdPn15Hw==
X-Google-Smtp-Source: ACHHUZ7sHQ2vM5dOEut7OWBwmr64PpwD+O+eLDIi/3yGaZFXyvM32iDhsd0y3ZNyL2fRbWG1W+Mqhw==
X-Received: by 2002:a05:651c:1022:b0:2b4:636a:67f4 with SMTP id w2-20020a05651c102200b002b4636a67f4mr6577704ljm.20.1687276465319;
        Tue, 20 Jun 2023 08:54:25 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id g22-20020a2e9cd6000000b002a8c1462ecbsm464265ljj.137.2023.06.20.08.54.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jun 2023 08:54:24 -0700 (PDT)
Message-ID: <33701b2d-ef25-411c-a858-5778e0c4705b@linaro.org>
Date:   Tue, 20 Jun 2023 18:54:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/4] arm64: dts: qcom: sm6115: Add GPU nodes
Content-Language: en-GB
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230620-topic-gpu_tablet_disp-v1-0-7bb02bec8dc0@linaro.org>
 <20230620-topic-gpu_tablet_disp-v1-1-7bb02bec8dc0@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230620-topic-gpu_tablet_disp-v1-1-7bb02bec8dc0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/06/2023 16:17, Konrad Dybcio wrote:
> Introduce nodes for the A610 GPU and its GMU wrapper along with the
> speedbin fuse entry in QFPROM.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/sm6115.dtsi | 103 +++++++++++++++++++++++++++++++++++
>   1 file changed, 103 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

