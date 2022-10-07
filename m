Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF9D5F77F2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 14:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiJGM25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 08:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiJGM2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 08:28:55 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5084BAA3CC
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 05:28:54 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id s20so7036081lfi.11
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 05:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AaaH4Hzpc+BWxzk2RGTWufBjtoYuA+LOvqpi3Lw3mMY=;
        b=JimTXh/0MZ1L5q5YlKnUBaL7g2yVNCqJFefLV7S7pBS22G1gGhIph68C0apbMB8qQq
         jWqj7S4q9PcZhvdwMvBaGwifdZ0usoCgy6COmg6zABI77dNCUKLne9z9trZUaAkcUpFy
         HJwVVByGoPIH5JLUTc4lhcJnDZdqvzC/OKRy2YgHI+jyrDXUAHHTeow3Yh/6rBq9kswm
         1ygzt+2T1ghghERjhYUybteaZJJ8qQWF1LbLKJT7+X7xd7bu2oMJ9hw2puw3Qybgqvzc
         8/5k3GIXazHdOqfFMa1SKgWKhvlBvzWr5D8Xwc+1kciMKNBEH3VGtWAOoeGhJv342AHY
         /FwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AaaH4Hzpc+BWxzk2RGTWufBjtoYuA+LOvqpi3Lw3mMY=;
        b=iioQDCqGtdJZowDdXsxF0S2cZ7eWRSXWx5uNVv0Lmsv9OvcU0KLp3uueWgG/J2uyoJ
         E3Ee3mfAjMNjSkQZP+wcnTsgEwGoV+nzB4VPYWOmVMUa5WBBfq+tdsR2L1S3TrJJXLW/
         wMKrkjBZ6lXnWnPtl5LGzSb3pJ7dChMZNQ7iFmT7o7kFvF3Ydl9fp5tgIw8AyO80pmEq
         AdB+FA1e/1gpNrfrq5IQGeCnWnVHMKOGOqDqODJ52kaC78i3sRrbX4r7rKuWdPmKivLO
         ZMaTJTzCFEp1pkJNra9PHmO2wrx252uJPugEsIsGwYUbOoFocK5MdnEF/3noP6ae0CSt
         cwxg==
X-Gm-Message-State: ACrzQf2NLHwl93RL8J+06f3Aix8614o/oYBoy7Dnz2HBvlKbhm1GKp+4
        UGyRb4WPHc8KOighTHF19AwbIw==
X-Google-Smtp-Source: AMsMyM7mciDeK4YJsQJNGOMn8IAMb4ygr5ZASg/buDnVtEEy6/BWFjR4RTN1izCeik5DNvsqVlPFWg==
X-Received: by 2002:ac2:5a44:0:b0:4a2:5c3d:d68c with SMTP id r4-20020ac25a44000000b004a25c3dd68cmr1649669lfn.347.1665145732626;
        Fri, 07 Oct 2022 05:28:52 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id z18-20020a05651c11d200b0026c0f6be5dasm244298ljo.116.2022.10.07.05.28.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Oct 2022 05:28:51 -0700 (PDT)
Message-ID: <5847d571-34d8-0af0-300b-019e6a628d6b@linaro.org>
Date:   Fri, 7 Oct 2022 14:28:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] dt-bindings: mfd: qcom,tcsr: add sc8280xp binding
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>, Lee Jones <lee@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221007121110.5432-1-johan+linaro@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221007121110.5432-1-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/10/2022 14:11, Johan Hovold wrote:
> Add a binding for the SC8280XP TCSR.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml | 1 +


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

