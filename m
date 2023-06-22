Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6EB73AD8C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 01:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjFVX7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 19:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbjFVX7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 19:59:07 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F372A2123
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 16:59:05 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b474dac685so1592811fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 16:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687478344; x=1690070344;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yyhmYJx/oJKFeU+NO8Awpq9ZWnYSt6vLG+dti5DQq9g=;
        b=ESLQBcZZpKSOVu3J2i5wbB7Ok/kWC3yma/hppJwAt/ZBZZhaWfjIpxBAfo8Ri3dDxe
         331ldYN7HKvXpTZpWHZVDtQ1SN+Nwwk9+lQx5D1JQ+sleueJ78pfsAgiKkgFrDREX+CD
         jy8aAY15uwcKQblhuZUXt1axpwZ5F17yAHKehQBp712ZTjUXkO10NpZvF0+wa12l79yd
         Z2W4oATLugH9bzogNVvUpWcExWkMxbKUtlpbeb0aBXHLCXnt3CiXf6VeUm0m4VWF6soK
         /Tradn85RdK4GDGxQ4iEoOPVUcNp1azMDrm+zoh2VSG7b5b0b+T6+xKVY0ftLw78SSSt
         rX5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687478344; x=1690070344;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yyhmYJx/oJKFeU+NO8Awpq9ZWnYSt6vLG+dti5DQq9g=;
        b=iDdqCJeTfqvl6WzeG+ZVGluxp5o52TU3DO3ShNfrJY5AKLQu1CJeDYYP2WL4GHC9dO
         STXHmgDM6pB2we9tMkSSZ/sLz5+3b09lYWDQr2S5cytS0wTKGe/OWQdysMKKZDoDOSOy
         mbVGyLJ1YaZigC4EmkzQ0Ah36iEtwtxn6FDSv6pgPkly8mhaa4VQhKfBID2GsXQtJvQP
         nOG3G36IRdfmK27SG08z7zwTMj3F9nYSv2ieE2DmAruLiUTTepaa8dKSFJOKXCvbrX94
         zmhidA1Z95WFoAVfwwAWo8TZGU14U4exdVtaThO361CK5S0RjY4bo1z6AuVaSj/SrWsn
         hBtQ==
X-Gm-Message-State: AC+VfDwOuo+4b/SUsU2Vxn9DKDIg8bAWwIqYAg0701bhWQxKnf7YlC9r
        RvVJWERyBY9e/tYRzMv0zKoQ6Q==
X-Google-Smtp-Source: ACHHUZ7uBnBOQeXQK/Qk8WLcwAVG8BL2oOHHK1g3QEaFZxzrfxsycpxyc2v14BJUHtDT0JstJfZatQ==
X-Received: by 2002:a2e:a1c8:0:b0:2b1:a810:e43a with SMTP id c8-20020a2ea1c8000000b002b1a810e43amr13441236ljm.34.1687478344174;
        Thu, 22 Jun 2023 16:59:04 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id x18-20020a2e9dd2000000b002b1edfe817fsm1495978ljj.88.2023.06.22.16.59.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jun 2023 16:59:03 -0700 (PDT)
Message-ID: <fc458e8d-9821-23cd-6a73-264ff6f04226@linaro.org>
Date:   Fri, 23 Jun 2023 02:59:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/6] drm/msm: Update dev core dump to not print backwards
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
References: <20230622-devcoredump_patch-v1-0-3b2cdcc6a576@quicinc.com>
 <20230622-devcoredump_patch-v1-1-3b2cdcc6a576@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230622-devcoredump_patch-v1-1-3b2cdcc6a576@quicinc.com>
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

On 23/06/2023 02:48, Ryan McCann wrote:
> Device core dump add block method adds hardware blocks to dumping queue
> with stack behavior which causes the hardware blocks to be printed in
> reverse order. Change the addition to dumping queue data structure
> from "list_add" to "list_add_tail" for FIFO queue behavior.
> 
> Fixes: 98659487b845 ("drm/msm: add support to take dpu snapshot")
> Signed-off-by: Ryan McCann <quic_rmccann@quicinc.com>
> ---
>   drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

