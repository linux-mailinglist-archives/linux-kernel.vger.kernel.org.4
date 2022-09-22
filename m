Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1F175E6A45
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 20:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232429AbiIVSCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 14:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbiIVSCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 14:02:06 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C59106A39
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 11:02:04 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id w8so15940934lft.12
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 11:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=Prm/7dt9Jb09jIgZ3WTvMH02jdAfiYwvGQl1oWckd6s=;
        b=Yzv6NyJs1WI7yVQiKEize54ZkCL4ZWr/ikYefiRVj8wHZ2DIego2yDZ0OcerECcfz7
         9IekGaK+r5IFBedLeh/ianEHZHDxQ/ugF/DyDay+Z5w5fJgEDmQqyUMyYvM7b4Klg3Ik
         UU31K6Iybg3VUIA/sHAfxxetfOzjZqYQr3n3adROG+u+U8yx3qhHYkccXrR8wji1QS9H
         5rSnTNtIWxt/re33fGX5eIIabn1BUnVsQwCmpkjBf4nt7PXjqs01MnKrha02xJfAb6/K
         x2TtNGCuDtgmzhSg6IDGTu8M+AYmxV7oTyqXH1n6uiJZqHyI7knDdWgVxD5fB48I4Dv4
         Lccg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Prm/7dt9Jb09jIgZ3WTvMH02jdAfiYwvGQl1oWckd6s=;
        b=2GM4r4KsYkF5AQdMRjJgAJ/OJdxonoqz+MzOvg0T3Kyzrd2L3NvMzL5uT69A4LxZli
         OHlZiiKwmQJ8IQQNydDDkGbBYQmj2/f3fWcy72KMvl7jPDgznnI1cZFzD7DUPvpEhm9M
         7/bjgoljEvf7JG6HAcz1/61vW8Lpu7o19aiSDMMJsU/zzFVl230Q+YJUlpXgXuZp9LC/
         Nsa4yqJ3766gNAax1DBq1AY4D2osMpqoBhNns/u3SQDkhzNDlfTMjzz8HOcCgN5j0GE4
         82DUu9WQIgJbrBJx2c65/Oq4l/DCgKnkQ5TW/37kLi/eDav+pvci0quPb4eko6T0xYwL
         TEgg==
X-Gm-Message-State: ACrzQf1QDow2Z94GOjcXzOcnwuIZ/O++JKZx8l7J+VA/zTziCnMSpjam
        IloF4pwVaSISS1PEk3d+W6jdSQ==
X-Google-Smtp-Source: AMsMyM5xgxVGkvgeO4Fft7GBD83ULM342IAq1Z+JxHJdYHC43UPCH6Fq9XYeNfws8rJelLC2HB8New==
X-Received: by 2002:ac2:4d0b:0:b0:497:a7fb:229 with SMTP id r11-20020ac24d0b000000b00497a7fb0229mr1664179lfi.174.1663869722482;
        Thu, 22 Sep 2022 11:02:02 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id o4-20020a198c04000000b0049f54a976efsm1045611lfd.29.2022.09.22.11.02.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 11:02:02 -0700 (PDT)
Message-ID: <7032e571-fb69-0747-e39e-b83161886935@linaro.org>
Date:   Thu, 22 Sep 2022 21:02:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 15/17] phy: qcom-qmp-ufs: consolidate lane config
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
 <20220920073826.20811-16-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220920073826.20811-16-johan+linaro@kernel.org>
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
> For legacy reasons, there are two configuration parameters that describe
> the number of lanes a PHY has.
> 
> Replace them both with a new field simply named "lanes".
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-ufs.c | 31 ++++++++-----------------
>   1 file changed, 10 insertions(+), 21 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

