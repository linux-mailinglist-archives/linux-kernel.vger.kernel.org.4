Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74E6A626769
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 07:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234623AbiKLGSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 01:18:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234237AbiKLGSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 01:18:47 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E3715FDC
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 22:18:45 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id l12so11274459lfp.6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 22:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ogXWCN0t521Ij0otOt/tVRnA4R2z6ldRz1ScJkRGGsQ=;
        b=pFT3u4kkDpRU+DOFPlY00vYx7zDAsAf5Hz69EDbHIamIMwyYw9sO8Gn42amkS9xP8h
         MJXAUwpo1Gv3rj/ukO6Kl+8HG88SXxSyQh5uJcAa6MbFCV4+Xd1XaFqqRa3NdS2iEc1E
         UfCu4pgYBDWshP/2At0ZSkuewtJe2TA9yZGIGRv9nkNJB5loK4Y4B4d2MorT8U699+aX
         A9UusTIt8MW9gpmnDxG2LCrzxDM2/9yM5mtomR9+jbioqQd1I+AP2+gYbowWGK8cSKNI
         OZU79cZBGs0tcek97oUhm+WDpcT6X6i6G35Mu/WJ9jqQdZWnKjkIMcfz0YUgi1PQPb8r
         dzAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ogXWCN0t521Ij0otOt/tVRnA4R2z6ldRz1ScJkRGGsQ=;
        b=dNh/BHPLjnNxr7qIGbnYhjh1dXJT1uyUcyN9RJDh3F00XEKJlUyMiJYxSb3laSynvH
         sY/Ubdv9DvRXX0E7k6c930e/O6gbz6v2HulTRPMHwZgaadkXbi3aJXU8tU31aepBQK3v
         y0vqMB4aYJ+w6xZSrDKw+gtyjZ07b+46zg+x/1wBmY/oNIQnW2IqrLscPDL+ea14AenM
         ABotoImvjHeSogmPpg+rQZDZAZvr/izuCdAzupe/da7C7jifOTKXcG02HYxEgi8DFTux
         XKfQ89LTLfXzSR0xjeR11SBon1x87Vvt5awWNIkYHgSej0nS5qK0c3rL+/InsPsJP0P+
         7MUg==
X-Gm-Message-State: ANoB5plWWHIPGIihqXhbv8o4a42a9Dl/RL9hLzSbPH3FRT77LVnMo5UR
        MKJqREGRVevnk7Psi6cMrh0NTw==
X-Google-Smtp-Source: AA0mqf5iqNcTbJWktJtWcItFCGC6wMLmJGYOBeuUpXoRTiDNhdQZXobUNi1w+oeH59dOfm4TzNztZg==
X-Received: by 2002:a05:6512:20c8:b0:4ab:6c73:28cb with SMTP id u8-20020a05651220c800b004ab6c7328cbmr1575082lfr.504.1668233924236;
        Fri, 11 Nov 2022 22:18:44 -0800 (PST)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id e10-20020a05651236ca00b00497ab34bf5asm716043lfs.20.2022.11.11.22.18.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Nov 2022 22:18:43 -0800 (PST)
Message-ID: <3e28efa7-3629-740a-4901-57d5e5c298f5@linaro.org>
Date:   Sat, 12 Nov 2022 09:18:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 01/22] phy: qcom-qmp-combo: sort device-id table
Content-Language: en-GB
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20221111085643.9478-1-johan+linaro@kernel.org>
 <20221111085643.9478-2-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221111085643.9478-2-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/2022 11:56, Johan Hovold wrote:
> Sort the device-id table by compatible string to make it easier to find
> and add new entries.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

