Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2D7721412
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 04:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjFDCKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 22:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjFDCKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 22:10:01 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5979DD
        for <linux-kernel@vger.kernel.org>; Sat,  3 Jun 2023 19:09:59 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f6255ad8aeso165354e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 03 Jun 2023 19:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685844597; x=1688436597;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V9eSsxUopAOhh02C1XZ5Y2iHb3zpn16hh2Ni/D7tYJk=;
        b=ojlqA7jxB8ljYaLIc3w25f2B0Hz3Rbu6nhF4qLAg0A6Iex8uquzsqsUfwIkL+CAuSZ
         sK6q0+ub8EPNp6MMtDhGwQoiIkgV2O256BdHkzGDpYw2gtvumhg1zD2XDs7tDm6qhgYS
         XHwRhieg4zlvhSO+VU8bAG8LfkOwR8sITNRtC9j3kuMjDlDe/iWcVV69OFOoqSJb/YPy
         4EmmPvVRYYYWlTyW/uxvT9zYNe31Jb1oMPwq/HASwSo4oCdfr1fB+6SfDlyPLLvvv0uU
         9pnOvh77elcWHiI3WhRnWx+GwoOsqezkf0oIbwbKwcWhHP5KVC8vOCQeEONcxZ1qOkpk
         ywBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685844597; x=1688436597;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V9eSsxUopAOhh02C1XZ5Y2iHb3zpn16hh2Ni/D7tYJk=;
        b=FL6anRZmlhI91sxYoj8k4DpaArpRFIcpSdlOXUjinYdvjYUSnveFA7EClbBavshryM
         6JOcBlbrlQM65qqbCr0EafkMPjSJE4r4otYxksW137D0wHSiD6spC2sK2Y2PBrejGM6D
         QiQXGEGOmELXInVGxhZqrPIPPiSIpj+XBG0/poZHHEpEj9iCwabWK1aucwEbwRjWh56i
         GtTNXKoWNQse6ev4Lvj6rmd+vpPdV/5ej0eVd8mG58zzZJ1HDd2NdzKUPVNq4L8elIDd
         A6uCiFzOFt7cVlfFz9XeN6tKm8BKpBJDEfinkfBtBpOfH9NjpiioUeZ/dgOHgjHWzaqh
         7Ezg==
X-Gm-Message-State: AC+VfDyXhj/0DCz5GF7AZExNAspKDdYjIJX6nCDatgwLVpI1WHtqpKHm
        jZVQS0MK0URFmrCIIBH4bDWroA==
X-Google-Smtp-Source: ACHHUZ7VlK4xbclyxPlsscCr4C6Comy8dBU2iSY/G5l/WNa8ffpmH3mxhNOZS+SIEZf7DeEu+xrQtw==
X-Received: by 2002:a2e:3803:0:b0:2b1:c389:c425 with SMTP id f3-20020a2e3803000000b002b1c389c425mr405969lja.25.1685844597625;
        Sat, 03 Jun 2023 19:09:57 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id n5-20020a2e86c5000000b002ac7a715585sm848818ljj.30.2023.06.03.19.09.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Jun 2023 19:09:57 -0700 (PDT)
Message-ID: <07d11141-02f8-6920-9c96-70cbefe6c05b@linaro.org>
Date:   Sun, 4 Jun 2023 05:09:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v14 02/10] drm/msm/dpu: add DSC blocks to the catalog of
 MSM8998 and SC8180X
Content-Language: en-GB
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@gmail.com,
        agross@kernel.org, andersson@kernel.org
Cc:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        quic_jesszhan@quicinc.com, quic_sbillaka@quicinc.com,
        marijn.suijten@somainline.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1685036458-22683-1-git-send-email-quic_khsieh@quicinc.com>
 <1685036458-22683-3-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1685036458-22683-3-git-send-email-quic_khsieh@quicinc.com>
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

On 25/05/2023 20:40, Kuogee Hsieh wrote:
> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> 
> Some platforms have DSC blocks which have not been declared in the catalog.
> Complete DSC 1.1 support for all platforms by adding the missing blocks to
> MSM8998 and SC8180X.
> 
> Changes in v9:
> -- add MSM8998 and SC8180x to commit title
> 
> Changes in v10:
> -- fix grammar at commit text
> 
> Changes in v12:
> -- fix "titil" with "title" at changes in v9
> 
> Changes in v14:
> -- "dsc" tp "DSC" at commit title
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
>   drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h |  7 +++++++
>   drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h | 11 +++++++++++
>   2 files changed, 18 insertions(+)

The sc8180x changes conflict with the patch at [1], which is already 
applied.

[1] https://patchwork.freedesktop.org/patch/531490/

-- 
With best wishes
Dmitry

