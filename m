Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5A46243DA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 15:09:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiKJOJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 09:09:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiKJOJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 09:09:35 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 775F6D99
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 06:09:32 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id d6so3427002lfs.10
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 06:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TSp9RRKoGBDuhWqH3ceG3jo0hwUm2X40WFiaDa/p1G0=;
        b=zt/AT5jD0PJ5GNvaI3hHJFtrPy9FGmDWD83X1tgNTXR2wKBD6E8/OJvMjdyPR286Gh
         A91NLtnqIocBIodw8kaZx1++Fa3n/0RD4b7RWlfdGrATc5JRo/fwVU1FyIQ9KIM7GN1V
         LSA+Em6D3wubATg0/DwYCenOVsdbGXaFNW+pNX4jOkVjjTjiPEJ9M2Y8VTEElEMWdfGu
         V37FD945yHjDOUALHAt4Y0YtJK8Ze96WqqRfTFVe+emsr0PHkSxxPkxHwDi7VayCiBw1
         WwTbg4FucG+BVVqThxj/CUOY5jCfk6rrqst9n1gRew55l694Jsus9UUMw5clAIWgvtX6
         bo+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TSp9RRKoGBDuhWqH3ceG3jo0hwUm2X40WFiaDa/p1G0=;
        b=VJt9XyfIl3tx6fkbtHoxHbps8BSxSFbJucpvT0rLP6hqWA1fkLRxyEQNWhVBFbAXb/
         HmxhjKgShduCqMG3GbYJUls0PP1DhLMaxHghFfQcPsOASmcrY+K4g11dHUoDCgeSUUSs
         gsW6Jo7omhxJreHTeJ3EwEU0y8Gxi+bNMedNiJEDe2I0M20VoVpUBFaIH483NIA3y2BT
         YnVVYXzYBkTsfVVkvf/qNFXTSpLubVgT8TO0gMGqCsgNXVfvb+1QU+xGNokkBiocW2W7
         xKk7F3KkUKM1xTwAaxr51MOaBNfEviCkmsLs5GqQVjCro6T9DlqVC204yeb/Fa/eRyea
         EzoA==
X-Gm-Message-State: ACrzQf0vpyn5R2ND0X4B+gbdEK2ZJwSUWv75fSivO+Hlo/BLCi/1j3He
        Kd8UWNHbsB3qkubwKDcFy9VnWQ==
X-Google-Smtp-Source: AMsMyM7go7vn2LsLsVWb0hJ5g/0WoyiU66YXUPE9X1FusIO49Ox/bMvhAfWga9RFiYZW9dqyxDxdbg==
X-Received: by 2002:ac2:52a9:0:b0:4a2:2f2f:449b with SMTP id r9-20020ac252a9000000b004a22f2f449bmr1561097lfm.235.1668089370868;
        Thu, 10 Nov 2022 06:09:30 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id s16-20020a056512215000b004a2c447598fsm2775264lfr.159.2022.11.10.06.09.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Nov 2022 06:09:30 -0800 (PST)
Message-ID: <8d8b2d1c-617f-43dc-8629-b74ac954fa07@linaro.org>
Date:   Thu, 10 Nov 2022 15:09:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 2/3] arm64: dts: qcom: sm6375: Add SDHCI2
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     patches@linaro.org, Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221109144153.53630-1-konrad.dybcio@linaro.org>
 <20221109144153.53630-3-konrad.dybcio@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221109144153.53630-3-konrad.dybcio@linaro.org>
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

On 09/11/2022 15:41, Konrad Dybcio wrote:
> Configure the second SDHCI bus controller, which usually the
> interface used for SD cards.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
> Changes since v1:
> - use mmc@ node name instead of sdhci@


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

