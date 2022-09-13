Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 155B05B6B75
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 12:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbiIMKNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 06:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbiIMKN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 06:13:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 383A65C95E;
        Tue, 13 Sep 2022 03:13:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C3BF461384;
        Tue, 13 Sep 2022 10:13:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 309DCC433C1;
        Tue, 13 Sep 2022 10:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663064002;
        bh=hdZkDGZj0hW1ZQKakHNH/Z4U2MQE+eIhevWLBVgmYkY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZxlL56uO67c0ggoli70OUc9RmoetNPVGTZdjlWspXIkPedAoiNIDmNz3bPpFZfe7x
         PnbA2MktOEr9jY0Zp8i9W9H55xM576hgIA52BiY1+jQ51eKLf5R87mBGysAoLShTy1
         3mPpjOXepgSV7uZlL2zO06p2w7UR7qWRi6fqbuLTY/fi2TASWRz7xEEnX2nXyh/59x
         CWa6WFgAXSXdlv04asjaDlFts6Kz3gpeh/mH1CJK4DUcYKeOHPIFA5pYJnT6dYc1Pb
         FnXoOV3PJ75k7TloBPqMmmjSLRafNYIOdRwV3D845EsGJP0sdnu16DdyyUKzYn5Xlx
         m4qaYidzdqPkw==
Message-ID: <81cd9d0e-ce30-5404-cb0c-60f3f718ace7@kernel.org>
Date:   Tue, 13 Sep 2022 13:13:14 +0300
MIME-Version: 1.0
Subject: Re: [PATCH] interconnect: qcom: Add the missing MODULE_LICENSE
Content-Language: en-US
To:     Leo Yan <leo.yan@linaro.org>, Huang Yiwei <quic_hyiwei@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@somainline.org, dmitry.baryshkov@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220913062721.5986-1-quic_hyiwei@quicinc.com>
 <YyAscuyA1pKmEDH1@leoy-huanghe.lan>
 <d47faa55-9b3e-022a-c074-080ddbe0658b@quicinc.com>
 <YyBWIUjvnHqmeWCG@leoy-yangtze.lan>
From:   Georgi Djakov <djakov@kernel.org>
In-Reply-To: <YyBWIUjvnHqmeWCG@leoy-yangtze.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yiwei,

On 13.09.22 13:06, Leo Yan wrote:
> Changed to Bjorn's updated email.
> 
> On Tue, Sep 13, 2022 at 04:30:50PM +0800, Huang Yiwei wrote:
>> Hi Leo,
>>
>> On 9/13/2022 Tue 15:08, Leo Yan wrote:
>>> Hi Yiwei,
>>>
>>> On Tue, Sep 13, 2022 at 02:27:21PM +0800, Huang Yiwei wrote:
>>>> Since icc-common.c can be compiled as module, add the missing
>>>> MODULE_LICENSE to avoid compile errors.
>>>
>>> Just curious how you can enable config INTERCONNECT_QCOM as "m"
>>> (module)?
>>>
>>> I checked the config INTERCONNECT_QCOM which is dependent on
>>> INTERCONNECT, and INTERCONNECT has below dependency:
>>>
>>>     - DRM_TEGRA [=n] && HAS_IOMEM [=y] && (ARCH_TEGRA [=y] || ARM && COMPILE_TEST [=n]) && COMMON_CLK [=y] && DRM [=m] && OF [=y]
>>>     - TEGRA_MC [=n] && MEMORY [=y] && (ARCH_TEGRA [=y] || COMPILE_TEST [=n] && COMMON_CLK [=y])
>>>
>>> Seems to me, it's impossible to enable INTERCONNECT as "m" because the
>>> dependency ARCH_TEGRA/OF/COMMON_CLK cannot be configured as "m".
>>>
>>> Thanks,
>>> Leo
>>>
>> Found the problem, INTERCONNECT_QCOM is modified to tristate internally
>> so we can compile it as a module, and the new added icc-common.c uses
>> INTERCONNECT_QCOM config to compile, then cause the problem.
> 
> Thanks for confirmation, Yiwei.
> 
>> So shall we change INTERCONNECT_QCOM config to tristate?
> 
> I personally think modularization is the right thing to do; to avoid
> misleading you, I would leave your question to interconnect
> maintainers.

Thanks for clarifying! It sounds like the right approach. So this should
be a single patch that allows icc-common.c to be compiled as a module and
also adds MODULE_LICENSE where needed to avoid any compile errors.

Thanks,
Georgi


