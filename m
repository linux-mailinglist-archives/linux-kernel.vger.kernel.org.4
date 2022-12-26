Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5638E656266
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 13:04:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbiLZMEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 07:04:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232045AbiLZMEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 07:04:05 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE126323
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 04:04:03 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id bp15so15679435lfb.13
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 04:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gr+Wz6MNSievNoL0z+ewpQl2PEfJ+HKst7CTvFBKGd4=;
        b=tRxPiX0RYv1PndPekSZ4YwbOky5WJ9uY5zj5ASkuQXEJB4UPVF0igxZW2WbXmK89dZ
         fqvXicSnYzMFoHt6gaFmNyrF5wqQuP7jTt8Lyw8g6tVCm3ADyeN8Oj9bH0jCir8r+vqi
         MtcGuW37nuKdOPpQFUh8TMlIE7Dtl0qUrZwIYF9vZtf3gNoOyYsX6lFDYIV3B/rtCvmL
         Cc9LB/gjhSf+c+qqI331Xod8gO2bcL9pPDrdeqopL2VVvxOGZJgZpdmBA5MysRz5NAe+
         8eCmlBJmJMXWJ1jOvmDDNe14wfhjPRohqVyFH+ASGbqq+vx9SYb4CQX4YH67nCaLKW+g
         IyOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gr+Wz6MNSievNoL0z+ewpQl2PEfJ+HKst7CTvFBKGd4=;
        b=a+r3xcwrLHCA858TzzSVrL8Ws8FmIEjKfZSH+ISWsz9GLONTLfuFNOCcWHAOECvPN8
         IW/R4LFkbQ2oUyMlgrOmnKYfllOJLfUG60eAvcT79MQiqHT39eJbwZ8tQIX+6cn0BxEg
         NX8JgHlzxyvoxLePr/YgZbOrYqEwrA98+bAs7YlnHbj3K5ZFwitWFbaBUCo6vFnNfGiW
         7BoKSI38UwtS+1CGg+fjaLfKTvlE+UEA6WgWIp3TEMZqo4xuKTpxNGai2945+aPYYync
         ENDlX6HIbxlbdlbstNhwTLHYowj4HDN6wLargyewYERjxF0oKvbZrb3/8Ju1+1mbjmJq
         d9Fw==
X-Gm-Message-State: AFqh2kpSITGphs2cuyWTTlj+aFgWJ6u2A/v7sJsyHOiUOullssMOq0+V
        cspgp3Rj2P/aXBJ+ae+QO8ZcWQ==
X-Google-Smtp-Source: AMrXdXuARa9158QFDdJLsbBht8F5Sat1Th1PCWmofCg9jnSEMW2PlZaKrqIJcljcihL4Z1E5Ohp0vA==
X-Received: by 2002:a05:6512:507:b0:4a4:68b7:e719 with SMTP id o7-20020a056512050700b004a468b7e719mr4783811lfb.3.1672056241490;
        Mon, 26 Dec 2022 04:04:01 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id j10-20020ac2454a000000b004caf2118ecasm1715565lfm.208.2022.12.26.04.04.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Dec 2022 04:04:01 -0800 (PST)
Message-ID: <ee597e4b-2656-3852-4daa-f3db7abe6db0@linaro.org>
Date:   Mon, 26 Dec 2022 13:04:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] arm64: dts: qcom: c630: Fix firmware paths
Content-Language: en-US
To:     Steev Klimaszewski <steev@kali.org>
Cc:     agross@kernel.org, andersson@kernel.org,
        devicetree@vger.kernel.org, konrad.dybcio@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org
References: <20221225040821.8395-1-steev@kali.org>
 <20221226004727.204986-1-steev@kali.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221226004727.204986-1-steev@kali.org>
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

On 26/12/2022 01:47, Steev Klimaszewski wrote:
> The firmware paths were pointing to qcom/manufacturer whereas other
> devices have them under qcom/chipset/manufacturer, so fix this up on the
> c630, so we follow the same standard setup.
> 
> Signed-off-by: Steev Klimaszewski <steev@kali.org>

Do not attach your patches to some other threads. It messes with reading
and applying.

Best regards,
Krzysztof

