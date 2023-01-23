Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1782677B1E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 13:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbjAWMiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 07:38:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231697AbjAWMiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 07:38:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0128CE06D;
        Mon, 23 Jan 2023 04:38:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9DD9360EC4;
        Mon, 23 Jan 2023 12:38:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F33BBC4339B;
        Mon, 23 Jan 2023 12:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674477494;
        bh=H+OW5DW2jeWkZvRmxDgz1ed60PrBNSnXSPQjJ/Kwihk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=BEDC7QceJmbRsOQqIcGKhnAS2rq9TrHli4lvckskodzCC1mxiNSXKTP7gizrwlzm/
         7kbIuQEp86DuMkX6/ktJlU/uilVq+gPJrQVmrNvZpG65XLeN9zDFipPu7inAyKDBcS
         eTJFcFe2CBcmNWpLOY4+Es5HHB50JlthORvgiKGLS/5ALeAXNpvT1b8I/A6p3fHThn
         yH235OdH5KM+QWxx4f0cxVsjtgTGHY+4F2jqA4+pRFcl+mZPTIdcx38uy6JbQpNn2D
         VSA7hhwsYTaAvMoTfVE2NYI6xqlWMaf12/GZ2mQwGmFYYiphMR0VCjJgJS3QxioEmq
         iATV6Il2RU8jg==
Message-ID: <2d5f0bc3-620a-1fd8-061f-92f16efd3c5e@kernel.org>
Date:   Mon, 23 Jan 2023 13:38:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v2 1/3] drm/msm/gpu: Add devfreq tuning debugfs
To:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Chia-I Wu <olvaffe@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        open list <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
References: <20230110231447.1939101-1-robdclark@gmail.com>
 <20230110231447.1939101-2-robdclark@gmail.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230110231447.1939101-2-robdclark@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/01/2023 00:14, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> Make the handful of tuning knobs available visible via debugfs.
> 
> v2: select DEVFREQ_GOV_SIMPLE_ONDEMAND because for some reason
>     struct devfreq_simple_ondemand_data depends on this
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---

For some reason this was merged even though earlier kbuild reported
build failure. This breaks linux next and qcom defconfig. Please drop
the patch from the linux next.

See earlier build issues reported:
https://lore.kernel.org/all/202301130108.fslQjvJ8-lkp@intel.com/

Best regards,
Krzysztof

