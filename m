Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC5A0743311
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 05:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbjF3DUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 23:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbjF3DT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 23:19:59 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A1D94219
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 20:19:25 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f957a45b10so2122648e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 20:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688095163; x=1690687163;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OClf5F1H7d+2V177DAXItTLQdlnvTteMUGZEh2YOK44=;
        b=dyIgM+Wm0MjHqL7EeHkgYjMMYvjaMvFilsxt0Z8gbwl5gYYSsSJ/bm7U6uD0pi4l40
         xKO81ShnxeH9jqINCTL7hLayDQ7GKmCwk4d0lo2cPQpsxtveUHkVpJenS318hLTD3NHP
         epfka63vzyXboF4DURHUb/C1hSyOEGr1tkx5gJCDRXBX4q3hf0zwOw5QecHk24kvNkMG
         nmsXqzBT3OErc/MfL4UMRhcvPLQX321/a1fLRvpuLyZUwXBO8gcM6fFa/A5CBAeD4vO2
         QZg5LUWVGEOBjQ5WvaOGLytopbr6MbLfUgMctP23dji2eirYYCpiRz7Nr0ROxbVIvkQq
         tphg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688095163; x=1690687163;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OClf5F1H7d+2V177DAXItTLQdlnvTteMUGZEh2YOK44=;
        b=OMX+TbKR6I1e1NByqcz2XOhVsugcLUwgc2C+k/L+CmtrmXu75DSZ9ASJ5mVSdvvcRJ
         nnBRKMTmv6QmeEa9JnDMaHQfUgWpv1aCNGIOCLHKQ+B9+Pw+8BGviS2EXS2yJHqfX+Eg
         EL/9g/DRkNan09oda1095+54cn986/NhuZ0H8YK/K2FXIdRSZN1aSP4M4quhM2xoYf2A
         zN1AEtKaoYREai+7RYbN40fvFoeSMiQYije1XdrkOb9tlHvouzoz4D/OrQadB7hKPBtE
         1/oDAGleIzw/nKgcsFdTkWmQCM9xhYkZPFVpaQHRXFiktuhyr5qZQkFEPeh6dzvgOQg8
         TFJQ==
X-Gm-Message-State: ABy/qLYsidtLVUR7Pl0BFK+rcThMfYSnESxmpVyg59MkPAB2CCf7VpKV
        4cMqcyvn0F4h/4E0A8NdZVL2zQ==
X-Google-Smtp-Source: APBJJlF145Eu1JiHcpFKpAC1sJj9661vjODWwrSy/N6pSHACGsaSAvlcEDIhA/f0/sivEf3Sary9kQ==
X-Received: by 2002:a05:6512:e9b:b0:4f8:5ab0:68c4 with SMTP id bi27-20020a0565120e9b00b004f85ab068c4mr1263400lfb.59.1688095163116;
        Thu, 29 Jun 2023 20:19:23 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id v11-20020a056512096b00b004f76658694csm2534237lft.238.2023.06.29.20.19.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 20:19:22 -0700 (PDT)
Message-ID: <bf2f0e5c-79d7-6160-88fc-b79fc18bbfe0@linaro.org>
Date:   Fri, 30 Jun 2023 06:19:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 1/3] drm/msm/dpu: re-introduce dpu core revision to the
 catalog
Content-Language: en-GB
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, quic_jesszhan@quicinc.com,
        andersson@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230629193001.22618-1-quic_abhinavk@quicinc.com>
 <aab1883a-b367-f919-8ff6-d3e09ebc0ffe@linaro.org>
 <060b6125-f08c-f8a4-e28f-f3d12b971c79@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <060b6125-f08c-f8a4-e28f-f3d12b971c79@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/06/2023 06:17, Abhinav Kumar wrote:
> 
> 
> On 6/29/2023 5:24 PM, Dmitry Baryshkov wrote:
>> On 29/06/2023 22:29, Abhinav Kumar wrote:
>>> With [1] dpu core revision was dropped in favor of using the
>>> compatible string from the device tree to select the dpu catalog
>>> being used in the device.
>>>
>>> This approach works well however also necessitates adding catalog
>>> entries for small register level details as dpu capabilities and/or
>>> features bloating the catalog unnecessarily. Examples include but
>>> are not limited to data_compress, interrupt register set, widebus etc.
>>
>> Generic note: this description can be moved to the cover letter, it 
>> covers the series intent.
>>
> 
> I kept it here as I didnt really have a cover letter but I can add one 
> and move this there.

Yes, please. I suppose that any series of more than a single non-trivial 
patch should have a cover letter, which describes the intentions and the 
ideas behind the series.

> 
>>> Introduce the dpu core revision back as an entry to the catalog so that
>>> we can just use dpu revision checks and enable those bits which
>>> should be enabled unconditionally and not controlled by a catalog
>>> and also simplify the changes to do something like:
>>>
>>> if (dpu_core_revision > xxxxx && dpu_core_revision < xxxxx)
>>>     enable the bit;
>>>
>>> Since dpu's major and minor versions are now separate fields, lets
>>> drop all the DPU_HW_VER macros.
>>>
>>> [1]: https://patchwork.freedesktop.org/patch/530891/?series=113910&rev=4
>>
>> Please use `commit aabbcc ("do this and that")' in the commit messages.
>>
> 
> Ack.
> 
>>>
>>> changes in v3:
>>>     - drop DPU step version as features are not changing across steps
>>>     - add core_major_version / core_minor_version to avoid conflicts
>>>     - update the commit text to drop references to the dpu macros
>>>
>>> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>

-- 
With best wishes
Dmitry

