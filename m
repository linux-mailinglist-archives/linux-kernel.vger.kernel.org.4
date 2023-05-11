Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C993D6FF1B0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 14:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237327AbjEKMjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 08:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232181AbjEKMjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 08:39:35 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C8926B7
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 05:39:33 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2ac8091351eso91122631fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 05:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683808772; x=1686400772;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sguCADxh6/8JZhFfgnCw2t9kQNtuJnhKvTXcCcJKeVo=;
        b=N+cChiVGWGTovdxW3imjqG5act1QQ5KtOXb3rtHLD0O5XukjYbg4R8yAFzaKwsj0LV
         sw26mEJ4W2mmwpCqPIz/MEc9EQoRXJRPXV95YPcUdrkNXSLeKcwBT2cm9C1L+p+15dpr
         2I6soBLa49oUYkTYkhbTtNs8tOFwxOiBNiP7z0uAqxtfQjmImVisFnxkF5u0k6k/t6pY
         O0XkPrRpnSIpg9+5p6XpcY5Ax06D8WwHsdxn2h4MDX2SVSW6otTrHULi2pD5B9+N7Syy
         eDWZx0fD9yAF6aAbOvxMrxefdna9pQ7gzLCjaHjYmEXVDiUUqx04bgounx98mhAekQTd
         QfSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683808772; x=1686400772;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sguCADxh6/8JZhFfgnCw2t9kQNtuJnhKvTXcCcJKeVo=;
        b=B8QSdXM+abCP/Zav+EKtZRHzU6uv0OKUCfndN9kFS/5DZx1D1/fCtooPRZ20JahkCN
         GN5jbRNE6Kjm+OV3fV2mOKlohNppTHaCZNtOBC18iXBJPWbgCEe/cQO1NWt5UAfvtgEC
         Ta5DGz1HZI9rssljuavRTaoKx7xwZvWESLoVnkgNCd8z6Ijpf2MOvhNoCD4qX8RXaHlA
         RnZryBNlCo0eJDtL2R/LHMoV7CAH6KuMWKOkFfQ63/3FGrOct+P6+Wk30fDOnGuMoPDF
         iH1Z8kKLcMCg1R+KMDwngAv/RaerS9TqKORg4RIP18oenUBfEypB2qWeoDs1W2jaK2Kp
         IKRg==
X-Gm-Message-State: AC+VfDwSGRoBuAA2+mmMlmHz3jkNWeTVGHSmw1WSNIK3SO9vcpD0Sew2
        KDhYVq5RaTZJA2gjj2Qu4Lg3Gg==
X-Google-Smtp-Source: ACHHUZ6+tTZyN721QPlPxPuC2A0OHeNX3tT1BQq7UBNV3ZI/xQJB2a24CSnNTYmrGnjbCg+GxE97XQ==
X-Received: by 2002:a2e:3211:0:b0:2a8:ba15:eb6f with SMTP id y17-20020a2e3211000000b002a8ba15eb6fmr3164629ljy.6.1683808771890;
        Thu, 11 May 2023 05:39:31 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id v23-20020a2e9617000000b002a8bc9918d4sm2374591ljh.97.2023.05.11.05.39.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 May 2023 05:39:31 -0700 (PDT)
Message-ID: <894ea5be-5126-b72b-ad88-4f06cb5c11ca@linaro.org>
Date:   Thu, 11 May 2023 15:39:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] drm/msm/iommu: Fix null pointer dereference in no-IOMMU
 case
Content-Language: en-GB
To:     Luca Weiss <luca@z3ntu.xyz>, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Rob Clark <robdclark@chromium.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20230508-6-4-drm-msm-iommu-fixup-v1-1-a7a21ec94f5b@z3ntu.xyz>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230508-6-4-drm-msm-iommu-fixup-v1-1-a7a21ec94f5b@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/05/2023 23:26, Luca Weiss wrote:
> In the case that no IOMMU is available, msm_iommu_new can return NULL
> which should be handled. Without we will get a NULL pointer dereference
> in the next statement when we try to use the mmu variable.
> 
> Fixes: 8cceb773f565 ("drm/msm/adreno: stall translation on fault for all GPU families")
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
>   drivers/gpu/drm/msm/msm_iommu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

