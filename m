Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF5EC678CA0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 01:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjAXAKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 19:10:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232049AbjAXAKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 19:10:40 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0784F2BF16
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 16:10:21 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id v10so16559614edi.8
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 16:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h9InQuEAasegQPkXBmgOapwHP1eVXkQE74+WMtrPDbE=;
        b=n0d5aadnK5xFzNiAbzjpBW8R1l0Un59NvTRG1eyLJUD+LelcC2fwacIAV96lEkWBng
         Ps5AnB7P+ZA+bzI3isUuTldYxb01kM2SeJefXkRc5ssrGT4R9OXGYoxSKsbTS8D4pta7
         wtvI4p+bqWII0vVZ7zavVgtRpraGMypz2tTS93WQ3zeuvNqAGMF7COloHZcH7q70R/a4
         hIaeKldWuvTI9SnefBEOjGw7EbRJTDKTBUo1ZLQ46vY9UTLpnzBU/3kij/7qOMxmprZT
         aOrYwPfkcyC/NzHQw9Jgw165COyiMcz+PvptiyEmRnqVxfkh7gHBeYLe8UaznEO3Wunm
         mqEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h9InQuEAasegQPkXBmgOapwHP1eVXkQE74+WMtrPDbE=;
        b=wPoojkWeMRQUfUesOejrflzktqRomF4coKuA7cZjgB8ydiqi2Is9W0QtTMXs0Chv9/
         xIYsMo0A927pwU6s9zCVjWGQouEw8U+kH98++fx3lFKNA88mEL8KmZvQ1JfF03p+SeZi
         HmKfJ1SqSw9c3/EEQNk//BPPHqCeaMnnP53e9CNPEog60Mq9HPRZzgjgQWHSAOKIVnAl
         c0GIhLutsD2CqdigCdatGmxghBEP+gIiR0dsFaeULpnFlWMneezZSYdIHZy2qfkbDFY9
         dK61+zMRwC8j2xAKoYdVEyGO8di9EbPQ3V56dqq6aX9dvWNE0UBPdO9dY20iRK8p15ir
         JqSg==
X-Gm-Message-State: AFqh2krsdHts1sBwZYCoMLJ4pWYzSjOwAyKqLl8f2sVafSmugPZ+hd9r
        MzFwbzA743CDJ56aCwSaZ3TFnw==
X-Google-Smtp-Source: AMrXdXtXulxVSbBQgMkYnJtdz0QccnWBdhLLidrfMwJJJJGe2vfdHo5UH5h1VYj1vWYqVX0iOXDijA==
X-Received: by 2002:a05:6402:493:b0:46d:53d7:d21e with SMTP id k19-20020a056402049300b0046d53d7d21emr26582675edv.27.1674519019241;
        Mon, 23 Jan 2023 16:10:19 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id d29-20020a50cd5d000000b0049e19136c22sm330354edj.95.2023.01.23.16.10.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 16:10:18 -0800 (PST)
Message-ID: <47c83e8c-09f1-d1dd-ca79-574122638256@linaro.org>
Date:   Tue, 24 Jan 2023 02:10:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v1 00/14] add display port DSC feature
Content-Language: en-GB
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@gmail.com,
        agross@kernel.org, andersson@kernel.org
