Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF1771493D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 14:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbjE2MQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 08:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbjE2MQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 08:16:29 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A0BFD
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 05:15:56 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2af2c7f2883so33528341fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 05:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685362554; x=1687954554;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4R+IfYo+E0SCCMD1zQpk0fCdlACgecdJiT+kGuqtiLg=;
        b=StPnAtUCsV6F1TvbGaGOO5K8T4D+osbaUPE84n7vpIgQLPOhWXmf2VSZHgGNsNizeP
         2b//hXbvsBdFFopE3FaEoZmmlb8QaYwAAB3lveJLIfFDuxdPAxICRVzi4zNiAJAJ+4S2
         ntcAgJWM07if4qmkSAuwZq9p8oZevZiorWXn+5R3W/stB3qWFsZ3XGchwnXBHZLoZ6qb
         DPXsVukBjItob1hHw0Gbl7M46z/FJeEFdHMWAsoorGjRbkS6Al3sajuxbFIoqIodI7+4
         qthetIQvflWchqqtCpp2gL0iAZTympVPgELG9DDU8qXqZdhqgsCgig/dPjeu3XSzPtF1
         UtXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685362554; x=1687954554;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4R+IfYo+E0SCCMD1zQpk0fCdlACgecdJiT+kGuqtiLg=;
        b=BZ2VcBe6DZY5/TI2wFifHji+4tVM486sD/82+XDRqCSv3NihPiybtKz3OBr8CRrEw1
         +5Uctc1J9abE5nQH5DrxFrSMCVajz1bAtIjOaEmOSF1ddX28I31wVOfD/DXxE0MzU3LQ
         ZZkvD3GO1ZNWMFXnPrUT8fQ2ZCjukLU34DjToSWSdcyl43KtwQxkhu1rSeozJHa+Wi4W
         LtCSV+oB+FixNU8/aLGGdKeC2mjWzJVaduf6gkv3SmyMaj+7OXUBY5NFrj4H+7HQy37T
         JuPIWovGvEd3zoKGWgQtQbNJEqZQ6oQKBeG8uX6Er9pgEp6K01QjZxxdaNxCzyUNOdQD
         /WCg==
X-Gm-Message-State: AC+VfDyNtsQMVLhdM5spzRq1lYeB9hLZKQhwr929NIlUHO49Y3/MKlOu
        NeJjMpkRltV28m0C1Q5ObOw8DQ==
X-Google-Smtp-Source: ACHHUZ6aG6I3AHLtXeZR7Ibl3hYkDkhoUmq/6kFzkMFcm1XAR4QkvNx7jyhrqwijGbSD0P1l5QeOCw==
X-Received: by 2002:ac2:5204:0:b0:4f3:bb84:a780 with SMTP id a4-20020ac25204000000b004f3bb84a780mr3686586lfl.23.1685362554501;
        Mon, 29 May 2023 05:15:54 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id s9-20020a19ad49000000b004edc55d3900sm1974509lfd.0.2023.05.29.05.15.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 May 2023 05:15:53 -0700 (PDT)
Message-ID: <35662a02-a06d-017a-56bd-9e328fc0ae39@linaro.org>
Date:   Mon, 29 May 2023 15:15:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 5/7] drm/msm/dsi: Add configuration for MSM8226
Content-Language: en-GB
To:     Luca Weiss <luca@z3ntu.xyz>, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230308-msm8226-mdp-v1-0-679f335d3d5b@z3ntu.xyz>
 <20230308-msm8226-mdp-v1-5-679f335d3d5b@z3ntu.xyz>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230308-msm8226-mdp-v1-5-679f335d3d5b@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/05/2023 12:44, Luca Weiss wrote:
> Add the config for the v1.0.2 DSI found on MSM8226. We can reuse
> existing bits from other revisions that are identical for v1.0.2.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
>   drivers/gpu/drm/msm/dsi/dsi_cfg.c | 2 ++
>   drivers/gpu/drm/msm/dsi/dsi_cfg.h | 1 +
>   2 files changed, 3 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

