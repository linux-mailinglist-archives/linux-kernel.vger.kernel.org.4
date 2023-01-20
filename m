Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0422267513D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 10:34:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbjATJeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 04:34:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbjATJeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 04:34:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015E6D7;
        Fri, 20 Jan 2023 01:33:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E7D3061E60;
        Fri, 20 Jan 2023 09:33:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36969C433D2;
        Fri, 20 Jan 2023 09:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674207225;
        bh=flGcaxUpqgF9SiqX+TICUIWFq/FXqENur7P1o86/rHY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=XJYyIMynCAzLWyyw3ZwFpO5CSRJVeTfe+kvui3Qu7aZ8m5bhWAZwP2S7XE5Dcxky+
         7+e44erve1l6DUdzSKFijm68uYg7l4z1imA+tvF52F4jZ/b3fY1Qk57WTVcfTO+1eP
         dnRr8iej2Yi5gsyPH3e+bJV9tRpEgPGC+I+1TuRtx3sJCVVaauUFqvHNIGVWb5AJL8
         0VHRTVhFUezNFyEHIDFkVsamlCjhq3/1AQoyG1v6+rKRv62ucNyIurI7+CfAk2TIgq
         aW4TZwrCanxNizsExEBscyEI/qp94kTSxy9q296hCdmxXtYuS+vN0iLd2p7DlLxHPP
         80FpsvKWIlq6Q==
Message-ID: <72112478-32fe-7e00-aa69-073140bc6713@kernel.org>
Date:   Fri, 20 Jan 2023 11:33:40 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v3] dt-bindings: interconnect: qcom-bwmon: document SM8550
 compatibles
Content-Language: en-US
To:     neil.armstrong@linaro.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221114-narmstrong-sm8550-upstream-bwmon-v3-1-7d63d2ae6bce@linaro.org>
 <5ab38158-6e75-ea9c-f788-f3a2d77dbbe7@linaro.org>
From:   Georgi Djakov <djakov@kernel.org>
In-Reply-To: <5ab38158-6e75-ea9c-f788-f3a2d77dbbe7@linaro.org>
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

On 18.01.23 17:05, Neil Armstrong wrote:
> Hi Georgi,
> 
> On 09/01/2023 13:11, Neil Armstrong wrote:
>> Document the compatibles used to describe the Bandwidth Monitors
>> present on the SM8550 platform.
>>
>> A BWMON v4 IP monitors the CPU bandwidth, and a v5 does the LLCC
>> bandwidth monitoring.
>>
>> This is described by adding "llcc" and "cpu" into the compatible
>> strings to differentiate the BWMON IPs.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Gentle ping,
> Neil

Thanks Neil! Applied and in linux-next already.

BR,
Georgi

