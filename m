Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 887D16FB17B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 15:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234055AbjEHN2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 09:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234061AbjEHN2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 09:28:12 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D80E2BCDF
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 06:27:52 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4f13bfe257aso5078064e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 06:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683552468; x=1686144468;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r+TBigWM2ehipDbkRUdAuCgzID6oBks8XaTBJDdkWFc=;
        b=hTWTo7imOys4AFS87cJGEfMIEpOPXd14uhIiXwOPXLeclA6p9XMDcbEasRbbdZPaEV
         R3aola0CtD9H550QWPPCXOHELxXgmpHin+WlAzlo6mosVOskSksL3/smUcDW18/3ztQk
         cVySGYoIE15GscAZgT/wJfZwuSl+i2kAKi+rJRea7d40F6wlkhZY0r5JVtmRjLaogpPI
         Xt9hXit6KOva2ndrVoD0ptwRzyx7hBvcz/UXpkIHRUtLyxv8VMJsFiPDyNCJIAY68X1r
         gKhQr9jveLvMtvxMrRrRjuZDyUm9rrIYYvddGedDwibG6BpJFY39zRR6yQsjhBzVbujY
         c0VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683552468; x=1686144468;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r+TBigWM2ehipDbkRUdAuCgzID6oBks8XaTBJDdkWFc=;
        b=K70+VqhPVhrCxsCIcOeAYh25XT6KI77LnsKzWmQsgmpzeEdZDaR1vNYOpT1btOIofW
         rt/aUMmRk2m91kJ+oIO4MenghJnZnbzg3FkuM4wyxIZMpdSU3hmv1HMeWV8gnbSsk2oo
         uzDNGjKCDODFxZVxIafJBy6GnnwPVOWX+wkNDebK8EGktFJcGf+Ytg+Vonsm5yAKsxu+
         VPueG4xmY1rc5KehaEtePaamzQdLnk+2N6Uy4fNigCsImRrtmSMnv+bG6Es9ebag2WiG
         pxWN/JeiyhD6+AwFSx9GkGiEmVkDSWfiE3lLLoJ47XorrDhjuKRKzn9TgoCIAOX4mZ3Y
         A/lA==
X-Gm-Message-State: AC+VfDwH9IuT+z5GmY0h/og41FgEPoQG8yqhzT8wbR2dbrEPuqNQnqF6
        xQrbtWDkyESzUTr4maUDKjMc0g==
X-Google-Smtp-Source: ACHHUZ6tSkDWh0vYddQ9hk5i8imyUIVF7oZz7m751SD3qNwFBLPxX7uzZ9yTb7bZHmVRYVKPW0RiCQ==
X-Received: by 2002:a05:6512:38d1:b0:4f1:4468:ee65 with SMTP id p17-20020a05651238d100b004f14468ee65mr2639843lft.30.1683552468354;
        Mon, 08 May 2023 06:27:48 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id 19-20020ac24833000000b004f0049433adsm1294617lft.307.2023.05.08.06.27.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 06:27:47 -0700 (PDT)
Message-ID: <a4f72011-5505-77c2-da3c-dd4e22a4f8d8@linaro.org>
Date:   Mon, 8 May 2023 16:27:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 2/6] thermal: qcom: tsens-v0_1: Fix mdm9607 slope
 values
Content-Language: en-GB
To:     Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20230508-msm8909-tsens-v4-0-d9119622cb19@kernkonzept.com>
 <20230508-msm8909-tsens-v4-2-d9119622cb19@kernkonzept.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230508-msm8909-tsens-v4-2-d9119622cb19@kernkonzept.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/05/2023 16:13, Stephan Gerhold wrote:
> According to the msm-3.18 vendor kernel from Qualcomm [1], mdm9607 uses
> a non-standard slope value of 3000 (instead of 3200) for all sensors.
> Fill it properly similar to the 8939 code added recently.
> 
> [1]: https://git.codelinaro.org/clo/la/kernel/msm-3.18/-/blob/LE.UM.4.3.2.r1-04200-9x07/arch/arm/boot/dts/qcom/mdm9607.dtsi#L875
> 
> Fixes: a2149ab815fc ("thermal/drivers/qcom/tsens-v0_1: Add support for MDM9607")
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
> ---
>   drivers/thermal/qcom/tsens-v0_1.c | 24 +++++++++++++++++-------
>   1 file changed, 17 insertions(+), 7 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

