Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 152696D7478
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 08:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237102AbjDEGgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 02:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236997AbjDEGga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 02:36:30 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E926B3AB0
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 23:36:28 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-500298a69a0so217551a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 23:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680676587;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9yvcVihuH9wEZQZUx/B/kZ5+djU5fILXyRrycwbFq1U=;
        b=TvQBbCSWXYhS77wmCXyqApj4VkHr2Zt7VkkaLE4c0orGQF+GzuHRlgay5y0SVMhGhA
         732IXN7OjWQOo7yAqqCoiMawA+DlZr5YRZHkUqmoah2nQB4UzixnQhM3B81Uk0xghNQO
         nD6IDscAJDPRAnqt2sfn6tzpRUQqTsn5mGsMn+RLt8qllPCsF/PT3rih/fDm+xapzJIF
         kUoAELCA0O4FukpwiGXOBIFhY6UGTOSd4BSir5UxAsXW9reiJpfF79FszmSAemr3PotU
         6SKB9DAsDrx79cGo4IdvBAoZXGm5IQBkIwPHIX/scNHyVWxSMVlFSoG1GhQXeY29vhdv
         zhUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680676587;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9yvcVihuH9wEZQZUx/B/kZ5+djU5fILXyRrycwbFq1U=;
        b=X1c79Ohkgpq8E+TeH815PLKYDDNTng+tIbpf610m6I5vfrttE1t2Givf/Sa+0UJy9X
         37vEPBoba0/k/j/dRsOlygbb/c1mvmONG3UEqTvqqg/zVZrAIKEvu0MIs1BObxkh/nAI
         TcHM3PBilmZOSacNMJR8kWUgSsxI3SwjPPox+GgGhVTVxJD+k+xBVZKqPAlAiON52SXT
         BQ+jSwwrFMilE0ewURGWvaHHIj1sXVvFRMMOEWLxONXM45azdyHeADeMlyMb8GFlGtGK
         eHaUuXs/l5eBa8hTYTHEpV6yQsCnkIewimcVYoWgAiQfJuFnaNKoabw1a3g4ULmQJpRE
         F04g==
X-Gm-Message-State: AAQBX9fH52ob+znyZVJlASq7d8Gj5WAyPeWRIgiSJQst4ZvHKhv/6hih
        +0BM9bi3MJW4SEAM+emN+WkyeA==
X-Google-Smtp-Source: AKy350aV0VWB0Xp1TErOrOX/pYnT3FuSj6/R0SDUrLH/kFZPjvTo+/Jt8izFFo5rNtrh7uybTcUEkg==
X-Received: by 2002:a05:6402:496:b0:501:d3a1:9a3a with SMTP id k22-20020a056402049600b00501d3a19a3amr747028edv.25.1680676587457;
        Tue, 04 Apr 2023 23:36:27 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:3f:6b2:54cd:498e? ([2a02:810d:15c0:828:3f:6b2:54cd:498e])
        by smtp.gmail.com with ESMTPSA id z23-20020a50cd17000000b005021c7f08absm6794887edi.29.2023.04.04.23.36.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 23:36:27 -0700 (PDT)
Message-ID: <2b65e60f-6518-6a79-42c0-922d4574d5b2@linaro.org>
Date:   Wed, 5 Apr 2023 08:36:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v6 02/15] dt-bindings: display/msm: gpu: Document GMU
 wrapper-equipped A6xx
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Marijn Suijten <marijn.suijten@somainline.org>
References: <20230223-topic-gmuwrapper-v6-0-2034115bb60c@linaro.org>
 <20230223-topic-gmuwrapper-v6-2-2034115bb60c@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230223-topic-gmuwrapper-v6-2-2034115bb60c@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/04/2023 13:54, Konrad Dybcio wrote:
> The "GMU Wrapper" is Qualcomm's name for "let's treat the GPU blocks
> we'd normally assign to the GMU as if they were a part of the GMU, even
> though they are not". It's a (good) software representation of the GMU_CX
> and GMU_GX register spaces within the GPUSS that helps us programatically
> treat these de-facto GMU-less parts in a way that's very similar to their
> GMU-equipped cousins, massively saving up on code duplication.
> 
> The "wrapper" register space was specifically designed to mimic the layout
> of a real GMU, though it rather obviously does not have the M3 core et al.
> 
> GMU wrapper-equipped A6xx GPUs require clocks and clock-names to be
> specified under the GPU node, just like their older cousins. Account
> for that.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

