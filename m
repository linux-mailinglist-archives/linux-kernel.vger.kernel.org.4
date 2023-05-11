Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 691B06FEAD1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 06:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236782AbjEKEj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 00:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236915AbjEKEjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 00:39:52 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3726444B8
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 21:39:51 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4ec8eca56cfso9047179e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 21:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683779989; x=1686371989;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RQLVQkJFQ/faBhReu2ueMCnuIL91erqtpVqo/xwpkJA=;
        b=D4lhAg7XBxsQvcgiGqj2A2Pe7cz2On2AVz9DbCfrPHcv5Dh+DhMWrSVMWG6k1lPhkZ
         ODBX+x2DkOQpouMBuON+g7kVOf3ETKJ3Hu58IemXW9WVL9Bf1vvZLjNPU72KqftDQtu7
         cpiRZAZ6GMk4KBuLyj3klfr2ERw7WV+tfcqQH0jRJcs/7pDfpUXrq4w9G4/ex6U+BP0i
         L+8oQAfAC0Dz9nuEFD8ZJwhLDDGKhx9+Ra7CWIAOEhWD3LtvtCw0YR8Slz5+9vdq43jo
         0O2/cRkr1gRINCTwSO0xH2psg5uhW0J9yI++K9OHbNt2M4bULuqJHjo2ibe4esh7I0Kb
         5cVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683779989; x=1686371989;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RQLVQkJFQ/faBhReu2ueMCnuIL91erqtpVqo/xwpkJA=;
        b=ixAanuLO580j35AVQC9UXiFqWcuLiX5eToIVgIfkPL5QAY+QtRZIMIq7mVhXOA9adh
         /pgvrpNwfuwM3O8Bh8PgSaUqA0Db6LrMRLs7IlN1YlUXwZZJrPrDf4FglsS3p0N2X8F4
         HFWi6Of9G2YU6haoH+8ByrSocIQUNegbfd81Cmlv68IY3CtPR1/FVHWyB7zdvX1Rccxh
         X59TmzGGE232F40iyVcSRKt568PmO2zBJKM7t/4JooK6Dl2OEKqWZA5J78OW9dPu0qh7
         a52qURGux9ldnG9M+Wtk9S9/jBshdK+KGB2OMGQZcpUqZrv0ipqYlC91exCtHccXAWRz
         61RA==
X-Gm-Message-State: AC+VfDxnGPw6P8IMM+qRyLuCrTJqSiapvblTeMk1THQJgJfrIrjOaZGL
        odJrTn83KIKkrOFF5xrZn23sxg==
X-Google-Smtp-Source: ACHHUZ6lH8Hu+PVvErghf0IC43biqp7n5FEPCrQxf3iBmTdwCKHD7ha7oZ50swemwg0PykcylFrJhQ==
X-Received: by 2002:ac2:4e63:0:b0:4f0:1a32:ca23 with SMTP id y3-20020ac24e63000000b004f01a32ca23mr2342580lfs.40.1683779989399;
        Wed, 10 May 2023 21:39:49 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id h7-20020a05651211c700b004f1430ee142sm965115lfr.17.2023.05.10.21.39.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 May 2023 21:39:48 -0700 (PDT)
Message-ID: <a6146d03-18d1-b1c6-cdbb-d3527cb9021a@linaro.org>
Date:   Thu, 11 May 2023 07:39:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v6 2/8] drm/msm/dpu: add DPU_PINGPONG_DSC feature bit for
 DPU < 7.0.0
Content-Language: en-GB
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@gmail.com,
        agross@kernel.org, andersson@kernel.org
Cc:     quic_jesszhan@quicinc.com, quic_sbillaka@quicinc.com,
        marijn.suijten@somainline.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1683756453-22050-1-git-send-email-quic_khsieh@quicinc.com>
 <1683756453-22050-3-git-send-email-quic_khsieh@quicinc.com>
 <b4438422-f24b-7fc1-18cf-3cebdd777530@linaro.org>
 <1a6109ae-7c83-c04e-60c9-dfca6b83d662@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1a6109ae-7c83-c04e-60c9-dfca6b83d662@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/05/2023 07:38, Abhinav Kumar wrote:
> 
> 
> On 5/10/2023 9:29 PM, Dmitry Baryshkov wrote:
>> On 11/05/2023 01:07, Kuogee Hsieh wrote:
>>> DPU < 7.0.0 requires the PINGPONG block to be involved during
>>> DSC setting up. Since DPU >= 7.0.0, enabling and starting the DSC
>>> encoder engine moved to INTF with the help of the flush mechanism.
>>
>> Nit: was moved.
>>
>>> Add a DPU_PINGPONG_DSC feature bit to restrict the availability of
>>> dpu_hw_pp_setup_dsc() and dpu_hw_pp_dsc_{enable,disable}() on the
>>> PINGPONG block to DPU < 7.0.0 hardware, as the registers are not
>>> available [in the PINGPONG block] on DPU 7.0.0 and higher anymore.
>>
>> this looks good
>>
>>> Existing call-sites to these callbacks already skip calling into
>>> them if the function pointer is NULL.
>>
>> This is more relevant for patch 3 commit message.
>>
>>> Add DPU_PINGPONG_DSC feature
>>> bit to all chipset with DPU < 7.0.0.
>>
>> This is incorrect, as we do not change the catalog in this patch.
>>
> 
> Sorry but why not? The changes done to dpu_hw_catalog.c do exactly that.

Because the patch does not add this feature bit to any of the chipsets. 
I think the relevant patch was lost somewhere during the rework/rebase.



-- 
With best wishes
Dmitry

