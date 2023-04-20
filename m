Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 066656E86D3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 02:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbjDTAsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 20:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjDTAst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 20:48:49 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481862D7F
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 17:48:48 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2a7b02615f1so1847431fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 17:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681951726; x=1684543726;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OckS2BfEFVMjSC+akapUtOqBGX/h+ZT6q2PObAak2Jo=;
        b=of1Fe8+rte+0q44lW2Pg7/jkv2JzJlXjSP69V35PiAbAOAs/B9KhJLoCz9d19XqEJL
         5W2ccPRIyN/bgBXduTDul0iKVct2nTk4w7Pu4JGXa7lX9UnCYthGhuqWoAv91VabCxW1
         +WGoCq5ZkBNqMVoYQA0tlpiJgUsUVkXUZQUjskRvSra5x9Fx3XKbtJ9ewW5MmfNtCx1g
         3k80PIUsffeJWuj5lBuK3lxnXv9HMJ13e2WkXsdmklu0EVcrsxEXtRTYS1i/0OBC2BS/
         mRymuc04+Hdsw72uuZC897kL2Lbzz+MK/yfugTsLsxXHcsh/Pp6OmW3zsPqyq/6C6YH0
         Dzcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681951726; x=1684543726;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OckS2BfEFVMjSC+akapUtOqBGX/h+ZT6q2PObAak2Jo=;
        b=QPDrAZUrOBfygdNXNrYWorTLumsRvnbr0XB8CCO5Mlo75YhHa6MPvtJmybY30idDGn
         hbC35kD7Xsjp8nPXTULiJi0VvhxQYjI5zH3QcHwXBTx/ql68Hpodfw1QwFgEEkuvrXyY
         BuePpxbcNHSbHQCNJ1tJhmeZSwXc+rcO41NIjemgPYZV0DeDkPPykLRs+I7YrMh/FaOU
         zO/foJpW0svTlzKogpWh9iRPf9R+YJgI9NL71CotUbBdJKfqDMI62mWkrI3uzwYlvIot
         zIr5cBemJf6npTWV7pHzo4RSlHNwYLQ2ZfGEuiWPmAuHxSQRJb0N8P39kD6WiOeBy0fE
         0vVg==
X-Gm-Message-State: AAQBX9dEUeruJjI7XamW4eiK7oxfY9VZeSI+Qip70xf44DJVlDj+g2VL
        +R7B97+iOm9n0voifxApAZVzHQ==
X-Google-Smtp-Source: AKy350ZUT8RCWkMoPsNeeBL58+bY0ydYaCEMQ4R5U9q6ztvXkYBk1u005WXgty5JHgzOTpeqwCX+mQ==
X-Received: by 2002:ac2:5929:0:b0:4ed:d5ce:7df0 with SMTP id v9-20020ac25929000000b004edd5ce7df0mr1773953lfi.7.1681951726537;
        Wed, 19 Apr 2023 17:48:46 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id v6-20020a2e9606000000b002a77f45cc00sm18114ljh.29.2023.04.19.17.48.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 17:48:45 -0700 (PDT)
Message-ID: <e129858e-5d8d-32d5-96ca-07ab4f1ea938@linaro.org>
Date:   Thu, 20 Apr 2023 03:48:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 08/17] drm/msm/dpu: Drop unused poll_timeout_wr_ptr
 PINGPONG callback
Content-Language: en-GB
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Adam Skladowski <a39.skl@gmail.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Robert Foss <rfoss@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Rajesh Yadav <ryadav@codeaurora.org>,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Chandan Uddaraju <chandanu@codeaurora.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Archit Taneja <architt@codeaurora.org>,
        Sravanthi Kollukuduru <skolluku@codeaurora.org>
References: <20230411-dpu-intf-te-v2-0-ef76c877eb97@somainline.org>
 <20230411-dpu-intf-te-v2-8-ef76c877eb97@somainline.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230411-dpu-intf-te-v2-8-ef76c877eb97@somainline.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/04/2023 23:21, Marijn Suijten wrote:
> This callback was migrated from downstream when DPU1 was first
> introduced to mainline, but never used by any component.  Drop it to
> save some lines and unnecessary confusion.
> 
> Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c | 18 ------------------
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.h |  6 ------
>   2 files changed, 24 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

