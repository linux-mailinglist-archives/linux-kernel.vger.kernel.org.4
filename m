Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1E165B3416
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 11:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbiIIJhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 05:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbiIIJhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 05:37:03 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7149395AD2
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 02:37:01 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id y18so1118372ljh.12
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 02:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=jJHZh3XOc0dD8msZ4f9CzmXSU1jFvF34HN6njLtaCUI=;
        b=fn5vyPQIwEzVacy8ihq1WYzE4mGJbBxwXPqAaJW1j0oEYUG0RHS+BK23giYaTgXKOW
         d3qEI7aCH5SQVntmQiMZV+JAl5xpgBA8nRg2NX3/LPxwLoFahmPgm5kNu1PetJrdq6Hb
         8dNbHvWvFkVI2OXQHmyWSx2P2Z+mOl/SbLfku0ZjEUnMYaU4tJ23fNJu9awue06bdZN7
         g7rba1E81GFYD25q/g973heKK+2qnFjppuJdTwBNqsiOBJDW12E9rihay0gNsf8a7Xys
         I19bgGqN5F1Qh2hPRVDe/1b1NGV7g9h57Ft3ZFRnXf32+xltowN816qusWPU6HNC2h+J
         vR7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=jJHZh3XOc0dD8msZ4f9CzmXSU1jFvF34HN6njLtaCUI=;
        b=sEwqMrtYMxhnruvkrsFQTTS1ATDYKKY/XJ28xbyGLAGvfXUi60NukzaZJB5qUfgQqj
         3T7VYRc0+il5kSz8mkwbm5xEVn2J9z5kyPMfp7f+X1m58wBHDgznl4D2vRSiJk12khHT
         84+hs2q4G0zCyPLvVvK+HW6nyL6IaxcC3BsVbF/7e5IsYofT76ziBDuIvdZdxsaLY9Ke
         mtUhHCaiSAOAzhoerPQ1UZalqn/Zj9TUFXd8tS49x0WM9jDnKrVUR83M8fQj2l3UpNbw
         EpoXSXuSlC1cV4Ae1XkGOrt0nftsleFdr2+TTjVbkfNBbMQKxGEjHnCC7hg2uVvp255z
         nXAg==
X-Gm-Message-State: ACgBeo0NMtyB57kIPRhhkKsxKrbf3dBfxxOorQDFEURmnQjyQrW2wuBy
        f7eTSERy5u2l7bZB7vP4OxQpqQ==
X-Google-Smtp-Source: AA6agR4ce1I8gV2VI14mW0UHj3BF7vtBvvaXsUhX5rocfFkNQz4SoWCWb//HltaeKRppDFlBoR3bpA==
X-Received: by 2002:a2e:bc20:0:b0:26a:b0b1:85b6 with SMTP id b32-20020a2ebc20000000b0026ab0b185b6mr3855069ljf.118.1662716219768;
        Fri, 09 Sep 2022 02:36:59 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id bd23-20020a05651c169700b0026be7a4fa49sm655ljb.99.2022.09.09.02.36.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 02:36:59 -0700 (PDT)
Message-ID: <1a083979-c92e-3b32-fa2f-606359b93ac0@linaro.org>
Date:   Fri, 9 Sep 2022 12:36:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 03/16] phy: qcom-qmp-pcie: drop unused runtime PM
 implementation
Content-Language: en-GB
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220907110728.19092-1-johan+linaro@kernel.org>
 <20220907110728.19092-4-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220907110728.19092-4-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/2022 14:07, Johan Hovold wrote:
> Drop the unused and incomplete runtime PM implementation, which was
> only used by USB PHYs before splitting the QMP driver.
> 
> Note that the runtime PM was never disabled (and state restored) on
> driver unbind.
> 
> This effectively reverts commit ac0d239936bd ("phy: qcom-qmp: Add
> support for runtime PM").
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 38 ------------------------
>   1 file changed, 38 deletions(-)
> 
-- 
With best wishes
Dmitry

