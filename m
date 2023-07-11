Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C077374F534
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 18:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbjGKQba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 12:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbjGKQb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 12:31:28 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A481010C2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 09:31:24 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f95bf5c493so8907457e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 09:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689093083; x=1691685083;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zKYYp8rVnqq2DLqZW/bklzE/ZMHurz3rrSzMUFEOKHM=;
        b=zFzIfPOJtTc3JedXcpf8f5wS9UMptT+LC3Rv6KrrdCaUkFkC+aWbgJWIvV7e4K/4rm
         fi0wVwyU3bRBNsJ+fJjqLSB/DKGs2tgfxxjucIXjuN+qnPg4YMMn1/dUJ/kK+2JIfkSp
         qvySgPXy0X/Vcv8RAjVmAz8u6hZgFRO3mLxlVyB4BG0Fg5vnZ7PFY92lBx13VhkPrbBN
         qagAI6+itiefX27A2SDas+Cf31AeM+LHVuTvejbci8ciAjyE5OGTQcOQkNkk+1Ij501N
         iOtLS8xzNLfR8mwUAZrRCCsyobcYfUWxZa7juQ+W8rkhKnyS4NyTu89VPtGJFs4beqDc
         EVSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689093083; x=1691685083;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zKYYp8rVnqq2DLqZW/bklzE/ZMHurz3rrSzMUFEOKHM=;
        b=kdfzgFh8aCMAqGR/PT3+m8oIoMUfWqBbkcNgdX0S2rac2kS5vbUoEFSQ5RKUExg/W0
         isVIJbA3KaBcMM1okNIvCI3PIX/GbewSUfvQl5LApU0sNth27bAFp78kBeuOPcLBkpEi
         WDfKAsYHSAB5oUcY8jt/Pp6MG8l8TNme8Drq4z70XvZdn4/1D3PmOp/haZw0z50wpO6h
         GgBLRIP3hcVSIklN+C+mJ/h6SrQnmZmwZTDQ8QTiPNpsTd9A79cGyv8jI1iLdX2K3ecZ
         Xfy2303bilNfAXYwAoWEpDArPzj0TY9U7uE9CYV2Zow7DNbUXAir+QPFd371MgouZbn/
         cslg==
X-Gm-Message-State: ABy/qLb9tYGH4b6591Yt7P/btXF0KUj8LeHVHBQf6JUOkRH3GUE8onA0
        v6clTxr02Ui9M9c4+Uvf7SFsFg==
X-Google-Smtp-Source: APBJJlHRxzjd3W9HsTSu5RyuJ6elWYXh3WoAGvEetwlsHWPL0V89iyKDGu23q05iykeuv9Xrc7aNUA==
X-Received: by 2002:a05:6512:3090:b0:4f8:4512:c844 with SMTP id z16-20020a056512309000b004f84512c844mr16215043lfd.48.1689093082805;
        Tue, 11 Jul 2023 09:31:22 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id v5-20020a197405000000b004fbc01e17c0sm376987lfe.82.2023.07.11.09.31.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 09:31:22 -0700 (PDT)
Message-ID: <3b4865d7-2730-1ea9-d75b-a015d27aa84d@linaro.org>
Date:   Tue, 11 Jul 2023 19:31:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 0/2] DSIPHY RPM
Content-Language: en-GB
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230620-topic-dsiphy_rpm-v2-0-a11a751f34f0@linaro.org>
 <168908465045.1869384.1893558597710112842.b4-ty@linaro.org>
In-Reply-To: <168908465045.1869384.1893558597710112842.b4-ty@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/2023 17:21, Dmitry Baryshkov wrote:
> 
> On Tue, 20 Jun 2023 13:43:19 +0200, Konrad Dybcio wrote:
>> Some recent SoCs use power rails that we model as GENPDs to power the
>> DSIPHY. This series attempts to make such configurations suspendable.
>>
>> Tested on SM6375.
>>
>>
> 
> Applied, thanks!
> 
> [1/2] drm/msm/dsi: Use pm_runtime_resume_and_get to prevent refcnt leaks
>        https://gitlab.freedesktop.org/lumag/msm/-/commit/a402e0e61b75
> [2/2] drm/msm/dsi: Enable runtime PM
>        https://gitlab.freedesktop.org/lumag/msm/-/commit/4e905c2acc9d

Unfortunately this series breaks our CI, see [1], [2]. I had to remove 
these patches for now.

I suppose this is either because of a probe deferral or because of 
having subset of drivers built as module. Konrad, could you please take 
a look?

[1] https://gitlab.freedesktop.org/drm/msm/-/jobs/45271774
[2] https://gitlab.freedesktop.org/drm/msm/-/jobs/45271775

-- 
With best wishes
Dmitry

