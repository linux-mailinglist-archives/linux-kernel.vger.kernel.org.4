Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B477474BB31
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 03:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbjGHByy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 21:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbjGHByx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 21:54:53 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 235511FEC
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 18:54:51 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b703d7ed3aso41190151fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 18:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688781289; x=1691373289;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=npaEU4Jq+DAwfVt4RBA7ILDlsHaYzhtoNC6VoI1b+k0=;
        b=gPZfaN7wS1UvnJsefZI2XiL3Q1PD5is58lGYunpUxNdO8PPo4qWpmUh/eC4+JWtb9S
         ih0YWQ10owKrZ25fsuouXL1f/P0wuFOLQvd2UuWt8zbKb2ZjSCoi9NM7QY3rOqt3kJl/
         cvQveiw9Mq1lVSrYvYYq0DnDclWNRoa16g48QanJvN4fWzttvpr5kqGdyiUTCLba70uH
         ANznAzqveAcvo9xRQDd9VtlcQphPGkXoofB3pgNU60oP0jeRSq76PDUiFd8AubuDCE1+
         dnRf4EvB9YuwvGUI8t70eiW54Sia4PKsDjbIxivVKgrPgjPclvJuMCfn9K5fC+lsbK6r
         oITQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688781289; x=1691373289;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=npaEU4Jq+DAwfVt4RBA7ILDlsHaYzhtoNC6VoI1b+k0=;
        b=k5EinYtpvWOU2ZYUCQXVqCxLEwVTBQ5cppa5NXfhJFXyAGhHkRZmMqP8Pe9J4Cbk4E
         pgqOn91gSwTJ+YvZ7FV2WSmEoumTkKbhPdlbngeWe7trHnqPKjgymQSAx5ZvXDy08EHR
         R6RS27vU49/yrEm69YWc2r9NyA7lcRI+VGbYX0pm3eKdqOCNg9AIPvhVXLeVoBIfz8BY
         Uaz67owD80mVR/KFmcAOu/adDVNe7WzntdIQ8XwrpUm+THv+Rnohl7y6UPQO0GTc9UO6
         TNtDGL7rqEVDl93k8EzFe4eKjLdnMrVh2lA1J5QexB7hgmkW314i0bQvyAjjx4thGtow
         N+nw==
X-Gm-Message-State: ABy/qLbYezvLWgRZOfHZHKzm60mm7rQ2AqmfHXYyfDEIwDcz/pLYzVQz
        VfsEWvSDLJ8rOmKRtqLt9zl9iQ==
X-Google-Smtp-Source: APBJJlEqEgf+d4ZF9yehdGdjs2x11q0lZlUuW2aPMwV2iNCRMA3/PB8q3uekMYLKJLMYtpFnAXGJRA==
X-Received: by 2002:a2e:8e96:0:b0:2b6:e13f:cfd7 with SMTP id z22-20020a2e8e96000000b002b6e13fcfd7mr1075227ljk.4.1688781289298;
        Fri, 07 Jul 2023 18:54:49 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id m15-20020a2e97cf000000b002b6e13fcedcsm1011031ljj.122.2023.07.07.18.54.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jul 2023 18:54:48 -0700 (PDT)
Message-ID: <c6347aed-4beb-078a-2d42-bf2ad335f45e@linaro.org>
Date:   Sat, 8 Jul 2023 04:54:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v5 5/6] drm/msm/dpu: Refactor printing of main blocks in
 device core dump
Content-Language: en-GB
To:     Ryan McCann <quic_rmccann@quicinc.com>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Rob Clark <robdclark@chromium.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, quic_jesszhan@quicinc.com
References: <20230622-devcoredump_patch-v5-0-67e8b66c4723@quicinc.com>
 <20230622-devcoredump_patch-v5-5-67e8b66c4723@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230622-devcoredump_patch-v5-5-67e8b66c4723@quicinc.com>
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

On 08/07/2023 04:24, Ryan McCann wrote:
> Currently, the names of main blocks are hardcoded into the
> msm_disp_snapshot_add_block function rather than using the name that
> already exists in the catalog. Change this to take the name directly from
> the catalog instead of hardcoding it.
> 
> Signed-off-by: Ryan McCann <quic_rmccann@quicinc.com>
> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

