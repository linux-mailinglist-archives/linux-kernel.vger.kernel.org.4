Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 701E86FB1CF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 15:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233424AbjEHNjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 09:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233718AbjEHNix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 09:38:53 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0D435D85
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 06:38:24 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f14f266b72so2803292e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 06:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683553101; x=1686145101;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bpiJVQGtmpGeWD2h/OMRu+hOxlvzEgfNUk4kR+fQklM=;
        b=NEuSP0poH2UiHRVG40dJJ4LXsnXZlFCsZcnO/BX0gHe4yzvPFLgprRqA66QRM/htDH
         6uBdz93p+fpE0arzyrOtJBscIpndpWhnofCtn0odmegQDHP0rG+ea8UqvE2TfAascGwl
         Uuv3WCwC2Wgal1TQ72/IFUS+mLZlPoF+qWFMICwbIyDYLdd1VhsuRorBbdZ0lu7ndv0v
         r5Z/PtDT/SdrQ8iAG4rrwZ2SxWbtqDvIB7abaed96DDZy9Q/JK/nBUpvuBpSrqISvDeE
         uDaMhnQ/ObMNcsSa353K0ApMxwjm5CkSDJ2J8a5f8TPDHKp+AMJSPaBeijNvLEs+JLLY
         FlHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683553101; x=1686145101;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bpiJVQGtmpGeWD2h/OMRu+hOxlvzEgfNUk4kR+fQklM=;
        b=j4AlEafMEf7MqDnTwUvbCbsqliTqBOLtAjnEclEBg8QGl1V3Ro83Sav37zVxBviarr
         BBZMdzv4vcGErByOwox14S5BuGiRab+3U9UisflamBFcVAdjdRCuIykmOqufyvcQ3dfH
         52rwkO3KB6hJd+Cagh1QZ37SJ+DynUjIx2i7lKzV5pbv69n0voEqtTUTMRemBaIOM+dh
         kFwwYsL2ZmmNNsMpJRg0QgXC3KRu9BOkjdUTs1Z74Mw1d0gKJS6Bm+/8j1U2iVJTSmUV
         a9jqOtwXsiCvS2WxUGeon0V2TiW7KELZBsxFjCD2HMKfNztcijHurS2yyhGgqOYE7coN
         TfpQ==
X-Gm-Message-State: AC+VfDyiFxFtWH8KBDVVWo6YfQWAuiEFqtfXReSJM377BdPXXq98KU2s
        QJA1FikktiXUjOlHF0b891c1lA==
X-Google-Smtp-Source: ACHHUZ5wavKYuce/KoPJbJp3bMQJZiYfuiKtwh04eQeDJR+b96oQL05KrCL64PAvYEEcz2+pphAc5Q==
X-Received: by 2002:a2e:9cd6:0:b0:2ac:d51f:2d60 with SMTP id g22-20020a2e9cd6000000b002acd51f2d60mr1961110ljj.33.1683553100680;
        Mon, 08 May 2023 06:38:20 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id h22-20020a2eb0f6000000b002ad8bccceb2sm726381ljl.57.2023.05.08.06.38.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 06:38:20 -0700 (PDT)
Message-ID: <ab9c0681-64b1-8bdd-ba9c-bf87a2edefef@linaro.org>
Date:   Mon, 8 May 2023 16:38:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 3/6] thermal: qcom: tsens-v0_1: Add mdm9607 correction
 offsets
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
 <20230508-msm8909-tsens-v4-3-d9119622cb19@kernkonzept.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230508-msm8909-tsens-v4-3-d9119622cb19@kernkonzept.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/05/2023 16:13, Stephan Gerhold wrote:
> According to the msm-3.18 vendor kernel from Qualcomm, mdm9607 needs
> "correction factors" to adjust for additional offsets observed after the
> factory calibration values in the fuses [1, 2].
> 
> The fixed offsets should be applied unless there is a special
> calibration mode value that indicates that no offsets are needed [3].
> 
> Note that the new calibration mode values are called differently in this
> patch compared to the vendor kernel:
>    - TSENS_TWO_POINT_CALIB_N_WA        -> ONE_PT_CALIB2_NO_OFFSET
>    - TSENS_TWO_POINT_CALIB_N_OFFSET_WA -> TWO_PT_CALIB_NO_OFFSET
> This is because close inspection of the calibration function [3] reveals
> that TSENS_TWO_POINT_CALIB_N_WA is actually a "one point" calibration
> because the if statements skip all "point2" related code for it.

Indeed.

> 
> [1]: https://git.codelinaro.org/clo/la/kernel/msm-3.18/-/commit/d9d2db1b82bf3f72f5de0803d55e6849eb5b671e
> [2]: https://git.codelinaro.org/clo/la/kernel/msm-3.18/-/commit/d75aef53a760e8ff7bac54049d00c8b2ee1b193e
> [3]: https://git.codelinaro.org/clo/la/kernel/msm-3.18/-/blob/LE.UM.4.3.2.r1-04200-9x07/drivers/thermal/msm-tsens.c#L2987-3136
> 
> Fixes: a2149ab815fc ("thermal/drivers/qcom/tsens-v0_1: Add support for MDM9607")
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
> ---
>   drivers/thermal/qcom/tsens-v0_1.c | 11 +++++++++++
>   drivers/thermal/qcom/tsens.c      | 16 +++++++++++++++-
>   drivers/thermal/qcom/tsens.h      |  4 ++++
>   3 files changed, 30 insertions(+), 1 deletion(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> 
> diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
> index 1b454de3928d..e69889dd524a 100644
> --- a/drivers/thermal/qcom/tsens-v0_1.c
> +++ b/drivers/thermal/qcom/tsens-v0_1.c
> @@ -229,6 +229,17 @@ static int __init init_9607(struct tsens_priv *priv)
>   	for (i = 0; i < priv->num_sensors; ++i)
>   		priv->sensor[i].slope = 3000;
>   
> +	priv->sensor[0].p1_calib_offset = 1;
> +	priv->sensor[0].p2_calib_offset = 1;
> +	priv->sensor[1].p1_calib_offset = -4;
> +	priv->sensor[1].p2_calib_offset = -2;
> +	priv->sensor[2].p1_calib_offset = 4;
> +	priv->sensor[2].p2_calib_offset = 8;
> +	priv->sensor[3].p1_calib_offset = -3;
> +	priv->sensor[3].p2_calib_offset = -5;
> +	priv->sensor[4].p1_calib_offset = -4;
> +	priv->sensor[4].p2_calib_offset = -4;
> +
>   	return init_common(priv);
>   }

I should check if using these offsets would allow us to drop the custom 
code for 8974.

-- 
With best wishes
Dmitry

