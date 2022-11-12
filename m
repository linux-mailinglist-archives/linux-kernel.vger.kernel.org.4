Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2F66267B0
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 08:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234515AbiKLHiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 02:38:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233223AbiKLHio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 02:38:44 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FCB532BA8
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 23:38:42 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id d20so6816631ljc.12
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 23:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+OX/giQG0JpVo/NBsHgV87sgp361wbPnuLuWRkMeULs=;
        b=J3lsKMcD7uIsM0UFE0MSJQWf16+ukS9uM0wZM1DFKInoWE8WOV/SoNyfAO1y0zbhsM
         IxlyILDMtahH1jkjr9QjEEstFcG+NgbaSQ/hekIK0GwBes3Ox5T5reMcFlUT1DOee2SP
         fbIp/h2LBBr+UAWTxCu5FTcfuHiYpI599DpHn1yrDEnaHfgBoBjhwKBjpCwKVRQogqCk
         EAc1O965NYdNsXK88aI2GBLHWq6q/cE4S11aNny+wryoD8rSB4mKJeZgWbxKjI+ylLSn
         3/tZ763CzMMo628XPlmSbev1vj3tjPn5umBbC94nZRF/ecTLISQEhGTWc1l1F5IKusUq
         vE6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+OX/giQG0JpVo/NBsHgV87sgp361wbPnuLuWRkMeULs=;
        b=O1Mstzy0cDNUtzQ95bm+DLqHZe7fSlE4G7DJSCl2EMZZpEwtETm16ea729vt/gS2lp
         ZmXaFA9mAoCtV4vdb3jE2U6Kv0gOOkqD5pxvB0VafiqUVuf0eovedPwGx1y9LeRl2i/V
         P3S72GJ4fuE7ay4chO3P2omDlWCsJFlFjdsaMkFVPnsrqbl/cpT3pKVFujN+Bsngv/5N
         FBD9B2/LDvS96HG1VVnRPJi+Yz8LccK6C/JxFsmbUdnetvdaD0pjJv3LJQwUc4OJxV2t
         SZEhxgGllRShDIxut3269RJBtOwdLGryg1bCvHpRhE7DIq62bAvwGW95Ud9756TXlIdf
         tEWQ==
X-Gm-Message-State: ANoB5plGNNif5SSdQnp70BhZLmn5jQ0kOaSA4YlgJv3kKSVwliPKHjYT
        yw9odqoWAmJr2y2DK3y/juNT4g==
X-Google-Smtp-Source: AA0mqf7JsNX4MDYLP3mvntvPXJaVl5ZVOr7fFyk+vkdPxd3zNoddNV6phcMz2o7yn2B91qjLeZWedg==
X-Received: by 2002:a2e:94d0:0:b0:26d:a666:6358 with SMTP id r16-20020a2e94d0000000b0026da6666358mr1535671ljh.148.1668238604360;
        Fri, 11 Nov 2022 23:36:44 -0800 (PST)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id q6-20020ac25106000000b0049f53d53235sm740229lfb.50.2022.11.11.23.36.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Nov 2022 23:36:44 -0800 (PST)
Message-ID: <f60d616d-a729-8862-00b5-3a4a62f79f49@linaro.org>
Date:   Sat, 12 Nov 2022 10:36:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 13/22] phy: qcom-qmp-combo: add dedicated DP iomem
 pointers
Content-Language: en-GB
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20221111085643.9478-1-johan+linaro@kernel.org>
 <20221111085643.9478-14-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221111085643.9478-14-johan+linaro@kernel.org>
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

On 11/11/2022 11:56, Johan Hovold wrote:
> In preparation for merging the driver data, add separate iomem pointers
> for the DP part of the PHY.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 246 +++++++++++-----------
>   1 file changed, 126 insertions(+), 120 deletions(-)
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

