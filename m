Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7256860B136
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 18:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234237AbiJXQRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 12:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234999AbiJXQPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 12:15:38 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64AB8125024
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 08:03:24 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id bp15so17127031lfb.13
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 08:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2xaMm78fM2rUZsQPmBvYXK97To/2DK/rtGwK+0qiEt0=;
        b=r0gnmUhcfoDGmqHuXWVGnOZ8m4Vp2E9CRPBUM3zSGQ0+v3W6eCljPT1bVvefZLqlqN
         CGqHJtZZLjGOgMNOIzZDNUye2auuKVXnxEvNaDglhe+BOT4HQj37jr3Ot/fI3gvN1ByX
         M/d7ZLuzCaSqlvDb2NgSQDH0Mh+QStyVva74R/oPhm4lBYRxLQGKRQiX9EOjbGqDjPWx
         upfpa2Ybp5OkLnYWBBT7X9QSv/EJ5+ZvUANae+mqQdmPjY2P96gPAWAxOJUyklj5bRyk
         Qr6x+4tcHzVmHvcnPyOt+9PKe8Eyx8J7tdoTraqOIHakQI+MOCd/N4Vtv4/ic2g7wa8w
         UDfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2xaMm78fM2rUZsQPmBvYXK97To/2DK/rtGwK+0qiEt0=;
        b=ftufGHVoefZcSh1FJgIliaq8KQPoemhG4vcpeXyjMRqJ0qg2MEX4O4VY06fgtFR5aV
         RFFOfDF2t3mHhYKfGCSCbEDI6BHSR2cpCaVFoKAAmGgMgBqVe1idXw66LDXLdRqpQ079
         9GwHlANwpS1ng0ajLp/nVXaZijw1RDe64EYAdxIXJoanmauclp2EHnpGDnrO9OhcAZbM
         z8y2OZmYAdReagopkbFFnD2oNjHCilTPT/w495poVioM7Ls1KlY78FRun4KQByHAcBwz
         Om0XxF6ktyiRNRPhm25gEdqAU/mtyHTMOWX9TqtO0oKibPRIEd8LaG/tWmBSm207byzD
         k1uA==
X-Gm-Message-State: ACrzQf1LChNPKt17g/yh1egOIPyYZMDFI4s6IR+0Uv1ZTz9779Fi/cbk
        QsGjd0/8XYw/atklDliNM4jiLy4b5N6A7ioO
X-Google-Smtp-Source: AMsMyM58S+kwJjzf/AcosLQEKY92VlM/X/zNBCksGzwTStER3W9096fbJUbGcKmYoC1waiUXkJ7OAQ==
X-Received: by 2002:a05:651c:1950:b0:26f:ec78:6178 with SMTP id bs16-20020a05651c195000b0026fec786178mr11284200ljb.98.1666618374256;
        Mon, 24 Oct 2022 06:32:54 -0700 (PDT)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id i11-20020ac2522b000000b00499bf7605afsm4545272lfl.143.2022.10.24.06.32.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 06:32:53 -0700 (PDT)
Message-ID: <614b03b7-e6ff-bdad-449c-b84f840b2e1f@linaro.org>
Date:   Mon, 24 Oct 2022 16:32:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 01/13] phy: qcom-qmp-usb: fix sc8280xp PCS_USB offset
Content-Language: en-GB
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221024100632.20549-1-johan+linaro@kernel.org>
 <20221024100632.20549-2-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221024100632.20549-2-johan+linaro@kernel.org>
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

On 24/10/2022 13:06, Johan Hovold wrote:
> The PCS_USB register block lives at an offset of 0x1000 from the PCS
> region on SC8280XP so add the missing offset to avoid corrupting
> unrelated registers on runtime suspend.
> 
> Note that the current binding is broken as it does not describe the
> PCS_USB region and the PCS register size does not cover PCS_USB and the
> regions in between. As Linux currently maps full pages, simply adding
> the offset to driver works until the binding has been fixed.
> 
> Fixes: c0c7769cdae2 ("phy: qcom-qmp: Add SC8280XP USB3 UNI phy")
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-usb.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

