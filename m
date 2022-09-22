Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7A975E6A29
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 19:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232261AbiIVR67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 13:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232343AbiIVR6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 13:58:48 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B0D106518
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 10:58:47 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id f14so15983063lfg.5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 10:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=bUaFyQ94fZMRIXN/N5asK1vtQVwkzWhJGyxmV73G/hs=;
        b=WSdkF2ebXtZNI6gJOnCNAse/3uE4RgY6VSWqOlZR3D8kIl4csnP7fQnR3pUL9SCXWI
         2LgKdj3cJBSOu5MO2vp3JzFKh5Zp1WOLNeBtpclSTm18kZGe2NroCKNCyKY+q6fXFBnk
         wlqqyb89pM/eyM+e/c7kSsyPYzDf/5v1PN+iShEaeAbKTjHHy9/1mn0uImoDDp5sNd5h
         pQwZDUhc6kUlifqeygwUWi8aD0LHTazbeJn83PBxYDbjMG1YuVjqQ6tFn7d2vljLNDuw
         y5q68X/QOraDNuO0v0o+VQtpPj6DBCG5RHl5n0Xq1khzC2t63sz6JVikI9R0xEcW+tQZ
         XrQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=bUaFyQ94fZMRIXN/N5asK1vtQVwkzWhJGyxmV73G/hs=;
        b=yw0XNILlS3jJikiA9J77piQHzaYS4jUgBzy+ZI3zy14VH/gCSdxssaf7PRrFNAt8Ey
         ALesNmY19npbZFI/3uvaSmdB8Dk4pjS8w5phJSr9WE7CXcGdgiEAF2xjoFNb+kU43fQo
         bfex+W7ZulXwiE1yUXHXN27A1dwNoK5YK4D9WvYCgEN75Hs0QkWklik9XgoCeUZ0x2w4
         arFLKxdqEbuPUAY5HMXlPeyER1OQcdn5efch1MAZykL1CJyuQUMXYfSnZ5x6py76X5+c
         dUBtjw6E+4Q8u//jXrf3HL0qq5k+l9qRDYYTu8I4f0ZCcmVP2LGvvbTeUcUo/gEOoGu1
         9esA==
X-Gm-Message-State: ACrzQf09BLtIRZ0Lp2wt/Hz82FeaKeG2MXdivTLWIgUwiAK/nDAoy4hi
        HnMS3RqNYoVomGMDxDQmq9M4Dw==
X-Google-Smtp-Source: AMsMyM6AVNDlrOZFjtzvPW6bScSQC0XExoQfPFreI/hlikLYnC0UgJkA9CU9kz0qFU1jf0DVXb5F5w==
X-Received: by 2002:a05:6512:118b:b0:492:e3c4:a164 with SMTP id g11-20020a056512118b00b00492e3c4a164mr1831759lfr.598.1663869525804;
        Thu, 22 Sep 2022 10:58:45 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id q8-20020a056512210800b00499b726508csm1032447lfr.250.2022.09.22.10.58.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 10:58:45 -0700 (PDT)
Message-ID: <d78b87d1-145a-d73a-5dd6-d71b189f06d7@linaro.org>
Date:   Thu, 22 Sep 2022 20:58:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 09/17] phy: qcom-qmp-pcie: drop unused mode field
Content-Language: en-GB
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220920073826.20811-1-johan+linaro@kernel.org>
 <20220920073826.20811-10-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220920073826.20811-10-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/2022 10:38, Johan Hovold wrote:
> Drop the unused mode field from struct qmp_phy.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 2 --
>   1 file changed, 2 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

