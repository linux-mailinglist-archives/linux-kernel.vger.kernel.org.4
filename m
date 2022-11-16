Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF02B62BB7E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 12:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233612AbiKPLW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 06:22:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239192AbiKPLWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 06:22:34 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 810D032BBE
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 03:11:57 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id be13so28981388lfb.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 03:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AIhdRtwfJxcSXkKxrQciTPwjYns7WX/KPRxRtELNuBo=;
        b=FGITvHx7/Dtu/7hLuQxKvATO4co9YpeSV7pKkPMRnqunFYXtIvwFhQTb7q/CSEoss2
         4SNRotXXM0JWHBHHmlYaMMPkgj2nip7ANeF57qxphhIy+TMHYq1ZyI8Y3SbTRhywF5Cb
         jC0UiURkbBreN3UESQ8c5Fui+phZoLKXjVmRNAXT8ZQLLoWLdWjhy1DhE8in89gxJ9z+
         gdwhYiq8LgzR0nsVkz8ZuaEe8BOx4MWcA/1tk6fwLpBJPMPVCj/zOb8krkL6XOhx1rj/
         +offxsPLXKNC+WsZc7IQcsIPZoj8gDzXNyb8+Kkiy+R6ny7DMorxD5JzcKAVkuMGA2Kl
         tkSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AIhdRtwfJxcSXkKxrQciTPwjYns7WX/KPRxRtELNuBo=;
        b=PJwhqPM3pydJUE1SIBT2iLsHJN5Vc96RjOsh9yDlV0OMzPKsjC93dIkDcID0DDIQMu
         gkgOmHemJjOKNdm/gWXoqRQ/Ge0R3533+Jhme72rfOuNJZ0AvLUmjlcYx0qszoHskWX5
         IiK4KKejC5CFFJ1HVgGPse83agtEGIVRkFmqI8ITUPIoQRt2qalrt4+WQSr5qvsDSGmD
         8qSlIOQfFQXqss6UMYdGRnPjs5tKIeCDeoF/Dg4BAk2IpxGKKMxaZjFIGpBHeGOU+qG2
         WCOflnhPn3/Ppm2YlKypPc5rMt6pGBDn9hMQLMEgR7LmvRuQyxbKzc5lNjljYPPXs8iV
         aMHg==
X-Gm-Message-State: ANoB5pnOqf+cuAnUSGjXrWeIWmGXselrj7ZdEgh54Y9a/pmBtUygHjnF
        7pmNX36aj6JJXIr+UQEgINdeqA==
X-Google-Smtp-Source: AA0mqf4GUS35iCiXM39dALemTg8Vo0uN4hBr1vfIoQnjuVH1IF3zaK1O5DxZn8vW9lrEgIALd1OzFg==
X-Received: by 2002:a19:645e:0:b0:4a9:e27a:1cfa with SMTP id b30-20020a19645e000000b004a9e27a1cfamr6924743lfj.147.1668597115927;
        Wed, 16 Nov 2022 03:11:55 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id y29-20020a19641d000000b004a22599c4ddsm2547699lfb.268.2022.11.16.03.11.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 03:11:55 -0800 (PST)
Message-ID: <74943a08-f5ea-54a0-3891-ef58adac78ca@linaro.org>
Date:   Wed, 16 Nov 2022 12:11:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 3/4] pinctrl: qcom: add support for i2c specific pull
 feature
Content-Language: en-US
To:     Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
References: <20221116105724.2600349-1-abel.vesa@linaro.org>
 <20221116105724.2600349-4-abel.vesa@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221116105724.2600349-4-abel.vesa@linaro.org>
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

On 16/11/2022 11:57, Abel Vesa wrote:
> From: Neil Armstrong <neil.armstrong@linaro.org>
> 
> Add support for the new i2c_pull property introduced for SM8550 setting
> a I2C specific pull mode on I2C able pins.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Also missing SoB.

Best regards,
Krzysztof

