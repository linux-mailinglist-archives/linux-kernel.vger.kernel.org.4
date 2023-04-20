Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 509636E9ECD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 00:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbjDTW2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 18:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjDTW2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 18:28:15 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D250D2D6B
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 15:28:13 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4ec81773d50so947677e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 15:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682029692; x=1684621692;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wJsMjTzILrouzKr+eknMhhMXReN576hgLHcFIjcVkig=;
        b=tZ+pHzAz7K05Ml7vyAyOeFzXW7GNQ86dqUHMye2xs5c4soQgdpYTCy3P1Wyx19H4bJ
         vVqqoFFPSinMQYoFil/xU3ezXH9nUAoH3brdvs1fDql1z5kJ6kMeQuRUnj0ubrrT/GWQ
         e9fNhB9L/MhESjQ0JqLwsteMM1UrOyPbr0BjX1LQ+jyCVT9pAk1IcerIizFiBGE7d094
         rrAxXHTrmcXERk0P3o3qOrP+ZXpTIsCCo5Fu9vsg1fZBsGGkq/rwY/9AhuSzNmB8MXHU
         IwVPMKMkTzG/5PRLa9jWH9bLeEWAvaXEHSANho71reFoWIXwYYDjQnsS1aSW0jjOI0B4
         dZfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682029692; x=1684621692;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wJsMjTzILrouzKr+eknMhhMXReN576hgLHcFIjcVkig=;
        b=TWLrA/0tk2bztPQfo5sqM1T2g18e9N6WWHnWLNSMuDkqNr0p8MWc2jZTRPkKT8ELYm
         asBJBfJvgOfwv7WbbvPqi91qtCnWajHkUXROPoCi/WGh9PZ7o+G5GrWJANw385IyvUN5
         /4cFLa9rNxQtUiyCQSOn7tReT0Q1QXq1ELHoFJv0lJfrAKwAVAiB3uPNVaIMPGZUPkkD
         jFyetKJeZ+DtJuM3o7l52PSUt//s6gGP3BL212fSe2VcZf9td3OQpmyGWQIDseY/SfSh
         QFOpPL1dWWlAa2yFg70EDWvILxqnlpCldm+FaYy8ws2aXncS9Vef48BdUbosRRDBeiYj
         3VZQ==
X-Gm-Message-State: AAQBX9cSHXe3zpszsMYvrgT5Q0eUjWLe2s9GAQSOZHFAJF2gstC1i/XK
        m7ry/Q5KMparE0IbkB5YjSp+Dg==
X-Google-Smtp-Source: AKy350bchLFLfQc9vyKcrJ9j9ObTS15sUpUmjEQY/7NEyIQ/xTevNiOWcbViiYTQ0mFWYlYb2H/R1g==
X-Received: by 2002:ac2:4c8e:0:b0:4ea:f526:5bef with SMTP id d14-20020ac24c8e000000b004eaf5265befmr701516lfl.28.1682029692099;
        Thu, 20 Apr 2023 15:28:12 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id n3-20020a2e8783000000b002a8e4678da4sm397332lji.139.2023.04.20.15.28.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 15:28:11 -0700 (PDT)
Message-ID: <6335ae3a-0370-92ed-9bc8-d8448db50627@linaro.org>
Date:   Fri, 21 Apr 2023 01:28:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 11/17] drm/msm/dpu: Disable MDP vsync source selection
 on DPU 5.0.0 and above
Content-Language: en-GB
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
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
        Chandan Uddaraju <chandanu@codeaurora.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Archit Taneja <architt@codeaurora.org>,
        Sravanthi Kollukuduru <skolluku@codeaurora.org>
References: <20230411-dpu-intf-te-v2-0-ef76c877eb97@somainline.org>
 <20230411-dpu-intf-te-v2-11-ef76c877eb97@somainline.org>
 <20fab838-e05b-163d-aa72-bd8235df9f2c@linaro.org>
 <38030486-f08a-33e6-f8d1-3f4de379a75b@linaro.org>
 <3d1b08f0-adf9-8815-46f7-c31b54a7140c@linaro.org>
 <fxph57xh3waxv7fpjnmgai4krpgrdxf3bmp2b3vbpgqbmkcy6u@ib3ds6idhgwz>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <fxph57xh3waxv7fpjnmgai4krpgrdxf3bmp2b3vbpgqbmkcy6u@ib3ds6idhgwz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/04/2023 00:51, Marijn Suijten wrote:
> On 2023-04-20 04:03:31, Dmitry Baryshkov wrote:
> [..]
>>>>>     -static void dpu_hw_setup_vsync_source(struct dpu_hw_mdp *mdp,
>>>>> +static void dpu_hw_setup_vsync_source_v1(struct dpu_hw_mdp *mdp,
>>>>>             struct dpu_vsync_source_cfg *cfg)
>>>>
>>>> In my opinion _v1 is not really descriptive here. Could you please rename it to dpu_hw_setup_vsync_source_no_vsync_sel() ?
>>> v1 refers to the CTL rev 100 a.k.a 1.0.0 a.k.a 1, but that's not
>>> yet very well formulated upstream.. if we even need it..
> 
> I think v1 just refers to "the first next variant of this function",
> similar to how for example Microsoft COM APIs start without a suffix,
> then get 1, 2, 3 etc appended as new variants "of the same" trickle in.
> 
>> Yeah, but this mdp_top, not the ctl. And for CTL I'd probably rename _v1
>> to _active to follow actual feature name.
> 
> Correct, I just got lazily inspired by downstream here.  There it
> switches on SDE_MDP_VSYNC_SEL which is based on DPU >= 5.0.0 as
> explained in the patch.
> 
>>>> Or maybe rename dpu_hw_setup_vsync_source() to dpu_hw_setup_vsync_source_vsync_sel() and drop _v1 from this function.
> 
> Maybe add _and_ in there?

Either way will work.

>>>> Up to you.
> 
> - Marijn

-- 
With best wishes
Dmitry

