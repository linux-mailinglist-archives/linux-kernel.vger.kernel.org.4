Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DAF55E6A4B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 20:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbiIVSDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 14:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232342AbiIVSCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 14:02:50 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE3D107584
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 11:02:22 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id c7so11908453ljm.12
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 11:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=2ykei3W9LQd1RzBfuNAPmmjbg1pi4i2oQK8s3yOPURE=;
        b=Fyk3AqDThJ8EGj7FSaldRI6IowkrpiZevbhXo2BiH5oMLJQdzO9NAyGGNtgkrO/h+8
         hbfhotTECYP/YlelL8KHDjVFerOtlXEAmLM0j4L48U0Ngd9DLHegkGkbg37tmR4oKmii
         NRgkJx7jVHZkThHncpYJptaWog1wnuJW8FAxwthqxfnkhhz9C4qybKPVDyyI5Eqx2bzb
         6j5x2jfvZw+4WLEvEKX2rMBLEOIE18D1G+NxPGgaaLBN4AfKKTZ2wAht4/a23+nHyqzs
         B5P71dc72QlmVXC8eAlgNn+y0pYq9TMgbhBXy+s5R4DRrdiarMKL5kBF2rDSyzF6DpiN
         ey5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=2ykei3W9LQd1RzBfuNAPmmjbg1pi4i2oQK8s3yOPURE=;
        b=trpSFHw2cSOIWfCboedBlGHNOQ0vmdDSdBU0U90EIK+Vopx2s7uDpBEx8Uta6c2P2r
         P2IbJZk76jGLhDqgW/dM1a2vjpVZFoSR0Hjw9m+dNXMNCojDdJr+8UAaPh15dzDdxD+3
         LM6fqjMxsIIv44UjmVbDkTcpC98NKc4kEALdY3LTdVu6B/6JbytftCzCpTxkpQ50BDWt
         xlWWYqiVRijblNC4aaplUhN24kCpQZNZtuFnCrMe+2Ycv2qdjIoxb8yqVaPqcD8itOiK
         0M2AoXIENNa4HtZr3y3Z96RlZbYbIrCjMxFkCoXfcGCloiNDbegVNs4l0Cq8o73c+RRS
         0AwQ==
X-Gm-Message-State: ACrzQf0kTrZURu0+JSbB+OLqrCzusIYyDGJ7Qca7oQHFfZtUheVxyExP
        6e/lpjzaA0JYGUr0plYyRBIApw==
X-Google-Smtp-Source: AMsMyM5FLpAMmuNQHjmlmpFYMpp5Q2Pd37Fauoc4Ihu1kvKrSaKiLWQowiY27QVdhozOHJdQ7i033g==
X-Received: by 2002:a05:651c:a04:b0:26c:50df:75ad with SMTP id k4-20020a05651c0a0400b0026c50df75admr1519340ljq.416.1663869741075;
        Thu, 22 Sep 2022 11:02:21 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id e2-20020a05651236c200b00494791fbd80sm1029715lfs.307.2022.09.22.11.02.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 11:02:20 -0700 (PDT)
Message-ID: <8a0beaad-2eb8-b5d5-28af-f44285644ff5@linaro.org>
Date:   Thu, 22 Sep 2022 21:02:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 16/17] phy: qcom-qmp-usb: consolidate lane config
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
 <20220920073826.20811-17-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220920073826.20811-17-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/2022 10:38, Johan Hovold wrote:
> For legacy reasons, there are two configuration parameters that appear
> to describe the number of lanes a PHY has, even if "nlanes" was actually
> used for a different purpose.
> 
> Replace them both with a new field simply named "lanes".
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-usb.c | 52 ++++++++++---------------
>   1 file changed, 20 insertions(+), 32 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

