Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B43962BFDF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 14:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiKPNot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 08:44:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiKPNok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 08:44:40 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761C5C21
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 05:44:39 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id d6so29534444lfs.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 05:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T4hKgCUbtIPYjvVJAsADYYX8s/YK6qYyIv7lDakUgf8=;
        b=VEpHCajPnZPUJLRco749jMCXFFhg782fTkosk19Hh810S9HfCFZbYVa89+BKWbfCiw
         v18IVTUIDjAcwJhGRBjDSVHMkRtW+DDvpJIm5mE5Xyc/4pbwbjim76LHflGT/BI62wJE
         Sj2GF90+/GY5ORLy0WC3sS8SCCSAltu/jzJIfH8LCJObnkFsIxsVMV/Wo6WNXvJGp7s3
         uLNLRVFZyu8Yva2Z7r+6Qt4KW+uo5nLWYzUu6zvSnvQFZ2BiDnkZahqAUPo8IHxhOBc4
         t/4EAjR3UwVGd2OrESj+Le4aIBAIcmJqjO6SMlw+gXsHRPHupZ1MpzpUKBO7r//NaRU9
         Mqww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T4hKgCUbtIPYjvVJAsADYYX8s/YK6qYyIv7lDakUgf8=;
        b=RdNbq+7aUbacMZ5e9Vy2jCzL9LuSLoVKHGjygdZGFWGHFsn4C3T3RgknUN7qybyT0W
         cMTRvgZcRPf2rn7QZySUj3RtGRXQrMvYHbFaLLP4leVnpYDP8P+NP8EClP0vD6wvojOy
         ZwhP+l6FBeZqciEtmW4jL7ybXdbTW+18avK4/0332rvqhY7RfmkUo0fPa7inWvzHeu+m
         7ncG4FrHHoymEwXrOatpKTe7Rhofe5ucu/pMJ2ZxuUtdTauDJ4we+fDvBvhhxVcbb/wN
         dd4a/voMIdLMxEwbnxyxi4MOqyrJgLE36V3E/jZG+WF4HVVAJo4LuQumJ0bVozS01OEE
         iZbQ==
X-Gm-Message-State: ANoB5plOeHHJRCkV6JvNHkUg+AzXWzkfoZRc/2topTNiJZqqvENGTEcl
        Z5kvOS/b4K5ZpxZYCfup9DVNlg==
X-Google-Smtp-Source: AA0mqf4qxnBJQnusEl1jH0gWmrzCYd1V8WQA6irfSbtpCNBUcZZxXbdSiHGfJ7EwX8Bojl0FHdcK0A==
X-Received: by 2002:a05:6512:5ce:b0:4aa:dd27:46ea with SMTP id o14-20020a05651205ce00b004aadd2746eamr6772533lfo.520.1668606277805;
        Wed, 16 Nov 2022 05:44:37 -0800 (PST)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id u12-20020ac258cc000000b0049f87fb416dsm2623550lfo.12.2022.11.16.05.44.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 05:44:37 -0800 (PST)
Message-ID: <de34d22d-cf56-0d1a-719d-2168b84d2ade@linaro.org>
Date:   Wed, 16 Nov 2022 16:44:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 1/2] arm64: dts: qcom: sm8450: Use defines for power
 domain indices
Content-Language: en-GB
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     patches@linaro.org, Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221115130936.6830-1-konrad.dybcio@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221115130936.6830-1-konrad.dybcio@linaro.org>
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

On 15/11/2022 16:09, Konrad Dybcio wrote:
> Use the defines from qcom-rpmpd.h instead of bare numbers for
> readability.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/sm8450.dtsi | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

