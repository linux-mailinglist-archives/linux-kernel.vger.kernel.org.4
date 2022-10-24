Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C02C260AF52
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 17:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbiJXPn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 11:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbiJXPni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 11:43:38 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D660642E4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 07:35:09 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id a13so32095821edj.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 07:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g2Ef1B72AKv92WqpGmoWgiykPR41P059MtKUSV1dcDg=;
        b=UZLOcBWKiIN/hH5Fs9NPYS3GijO4NAndQrmQRsKbral4tksqPRvrgE9UGfwXtyEgHd
         3MEhNw0FE1tEqcbwLrO6qm28DGlR0ex8Y25o0YdLXVjozxUIM6mADVXyhVDffXNjM9lv
         umVwGtRz8CB+qSE85KNt9vlxDYAygN/Gk/qBPtlwgaI4tha15FV68qcR8G6uzTb6Onyr
         O+MWquMaYfEVxL5hvHPYuix7O3O3YkJNCrizTMHZf8adWGxudjVZrPnHY3a3SN63K7ol
         zIw9OTzDmhPU6yaCrWAgy52h3QMWWWnG8Iy6Kf7gYo87SQBx3Ixq505MUOVCEjfh+O04
         R2GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g2Ef1B72AKv92WqpGmoWgiykPR41P059MtKUSV1dcDg=;
        b=QsuRX18VjeGIeR75r20Hds4l7FjQFJArZ+bG3ML/oih7rPXV8v2a4yNYfX1/bSHNR1
         UUZTmkiDGTXn2bbV0ceXePGkJSAT4mSdAJQGhkerxiYI7dyil4p2Mc4CxK0Sp3hFo7BV
         cnmzDWeD3Q8RnkXZ/9qjK0xLQ3GqOHMAEJWAb4DvkQ1xq9nUqUgiTxlIIsf+IWDIZXm1
         8VNGieg8Z0TlWZa3xqvW/pWuffUPsaYLHyOdvyx+yodvdxXhs8qGtRswQmKNkuCN2TyI
         YPUITgLNkLVxk0YW6+AIgfInSdmo07T1WcU9uI+8kjgFvUc0oZQGjg9qaxeD/091XlnC
         mPNg==
X-Gm-Message-State: ACrzQf0fzZZTGDwA7woIoqsudHI7RoOrIyIobzC+2QGZJg4Y46hWtUQS
        dL8/SxwgL6TgWB2cgOyoRIQYgZi0UUYLV9vi
X-Google-Smtp-Source: AMsMyM5jX7OiDEQDWyvzBEOzsc0vxkYH4NLEKD4zJsJxdaz8GYopiaVKrrXCyW7CktB9D8iJmH3GvA==
X-Received: by 2002:a05:6512:2c88:b0:4a9:4051:79a1 with SMTP id dw8-20020a0565122c8800b004a9405179a1mr3897069lfb.331.1666618277293;
        Mon, 24 Oct 2022 06:31:17 -0700 (PDT)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id c24-20020ac244b8000000b004947f8b6266sm4410814lfm.203.2022.10.24.06.31.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 06:31:16 -0700 (PDT)
Message-ID: <9cb136e3-4028-091e-a298-ff24880f32b6@linaro.org>
Date:   Mon, 24 Oct 2022 16:31:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 05/10] phy: qcom-qmp-ufs: rename PHY ops structure
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
References: <20221024090041.19574-1-johan+linaro@kernel.org>
 <20221024090041.19574-6-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221024090041.19574-6-johan+linaro@kernel.org>
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

On 24/10/2022 12:00, Johan Hovold wrote:
> Rename the PHY operation structure so that it has a "phy_ops" suffix and
> move it next to the implementation.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-ufs.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

