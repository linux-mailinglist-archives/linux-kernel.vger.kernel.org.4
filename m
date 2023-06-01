Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A51817197DC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 11:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232122AbjFAJ4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 05:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbjFAJyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 05:54:37 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0836E7B
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 02:54:05 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f3ba703b67so665326e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 02:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685613244; x=1688205244;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AJIoI2l+WIN05o9c4IUijVvVA2Ux7esddHxAo4SWQzc=;
        b=a2wB1Jnkb6fPSvHZYLILxpfoh2hFdQ+t3Xv4JhlrN9Tpql0pIBTdeg++CsPGwuTmu2
         K/PBOOt++5CYWYGtWP9/1VbHxY1J22rTHuRLeI4OK35b1xhPKLeaFXE8ZBBr6Z5rEqD4
         O+TD9A3lGqrlkaeDe90LfiaBk6JFb8mezu7/2wYnmJ4d/YYSX+Iggn+BuJX6AT/qaTh5
         XcnO30/rvjmrdJYe24EbegXw+t7W6F65nJxY9bdgMdAp2N29UBtHdfV86pxFhsbBRkQd
         yPX1aod00PC7HuRl9ZBUYvoDEgJYO1Oyl+HctkzUsKFR0elAAkFUZavEveA4LKA3WCIS
         NWWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685613244; x=1688205244;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AJIoI2l+WIN05o9c4IUijVvVA2Ux7esddHxAo4SWQzc=;
        b=eliKffqd2IWANwBtADeXHZ/FvmX9lsiNuT92xIzcYfAgQePQs8GtzE2kijCTFI4wcx
         NoKHLHamxwE3dv0mm1QX/HsOnWylhaVaI+/0Cmlr1JE4b243CFMYHQcwuwcp7AwKpnNT
         OdE4TancAGip2zDvRAPHDOGWURElJEo8D0weIeFdJ26WchBpINr3MCke9nIkcpXDXd9Z
         VFMajf80a6o7WtdJ25J76xjFKjRSdsc6hBIe4AjVTFssbtwzsg9W6BWJUoWu0Qb8jPl6
         OmwCMtKpQyygcWI3MF64NVpN65d9cQggz2/QLfgNXoSL6Nbo8bavRp8Jx5ZKwsedrnLM
         nRTA==
X-Gm-Message-State: AC+VfDwwz+OC1e2LAcFVK64Phv2L8p4hEUBa3bItAc0LMP6qvCY1GVmK
        ii2r/M1LHsI9FE/cd9aO4tY0jg==
X-Google-Smtp-Source: ACHHUZ4544N4JJji/KF2ebzl/FR5R8obPE9gcqJuAb0oZW/oh8LRsvrltyJvpgdDGRBY3wnqEl2IBg==
X-Received: by 2002:a19:c50b:0:b0:4f3:b708:f554 with SMTP id w11-20020a19c50b000000b004f3b708f554mr957382lfe.47.1685613244025;
        Thu, 01 Jun 2023 02:54:04 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id a21-20020ac25215000000b004eed8de597csm1033132lfl.32.2023.06.01.02.54.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 02:54:03 -0700 (PDT)
Message-ID: <536a962f-6276-ee87-fdad-5414251bc606@linaro.org>
Date:   Thu, 1 Jun 2023 12:54:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 05/20] interconnect: qcom: icc-rpm: Introduce keep_alive
Content-Language: en-GB
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, Evan Green <evgreen@chromium.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org
References: <20230526-topic-smd_icc-v1-0-1bf8e6663c4e@linaro.org>
 <20230526-topic-smd_icc-v1-5-1bf8e6663c4e@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230526-topic-smd_icc-v1-5-1bf8e6663c4e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/05/2023 13:20, Konrad Dybcio wrote:
> The downstream kernel employs the concept of "keeping the bus alive"
> by voting for the minimum (XO/19.2MHz) rate at all times on certain
> (well, most) buses.
> This is a very important thing to have, as if we
> either have a lackluster/wrong DT that doesn't specify a (high enough)
> vote on a certain bus, we may lose access to the entire bus altogether.
> This is very apparent when we only start introducing interconnect
> support on a given platform and haven't yet introduced voting on all
> peripherals.
> 
> The same can happen if we only have a single driver casting a vote on
> a certain bus and that driver exits/crashes/suspends.
> 
> The keepalive vote is limited to the ACTIVE bucket, as keeping a
> permanent vote on the SLEEP one could prevent the platform from properly
> entering low power mode states.
> 
> Introduce the very same concept, with a slight twist: the vendor
> kernel checks whether the rate is zero before setting the minimum
> vote, but that's rather silly, as in doing so we're at the mercy
> of CCF. Instead, explicitly clamp the rates to always be >= 19.2 MHz
> for providers with keep_alive=true.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   drivers/interconnect/qcom/icc-rpm.c | 10 ++++++++++
>   drivers/interconnect/qcom/icc-rpm.h |  3 +++
>   2 files changed, 13 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

