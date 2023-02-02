Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDE8B688245
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 16:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232997AbjBBPaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 10:30:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233108AbjBBP3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 10:29:51 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92F3222D5
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 07:29:05 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id r2so2043367wrv.7
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 07:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4Z/XOX5bG8yGv4MzjlHggQMoXQ9pyCAc4znwfftCw9k=;
        b=tB32XjeQXip+lYFOTLbsvkHytujuR4kbcfeisnQ8i44dL8uRS+FPDbs2tn+JMklZDi
         n559ZoMz6kkNjRqJWEX7jY5sVNkftxOfBkAUCJfVSD8i2OrnWDD3f9nE6l2+Dt8pkkSf
         9f7ZYpU74R2eAdCI70IEbNA++iFj06qw1dsES7cG1mmAB8N0xbjDYYUpBTvLgvO9S6SF
         Bk5/LHYwes+VVju53vqnCeDKhCi6ItuBFHJTwJge3qUKKH1pRLT63J4ZewWebHSVzBZX
         plJbHhUoBqysHS1XdLr6tcrQA/pquWCDIWwFoCy6hPXwaSi8T7aArAy49fyuJBobBYLt
         eVWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Z/XOX5bG8yGv4MzjlHggQMoXQ9pyCAc4znwfftCw9k=;
        b=y+dQKki/ycM5UYoPU0V2lYTYNSjOWTHLffNwOP1cSTLIL6yvkQKosmg9RToR3goSAu
         Q/1qpO7a8Z2uWw4zPDEyYYeV4DH8bm8TH/N6nmBSpxwXNTN1Y3Kgn7QCbd19cn9+M8k4
         CAPxPZkcDm8m1vhVfHJCcuhcyvyBoPGAhHQSmSUSpYSGT41Ut9qVoLOyOSxIlZ8XXXNN
         KljT7juSbdZ2CmnG13Uee95m2TpIqZhiF9qfDJpWHDMI4rdePyqpafwQLMJ/cMys+Mss
         89q5BTC3DTazvuZHCWHzoRmyMkaJZ3LTDwv3LD97BuWF+MkoKAUwqYlkC1N6YWucsyOh
         DC0A==
X-Gm-Message-State: AO0yUKVoV3RDClc2xYCK6y8WhscaKJSYieVqK+ViFm+2pBkO25ve1v40
        iRY6q4X0FpMjB8IIYbXHbiioEg==
X-Google-Smtp-Source: AK7set+9qfRXRhN1bMZ6UNCmOYR0aQOlT93xQt/sZRo2/r0MRH6rubyno0cK9agN2E/VYKCVZWa22w==
X-Received: by 2002:a5d:4e04:0:b0:2c2:fa7:56b1 with SMTP id p4-20020a5d4e04000000b002c20fa756b1mr5785115wrt.56.1675351719601;
        Thu, 02 Feb 2023 07:28:39 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id n9-20020a5d67c9000000b00294176c2c01sm20098243wrw.86.2023.02.02.07.28.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 07:28:39 -0800 (PST)
Message-ID: <4ffa873f-f83e-38c0-6286-8c89940b65d1@linaro.org>
Date:   Thu, 2 Feb 2023 16:28:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 2/6] dt-bindings: clock: qcom,a53pll: add IPQ5332
 compatible
Content-Language: en-US
To:     Kathiravan T <quic_kathirav@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jassisinghbrar@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230202145208.2328032-1-quic_kathirav@quicinc.com>
 <20230202145208.2328032-3-quic_kathirav@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230202145208.2328032-3-quic_kathirav@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/02/2023 15:52, Kathiravan T wrote:
> Add IPQ5332 compatible to A53 PLL bindings.
> 
> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

