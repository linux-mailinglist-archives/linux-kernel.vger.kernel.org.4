Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF3B8658F81
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 18:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbiL2RU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 12:20:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiL2RUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 12:20:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1FCE09;
        Thu, 29 Dec 2022 09:20:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA01561838;
        Thu, 29 Dec 2022 17:20:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB2CDC433EF;
        Thu, 29 Dec 2022 17:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672334422;
        bh=ax//aKS4OFvOYlenqfGxR9Ia+jouRNwGuuCUW0WKpPM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=MdiiEjQKJJZhFLhOPyM0YakToLJeXtOSCqGYp+7Ky61v1vg+u0KBd1+YTz1WHfaZr
         t1k7ZW5clKqa7Ive3BcdDHv1RzX3UY0TFPBHmrw2OQ/YTfXuroo1viF8yt4RL3Olph
         k0eDd41tSXGJhhiWJed+MubtrB2WtMx7sjnfPJ3prYrev4eBPoU7jZbRtR51AiDd2Q
         UFYUUU6IWFqpjhRlQ/Cr5Hvwu/j9U+ZCSqgb958fGnlH9+x4hIGzsVRWsSnJe2guMv
         vrHCK42KFvw+T40kLl4qaT68ul+9GMpLOXj4T5MpZpAwmDr5HUnlPPTrBmT91zdoYW
         wCtSY2qbYw78g==
Message-ID: <b5bd2314-e51e-94c8-c4a8-2426950160ba@kernel.org>
Date:   Thu, 29 Dec 2022 19:20:17 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v5 1/2] dt-bindings: interconnect: Add Qualcomm SM8550
To:     Bjorn Andersson <andersson@kernel.org>,
        Abel Vesa <abel.vesa@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20221202232054.2666830-1-abel.vesa@linaro.org>
 <20221202232054.2666830-2-abel.vesa@linaro.org>
 <20221205221425.c6eiserur27clirp@builder.lan>
 <20221228185700.4tyziwqiiopafstl@builder.lan>
Content-Language: en-US
From:   Georgi Djakov <djakov@kernel.org>
In-Reply-To: <20221228185700.4tyziwqiiopafstl@builder.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.12.22 20:57, Bjorn Andersson wrote:
> On Mon, Dec 05, 2022 at 04:14:25PM -0600, Bjorn Andersson wrote:
>> On Sat, Dec 03, 2022 at 01:20:53AM +0200, Abel Vesa wrote:
>>> The Qualcomm SM8550 SoC has several bus fabrics that could be
>>> controlled and tuned dynamically according to the bandwidth demand.
>>>
>>> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> @Georgi, would you mind picking this patch on its own, create a git tag
>> and share that tag with me (and then merge the tag into your tree...),
>> so that I can merge the dts patches ontop?
>>
> 
> dt-bindings/clock/qcom,sm8550-gcc.h has now made it into v6.2-rc1, so
> you should be able to merge this now,Georgi.
> 
> In order for me to pick the dts patches I still would need a immutable
> branch/tag.

Hi Bjorn, here is a branch:

https://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git/log/?h=icc-sm8550-immutable

Thanks,
Georgi
