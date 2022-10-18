Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1F4602D4A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 15:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbiJRNqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 09:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbiJRNqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 09:46:00 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC391DF07
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 06:45:54 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id v11so715599wmd.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 06:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:from:reply-to
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=girWpLhnDH5Eg8WtTtJ/aUyRj+2HWi7KI4BYRoNMPhQ=;
        b=r4Y64aJBlBk5I0Au6mcBaQSfZgJ1Ez5H+koz2S2xwZTS2iCc0NZHuRJT8QMtfSJ5ld
         1eceXLRnfbgGBNp/t7UkJamChtxzg/RPZ0UkZlVAuoUYkoktsOLAbqrxEeQF1Zw4+A0L
         94ljn6DIOvg00MuWmbwPDR+Xf3Df8GQilc5+m5tgxl5dfbS/8pogmGj3F/TcQLxseCBv
         7RmKM6PChv+sKDzzFLwE1up/3st+jYfQePHy397Bg/IHM0htZd1AyKd+h+YHOo3BdFJ2
         HEiBiJSwcJvTPd9BArw0FF1FZVU0Xd83AfK+Rem1vDtu4B1BheHQukIikR8qxNNpDbZj
         JZsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:reply-to
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=girWpLhnDH5Eg8WtTtJ/aUyRj+2HWi7KI4BYRoNMPhQ=;
        b=dXL3W93Trr/nCPWsX4js/7qBS9pOa6S6kfWud38PJfkdrTHXaruxlC5vpceR6bt8jo
         E5nc0SclXitAn6Id/y9CmsH1SVGTxLKTQ4aEBtibMWreMY4NMJVGm8juHNEC15901vp0
         VFgI2GaW5hNFi5iWYk+beG9RM09HkBalP+12A+e6C/aZuogMxQtwD06pi22QubJXU/kZ
         VGMjwL+Jbz00Fsbxv4JUMY3pk5JsC+MZG74Jy7lymXDvTAorjgiUulmao1gXl/cjVv+V
         CvpSBZWNRm6NeIUiZdGM5DLcwVi72oo81tWAwARCPf2+mqT/qo6fxpUdbO6l+oc76r54
         hYlg==
X-Gm-Message-State: ACrzQf3Ry+a6gYwEHRq1X8t7enQSANvF9Iue6NJNZJLBle0RB0mtciFK
        SFbn5xTcNLKUBJ9kVw4Wmg2xqfFSTT6yiY4z
X-Google-Smtp-Source: AMsMyM5j7eKRMx5R+MXqbWOtYfWnV/RtRCX2h9J/CBUag4EHQYMCqLNg4JaDPmsvuUukwu5We0HtcA==
X-Received: by 2002:a05:600c:2c4c:b0:3c6:e230:f18a with SMTP id r12-20020a05600c2c4c00b003c6e230f18amr17963029wmg.24.1666100753018;
        Tue, 18 Oct 2022 06:45:53 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:7fad:ace8:cda6:d900? ([2a01:e0a:982:cbb0:7fad:ace8:cda6:d900])
        by smtp.gmail.com with ESMTPSA id e9-20020a5d5009000000b0022e3d7c9887sm11087369wrt.101.2022.10.18.06.45.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Oct 2022 06:45:52 -0700 (PDT)
Message-ID: <941584f9-80c8-041f-8414-c6f3b2c36ed4@linaro.org>
Date:   Tue, 18 Oct 2022 15:45:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 5/5] arm64: dts: qcom: sm8450: Add GPI DMA compatible
 fallback
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Richard Acayan <mailingradian@gmail.com>,
        Melody Olvera <quic_molvera@quicinc.com>
References: <20221015140447.55221-1-krzysztof.kozlowski@linaro.org>
 <20221015140447.55221-6-krzysztof.kozlowski@linaro.org>
Reply-To: neil.armstrong@linaro.org
From:   Neil Armstrong <neil.armstrong@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <20221015140447.55221-6-krzysztof.kozlowski@linaro.org>
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

On 15/10/2022 16:04, Krzysztof Kozlowski wrote:
> Use SM6350 as fallback for GPI DMA, to indicate devices are compatible
> and that drivers can bind with only one compatible.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/sm8450.dtsi | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
