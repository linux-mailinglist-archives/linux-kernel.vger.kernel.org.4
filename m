Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8895762F517
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 13:39:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241449AbiKRMj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 07:39:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234711AbiKRMjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 07:39:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FDF85FD9;
        Fri, 18 Nov 2022 04:39:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B0535B823B4;
        Fri, 18 Nov 2022 12:39:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E086CC433C1;
        Fri, 18 Nov 2022 12:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668775191;
        bh=Lnueqp/kpC1SFUWqcqL9Z2eLWsWZtQl6Sw1+J6sSb+M=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=fqow3ZeVcTJkTdjw4uL5I6AWJTMraZOn8pklTnCil48WwwGxQ3oTOnu0gfvNPeO8+
         5vbhVW6rM9NpAA5hxBrmW3ry2q+O3eCGEKcaymxlvQFc7lgfGOvjIOT+MVpAFp3Yti
         zMHcNf5auM9pF3NPW9VK7LblFhbQu3hYCPwUzKqPCuLyuHZhyer9cO/w+6laJz3WtZ
         JYXB8CDX0gKK/cvsQMzQyTJiWB+JVw2GXSqLSud5LX9vVJ4sujDTJ6mNXI1u/1sFLK
         VYVVZCXy+pq0CGv+s27N/1rO+ikF8pOgbstF+ruBv5oBLqJ9kG8lgJ2gmtduIozPE0
         vEUFjXdP9CPNw==
Message-ID: <ca11b0aa-cc20-b4f1-600e-55a96383321e@kernel.org>
Date:   Fri, 18 Nov 2022 14:39:46 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 2/3] interconnect: qcom: sc7180: drop double space
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>
References: <20221027154848.293523-1-krzysztof.kozlowski@linaro.org>
 <20221027154848.293523-2-krzysztof.kozlowski@linaro.org>
 <1a53679b-07a6-1180-2ac2-ecfc3382fb52@linaro.org>
From:   Georgi Djakov <djakov@kernel.org>
In-Reply-To: <1a53679b-07a6-1180-2ac2-ecfc3382fb52@linaro.org>
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

Hi Krzysztof,

On 18.11.22 14:30, Krzysztof Kozlowski wrote:
> On 27/10/2022 17:48, Krzysztof Kozlowski wrote:
>> Drop double white-space.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>   drivers/interconnect/qcom/sc7180.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Georgi,
> 
> Any comments on this and third patch? I did not receive any
> applied-confirmations.
> 

I applied them. Should be present in today's linux-next.

Thanks,
Georgi

