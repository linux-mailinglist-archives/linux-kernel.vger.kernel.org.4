Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3D166240C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 12:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234784AbjAILTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 06:19:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234329AbjAILTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 06:19:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A595A140EF;
        Mon,  9 Jan 2023 03:19:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6464EB80DBB;
        Mon,  9 Jan 2023 11:19:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0AA7C433D2;
        Mon,  9 Jan 2023 11:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673263140;
        bh=vuM0HgyNy913qx6seMOGLv71TojRqqNfpRL5/Z8I0H8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kOoPJp/32xqJMqgInI7+zwJby18/0R2VUzOBsUnVUFVLLq1Ha2NIkOSHBQFcmv8c0
         3o074b9yvDZDfsVSVubzYGZ/7RO2HurhZFb1O/MS3Ex9qDA0TNDTQeQGfEQ4FJlGZs
         44tABXTXvJb2j9wIS5OGcxDj7I5HrVNWg5zlXKptmV5SwzFOBeVaqOtkB8dZ3NH3p9
         SBjtxV/3t+Yjl0RDdEXw7HC28RAnCi4NHVx0J46r51827yQ6I8c5kFr08jQDA71GBm
         XbeKxM3Yb3N8hXw5JbtbK6na3ujqITQDFnt43jLJvhqV9DZ4QlT7++rwZqiLtd6P22
         8oV64MnVlTCyA==
Message-ID: <65880fc7-0b2e-befa-f024-558e97ee5a91@kernel.org>
Date:   Mon, 9 Jan 2023 13:18:54 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2] dt-bindings: interconnect: qcom-bwmon: document SM8550
 compatibles
Content-Language: en-US
To:     neil.armstrong@linaro.org, Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org
References: <20221114-narmstrong-sm8550-upstream-bwmon-v2-0-20c555e3ba5d@linaro.org>
 <655f4a05-5fed-7481-1d00-a6a4faf4c6d8@linaro.org>
From:   Georgi Djakov <djakov@kernel.org>
In-Reply-To: <655f4a05-5fed-7481-1d00-a6a4faf4c6d8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On 9.01.23 12:09, Neil Armstrong wrote:
> Hi Georgi,
> 
> On 18/11/2022 09:29, Neil Armstrong wrote:
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
>> ---
>> To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> To: Andy Gross <agross@kernel.org>
>> To: Bjorn Andersson <andersson@kernel.org>
>> To: Konrad Dybcio <konrad.dybcio@somainline.org>
>> To: Georgi Djakov <djakov@kernel.org>
>> To: Rob Herring <robh+dt@kernel.org>
>> Cc: linux-arm-msm@vger.kernel.org
>> Cc: linux-pm@vger.kernel.org
>> Cc: devicetree@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> ---
>> Changes in v2:
>> - Reworded commit message
>> - Added Reviewed-by from Krzysztof
>> - Link to v1: 
>> https://lore.kernel.org/r/20221114-narmstrong-sm8550-upstream-bwmon-v1-0-b6dd08927f35@linaro.org
>> ---
>>   .../devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml         | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
> 
> <snip>
> 
> 
> Gentle ping,

Thanks for the patch! Could you please rebase and resend?

BR,
Georgi
