Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB891714A27
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 15:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjE2NUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 09:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjE2NUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 09:20:19 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE356B7
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 06:20:17 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f623adec61so34018005e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 06:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685366416; x=1687958416;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yzXTVsKBHc2Kk6Dlzodvb1WiYIhmlbBuhYwp2QvY7kY=;
        b=Q4dhslguXqfvdeBbTNbD5ieJpnyWVGQ292U3s0hH/PjCuddzk3CN+sANR4gn1OsZv3
         SjrZIB3UWQexOfRPr0D4AwJpyy9JasYdySD6s5jReCOvE6pg1k1fxtWbXBWLB+zFD6E0
         ZVUc36Sub9p597E5XaOACg7548qx/+FyJYRpIxKdqCOlqSMDTYR12+LT0fR+Elh5jkh3
         NdczRN2f2nprVP+dKlXICSsIJ+v5hYvbmEMfWYWiew1YyAg8/vM5HkOHhzBvsE2bNayr
         ADp9nmosfmQtUHV1LQ8K4fSRVxLv8wpV6vymCDU8/MCx2uFeDc5+Ca58idopvBUS7zEb
         MLxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685366416; x=1687958416;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yzXTVsKBHc2Kk6Dlzodvb1WiYIhmlbBuhYwp2QvY7kY=;
        b=SY5/GFoEgV7Y6RRw5ybria79BIi/OwQ+7E0JkcU7G5xeNrPQkAkZ1Hqw7QjSCBAYj7
         ov5Rbi2RH6gMcAGTBkw+fqBS0ZqlQ2Jc4Sfj/vHnUej60ugqXeH+aYBt5DP22IR3XPEf
         ZNH62RJJJqAmeROvjlV9qJ4BVJbzg35GfGVbO1cAnxGWakDrAD++4RnEgGJPgy+ncBzs
         UpHAUbaOkMcqRkh02cB5Z8S3tuf9e2dX9Di1X0lGV8eMjlabQEar7LSSPHLLjA7BC0sz
         X8rnVqgMpbVqCeXmB0MdUbRlcHDWUgEAlOz2JR84LrINUXtyWzOT5uawwd2VT7bRrkof
         Bq7g==
X-Gm-Message-State: AC+VfDxAEdOh3rwcKuBWRmb36vDqdYr8HvOI2OWs7ra8qdJdvl3+LGMQ
        NUYau6/luWbxdrgkmWDwBm+eeg==
X-Google-Smtp-Source: ACHHUZ4eZHe90J8QngVS1kOPyL07sdkVXU+1x8EKxC4xW3EVOaYQ0axJDQmvbADW7mTWFDjleFodjA==
X-Received: by 2002:a7b:c01a:0:b0:3f6:f29:7b4b with SMTP id c26-20020a7bc01a000000b003f60f297b4bmr9784322wmb.12.1685366416247;
        Mon, 29 May 2023 06:20:16 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id k6-20020a05600c0b4600b003f4fe09aa43sm18060709wmr.8.2023.05.29.06.20.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 May 2023 06:20:15 -0700 (PDT)
Message-ID: <4c0c0869-5e57-63cf-0152-a58443dc0512@linaro.org>
Date:   Mon, 29 May 2023 14:20:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/6] arm64: dts: qcom: msm8916: Rename &msmgpio -> &tlmm
Content-Language: en-US
To:     Stephan Gerhold <stephan@gerhold.net>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230525-msm8916-labels-v1-0-bec0f5fb46fb@gerhold.net>
 <20230525-msm8916-labels-v1-1-bec0f5fb46fb@gerhold.net>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20230525-msm8916-labels-v1-1-bec0f5fb46fb@gerhold.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/05/2023 13:46, Stephan Gerhold wrote:
> MSM8916 is the only ARM64 Qualcomm SoC that is still using the old
> &msmgpio name. Change this to &tlmm to avoid confusion.
> 
> Note that the node ordering does not change because the MSM8916 device
> trees have pinctrl separated at the bottom (similar to sc7180).
> 
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---
>   arch/arm64/boot/dts/qcom/apq8016-sbc.dts           | 24 ++++++-------
>   arch/arm64/boot/dts/qcom/msm8916-acer-a1-724.dts   | 14 ++++----
>   .../boot/dts/qcom/msm8916-alcatel-idol347.dts      | 24 ++++++-------
>   arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dts     | 20 +++++------
>   arch/arm64/boot/dts/qcom/msm8916-gplus-fl8005a.dts | 20 +++++------
>   arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts     | 34 +++++++++---------
>   .../boot/dts/qcom/msm8916-longcheer-l8150.dts      | 20 +++++------
>   .../boot/dts/qcom/msm8916-longcheer-l8910.dts      | 16 ++++-----
>   arch/arm64/boot/dts/qcom/msm8916-pins.dtsi         |  2 +-
>   .../dts/qcom/msm8916-samsung-a2015-common.dtsi     | 40 ++++++++++-----------
>   .../boot/dts/qcom/msm8916-samsung-a3u-eur.dts      | 12 +++----
>   .../boot/dts/qcom/msm8916-samsung-a5u-eur.dts      |  6 ++--
>   .../dts/qcom/msm8916-samsung-e2015-common.dtsi     |  6 ++--
>   .../boot/dts/qcom/msm8916-samsung-grandmax.dts     |  6 ++--
>   .../boot/dts/qcom/msm8916-samsung-gt5-common.dtsi  | 14 ++++----
>   arch/arm64/boot/dts/qcom/msm8916-samsung-gt510.dts | 12 +++----
>   arch/arm64/boot/dts/qcom/msm8916-samsung-gt58.dts  |  8 ++---
>   .../boot/dts/qcom/msm8916-samsung-j5-common.dtsi   | 16 ++++-----
>   .../boot/dts/qcom/msm8916-samsung-serranove.dts    | 42 +++++++++++-----------
>   arch/arm64/boot/dts/qcom/msm8916-thwc-uf896.dts    |  8 ++---
>   arch/arm64/boot/dts/qcom/msm8916-thwc-ufi001c.dts  | 10 +++---
>   arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi          |  2 +-
>   .../boot/dts/qcom/msm8916-wingtech-wt88047.dts     | 16 ++++-----
>   .../arm64/boot/dts/qcom/msm8916-yiming-uz801v3.dts |  8 ++---
>   arch/arm64/boot/dts/qcom/msm8916.dtsi              |  4 +--
>   25 files changed, 192 insertions(+), 192 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
> index 1c5d55854893..82f141b55eb3 100644
> --- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