Cc:     quic_abhinavk@quicinc.com, quic_sbillaka@quicinc.com,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1674498274-6010-1-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1674498274-6010-1-git-send-email-quic_khsieh@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/01/2023 20:24, Kuogee Hsieh wrote:
> This patch add DSC related supporting functions into to both dp controller and dpu enccoder
> 
> Kuogee Hsieh (14):
>    drm/msm/dp: add dpcd read of both dsc and fec capability
>    drm/msm/dp: add dsc factor into calculation of supported bpp
>    drm/msm/dp: add configure mainlink_levels base on lane number
>    drm/msm/dp: correct configure Colorimetry Indicator Field at MISC0
>    drm/msm/dp: upgrade tu calculation base on newest algorithm
>    drm/msm/dp: add display compression related struct
>    drm/msm/dp: add dsc helper functions
>    drm/msm/dp: add dsc supporting functions to DP controller
>    drm/msm/dsi: export struct msm_compression_info to dpu encoder
>    drm/msm/disp/dpu: add supports of DSC encoder v1.2 engine
>    drm/msm/disp/dpu1: add supports of new flush mechanism
>    drm/msm/disp/dpu1: revise timing engine programming to work for DSC
>    drm/msm/disp/dpu1: add dsc supporting functions to dpu encoder
>    drm/msm/disp/dpu1: add sc7280 dsc block and sub block

Some generic notes regarding the series. I understand that the the 
series is complex, but following points might ease both your work and 
the review proces.

First, atomicity. If your commit message says 'do this and that', it is 
highly likely that the patch should be split into smaller parts.

Second, please pay attention to the history. If some part of the code or 
  the data structure was removed, you have to justify bringing it back. 
This is extremely important in your case, as significant parts of the 
code come from the vendor code, thut it is easy to step on the same rake 
again. And if the previous removal was incorrect, please describe why.

If we went through 10 revisions of a patch a year ago, it's not worth 
sending again a patch that closely remedies one of early iterations. It 
doesn't stand a chance of getting through.

Next. Obvious item. ./scripts/checkpatch.pl should be your friend. It is 
not.

Last, but not least. Please follow the mailing list. Less than a week 
ago one of reviews pointed out that commit messages like 'this patch 
does this and that' are not really welcomed. By sending the same kind of 
commit messages, you stand a high chance of receiveing the same 
response. Please go through the recommendations in 
Documentation/process/submitting-patches.rst.

> 
>   drivers/gpu/drm/msm/Makefile                       |   2 +
>   drivers/gpu/drm/msm/disp/dpu1/dpu_dsc_helper.c     | 537 +++++++++++++
>   drivers/gpu/drm/msm/disp/dpu1/dpu_dsc_helper.h     |  25 +
>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c        | 341 +++++++--
>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h        |   4 +-
>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h   |   7 +-
>   .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c   |  43 +-
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c     |  50 +-
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h     |  74 +-
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c         |  43 +-
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h         |  21 +
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.c         |  23 +-
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.h         |  23 +-
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc_1_2.c     | 371 +++++++++
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c        | 132 ++--
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h        |  10 +-
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.h    |   3 +
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_top.h         |   6 +-
>   drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c            |  10 +-
>   drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c             |  10 +-
>   drivers/gpu/drm/msm/dp/dp_catalog.c                | 176 ++++-
>   drivers/gpu/drm/msm/dp/dp_catalog.h                |  97 ++-
>   drivers/gpu/drm/msm/dp/dp_ctrl.c                   | 839 ++++++++++++++-------
>   drivers/gpu/drm/msm/dp/dp_display.c                |  61 +-
>   drivers/gpu/drm/msm/dp/dp_link.c                   |  29 +-
>   drivers/gpu/drm/msm/dp/dp_panel.c                  | 749 +++++++++++++++++-
>   drivers/gpu/drm/msm/dp/dp_panel.h                  |  67 +-
>   drivers/gpu/drm/msm/dp/dp_reg.h                    |  40 +-
>   drivers/gpu/drm/msm/dsi/dsi.c                      |   3 +-
>   drivers/gpu/drm/msm/dsi/dsi.h                      |   3 +-
>   drivers/gpu/drm/msm/dsi/dsi_host.c                 |  14 +-
>   drivers/gpu/drm/msm/msm_drv.h                      | 113 ++-
>   32 files changed, 3429 insertions(+), 497 deletions(-)
>   create mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_dsc_helper.c
>   create mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_dsc_helper.h
>   create mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc_1_2.c
> 

-- 
With best wishes
Dmitry

