Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF97064D4CD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 01:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiLOAwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 19:52:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiLOAwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 19:52:07 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6367E31372
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 16:52:04 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id y25so13244749lfa.9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 16:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S6mAIVbE3TYfe/sfWszMjsZBqUjDt0fQZqgGBAUpy8I=;
        b=ByXnkyrSsttOE9yaSrHKJ9PTVsP8OSTXEDlhVcK0vltwTJpeofa/qPcGMhuYp9yqUX
         e7cgOS1KawYLWjYOEivEru4sKz9XjVOIwc6/cN5MseSeoqF1tM+t3cmKtXx8D7E5gSzP
         qh79npKk4m7i71hW8tTyrFNtVL0iY2Isz71f6eoK7UU1X0HjSaoLVmBZvottVJX8ztkj
         tCOpD9Dq5NQhTVZNJthrNy6xKzaF6vibEF34dWjpDrQciyvsCT+tpHS+oJhw/11LUoQL
         Fi8/Ve2xf2PvX100VbCj5bh5jKZ6febAW7ufjg+hENZG+h0lZXvALwuyI3BLHcRMm9fH
         Zbfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S6mAIVbE3TYfe/sfWszMjsZBqUjDt0fQZqgGBAUpy8I=;
        b=B1q1HQ0Cyx2o8lMvgfEI79F9PtBFvRLSKpae6/tGsnuUcA1G8/8DxdjJ4Q490zNc5z
         1jCUlbmO5aeXe7YRuCwvCtLa3w2RdNf9E9GwfCHj8pbARD9Bk+LIzDFCPleRDQwDFC4n
         ITPGdPBaZUP+CdKvV1qUgvAjqFFcxHSMjbSILrnotgvHA3KVXcxqjV58SwMzIfThSZXI
         xe3d87D7rUycZ2SA5pKLRCJb1IMconeLH/c131d+qjo0koXu0L1Ji58DOw3ecxrYCc7C
         G+2mHqJj9dDuhScBJjRya8b9EWWWs+oh7W8h3kGB0J7oBDdaFy5J3QMkmiMgQIhhtwBd
         u+lg==
X-Gm-Message-State: ANoB5pnoasNs23VyZyxhjAFICarYasyrnGWaqRxeye4uGuOhzSMO+LmC
        HIAO/OKTi+ub+EpGQ+htpbEG7w==
X-Google-Smtp-Source: AA0mqf4t5Y8GMiTGp+fKIC782S6ls3TtAofUfVlKy6Q2R1OccaJr26S2ArFTXFMKWtDcenAd/6Nudg==
X-Received: by 2002:a05:6512:159c:b0:4b4:f212:6173 with SMTP id bp28-20020a056512159c00b004b4f2126173mr7866197lfb.4.1671065522702;
        Wed, 14 Dec 2022 16:52:02 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id d3-20020ac24c83000000b004947984b385sm986881lfl.87.2022.12.14.16.52.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 16:52:02 -0800 (PST)
Message-ID: <560508a2-9ff5-16b5-ac50-efe9a2afbddb@linaro.org>
Date:   Thu, 15 Dec 2022 02:52:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [RFC PATCH 0/6] drm/msm: DSC Electric Boogaloo for sm8[12]50
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        phone-devel@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Vinod Koul <vkoul@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Jani Nikula <jani.nikula@intel.com>,
        sunliming <sunliming@kylinos.cn>,
        Sam Ravnborg <sam@ravnborg.org>,
        Haowen Bai <baihaowen@meizu.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Vinod Polimera <quic_vpolimer@quicinc.com>,
        Douglas Anderson <dianders@chromium.org>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20221213232207.113607-1-marijn.suijten@somainline.org>
 <154b2e08-25a0-c8b7-1dc8-2d41b8787f05@linaro.org>
 <20221214192322.vs4tvhlzjc265bva@SoMainline.org>
Content-Language: en-GB
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221214192322.vs4tvhlzjc265bva@SoMainline.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/12/2022 21:23, Marijn Suijten wrote:
> On 2022-12-14 20:40:06, Dmitry Baryshkov wrote:
>> On 14/12/2022 01:22, Marijn Suijten wrote:
>>> This preliminary Display Stream Compression support package for
>>> (initially tested on) sm8[12]50 is based on comparing DSC behaviour
>>> between downstream and mainline.  Some new callbacks are added (for
>>> binding blocks on active CTLs), logic bugs are corrected, zeroed struct
>>> members are now assigned proper values, and RM allocation and hw block
>>> retrieval now hand out (or not) DSC blocks without causing null-pointer
>>> dereferences.
>>>
>>> Unfortunately it is not yet enough to get rid of completely corrupted
>>> display output on the boards I tested here:
>>> - Sony Xperia 1 (sm8150), 1644x3840 or 1096x2560 pixels;
>>> - Sony Xperia 5II (sm8250), 1080x2520, at 60 or 120Hz;
>>> - (can include more Xperia boards if desired)
>>>
>>> Both devices use the DUALPIPE_DSCMERGE topology downstream: dual LM, PP
>>> and DSC, but only a single INTF/encoder/DSI-link.
>>>
>>> Hopefully this spawns some community/upstream interest to help rootcause
>>> our corruption issues (after we open a drm/msm report on GitLab for more
>>> appropriate tracking).
>>>
>>> The Sony Xperia XZ3 (sdm845) was fully tested and validated with this
>>> series to not cause any regressions (an one of the math fixes now allows
>>> us to change slice_count in the panel driver, which would corrupt
>>> previously).
>>>
>>> Marijn Suijten (6):
>>>     drm/msm/dpu1: Implement DSC binding to PP block for CTL V1
>>>     drm/msm/dpu1: Add DSC config for sm8150 and sm8250
>>>     drm/msm/dpu1: Wire up DSC mask for active CTL configuration
>>>     drm/msm/dsi: Use DSC slice(s) packet size to compute word count
>>>     drm/msm/dsi: Flip greater-than check for slice_count and
>>>       slice_per_intf
>>>     drm/msm/dpu: Disallow unallocated (DSC) resources to be returned
>>
>> General comment: patches with Fixes ideally should come first. Usually
>> they are picked into -fixes and/or stable kernels. If the Fixes patches
>> are in the middle of the series, one can not be sure that they do not
>> have dependencies on previous patches. If there is one, it should
>> probably be stated clearly to ease work on backporting them.
> 
> Ack, I may have rushed these RFC patches straight off my branches onto
> the lists in hopes of sparking some suggestions on what may still be
> broken or missing to get DSC working on sm[12]50, but will keep this in
> mind for v2 after receiving some more review.
> 
> That said, any suggestions?


 From what I've noticed lately:

- set dsc_version_major/dsc_version_minor
- try using dsc params from 1.2 rater than 1.1 version spec (there is 
small difference there)

-- 
With best wishes
Dmitry

