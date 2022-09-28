Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03CF15EE130
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 18:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234296AbiI1QDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 12:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234289AbiI1QDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 12:03:31 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA26FDF6A5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 09:03:30 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id z13-20020a7bc7cd000000b003b5054c6f9bso1567120wmk.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 09:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:from:reply-to
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date;
        bh=U/WlCXHpaS4EJuvdxGL7cBryc3HObdjRZAT31F4Yxs0=;
        b=zICZlPKn7tyOLOAOVwHKy7j8FYkPZKNM3Dp3EpmClXBSgdVE1Oahn5XuBI9B+CUy37
         f4WAv0KNxk1J9ZWoIkXvEmY2bVTcgwQ8qu+asVFfurA0Y+hhIY7J1MbBTsbJgg8I/8yh
         CrCZnWMuWNiiyQZNNO18tACTqKxLrSB/XalIeQTRZPyUCoYngL34rq01P4Yxn3TuxKuw
         HL6nS+RXFQVgohIBy/G1XKXLHcP39X+KKz9m+12GZsatndOamQifkcK1xkAP3zAVuIj/
         3Wl6yEHqzgVRjRgoJx30KZkdxsoR4uvyJ9vdzmD89NgLtCQvtECOu0lPlHkB0e3ShY+r
         ozPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:reply-to
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=U/WlCXHpaS4EJuvdxGL7cBryc3HObdjRZAT31F4Yxs0=;
        b=PkHNVk6ONTH+cC7Anpi0wbmWsxJvUuElFkC8pg07dMkF2vSaU0LTXQ3lpf12mSMtXJ
         5BmFBcnsW98eh5mkSGqh7igyVgM4wujf+PakCR4rPuN8eR059iAOOL4JQeYhIvwPoGrP
         gYDLcjFqcKGnw0lhwFIkw1+fcVb4JlNVcrOXY1fviXavTYw8NphuDVlZsT92kWBkkfGj
         yrf2sK/RMcMOtQtP7MHafPx8dDbYdGSfwpC/fciW6bN4qKsWYsuCVb8nAAi7lWK2gLsf
         zS2T7JR+oUIKb86Nq03K9nDGGrszAswaRiYeGjl56BckHvqzRKgIfaNNVmlC90WLqRRO
         4KxQ==
X-Gm-Message-State: ACrzQf2vQqqjy27PI+SARa91P0YkaqCliYLHtSLmDD4XL9dR8NSbBwhM
        /L2N5UsjVVOZ/jjG4eGRW+CwkA==
X-Google-Smtp-Source: AMsMyM6x9fCiPlAIsTrXnoVNYhb7/GEEGqBZYfkmXGta8ToHyMPsSfKUrtdi4383MYE4IJkQKbGoSg==
X-Received: by 2002:a05:600c:3d0c:b0:3b4:c481:c63b with SMTP id bh12-20020a05600c3d0c00b003b4c481c63bmr7084859wmb.147.1664381009499;
        Wed, 28 Sep 2022 09:03:29 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:11d4:7c71:accf:6521? ([2a01:e0a:982:cbb0:11d4:7c71:accf:6521])
        by smtp.gmail.com with ESMTPSA id j8-20020a5d6188000000b0022cc3e67fc5sm3380637wru.65.2022.09.28.09.03.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 09:03:29 -0700 (PDT)
Message-ID: <8982bb98-cbfe-3628-a646-a978ae0f09ed@linaro.org>
Date:   Wed, 28 Sep 2022 18:03:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 03/13] phy: qcom-qmp-pcie: drop unused common-block
 registers
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
 <20220928152822.30687-4-johan+linaro@kernel.org>
Reply-To: neil.armstrong@linaro.org
From:   Neil Armstrong <neil.armstrong@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <20220928152822.30687-4-johan+linaro@kernel.org>
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
> Drop the common-block register defines that are unused since the QMP
> driver split.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 9 ---------
>   1 file changed, 9 deletions(-)
> 

<snip>

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
