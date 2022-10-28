Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95F77611450
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 16:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbiJ1ORO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 10:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiJ1ORG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 10:17:06 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D521D73EC
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 07:17:05 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id r14so8545690lfm.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 07:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4J/sXyEdqyItftLKRWQlfAWzGrOTW4HnYFqWzMysIi4=;
        b=ZAL5xdvHt5LTVV98rbvm/6GVG7tPk50osYKnbq4cW9aBUDbMM2ZBuNrVDrWu7vhQ9X
         Hpi/T/OQSeA6kJS/sR8eKQ/26fNqKlY9PsD9t/MP4qO7o65/8PASdP1AB7nplZ4gOzJz
         Z/lHLC6TEFHlKSg4xatMU/FHWFNk6e0B1P+MDqI5lFnLQYpUi5jAmEBxFVRfYljaZCl9
         0GeMkc+8n5rqae9qCYwYfyQY2O3TnZqG99bJRyA6RnqLrtma8W+77TjHgvlTjBLoJUmI
         xObLRsuHh88/WnD87ryb8PvUR+Q1WNtMPDKU06znt3oUOLuj4OlQADfr+6L29QuI/tDT
         rf8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4J/sXyEdqyItftLKRWQlfAWzGrOTW4HnYFqWzMysIi4=;
        b=g8BdNJxu/VA/M1rCu/zkxTLDyknzTD20c7Ii+g7XW77FLtM0Z9MF7bVxoG9jSxzbOS
         YqP6NiqQr9C2pP2EOj7164RQNTCj9Y5neg1P53i3NBCFkO2C94C/py0g2A/s/ekDAU5B
         nI7MZ4g6//3Ov2vNm02S+qGSVqHdwaErgtbybpfuyusPfVNL8emTYSNvRg0aev1HXkZG
         O7vtTDDM1GLgMb2l5qr1n+X3knJhvxBfQm+spW3oUNKkU7V58/CLJwRwJKEYBdFhEMkl
         g2fc2XpkIhh9SCcdVofQX3YPvZ0CTuUMGz179xTaaHbqAqXMQmnsqeTh/W1GQhC+XT7t
         WQ2A==
X-Gm-Message-State: ACrzQf1AIUzp2JhxcMSI67SNKc9X4C+isufugC9iYwt7Y9DxOEBxT8Yx
        MyKJy0ELorb3sww8fYwzDdwphA==
X-Google-Smtp-Source: AMsMyM6eQiKVik2y9rlF5HrxniO/C+2f15b/1ffW5U9Uj2hWXG+lSG3PQEG8rBodPyFRQNcgbaf6sw==
X-Received: by 2002:a05:6512:ac8:b0:4a2:61e7:7963 with SMTP id n8-20020a0565120ac800b004a261e77963mr19939264lfu.363.1666966623425;
        Fri, 28 Oct 2022 07:17:03 -0700 (PDT)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id v22-20020a05651203b600b00497a1f92a72sm578570lfp.221.2022.10.28.07.17.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 07:17:03 -0700 (PDT)
Message-ID: <f8c0e2c1-945e-9bcb-30ae-05bdc43269ee@linaro.org>
Date:   Fri, 28 Oct 2022 17:17:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v4 15/16] phy: qcom-qmp-pcie: add support for sc8280xp
Content-Language: en-GB
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20221028133603.18470-1-johan+linaro@kernel.org>
 <20221028133603.18470-16-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221028133603.18470-16-johan+linaro@kernel.org>
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

On 28/10/2022 16:36, Johan Hovold wrote:
> Add support for the single and dual-lane PHYs found on SC8280XP.
> 
> Note that the SC8280XP binding does not try to describe every register
> subregion and instead the driver holds the corresponding offsets.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c      | 299 +++++++++++++++++-
>   .../phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5.h   |   2 +
>   2 files changed, 291 insertions(+), 10 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

