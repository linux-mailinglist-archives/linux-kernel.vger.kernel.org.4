Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3BFD6267CA
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 08:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234237AbiKLHs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 02:48:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234519AbiKLHsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 02:48:54 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC05419C3B
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 23:48:51 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id h12so6857321ljg.9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 23:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1WxsG42LKTQVTkXlEAiYKa0OwGib2EgN2ooRMVwZbEg=;
        b=Df1TvR67pZNpHd/nMYAZhVgQhoZiK2vlxVz1PDLu8R2Mhr1/Ial8EIiSDmsBoqieYC
         l9MhlstcmHHHDw3p+gKuskhYPSA81RUUht08dHc2p+CoyJnGR5wgQOD3i7t7gvgIMoTb
         Q7KfHSQvzGrDwjZzKHbenr4ru/yleOxyAulRdbf1aTzqrYTKQ5/EVxmZUQuK53wwXEiI
         u+YGFf4XBmIbqNUlTKiR0n5W8wSsq0fkCiloWzSuGBLzV2Hrm4k6mAQMFVaY9xTkjs9F
         5io8LF+JJ/2qvY40HgW+F77tS/ljuc0MZlHWc0jqGlRhG4IdccLBLTcTKE+j1kOLHups
         LD4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1WxsG42LKTQVTkXlEAiYKa0OwGib2EgN2ooRMVwZbEg=;
        b=nOP3GoCEPcWBdpd6BVkuXPviGbAVSSXrN39oqWhtyGU6druQpSfebLDt68FnVEznq7
         iUYGXpGnSMoSzaV71uaiMov2WUpzWKYEyw3qFxodf1Mmi5IJNu8PM/n35QlJRCXoVSFQ
         T3rTjsUo5Y8b+Fbt6cZeB1LThLVrkDPiiOhLnkltFfVAoIqO1UVji3so/Bv238IZ/LYk
         mkEbKn+Q5xMrX+ODhJP3jSHmY4255zwDl81U8q9PQvP2M3ZsODrE0Xbi5uKgs9J1BINx
         W/FZ//uOja75nPFTLN75XsCAfbxHSVPrtz+YusfbEWroG40gBA6SL5bb72LRmJuxA1iI
         EoWQ==
X-Gm-Message-State: ANoB5plh74uvHK0HvvkU7HvfrWogMVP+4mzNv2OzEVtNHMEPTegB0uIC
        Ds9qAxSmDEx4qR+QSBLzJEGRArIwKoQcYlrM
X-Google-Smtp-Source: AA0mqf5r/HaUD2qsEtfli181hg72rtsQbgum/yeB7dEGR+HqiCBJxpv2t1ri1kePIjScYIH/P4bE9A==
X-Received: by 2002:a2e:a590:0:b0:277:3ca2:dac6 with SMTP id m16-20020a2ea590000000b002773ca2dac6mr1531460ljp.143.1668239330269;
        Fri, 11 Nov 2022 23:48:50 -0800 (PST)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id j29-20020a056512029d00b0048b365176d9sm733775lfp.286.2022.11.11.23.48.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Nov 2022 23:48:49 -0800 (PST)
Message-ID: <7f892a0d-56f0-6811-0111-6922c2159b56@linaro.org>
Date:   Sat, 12 Nov 2022 10:48:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 20/22] phy: qcom-qmp-combo: clean up probe initialisation
Content-Language: en-GB
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20221111085643.9478-1-johan+linaro@kernel.org>
 <20221111085643.9478-21-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221111085643.9478-21-johan+linaro@kernel.org>
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
> Stop abusing the driver data pointer and instead pass the driver state
> structure directly to the initialisation helpers during probe.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 62 ++++++++++-------------
>   1 file changed, 28 insertions(+), 34 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

