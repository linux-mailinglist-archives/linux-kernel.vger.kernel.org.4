Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F14074E7E1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 09:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjGKHXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 03:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbjGKHXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 03:23:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E63E6F;
        Tue, 11 Jul 2023 00:23:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C4C961354;
        Tue, 11 Jul 2023 07:23:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D4C8C433C7;
        Tue, 11 Jul 2023 07:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689060214;
        bh=c+IFUbHNQn6eDorj+RXCICBpwm/+TCrwrs7pHSTekZM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=gZiDASqeOkRhVxOZ5WQbrpFJmL0xERrLGiTItb9wGfT3BbxYAZ1Xtvhn8kChUhY1k
         K2HSJx9Md3yQ1jmHBQOIfaxhm2BCqj5ynnU3Z8udP2Wu7V1IjTkf4gkNR9R4G7hjGR
         M3sLvqvbzqpDDoJl6K+jDoGkgBAByMdln0Z6AN9yKsJpz3unMoegFpgSkIxxPY3Kvw
         sqPMTwi0s0dYpJZPTpIQSCroLg73hWeCqj9gCG6zn7SPzzn5XJX4cKn88668Q6jbCH
         RbX0Icr26FeHSGV6Q+XSnyVfffjm3gPexVUpxbRK0Z50epP9+Z5tSG3721BqAzNjok
         aqsQoqnJR7mbQ==
Message-ID: <5ce1c3b3-a55f-4ff8-f6db-dc66eebf9257@kernel.org>
Date:   Tue, 11 Jul 2023 10:23:21 +0300
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] dt-bindings: interconnect: qcom,bwmon: Document
 SC7180 BWMONs
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Nikita Travkin <nikita@trvn.ru>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230616-topic-sc7180_bwmons-v1-0-4ddb96f9a6cd@linaro.org>
 <20230616-topic-sc7180_bwmons-v1-1-4ddb96f9a6cd@linaro.org>
 <f937db2e-a5b2-8ad9-ce5f-ed1ee9f2dda4@linaro.org>
From:   Georgi Djakov <djakov@kernel.org>
In-Reply-To: <f937db2e-a5b2-8ad9-ce5f-ed1ee9f2dda4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.07.23 9:42, Krzysztof Kozlowski wrote:
> On 16/06/2023 01:46, Konrad Dybcio wrote:
>> SC7180 - just like SC7280 - has a BWMONv4 for CPU-LLCC and a BWMONv5
>> for DDR-LLCC paths. Document them.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>   Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml | 2 ++
> 
> Can we get this patch applied? DTS is already in next so without this
> patch there are 90 new warnings:
> https://krzk.eu/#/builders/90/builds/40/steps/25/logs/warnings__94_
> 

Applied.

Thanks,
Georgi

