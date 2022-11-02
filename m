Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0BAF6172F0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 00:41:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbiKBXl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 19:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbiKBXkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 19:40:52 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478EC1400F
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 16:36:54 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id b2so234824lfp.6
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 16:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hVXT9xKOOQjMytFsPaMld5kkYAuqoQzWwoJxXPr+vis=;
        b=qq8uqswx+dq+fX6MQXKZl6KoVs/QJOKnrUR21/QGaU6BhmZyhop5mTLTMcB2X1PFDd
         f1EZKnHUbAaTDwqFK6CDEgmHT3QaWkO2Go4US8Uzmgve6OwhREBDpdTm2NuHcvVaJEa/
         XG/YO4EFStcH/Fw12QgGMcXXAlTmI80b2B03c+oCCYhCRfCOO+n+2K4aESl8w96LVBF1
         dvMPEDTp3LjBwX7H2N5lhMPGF95Fupvgiosxv9/Phyhuhn0iH3W15IWQb79RumpV0a+h
         p45tZIP4CAp5DvpvZ5yw7fHBIuKQxhFyo9VX9+r7+iAtxsyAYFdXdqU3khLDm4ajWozj
         13/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hVXT9xKOOQjMytFsPaMld5kkYAuqoQzWwoJxXPr+vis=;
        b=bprZmlfQKkynElUaLgdXblODRkrKKGHyzVe7W9FfAeoAPc04XzqfVGb/tgWu8XGZtC
         Phjqp8sYHS8GIfvG1xmg+qAAHu2lTlS8FspyCr5NvLSLRazYN5u6/PKV6L45mvscDc3a
         8bTO7TcPUT0EpDw5V4EJRckayE373qPFYNltgBFESmg5OymPaa4dUt/9XN0dqAwPfW5k
         VuVIfM47JrejCyLP6b9yry4BG+itRX3DI7KiwCOnSkipvDtURVHi6usqoGpvwx9RG10A
         IPdOelkIsLk6QSMzCj/aBSfY47DGGyOWCygiD/TBQS9qPpSYkMoifjN4Fitn9tgnWGIs
         JvCA==
X-Gm-Message-State: ACrzQf2Z2CTbp8u5ofnq86QOad6B/Odv/z+hX6WkuzzOwTslrh4kg7UJ
        MUFs1+U4tVaOn4rfWYSj0b3jxg==
X-Google-Smtp-Source: AMsMyM5g0cJ6EynJYUzGsGjtwQSJNbnVjoJzqN+ZnX7lGyY2p2L9E9jV//Lks8s5mnLud82ZcRO4mw==
X-Received: by 2002:ac2:4bcf:0:b0:4a2:c241:1979 with SMTP id o15-20020ac24bcf000000b004a2c2411979mr10626606lfq.89.1667432212678;
        Wed, 02 Nov 2022 16:36:52 -0700 (PDT)
Received: from [10.27.10.248] ([195.165.23.90])
        by smtp.gmail.com with ESMTPSA id q12-20020a2eb4ac000000b0026e90b478c6sm2364290ljm.114.2022.11.02.16.36.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 16:36:52 -0700 (PDT)
Message-ID: <9f11fad1-2ecc-39a0-33c5-8fb28750686c@linaro.org>
Date:   Thu, 3 Nov 2022 02:36:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v3 04/12] drm/msm/dp: Stop using DP id as index in desc
Content-Language: en-GB
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221026032624.30871-1-quic_bjorande@quicinc.com>
 <20221026032624.30871-5-quic_bjorande@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221026032624.30871-5-quic_bjorande@quicinc.com>
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

On 26/10/2022 06:26, Bjorn Andersson wrote:
> From: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> In the SC8280XP platform there are two identical MDSS instances, each
> with the same set of DisplayPort instances, at different addresses.
> 
> By not relying on the index to define the instance id it's possible to
> describe them both in the same table and hence have a single compatible.
> 
> While at it, flatten the cfg/desc structure so that the match data is
> just an array of descs.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
> 
> Changes since v2:
> - None
> 
>   drivers/gpu/drm/msm/dp/dp_display.c | 72 ++++++++++-------------------
>   1 file changed, 25 insertions(+), 47 deletions(-)-- 
With best wishes
Dmitry

