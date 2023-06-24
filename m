Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC01073CB1B
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 15:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233000AbjFXNss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 09:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbjFXNsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 09:48:46 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364721FCE
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 06:48:45 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4f954d7309fso2026776e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 06:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687614523; x=1690206523;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d9YJLCIpYToQE57X7+5G5EtcnZ1RMPAgUeTIP11pd3U=;
        b=yHPJtC7Mp2cKx/Prulu7JGSmBR2bUP0DTFHIsXsdA5OrKiie2bdUh3DlzVcyickWop
         BrP9M9h3zu3fXX2393zawF/mVYsSPomYUzmEnxwy5CSLSa35xCek3z8sovdA7k1cyaSt
         95R8yiJ7phSb/skwB+BYeVTtus5kcH38LmZzGscMFWb0KIdWXrEDKZZOgr1LrVMCqqx0
         nhGTvmDPk4L+zv4yxSbzGg1OrVpAS2waKKVPVwSeXe6PCUhzZ1TU6zWgoC5NrutHz4yg
         5cpEvcNJVmDF2o+6GEjdfvsfarw2HIj7vS0HsSoTWELYkjYX7QwiXrvVsQ9GPsW8VTtO
         B4sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687614523; x=1690206523;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d9YJLCIpYToQE57X7+5G5EtcnZ1RMPAgUeTIP11pd3U=;
        b=fcfC84bJkGJWeY+PnLMw1DqPdoAGsQf+XOcyxJC3K3dnc7KdgB2ezB7b/Rgi8t39wT
         OszMlZo5trXoaaJ16MZi9h/UN8E4FJpKqTgKOaWoHFk+uyhNqGvq0jtADZeCaP/XiiEz
         8T0AMXpUP8rd0hsudbNMi2QT7YZF9oj0ZzzyYC+l7MidZpAGVicUSzWKPCioxrUI5pZs
         E9KUWuKgxLhxnsvBusRP9TgTKmfUHtzOESm98xPqM+wagUhcwhwwsRuCsEiSls8glzeM
         RgDY6QKKdmo6Mm71aPBVzE3QzbCCu70F6efN/fL0z9LNuZkfSTNATod42eKOJ+OHzeTw
         KlfA==
X-Gm-Message-State: AC+VfDynHi82uOlh5CRUVjtxsgyLu7lExVMtZcNftZBEw2qWAdDHf4Xw
        TOG9wvidH/yB+TB3Z5FYHz2F3OfsLdWNT2xpFkg=
X-Google-Smtp-Source: ACHHUZ42jKtX7W+P46oaiEZR1+/HWcRGkV+LXkEy7ADI+/OMe3SZiS9nVNJQHkJyEVtg3yvpJlSVwg==
X-Received: by 2002:a19:5007:0:b0:4f8:52a8:d123 with SMTP id e7-20020a195007000000b004f852a8d123mr8242945lfb.12.1687614523211;
        Sat, 24 Jun 2023 06:48:43 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id x11-20020ac259cb000000b004f873e3282asm284858lfn.63.2023.06.24.06.48.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jun 2023 06:48:42 -0700 (PDT)
Message-ID: <1b40b16e-025a-c10b-e99b-404246de73fe@linaro.org>
Date:   Sat, 24 Jun 2023 16:48:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 10/15] dt-bindings: msm: dsi-phy-14nm: Document SM6125
 variant
Content-Language: en-GB
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, Lux Aliaga <they@mint.lgbt>
References: <20230624-sm6125-dpu-v1-0-1d5a638cebf2@somainline.org>
 <20230624-sm6125-dpu-v1-10-1d5a638cebf2@somainline.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230624-sm6125-dpu-v1-10-1d5a638cebf2@somainline.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/06/2023 03:41, Marijn Suijten wrote:
> Document availability of the 14nm DSI PHY on SM6125.
> 
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
>   Documentation/devicetree/bindings/display/msm/dsi-phy-14nm.yaml | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/dsi-phy-14nm.yaml b/Documentation/devicetree/bindings/display/msm/dsi-phy-14nm.yaml
> index a43e11d3b00d..60b590f21138 100644
> --- a/Documentation/devicetree/bindings/display/msm/dsi-phy-14nm.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/dsi-phy-14nm.yaml
> @@ -18,6 +18,7 @@ properties:
>         - qcom,dsi-phy-14nm
>         - qcom,dsi-phy-14nm-2290
>         - qcom,dsi-phy-14nm-660
> +      - qcom,dsi-phy-14nm-6125

Should we start using standard scheme, so "qcom,sm6125-dsi-phy-14nm" ?

>         - qcom,dsi-phy-14nm-8953
-- 
With best wishes
Dmitry

