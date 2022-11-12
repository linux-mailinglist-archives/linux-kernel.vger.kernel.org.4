Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13FCB6267A8
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 08:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234674AbiKLHc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 02:32:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbiKLHcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 02:32:53 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35712FC21
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 23:32:52 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id b9so6837220ljr.5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 23:32:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZeeRPkiWJ6dgVYLmrtRGsjTc/jG/dNAJ9wPW3QYFgpU=;
        b=tiYHbvZJnvWktz9Q2secp6W0miGCQWW6dBdJfSLlBajb8I7oy4ca6HMy+fv3ptMOk7
         tltt+7dsvMllR0DMVVlwdiC2nRi71/46qXPlgtMLW+B1YFqCueTDWHq/zOjIvszAQAaP
         bHOG0+yQtCO/d8iCQs8xdYIjPaOra4mdHaCotYeCIcUqYeIiy9aGhDVHK9fKeMKYu9xo
         ouGqw0oRoO9tyz9Pm2w7XR3SD/9zVVRHum3VJVwif6yhMvgpla9uMBUuHqsw0sZux9KV
         wgfYYE+QlIrIIOBqAdz9WEyA4VOeXRC50xk/ENTEeFEIrqp/0KIMzmhlRD406nJNZrjA
         pJJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZeeRPkiWJ6dgVYLmrtRGsjTc/jG/dNAJ9wPW3QYFgpU=;
        b=euhYX8Aa6fBMPiQqZoPRD9ByUMdW2p7mn6n7Ls7YjWoEOq2Q+VPKRjMrp8klcxtpvt
         J7gF1zv1TeU470+uhHMSwLIoBDONXL+S1MkV83+yt4vmrDQIvuVxhmtLJqW9BQzbXX0G
         unUBk4e0yV62lxQSb4QWasNAcmYsf8motVeYWj6inw+pIhvfzlb95mzifiypcmELgil1
         10gLlFifRPS0cAfyU//ICrcoXIJ3n/2tOAl/JwovdUm1xcBo2kWO2CFm4DHyJee6j78+
         LFEt8/Q9mPKLj/k9r26bRLGqwexhcG1kazPZv7l+ONsquWTwVP/Wc4c23CCLgHnjpuRJ
         uLXw==
X-Gm-Message-State: ANoB5plObZvvtBr+J9OLLIMFjjWTkZ2nd0+QS4Yq2ZzgUfp3MPQvu0NY
        PVBOfmYXfWNYup2pW4M4Od6rMg==
X-Google-Smtp-Source: AA0mqf53TKyvPCvEUZkaKsGEYJe0Siut9CWzlvX53yz43w45aFfp8j2EoBX2TEZ3s8BtbCSHF2ZYUg==
X-Received: by 2002:a2e:9982:0:b0:277:2b10:bf69 with SMTP id w2-20020a2e9982000000b002772b10bf69mr1763963lji.392.1668238371299;
        Fri, 11 Nov 2022 23:32:51 -0800 (PST)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id t12-20020a05651c204c00b00277041268absm783886ljo.78.2022.11.11.23.32.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Nov 2022 23:32:51 -0800 (PST)
Message-ID: <a889bb3a-cedf-4be8-158e-fc6f202fb7c0@linaro.org>
Date:   Sat, 12 Nov 2022 10:32:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 14/22] phy: qcom-qmp-combo: clean up DP configurations
Content-Language: en-GB
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20221111085643.9478-1-johan+linaro@kernel.org>
 <20221111085643.9478-15-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221111085643.9478-15-johan+linaro@kernel.org>
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
> In preparation for merging the USB and DP configurations, align the
> initialisations of the DP function pointers.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 40 +++++++++++------------
>   1 file changed, 20 insertions(+), 20 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

