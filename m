Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAF8D5B5EBD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 19:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiILRBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 13:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbiILRBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 13:01:47 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95EBD3136D
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 10:01:46 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id d64-20020a17090a6f4600b00202ce056566so3545157pjk.4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 10:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=KRfVvGxMcWVVzyGzWdz/B07EZ2xM4AP12X10HeNX+YA=;
        b=gOyUjZPNIXCMEPph8GNoIbJnxXERolL4pKU35zKKCoWurdjbLEcvEJq7C24/ChModv
         rX4FvfvLMH8Lqrj8NkiCyiJVJw8FkSvuDVVQp7n3XkPkFNdkuVOENYLDrJbZ2bC3uYCD
         MgsarfSZIl57U/mW9XHOGVcXUBbyU3KmBs0+BH3L7tGnoGdpdhQxJFKiEwrOwCkAGIpA
         h7MfIKpSXe/PC/Rsx+hmRcpxfTMJriDByqsfsqNc4P62m/5vC1FgUnTOqHUCVZoPH+N1
         Iv+75iJ1j9j8ttGNqnv17LMQ+oJ9qZuVeXePtDqJa8iycqnMdtHZSPE1pE70/aPQO65x
         KPkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=KRfVvGxMcWVVzyGzWdz/B07EZ2xM4AP12X10HeNX+YA=;
        b=Lj3VJalEQsE/+VnvBJyiGXbzIqv3vyMh9NzDJcIYTAbUMaqOyIQf3qRFzazb2ksrph
         y3Bdx/Qz0FfD/InJX9/Bypw0NLO6sjTtChpjaBjrPDGi3Ofam/5K9jP6bDEi6F6QXVdz
         24ZyzAZCWYcsY/UANuwRXVWWzC9PbV8L2D7jdnx9VKHvhbzZPs4R4SX6IG6XMZuFtp7p
         3sb74ZS944g1SeLAkFTLcADbTbj5prTm8lakN1p6QuSVlxlP0USjU6YgzD3UMJ9FVewQ
         d3vzNxg52vQDp5A2M1RD6Rx4sVQxcU4x0533uQXM92HnMANx9tX+7kKTewC0X8MMNXg0
         MVOQ==
X-Gm-Message-State: ACgBeo3CnNidOXkRPkaIFMLxAxpHL+l3qdlrAnJulHXrVdpVDn4VIqZq
        GPasPOSf55boHRW1e6iZlykOwg==
X-Google-Smtp-Source: AA6agR41bjUAzmYUs5QGJtGHWvfbasRXehs7fmqo8Z5czTetdmgzfi5tCsTKsKGzOZJTXLRSxovbFA==
X-Received: by 2002:a17:90b:4b88:b0:202:e381:e643 with SMTP id lr8-20020a17090b4b8800b00202e381e643mr2930028pjb.148.1663002105819;
        Mon, 12 Sep 2022 10:01:45 -0700 (PDT)
Received: from ?IPV6:2401:4900:1c60:5362:9d7f:2354:1d0a:78e3? ([2401:4900:1c60:5362:9d7f:2354:1d0a:78e3])
        by smtp.gmail.com with ESMTPSA id j8-20020a170903028800b0017829f95ca2sm3504900plr.286.2022.09.12.10.01.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Sep 2022 10:01:45 -0700 (PDT)
Message-ID: <42a21b98-b920-868b-999e-2a43c8f4093b@linaro.org>
Date:   Mon, 12 Sep 2022 22:31:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v4 0/4] Add support for tsens controller reinit via
 trustzone
Content-Language: en-US
To:     linux-pm@vger.kernel.org
Cc:     bhupesh.linux@gmail.com, linux-kernel@vger.kernel.org,
        andersson@kernel.org, konrad.dybcio@somainline.org,
        linux-arm-msm@vger.kernel.org, daniel.lezcano@linaro.org,
        robh+dt@kernel.org, rafael@kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>
References: <20220901105414.1171813-1-bhupesh.sharma@linaro.org>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
In-Reply-To: <20220901105414.1171813-1-bhupesh.sharma@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/1/22 4:24 PM, Bhupesh Sharma wrote:
> Changes since v3:
> -----------------
> - v3 can be viewed here: https://lore.kernel.org/linux-arm-msm/20220804054638.3197294-1-bhupesh.sharma@linaro.org/
> - Addressed review comments from Bjorn regarding early exit paths, spin
>    lock being held while returning from func, etc.
> - Also added Bjorn's R-Bs for v3 patches.
> - Rebased on latest linux-next (master branch) tip.
> 
> Changes since v2:
> -----------------
> - v2 can be viewed here: https://lore.kernel.org/linux-arm-msm/20220724122424.2509021-1-bhupesh.sharma@linaro.org/
> - Dropped sm6375 specific patch from v3, as suggested by Konrad.
> - Rebased on latest linux-next (master branch) tip.
> 
> Changes since v1:
> -----------------
> - v1 can be viewed here: https://lore.kernel.org/linux-arm-msm/20220701145815.2037993-1-bhupesh.sharma@linaro.org/
> - Addressed several comments from Bjorn regarding locking, serialization
>    etc received on v1.
> - Addressed Konrad's concerns about the tsens controller found on sm6375
>    SoC which seems to start in a bad state or is disabled when entering
>    the linux world.
> - This series would depend on sm6375 tsens controller changes being
>    added by Konrad. It is based on linux-next (master branch) tip.
> 
> Some versions of Qualcomm tsens controller might enter a
> 'bad state' causing sensor temperatures/interrupts status
> to be in an 'invalid' state.
> 
> It is recommended to re-initialize the tsens controller
> via trustzone (secure registers) using scm call(s) when that
> happens.
> 
> This patchset adds the support for the same.
> 
> Cc: andersson@kernel.org
> Cc: Amit Kucheria <amitk@kernel.org>
> Cc: Thara Gopinath <thara.gopinath@gmail.com>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-arm-msm@vger.kernel.org
> 
> Bhupesh Sharma (4):
>    firmware: qcom: scm: Add support for tsens reinit workaround
>    thermal: qcom: tsens: Add hooks for supplying platform specific reinit
>      quirks
>    thermal: qcom: tsens: Add driver support for re-initialization quirk
>    thermal: qcom: tsens: Add reinit quirk support for tsens v2
>      controllers
> 
>   drivers/firmware/qcom_scm.c     |  15 +++
>   drivers/firmware/qcom_scm.h     |   4 +
>   drivers/thermal/qcom/tsens-v2.c |  15 +++
>   drivers/thermal/qcom/tsens.c    | 193 ++++++++++++++++++++++++++++++++
>   drivers/thermal/qcom/tsens.h    |  18 ++-
>   include/linux/qcom_scm.h        |   2 +
>   6 files changed, 246 insertions(+), 1 deletion(-)

Gentle Ping.

Thanks,
Bhupesh
