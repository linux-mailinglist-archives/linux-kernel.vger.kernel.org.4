Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 269D5694A81
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 16:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjBMPNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 10:13:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbjBMPNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 10:13:12 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D22BA5CB
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 07:13:10 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id rp23so32640566ejb.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 07:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CLlvNqYXoYkTP0kXk28TWwYetNOEku1lexXp3so1wpQ=;
        b=i7NsvwPz0kahrM5fmdDO8q9o7THzA08ppzN+JveeQ4RQLJDW/l6vWNnLV78c7gExHX
         KabUpzj74TNt6CnADvUDMHssiOwqR/92UDc64YSlupnLFl31kpygOuacCQngej6gf5E1
         r4lV5GOLSjhcKt7VweKuXNG/BecKGYPOSxwp02tuPffxZMneRy8IWyZCAsUhtZQ75cQ7
         CrznSmVG0VCB9CaqSk0kgVi38UZShPeIr8wgOSzbTyP9BFNymxpNpckxjyO3nc5Te12c
         KGqeri9GUPow2yQLblLSdiBN0eJCEnHusxAjM17kEV/foIjNJtXXvQufsGr74cCvxuPW
         zz0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CLlvNqYXoYkTP0kXk28TWwYetNOEku1lexXp3so1wpQ=;
        b=MWZpNuGS7GSdL6W5Zfo16U/GZK/+6IauI5KuUbUJVSElbSKB8vf6t/f8w+4sYjbsIM
         jW/ui/OYq+1R1LCL4nkly88JwMkRiC1S57rK3vRuErIdYRsgyQ9p2OLQ2DDlLYeiL0Dm
         9gf91OOB4VSP5K5GBtOToXYhbTbYzi/Rt7lSI0iT2GmZXcdLY/224EiaXr3udYJwefsE
         ZdzBLbjGhCRjrRw+RTqXPoJYqlL6Aljs1G1dlDRvbzuJirGS/4wbjVDibYCuppGpDSfX
         X0bmhi2eS/5DvHHSiV4b9Bda9AtCGhpMmLotcyShU4VRsgZKUWVB+jWLozAHkMkjcclE
         926g==
X-Gm-Message-State: AO0yUKV7z9K7kc7lCbQUDj7D2Qm8jhr2pL4pTSqyBp83LYjpcbxxnxKt
        LQA4y0NmtEG8lwLf+oKe0WKEVQ==
X-Google-Smtp-Source: AK7set9ykx5c1Vf7M0592+yTkU1k83xL2xhs21Zp2nvIMxqWJocncbuq/2Y9bpmpoRD2syn1SRetNw==
X-Received: by 2002:a17:907:2c54:b0:882:82b3:58bc with SMTP id hf20-20020a1709072c5400b0088282b358bcmr27039031ejc.65.1676301188746;
        Mon, 13 Feb 2023 07:13:08 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id z15-20020a1709064e0f00b008af424d4d75sm6487522eju.194.2023.02.13.07.13.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 07:13:07 -0800 (PST)
Message-ID: <5a9f869e-da91-d79b-c94c-74734cd39904@linaro.org>
Date:   Mon, 13 Feb 2023 17:13:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 06/10] drm/msm/dpu: Add SM6350 support
Content-Language: en-GB
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Robert Foss <rfoss@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Vinod Koul <vkoul@kernel.org>,
        Vinod Polimera <quic_vpolimer@quicinc.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Liu Shixin <liushixin2@huawei.com>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20230211122656.1479141-1-konrad.dybcio@linaro.org>
 <20230211122656.1479141-7-konrad.dybcio@linaro.org>
 <a18cf663-115d-edc8-5e4b-3d19fcd9a02c@linaro.org>
 <cc364658-478a-f239-5d17-5ca2b7f7df8b@linaro.org>
 <20230213113008.ih7ii5m3cz4w3lmz@SoMainline.org>
 <8560b69f-8d42-995d-2f4d-11d6a64afef0@linaro.org>
 <20230213142831.hbzfp2chekshsqyy@SoMainline.org>
 <28c9ea04-fedb-16cf-f874-f4c965fbc445@linaro.org>
In-Reply-To: <28c9ea04-fedb-16cf-f874-f4c965fbc445@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/02/2023 16:58, Dmitry Baryshkov wrote:
> On 13/02/2023 16:28, Marijn Suijten wrote:
>> Feel free to propose a merge order listing all the aforementioned SoCs,
>> your rework, my INTF TE patches and whatever else is in the pipeline.
>> As I've been away for a while, and only have limited hobby time (_and_
>> have to split that on various projects), I'm behind on what's currently
>> in swing for DPU (need additional time to catch back up) nor will be
>> able to rebase/resubmit my patches often (a set-in-stone merge order
>> will really help prioritise/plan ahead here).
> 
> We have several patchsets in the pipeline (PSR, color-transformation 
> rework, wide planes) which do not touch the catalog, so the amount of 
> conflicts should be pretty minimal. We are still waiting for DSC 1.2 v2, 
> but it definitely will take time to mature even if v2 is posted today.
> 
> So, *possible* the merge order is the following:
> - fixes from https://patchwork.freedesktop.org/series/113910/ go to 
> msm-fixes
> - fixes from your intf-te go to msm-fixes
> - https://patchwork.freedesktop.org/series/111751/
> - the rest of intf-te and catalog (*see below)
> - DPU features
> - new DPU platforms (might go together with DPU features)

Just to clarify here: I want to hold on adding new platforms to DPU 
driver only. MDSS, DSI etc. patches are free to go.

> 
> * That really depends on the availability of the patchsets. Most 
> probably, as your patchset also contains several fixups, it would be 
> easier to land it before catalog split/rework.
> 
> So, if you have the available timeslot, could you please finish & send 
> intf te on top of msm-next.
> 
>> Sure, I will at least start looking at your 50-patch as part of catching
>> back up.  Do you want to process that on the mailing list or via
>> https://gitlab.freedesktop.org/drm/msm/-/merge_requests/44?
> 
> I'd prefer to use email. The MR was open to doublecheck that nothing got 
> broken on sc7180.
> 

-- 
With best wishes
Dmitry

