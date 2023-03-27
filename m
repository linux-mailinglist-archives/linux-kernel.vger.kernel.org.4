Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 274016CA122
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 12:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233369AbjC0KVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 06:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233578AbjC0KVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 06:21:06 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A72404C30
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 03:21:05 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id y20so10723988lfj.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 03:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679912464;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0/I9lr+ZkR5aRqUVRn/W21Ba0KeGxJDDvRUqsC5WDzc=;
        b=CVfaUAsDyhDdbif7Op1Sp/RHwzq3DKCet8dKRah5HkgGvKF+qQ8UuZX2nV20/pTcMq
         1SRyo7xBv5zE7YwNWdCMWfVIcD3kkrnTy+IhKkIDqzWMpF2LRlvK/+hZp8V1jKZvIyTX
         njbqYnX+WJEL86VUurSRZPiYDzWjgXBbIJkJK60qSjcxsgev+3z+FvGnN/5YNCwAMoSK
         TxZtaVScbU76jxG4Frrm3xrS2+ucHnJ44CmjZrRyT283bU2iaR2Im6GO1F39sc8ifKq/
         ShpxYdS+S2C6/JGhAyPU9v8n+AGiuvrbBqPOX4BAfLDVPNU7uhkdXUvUhqM8f7VzdLf8
         Fw3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679912464;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0/I9lr+ZkR5aRqUVRn/W21Ba0KeGxJDDvRUqsC5WDzc=;
        b=fey4TKDCHQhf9yjoouRKmBsdNxlNMBPB5TUcteB6rUyiR4rLf+eXtosBGrOAZoeRmr
         aSy+UwYraqejOz1HUMV9KfJiFyS++mhvhCHrWV4tU9mTtOybghhp5uj4aGEpku5wkaOa
         6tfKFtb1J64B1m9BItFVMIULtG6ZVX85XHd9m029SSLSOBNLBYxOyPZJg3V0HhmaaxW3
         mFEKojmqzEl1P18dH5zpYkOGN6fmhGj5Vz4cAijXP0o8LEYwLtfF9kjcMZ9LOse0Nbzs
         EBF0GJMQqe+A7P5MVGgbEhcGXUb15psLn+gfXq7PRV1bzzgzaE28tynDoiPD+fwODVDJ
         El8A==
X-Gm-Message-State: AAQBX9fGJVzzhhzneHoPrrpbga9hi7+v7xw+7Y8dgsRa9D2Z1PiUreiF
        F8uvoenIOx7NfJ8GNSq/wdSEHw==
X-Google-Smtp-Source: AKy350ZJ13M3V3+WgCqYi06dvK1hBJwmoJhMCuhIlmN019P0n2HARMAuSsuo6vqW5Xll6WjR0cTAPg==
X-Received: by 2002:a19:ae16:0:b0:4ea:e5b9:23b7 with SMTP id f22-20020a19ae16000000b004eae5b923b7mr3373326lfc.2.1679912463985;
        Mon, 27 Mar 2023 03:21:03 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id y26-20020ac255ba000000b004e9b307d2c8sm3706005lfg.238.2023.03.27.03.21.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 03:21:03 -0700 (PDT)
Message-ID: <f8c7b56d-0952-2d3e-95b8-c7d229e88bf9@linaro.org>
Date:   Mon, 27 Mar 2023 13:21:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 05/11] arm64: dts: qcom: sc7180-trogdor-quackingstick: use
 just "port" in panel
Content-Language: en-GB
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230326155753.92007-1-krzysztof.kozlowski@linaro.org>
 <20230326155753.92007-5-krzysztof.kozlowski@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230326155753.92007-5-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/03/2023 18:57, Krzysztof Kozlowski wrote:
> The panel bindings expect to have only one port, thus they do not allow
> to use "ports" node:
> 
>    sc7180-trogdor-quackingstick-r0.dtb: panel@0: 'ports' does not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   .../boot/dts/qcom/sc7180-trogdor-quackingstick.dtsi   | 11 +++--------
>   1 file changed, 3 insertions(+), 8 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

