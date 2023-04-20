Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD7CE6E8772
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 03:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbjDTB0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 21:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjDTB0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 21:26:14 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C86474C20
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 18:26:12 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2a8b082d6feso1892641fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 18:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681953971; x=1684545971;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G9FvCMd4FeVo4PGdQogEA9VqD03U+AN8Fda9+egyrSU=;
        b=U24J37geoSH8knCLGimuYh2eVXwAASShKiWGWZ7VPiAAnaA8QkEv09KhTwQWoLS1jl
         VNKMYY/X+TFnc2S1IrIfbkqh17JXgQri6kn1hGMGn+K6DcChJWvLpJA2C+3WR6sLz3F+
         O9Nyxnnkxnx2V7OYhtZVGlfajITnf6RK441JpW+XsUtVz8bhgTo9iwXS8qK/yp7d/IMr
         /JOs0Iaf1YHD9U6zKDdx+97c10114TyRz8ZJi/p+4upnMuoQoBhsPIow9wgFIz96YbLn
         GKzWZ23Qstll35AhgRfRJVrMRTrofldp7zCE5X892Vi8tNZOEBbgZxAsCexsXAg5JpqB
         1vzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681953971; x=1684545971;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G9FvCMd4FeVo4PGdQogEA9VqD03U+AN8Fda9+egyrSU=;
        b=Ur2krwvjoJDQVkS4/XKgwX3TJtgtUUpa2ykdM3GCnuQqCwAbFLmP0ln7fi3z1mHJEZ
         Tdxk2234UVdU2YelQnix1YuysZIzYrNdz0pkIMrfEm7j+C0rJTUG57iJJQA9i2iYTkz6
         R/iMJPlS5bsNSOpVnaZmUpH73Fake6cVJvT0qoNWCWk6i8gRRrQ08VyWZc+DoA2jL3BX
         wy7SrmCXkfTVMy9z9zyZags48UO1/b59Ge1YnVhdixDx3F+GwvR6/8KmFurpxcqfrXUw
         SahBhAn/ZhibV3+DLhjl8w8SJ30fQppVGYzUwksrH3mFM1Gv4egS+/yLo5mPjJKHUDu7
         vroA==
X-Gm-Message-State: AAQBX9cpDXwc6qM2OCY4sv3oonL+xDgEEtschCIa/3uWyYoPh3N4sjp4
        BgWmicl9ZNT2y6LPMASVNvH8CA==
X-Google-Smtp-Source: AKy350arA4VCD3/gkVo48bfEQ+3dNYxvQNgHZ0dKcoIlBBgvzM0ukon3pkBRaYJJaKtytZK1dCxMQg==
X-Received: by 2002:ac2:5545:0:b0:4dd:af71:a5b7 with SMTP id l5-20020ac25545000000b004ddaf71a5b7mr4148524lfk.41.1681953970982;
        Wed, 19 Apr 2023 18:26:10 -0700 (PDT)
Received: from [192.168.1.101] (abyj144.neoplus.adsl.tpnet.pl. [83.9.29.144])
        by smtp.gmail.com with ESMTPSA id b25-20020a056512025900b004cb23904bd9sm58367lfo.144.2023.04.19.18.26.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 18:26:10 -0700 (PDT)
Message-ID: <c0e0a55a-cc37-fe8a-8d8a-5fe257f99b9a@linaro.org>
Date:   Thu, 20 Apr 2023 03:26:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 0/2] DPU1 GC1.8 wiring-up
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230420-topic-dpu_gc-v1-0-d9d1a5e40917@linaro.org>
 <5b133c55-e4f5-bfd2-b542-a7d44313c038@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <5b133c55-e4f5-bfd2-b542-a7d44313c038@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20.04.2023 03:25, Dmitry Baryshkov wrote:
> On 20/04/2023 04:14, Konrad Dybcio wrote:
>> Almost all SoCs from SDM845 to SM8550 inclusive feature a GC1.8
>> dspp sub-block in addition to PCCv4. The other block differ a bit
>> more, but none of them are supported upstream.
>>
>> This series adds configures the GCv1.8 on all the relevant SoCs.
> 
> Does this mean that we will see gamma_lut support soon?
No promises, my plate is not even full, it's beyond overflowing! :P

Konrad
> 
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>> Konrad Dybcio (2):
>>        drm/msm/dpu1: Rename sm8150_dspp_blk to sdm845_dspp_blk
>>        drm/msm/dpu1: Enable GCv1.8 on many SoCs
>>
>>   drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_0_sm8150.h   | 16 ++++++++--------
>>   drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_0_sm8250.h   | 16 ++++++++--------
>>   drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_3_sm6115.h   |  4 ++--
>>   drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_5_qcm2290.h  |  4 ++--
>>   drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_0_sm8350.h   | 16 ++++++++--------
>>   drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_0_sc8280xp.h | 16 ++++++++--------
>>   drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_1_sm8450.h   | 16 ++++++++--------
>>   drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h   | 16 ++++++++--------
>>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c           |  4 +++-
>>   9 files changed, 55 insertions(+), 53 deletions(-)
>> ---
>> base-commit: 3cdbc01c40e34c57697f8934f2727a88551696be
>> change-id: 20230420-topic-dpu_gc-6901f75768db
>>
>> Best regards,
> 
