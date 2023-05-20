Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71AB470A456
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 03:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbjETBdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 21:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbjETBdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 21:33:19 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 098FDE4C
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 18:33:18 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4ec8eca56cfso4317738e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 18:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684546396; x=1687138396;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UAL5nYCj2vZvRS2Tz7EI1xVwLYus4KEX3uqoy05ZFFI=;
        b=MTtBkbuHU4/MtJ2M4gEQGQcKGpcAIKjxMBA8u71oeSIBlIaXgZGwFWU8lP4d4QpWGz
         Q55Uc+H4S97UyOl520XJv4/JiqOhB9R3obS14SIpS5axsPkO/1bWKNFPjNe0FMmBLY7O
         sN3GU7V7SIkd5vO8+0rrihI3bOsM8ADLqD7XnkRwj9roQM7UoFl55dx/JLkHAncL0h66
         PHVSkLoXKte65M6h/FWpH8RZCC94imjYWBnd1XfWCm3KB/9HhDqXRzzl5nZxisu5A/b3
         H/IzKovHCpUSQOHXzr593hDO0I3aKt8S6be3DqAbJfE0TY04RC9/mxzbLsKKt3FtOWlm
         vQ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684546396; x=1687138396;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UAL5nYCj2vZvRS2Tz7EI1xVwLYus4KEX3uqoy05ZFFI=;
        b=YIWlGGgjjDecYqSbLrXU+mCMxQoF+UWOaU78jIS2JdaPPvRMwQLgL7ZLZn9tLiq1wS
         sb4HPKjEIKyXrnzVNlcur+XiIBU83SnBx6b6EQjqjvrlnXfmXUPRn/FjE2cWx0pUxOsp
         mMDFPWd0jIAvERPZ3gyeSRwK8A0GILQYh0V+CfDE8fbuUca+7E87W/Fij/UB0Ym9vwbH
         //3NEOTpaHKnJc4qmrWAI/4BfDPC+x2VyJiirzSd9oXBHGSbQT8jamc2ztlyPAuBYnRx
         xA6DMTEisRgvGFU+SroV6CLPQOP16/q9RlFES09SwFFlnVWXeeAmmm76JiL4eJlDNHQT
         qdbg==
X-Gm-Message-State: AC+VfDwUCpl7N68NjnOot5uvC9rQaXTEAOAbzxteCV5yAJe1Zq0UEFA1
        g5yHnp+/kaZCaofqG3lrYTkpNQ==
X-Google-Smtp-Source: ACHHUZ7HHg3UADQtG6fGoZzNDiGfxuM+1bHdrchFAFZ7Orolvob30+32S9e800thyEfVX5X2KbhKPw==
X-Received: by 2002:ac2:4e4c:0:b0:4f3:ac64:84f5 with SMTP id f12-20020ac24e4c000000b004f3ac6484f5mr1097360lfr.36.1684546396305;
        Fri, 19 May 2023 18:33:16 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id c26-20020ac2531a000000b004f160559d4asm86296lfh.183.2023.05.19.18.33.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 May 2023 18:33:15 -0700 (PDT)
Message-ID: <8ae06612-6108-4cda-79b0-7e26b4b38d24@linaro.org>
Date:   Sat, 20 May 2023 04:33:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 09/12] drm/msm: mdss: Add SM6375 support
Content-Language: en-GB
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev
References: <20230411-topic-straitlagoon_mdss-v4-0-68e7e25d70e1@linaro.org>
 <20230411-topic-straitlagoon_mdss-v4-9-68e7e25d70e1@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230411-topic-straitlagoon_mdss-v4-9-68e7e25d70e1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/05/2023 20:04, Konrad Dybcio wrote:
> Add support for MDSS on SM6375.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   drivers/gpu/drm/msm/msm_mdss.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

