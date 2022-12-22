Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2556E654443
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 16:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235217AbiLVP0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 10:26:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235596AbiLVPZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 10:25:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812E832B9B;
        Thu, 22 Dec 2022 07:24:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2B4F61C39;
        Thu, 22 Dec 2022 15:24:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1461C433D2;
        Thu, 22 Dec 2022 15:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671722655;
        bh=PaJJzDAqCM5gdVG09afArPFJ3vzVbZBS3+mhAyVeRso=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mkOvsFviOPyaubFZ8aSzcKb53eH+YSt2eCRZunqYqCToDXEe43ho3waFovcNF52Ec
         qk2LVS/xFayO7dmyxgXq819Ba1HolsE9yq6N3eBAKB0lCnOt8xrRlnTfaXQqYBqxLG
         Nl8rsUM2oYB6u2Cg6wRkdTn4TX12q6u89hGFSrdXcunavynySL1wMZrekAVPpyiZO/
         5vVEP528xL3j0jGDvEH59JwxfUc6MSYpVw9l9Iuo4iKOGEa9MOt2uO3RI/yHxIDa9g
         K5Dg9sT93Fv+97glT3ddeLxaKy9DXLXwT7TPrXEQ2hQR4uax92KrzHTs0kWphmXZFc
         Rt0MUQ2UGD3+Q==
Message-ID: <a41b83ab-6883-f14c-1584-5de4c9b0a650@kernel.org>
Date:   Thu, 22 Dec 2022 16:24:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3 1/2] arm: dts: arm: add arm corstone500 device tree
Content-Language: en-US
To:     Emekcan Aras <Emekcan.Aras@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <Sudeep.Holla@arm.com>,
        Miguel Silva <rui.silva@linaro.org>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20221222123244.147238-1-emekcan.aras@arm.com>
 <20221222123244.147238-2-emekcan.aras@arm.com>
 <c7baec50-c838-d8fe-d09a-93ee445de045@kernel.org>
 <DBBPR08MB4838C52E20C5D6D0558FAA888EE89@DBBPR08MB4838.eurprd08.prod.outlook.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <DBBPR08MB4838C52E20C5D6D0558FAA888EE89@DBBPR08MB4838.eurprd08.prod.outlook.com>
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

On 22/12/2022 15:57, Emekcan Aras wrote:
> On 22/12/2022 13:32, Emekcan Aras wrote:
>> Corstone500[0] is a platform from arm, which includes Cortex-A cores and
>> ideal starting point for feature rich System on Chip (SoC) designs
>> based on the Cortex-A5 core.
> 
> Use subject prefixes matching the subsystem (git log --oneline -- ...).
> 
> 
> You got this comment already and you did not follow it.
> 
> Sorry, I'm new to kernel upstreaming. I thought I fixed this. Isn't this the correct subsystem prefixes:
> arm: dts: arm? Can you elaborate more? (git log --oneline -- ...) is not very clear for me.

Using git is nothing related to kernel upstreaming. Every other
development using Git... is using Git, so commands stay the same, right?
This is generic SW development. I gave you command to figure out proper
prefix, what else do you need from me? Link to manual on git log? (it's
`git help log`, BTW)

Best regards,
Krzysztof

