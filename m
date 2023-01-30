Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 969E3681349
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 15:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237830AbjA3OcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 09:32:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237783AbjA3Obz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 09:31:55 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D38544BDA
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 06:30:15 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id y1so11256304wru.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 06:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=F66bY08dMNPtmtwYL17v3A+FulNzCrtIG98eK06he9I=;
        b=hgDSa2U0PfGi0F0fcdrmEQqNXHbzzPUStTlWvjDue53tVn3xDxiHoOMBt11mS8RNti
         7vx30tgEha+USbvac0qnIfBBxyOp9cL4lRjmR6T+Ow1MV5V3NHFGZDRWX2CkiuMJFfKF
         jGmAJTKrZmKqBQLrkInuItoFlqJOvdMNT6nxZG5FEvBV/j6dEU6lNrJl445Ueno5SdGB
         FOVmt5zubGdruPQqm6uUW/IfK/m0yW0EGGjNszokE7dHe5g+F+TeZghbAVeNr9WgvfLp
         wYL4FQnYQ1PcA0l9zt4yh0/pgEA9iAuqLVDtKu8B/vQLBkYn+43uvsJYiFB4NEpTYzN7
         FfAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F66bY08dMNPtmtwYL17v3A+FulNzCrtIG98eK06he9I=;
        b=JQUaojJXIEdpdqNw/yLuenGAMYwcQ3FE4XrYaHiUpoq2iHNiPiwNCwSXR6yDYA0yQF
         0QVZmeDm7NwHgdQWfEpFWwxXO3u9UktJoVn1KPTHv+bniqNMEwHred8ODZrYCouEW6Sk
         1ZM2GlNOm66Vts+U3JnSzvLqcvfSKuPH2IBXQ2VlpyEYDlwJx+9wPylzSz47jmBrgYmz
         Y6senYUXfx7NBH+CqqLJIoe2DJx7STqzHhgg21XJX2Lt3m+pLvt9aSlBTaiy5v8+OEPf
         rUeoWCBimXoxDpRjpgCta3I2sK8FzIFQRj9s/TcOxKbImU6yD0yDOIgaei7lqwAsf96E
         ACZA==
X-Gm-Message-State: AFqh2kp9zuvUHaI+pW+20809dxGb+wQcGFcqa9+m3oLf2zQcNKRIsZj4
        +oa1hr2EWpVlhJFT9ec9pC5YYE8ojEZDdKZxGGo=
X-Google-Smtp-Source: AMrXdXtfnj4rstjbSHlIlbiQ0wUlyLEoMF3Nc68wCzRHiud9ME3mAqNrg22eJ69bjTy9NkQX9EkoFA==
X-Received: by 2002:a05:6000:a03:b0:2bd:e7b4:aee3 with SMTP id co3-20020a0560000a0300b002bde7b4aee3mr47550026wrb.66.1675089013427;
        Mon, 30 Jan 2023 06:30:13 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:5f17:219:cb05:7cd? ([2a01:e0a:982:cbb0:5f17:219:cb05:7cd])
        by smtp.gmail.com with ESMTPSA id f28-20020a5d58fc000000b002be5401ef5fsm12477975wrd.39.2023.01.30.06.30.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 06:30:13 -0800 (PST)
Message-ID: <5ace1821-1892-ace5-c230-34200119cc55@linaro.org>
Date:   Mon, 30 Jan 2023 15:30:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v3 4/4] power: supply: Introduce Qualcomm PMIC GLINK power
 supply
Content-Language: en-US
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sre@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>,
        Johan Hovold <johan@kernel.org>
References: <20230130042003.577063-1-quic_bjorande@quicinc.com>
 <20230130042003.577063-5-quic_bjorande@quicinc.com>
Organization: Linaro Developer Services
In-Reply-To: <20230130042003.577063-5-quic_bjorande@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/01/2023 05:20, Bjorn Andersson wrote:
> From: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> The PMIC GLINK service, running on a coprocessor of modern Qualcomm
> platforms, deals with battery charging and fuel gauging, as well as
> reporting status of AC and wireless power supplies.
> 
> As this is just one of the functionalities provided by the PMIC GLINK
> service, this power supply driver is implemented as an auxilirary bus
> driver, spawned by the main "pmic glink" driver when the PMIC GLINK
> service is detected.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Tested-by: Konrad Dybcio <konrad.dybcio@linaro.org> # SM8350 PDX215
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
> 
> Changes since v2:
> - None
> 
>   drivers/power/supply/Kconfig        |    9 +
>   drivers/power/supply/Makefile       |    1 +
>   drivers/power/supply/qcom_battmgr.c | 1421 +++++++++++++++++++++++++++
>   3 files changed, 1431 insertions(+)
>   create mode 100644 drivers/power/supply/qcom_battmgr.c
> 

<snip>


Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Devices doesn't have a battery, but it behaved as expected and values were coherent:
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8550-MTP & SM8450-HDK
