Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB1E716750
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 17:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbjE3Plm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 11:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232001AbjE3Plj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 11:41:39 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF09DFC
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 08:41:37 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-96f6a9131fdso698349166b.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 08:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685461296; x=1688053296;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NdIKL13IA/VVIsQg9Ntg/oyG9VIy1QB/RtS37gRRRL0=;
        b=ExG7Of/p5LzWELs3RzPcRUT+B9JnbICl/gtisRaUY1+U4nFtbtObZcyg4/Yq2G+eRn
         6+0VQGjCVhFS2ghQf8A670yuZM1pmiLyOonfv26T5uww1wj0Yn4U5av8hB02X98fkimE
         T/sy4spO9m+cgyrk7ZdLgeoIGz5kl/s+yDPv9cE8DA0QsQYG/YlDUcqU6+gpLYebrqqo
         TpUJ9OG/KDpCqq8+LZkbYwO1MCrKkLkT+0lhRRYp2YZAw7yGQYQHbLytz1V/qFoijhmc
         1UCb1ZtWaEW8B1VsjGIxbMCpbR8Wun5E4vMVNYjFsgdJjBmI6sV0JqprbuVZl3HfvYH8
         om1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685461296; x=1688053296;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NdIKL13IA/VVIsQg9Ntg/oyG9VIy1QB/RtS37gRRRL0=;
        b=lIfwv7kVjdnsDq088nVu4QpvWLS+2yqPom/cO4hLCkfQJORVz5ERidmTnYHE7yZDuA
         1O7lT68ukmjkHt4JpN7y/NO1Vf8Ayk97v/lQ27986SVDs/D+VDQlV7qMjvJkWv64TOjn
         h43++CpM+DunIoGlANruPhZOMPs++o+y5MpENcNWD0xddS12djj6x2owUoo7UaxBXBQ7
         e+Y0M/vOUo17OA+/0DyYpRxIJ4n2WaWDUkOeRVw12iqo1yHfpt3PsNNbQ+Goplkz/gfp
         F+h/lDp6BbuecYUFMuS+EpzNKEOp2kJ+5hWf0EXolVH7v8yVXh8p3/ImBszdfCzQ2zQC
         izlQ==
X-Gm-Message-State: AC+VfDyFski66CU5TgCgbb2L0lyXwR+KoCUqySzPyXVt6RrtlLO1uNky
        0rolzXmFCy48BLLstVCRjpIEXg==
X-Google-Smtp-Source: ACHHUZ5SVmLH37Vc2JWRV45jsNFz+5foPXXKBAt6V1LgNBqBZ1+IO9RB1ouM9aLjaX8SOPbnsXd8dg==
X-Received: by 2002:a17:907:3e2a:b0:973:940e:a00f with SMTP id hp42-20020a1709073e2a00b00973940ea00fmr3151496ejc.6.1685461296486;
        Tue, 30 May 2023 08:41:36 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id j13-20020a170906254d00b0096a6be0b66dsm7430567ejb.208.2023.05.30.08.41.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 08:41:36 -0700 (PDT)
Message-ID: <3d5e627d-726f-9db6-0a59-aee72d4c4ff3@linaro.org>
Date:   Tue, 30 May 2023 17:41:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] dt-bindings: clock: sm6375-gpucc: Add VDD_GX
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230529-topic-sm6375gpuccpd-v1-0-8d57c41a6066@linaro.org>
 <20230529-topic-sm6375gpuccpd-v1-1-8d57c41a6066@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230529-topic-sm6375gpuccpd-v1-1-8d57c41a6066@linaro.org>
Content-Type: text/plain; charset=UTF-8
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

On 29/05/2023 15:14, Konrad Dybcio wrote:
> The GPUCC block on SM6375 is powered by VDD_CX and VDD_GX. If the latter
> rail is not online, GX_GDSC will never turn on. Describe the missing
> handles.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  .../devicetree/bindings/clock/qcom,sm6375-gpucc.yaml      | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Best regards,
Krzysztof

