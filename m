Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69C0A5B3473
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 11:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbiIIJsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 05:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231805AbiIIJrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 05:47:55 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F40E7110A96
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 02:47:52 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id f14so799573lfg.5
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 02:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=UC/RYJCZztRm1rSOSADEzcPaiE3TFJT+Z5tiSzE3pIY=;
        b=WCmQbBQXmbzmKntTlhBu3beHFSwPztkJXCXCJ67r43m8w1qKbsjBoOxnBOvXnb+yby
         /uznaMglIk86U7Eg5FSBwVrR/3GBhp05MMm0OULZt1dAJ2vQB14/aezAO+SsXSNof1q3
         WuBOnpkbSIx7npg9Q6bV2W/LPUnsxhBYchUf18XcvUDlsqeFFKPAFpqSjKw/ZrikUXCj
         ETrMGMzcxOqZbw4UMq5hpq3GPA4qBCxCmACP0Z/UIlTB+CBXunB8ppLUSIc2NJCTaTuN
         0WcDFvo72dqFU4abnEdkaGayM4+yVAy9MC3Ury3UL7hHVj3B4GmBkPHhVNRINGrf561X
         Y7Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=UC/RYJCZztRm1rSOSADEzcPaiE3TFJT+Z5tiSzE3pIY=;
        b=Kj8Ef277FxvQbwExiN5/6yoF7rji6obWPx2aJRHEj2pMY3Qe4uv6fM7TH7qJP85cnd
         TlrsHwIkl70VQ8X5vN4wj4SmgGi24cs8vEbhJB/O7dDcAa0gikA8fCyqNvE1EL2EvTeI
         usZS2Zq9IEVV831qVfCJD5mlGGXh691tS+X/hKk7mxyDEtvH2mlhnN0FYcwF2esBkjC7
         Zysjx4HbtnYgp308yV0+BG4RAyUP7SRBk9xR6etRVIFnIl8HNstHhTRhAThZjmmeDf60
         dgZbXNAnG2XrlIn6fPOac58lQbLAy29Mw9jUqDuHMnqvmilQFd8kJ/o9pG2zcCtnZH4N
         N0fw==
X-Gm-Message-State: ACgBeo2OZES1K8USMpli0gEahW7jNueQj5WTis+AaSyXPsR5w/7offRD
        KM4ffg6XPJuPbiozyJm6H8P78Q==
X-Google-Smtp-Source: AA6agR5UqzXXevsvW/zI4AsS16Q/lo64SrrZM1t4RbqlgEun59doiX/cK/9YbSah0ZKU8Ksc2g3yFQ==
X-Received: by 2002:a05:6512:e98:b0:492:cf3c:8860 with SMTP id bi24-20020a0565120e9800b00492cf3c8860mr4053202lfb.603.1662716870498;
        Fri, 09 Sep 2022 02:47:50 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id x18-20020a056512079200b00498fd423cc3sm4135lfr.295.2022.09.09.02.47.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 02:47:50 -0700 (PDT)
Message-ID: <f1681e74-9c48-320a-6f0c-70518c768b78@linaro.org>
Date:   Fri, 9 Sep 2022 12:47:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 15/16] phy: qcom-qmp-ufs: shorten function prefixes
Content-Language: en-GB
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220907110728.19092-1-johan+linaro@kernel.org>
 <20220907110728.19092-16-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220907110728.19092-16-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/2022 14:07, Johan Hovold wrote:
> The driver function prefix has gotten unnecessarily long and hurts
> readability.
> 
> Shorten "qcom_qmp_phy_" to "qmp_" (which likely stands for "Qualcomm
> Multi PHY" or similar anyway).
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-ufs.c | 88 ++++++++++++-------------
>   1 file changed, 43 insertions(+), 45 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

