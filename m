Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01A4A748ED7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 22:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233670AbjGEUX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 16:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbjGEUX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 16:23:26 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A2A173F
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 13:23:25 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4f9fdb0ef35so11595103e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 13:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688588603; x=1691180603;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i4Krz0jpGa+XsfRzmlooU2kh6gKmBpKJ+WGmeH2oOqg=;
        b=OCJKPDAEF6uYuFYTTRjmoDcNVfCOc3C65oJTLebbJjGX9zDQd1S9oLEPA/8I/1w44l
         s7aj7glDs6V8m4aLWBr/R7dQljgI8io7/sz9JVKfynw50NweupSgSF8R9wd4JFA4zUJk
         tTx/Sl93Ao8jqXb/uxZADO5jjMNn1W6HFvnd+LmYyXkSkWVCYgn+D0m/pamm0D5jp4gz
         tqLFL7F+dPwI/VpZrhPaw/ZdXyMGvlhwJR9svNBUdQIikKCQvmUA6ZsBl+9oMSugjcoI
         4cjMXDq8JltvDbRjyiCAFmC5J98GEZP30Iy1xaME6hP3UhenxrnrPRX9rBPmA/wNYeI1
         b98w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688588603; x=1691180603;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i4Krz0jpGa+XsfRzmlooU2kh6gKmBpKJ+WGmeH2oOqg=;
        b=PH4VuZiKQdNomY3SIEsQBqQQHcFhQiU2GpBUgYd/+wrM8TQ2eJUefzwzsOp3tISs9L
         R25pbjJS2c6YTBGl4io37+OJY99OlnmZh7frIhQNuQUCL4QoxBcB7ChsWOZCfg4plwDE
         rS6uFir0FrR8r2hcRyuCwbU3iu//6jsWZr5POfl4WQXWWvUrF9r75T0PWI8PPK+ri3E6
         C4VTX6qHmPP5xH1F/nHOBJhQj7/xtYCFmWn0PyGqmUSn4tfxg7vwQnM8h8O8NZicGUsx
         Pw9/I8omnwfMrRpYz1ZOI4pruFsjINC7uCwm3aullIj4mlOi0mfkkX1zU20zmodI9Id9
         y3UA==
X-Gm-Message-State: ABy/qLbOonilsvWG2OPoyn0QvX8qHWqf2YapJiWwWNEY4mZDsT6ZaHqU
        jNODmE0Gp8TDbiHyfad4g7GhPw==
X-Google-Smtp-Source: APBJJlErhbnzb11CngKsxh5v1reVcDJ9y5He3cf6Hfu/CY4cRjQ5+lMWFHIQ3pvGXPpkL8mDGwPEDA==
X-Received: by 2002:a05:6512:3d28:b0:4fb:8802:9554 with SMTP id d40-20020a0565123d2800b004fb88029554mr95575lfv.6.1688588603673;
        Wed, 05 Jul 2023 13:23:23 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id z14-20020a19f70e000000b004fa35167729sm5492187lfe.159.2023.07.05.13.23.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jul 2023 13:23:23 -0700 (PDT)
Message-ID: <878861f0-f862-f19d-970a-825f660ba281@linaro.org>
Date:   Wed, 5 Jul 2023 23:23:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 3/5] drm/msm/dpu: Define names for unnamed sblks
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
References: <20230622-devcoredump_patch-v2-0-9e90a87d393f@quicinc.com>
 <20230622-devcoredump_patch-v2-3-9e90a87d393f@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230622-devcoredump_patch-v2-3-9e90a87d393f@quicinc.com>
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

On 05/07/2023 22:30, Ryan McCann wrote:
> Some sub-blocks in the hw catalog have not been given a name, so when the
> registers from that block are dumped, there is no name to reference.
> Define names for relevant sub-blocks to fix this.
> 
> Signed-off-by: Ryan McCann <quic_rmccann@quicinc.com>
> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c | 20 ++++++++++----------
>   1 file changed, 10 insertions(+), 10 deletions(-)

I'm not happy with this approach, but let's see how it goes.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

