Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBE046945EF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 13:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbjBMMfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 07:35:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjBMMfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 07:35:40 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E811ABEB
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 04:35:33 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id hx15so31413824ejc.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 04:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g6etP0PHoEzmwkAwU1sWyc/fLmfc1gwqL6wt4gHzdmw=;
        b=hnv0aANWv0LshJQhx6NxJdjMa9idzF2ChBnJpk4z4R8hie6sV8ZbP6dbf9ZIetFPYL
         7+21H4Ja7Kziwvjl7VrH3kNQxctWTHHf6OfVJJzWVOyWEMhlSCCTa2wfzjqHn1WtOfco
         /65cXuNQ29DgfUdbg2q7jJG/mInbyOAX9OIkUkWqu1ot08iOIzNTa9Vaos2j5ptJcGww
         Db0Z9soV9OGsUn8RIYthoo9d1Qj5EH5xO8JAqqHm647HGf2jUqtfosYyh0evnFO5cOzG
         +VrpB1B2iaiUatlxDG9tCiGOgGNxy0b78QGkBRSclusVBTs3vQqDv+M2cRT1ZxTBoExb
         kYCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g6etP0PHoEzmwkAwU1sWyc/fLmfc1gwqL6wt4gHzdmw=;
        b=pKUEybYH4P57oueT/aE3BUIfVo7OdMCMXDgA1Cao5I0jB/+g/Daac9YtEgO+yB6sXu
         oiBmJlkMmdj+hlppnKzOlNTrZghRxqwNmb5YLlZrODvQEVArpbdAuE/TU+9FKlTdLMN3
         8ckN0z5nWplRPlV8qb7k8mrNoaCsX5zjb7LHNocWwW1rDUveZg0zl47FtR86jNlPiOUn
         MUFini5HEEzGYxsrMTohHkUkCFp7lCz290Q/K9ite7OoV2z6jWCXG3kxmw07L8tHObPO
         qo7LSJAD5fB4OBPTD/PtXBJr/npRfcLnLrcrJ76zggx2SxaF8VP8gSMNvF7vS8TgUvmO
         1cJw==
X-Gm-Message-State: AO0yUKU6pEM3MFNin91+/q9cyPPmlBZO/TDxX5ZGc/jkh4LKqavGIEkg
        hoEFxRzfyCsf+2udGYraFGY4Rw==
X-Google-Smtp-Source: AK7set/a4QxyKqE9KlCKpOjOcecOb57gmOGMtMJ0rcHamtTPFjtjef7xpvmMt4Hd8ptxbq3EdiB6DQ==
X-Received: by 2002:a17:906:5d9:b0:878:45e9:6f96 with SMTP id t25-20020a17090605d900b0087845e96f96mr24442385ejt.49.1676291732123;
        Mon, 13 Feb 2023 04:35:32 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id n5-20020a17090673c500b0088aadc18b69sm6747375ejl.101.2023.02.13.04.35.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 04:35:31 -0800 (PST)
Message-ID: <8b8f61ea-8419-c4b5-0434-276d13fe3e39@linaro.org>
Date:   Mon, 13 Feb 2023 14:35:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 3/9] drm/msm/dsi: Fix DSI index detection when version
 clash occurs
Content-Language: en-GB
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Douglas Anderson <dianders@chromium.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20230213121012.1768296-1-konrad.dybcio@linaro.org>
 <20230213121012.1768296-4-konrad.dybcio@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230213121012.1768296-4-konrad.dybcio@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/02/2023 14:10, Konrad Dybcio wrote:
> Currently, we allow for MAX_DSI entries in io_start to facilitate for
> MAX_DSI number of DSI hosts at different addresses. The configuration
> is matched against the DSI CTRL hardware revision read back from the
> component. We need a way to resolve situations where multiple SoCs
> with different register maps may use the same version of DSI CTRL. In
> preparation to do so, make msm_dsi_config a 2d array where each entry
> represents a set of configurations adequate for a given SoC.
> 
> This is totally fine to do, as the only differentiating factors
> between same-version-different-SoCs configurations are the number of
> DSI hosts (1 or 2, at least as of today) and the set of base registers.
> The regulator setup is the same, because the DSI hardware is the same,
> regardless of the SoC it was implemented in.
> 
> In addition to that, update the matching logic such that it will loop
> over VARIANTS_MAX variants, making sure they are all taken into account.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   drivers/gpu/drm/msm/dsi/dsi_cfg.c  | 52 ++++++++++++++++++++++--------
>   drivers/gpu/drm/msm/dsi/dsi_cfg.h  |  5 ++-
>   drivers/gpu/drm/msm/dsi/dsi_host.c | 10 +++---
>   3 files changed, 48 insertions(+), 19 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

