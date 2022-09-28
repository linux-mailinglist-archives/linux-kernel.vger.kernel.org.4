Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAEB05EE114
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 17:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234307AbiI1P6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 11:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234478AbiI1P6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 11:58:17 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B76D4DE9
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 08:57:40 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 130-20020a1c0288000000b003b494ffc00bso1013986wmc.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 08:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:from:reply-to
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date;
        bh=gr4NX9hKRksMUEvq5iTnWXuuqbt/cVaS54wl4qK2lz8=;
        b=mdJ3llifS4oJUpDPAfPfMM/e0Rps1EgY/vfmcdeIeb1PTNfbiUzu74Rq35J8bTdz68
         Ki4TAcYr2QXp+pVREY+gV6TixTC3BV5nGW6A1Uj1uFmC4tZPVuYoJE/zVbRRClGSr8a0
         t8bA2ch1kfpMa4or71ORVt8H+6QD/00XeuiY3OHKh0kXm3f6Up+tVoRVkN+ieq2gEaiG
         nNSerlekU1cbt/5nWaetLqJR5pdnGIIihnmjk6KGf4tjxDCtjX49MV7pl5TIkShAYKuf
         BRnLcTfMXZJH891uiyW/cEIqPN1qSyRLvEqfV5s2Kbxm1ByCZ3/L2nlq/tL0m1V84Mrf
         oWqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:reply-to
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=gr4NX9hKRksMUEvq5iTnWXuuqbt/cVaS54wl4qK2lz8=;
        b=GWiETZma/Qo2+gLxFhBRw+oNXiTLI9Q8BaD029V+Nj0ezbjnKiQARdRz3dDE00ebXw
         om5EO5QfKNxSc4IEgx0srqcygTOttJgSoplZh683R5m6biZzxscdSwS/RufcyV/HXmAg
         tOaVO09zRfwDkpRBYjiHsYTVqGtDQd6rhtwxJlf/7Hdf2TDLXBfHHj1n6NwWrYfWniSm
         a0gPGkJ19AXqDnbLRGowqEU7IsKj9cbA9Tp3DjpJnvKdh1+PEfbVX0Sgovr/UxdEVP7Z
         Hs0BreLnsVtAACcRf2UHaKFt6R/oo69KS/ZZIxx9eEJ+VsweUC5xL9vMfbrO1s12O7Tj
         wFCQ==
X-Gm-Message-State: ACrzQf3wAdGTnUssdc1zqcmhc9DLGy/u35jeb9hELrilWP8B3nFE10AS
        H7x5yTIxRJCfIgLKKmX9sh1OAg==
X-Google-Smtp-Source: AMsMyM52RP978MnDNTMt8hGiwehpzwFh2XZw41YvZzfZBT9JDhg3g2F+igKOAnGTDVkRxYzJwttHcA==
X-Received: by 2002:a05:600c:3844:b0:3b4:becc:e43 with SMTP id s4-20020a05600c384400b003b4becc0e43mr7446114wmr.33.1664380657522;
        Wed, 28 Sep 2022 08:57:37 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:11d4:7c71:accf:6521? ([2a01:e0a:982:cbb0:11d4:7c71:accf:6521])
        by smtp.gmail.com with ESMTPSA id q16-20020a7bce90000000b003b492b30822sm2098621wmj.2.2022.09.28.08.57.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 08:57:37 -0700 (PDT)
Message-ID: <85ce689b-4fea-49a4-2faf-eac15eb2ab6c@linaro.org>
Date:   Wed, 28 Sep 2022 17:57:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 04/13] phy: qcom-qmp-pcie: unify ipq registers
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220928152822.30687-1-johan+linaro@kernel.org>
 <20220928152822.30687-5-johan+linaro@kernel.org>
Reply-To: neil.armstrong@linaro.org
From:   Neil Armstrong <neil.armstrong@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <20220928152822.30687-5-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/09/2022 17:28, Johan Hovold wrote:
> The IPQ register array is identical to sm8250_pcie_regs_layout so drop
> the former.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 11 ++---------
>   1 file changed, 2 insertions(+), 9 deletions(-)
> 

<snip>

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
