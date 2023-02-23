Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7F336A0CFE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 16:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234842AbjBWPc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 10:32:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234822AbjBWPcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 10:32:55 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514085584
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 07:32:51 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id n2so10943317lfb.12
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 07:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tHGfM64SxFiZQAus2x2OY9eDa8kR3HUSV6URvFBcQKE=;
        b=Ux1T46I+Tmsz04WKId1d/6kLP3w2wksf11euq18tEkNeqkH9dgcfPmk+JFCV7KU2wB
         SrVkI9lOEY2RopkV8Wxhn7+5DjWHTwgwG1H0aXA1S79EQEHW+7BB9cFdguvRKS0saV2r
         aW1S6/yfli3zTC356vzt6cBrVhDTH+GxBkcvPIlASFDnWiq4TW7BuJcm7Z3rOxRQqYo3
         dQvCnHJw17Zo0Ktq2W0UeODKBtgee8/IfQe0LCLUB9ywipCJNmzyHPlp1KA47rSanbW0
         k2l1JBG2D7Irj1kyuF6Tf/wQgo7BgVGuCDAv8SJXgwjKMzo4W9fmpMiUmrw9JQf9NSyE
         0/rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tHGfM64SxFiZQAus2x2OY9eDa8kR3HUSV6URvFBcQKE=;
        b=ob3QiGpvfzKOgIEE1A7voqPkTNEbdkBZu5S+gpChVmqFm5M/l+7vsK78rFNvxcCJNb
         M+Lc+9U5GJsXbNv7TRVXa8rgH0GqYCX5m1eb+1CStcskQnWvpgQeJ1rT/kVpq0E6hD68
         hwE9bv705lXyZRP5+Nlofn2Yci/EMBQuNxe4yMnrEm5GmyyGbv4fcPS9LGQnw/52vRA8
         pEb9pt1/S/V/4CqqpAvr07Ip++sf8pfaPZMUFwIpIIZCczoOaazB0uMEiPg4z/FQT2en
         bBDWc11iDNy1X2tRm3m+t3pV7WNP/1xXemuhBjTksfFTvXcsemln0euGXD3BnpNCAD1o
         jR8g==
X-Gm-Message-State: AO0yUKUSiM2His+zuDWR6Kn7psA6xi+rfsnhUDwIBQ2EGxyet3O6u2E5
        Jl/lHGVm4Q4H9bLHa5YzRk5T2Q==
X-Google-Smtp-Source: AK7set+PhpmHoQbaBIWTSqdYGYol1WuhJWnV9zWiSplaw0KYD4YOdcgrO3zw33cVi1cIgKjExzkCPw==
X-Received: by 2002:ac2:43d0:0:b0:4cb:9fd:63a3 with SMTP id u16-20020ac243d0000000b004cb09fd63a3mr4156616lfl.66.1677166369444;
        Thu, 23 Feb 2023 07:32:49 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id u13-20020ac251cd000000b00498fc3d4d15sm70531lfm.190.2023.02.23.07.32.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 07:32:48 -0800 (PST)
Message-ID: <b69d9fcb-ca55-a9b5-3e30-efd9800fe220@linaro.org>
Date:   Thu, 23 Feb 2023 17:32:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v3 2/7] drm/msm/a2xx: Add REG_A2XX_RBBM_PM_OVERRIDE2 to
 XML
Content-Language: en-GB
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230223-topic-opp-v3-0-5f22163cd1df@linaro.org>
 <20230223-topic-opp-v3-2-5f22163cd1df@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230223-topic-opp-v3-2-5f22163cd1df@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/02/2023 12:51, Konrad Dybcio wrote:
> This is a partial merge of [1], subject to be dropped if a header
> update is executed.
> 
> [1] https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/21484
> 
> Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   drivers/gpu/drm/msm/adreno/a2xx.xml.h | 12 ++++++++++++
>   1 file changed, 12 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

