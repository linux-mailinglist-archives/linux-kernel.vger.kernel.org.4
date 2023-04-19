Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D97846E8527
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 00:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232814AbjDSWo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 18:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233238AbjDSWou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 18:44:50 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A71137EFD
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 15:44:22 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id h2so635933ljh.13
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 15:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681944257; x=1684536257;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=68AGYlQ6GL8Id5Bj4tL7yDrVLE8ybeIun+9u5kU+miQ=;
        b=AuJGpMUOVAQOas5/SHMGxpKJcNNyvH/8/DGB4GOdlhRuz3ng/gqEoRM3F7swrDihem
         eXOlQETCn6QnA2uxFSIwrpTiAWfQHbbr97vsz1boBXQ0Rh0Wshk+eymQb8YeXLZXlG7R
         1DpGX73qgRRuWG/Y0n8tJMVP2SXrqm48yVPpyKphTETiyhpPsDPMkmNfyHSimY0QGLZp
         50RR7ZeucUIuydE8cPj7rX44tIzkeG9Y15tMAHBeb+TegduwQ+se/6iEYcJxCRQg1QYg
         K6PJ44fIBj02qWGdZsGYKEXNfTd+QC1y+I17c++8xZGEe2fJ/A4I37fxwo5oWYeuZFMf
         fTmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681944257; x=1684536257;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=68AGYlQ6GL8Id5Bj4tL7yDrVLE8ybeIun+9u5kU+miQ=;
        b=iI9sbj/RAFgV7efkrIsqj8c3DqSTufcnoQ/aePxLkvcWTLgku1fNS9woPFJqtuFhjI
         feTDW7osZdKZzPmau9sHWzk/gwmohedOF7BwbKtielO0hbuHXWehsvqewAeIFmT/nQEI
         Sw+InSJP4Cbgu4Jn0ML36kuTVDWF6klsDkgUaYlOlIq/DluLXGI0/lAynBbhr5nUbsrr
         dtHcms9qdrtXqXQETGzcdHNomqeB1eYyfMvkqbAL4YTqp/AYdd0w5zGNdScPKMW/MqU6
         Y+D9gH0WFuRj3b3PNU1PyBZrJgReDBS6yF2YP11oXRa75E1t1oKo+oa7zgzjzr2O9qG+
         hBDg==
X-Gm-Message-State: AAQBX9fZLfRd+rxoTF9WoA143teKuyL0mW25JmSt1y8VxOXepK4a/TFW
        iX1PAM7nOMl7T4eMWrhRyQgLRJGyxgrdWsVtKlk=
X-Google-Smtp-Source: AKy350avbp+i25TM39CqKnZY8u0sm8EAdwviMJHLgiIsLvF9GUSyWmmhSvBhulbBO5XNdIRakeTwgg==
X-Received: by 2002:a2e:8049:0:b0:2a7:730d:a7c2 with SMTP id p9-20020a2e8049000000b002a7730da7c2mr2477442ljg.46.1681944256801;
        Wed, 19 Apr 2023 15:44:16 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id n13-20020a2e82cd000000b002a8aadcf15bsm2688424ljh.120.2023.04.19.15.44.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 15:44:16 -0700 (PDT)
Message-ID: <dbc1036e-c850-1d68-1161-1a353416b3e2@linaro.org>
Date:   Thu, 20 Apr 2023 01:44:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 05/11] drm/msm/dpu: allow using all lm mixer stages
Content-Language: en-GB
To:     Arnaud Vrac <avrac@freebox.fr>, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230419-dpu-tweaks-v1-0-d1bac46db075@freebox.fr>
 <20230419-dpu-tweaks-v1-5-d1bac46db075@freebox.fr>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230419-dpu-tweaks-v1-5-d1bac46db075@freebox.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/04/2023 17:41, Arnaud Vrac wrote:
> The max_mixer_blendstages hw catalog property represents the number of
> planes that can be blended by the lm mixer, excluding the base stage, so
> adjust the check for the number of currently assigned planes accordingly.
> 
> Signed-off-by: Arnaud Vrac <avrac@freebox.fr>
> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

