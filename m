Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A9D5B3147
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 10:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbiIIIDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 04:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbiIIIDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 04:03:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4EB100422;
        Fri,  9 Sep 2022 01:03:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B1AA761F03;
        Fri,  9 Sep 2022 08:02:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FD5CC433D7;
        Fri,  9 Sep 2022 08:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662710579;
        bh=+1jf4vnkdN2PEc2sJmjoWRV+8uzkgTQry95TvIwUh1I=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GTjnX5bMeCaAxxZ9L9Ehc2UzzS/QVJ4WG47BVxApQhRxPoGyTxGf8YzCxluvx5Xuo
         cW422r4xQUcHZB4U6i6zsR1gFgorgtLr3yVhoYnrhX26DLze8bdsgoOzgrQ9zmkwa5
         EcMooQX1M+rd/aIJOh8PjVianR0V7Gab17mPMNMVD3mdI/IwfATRXJcagJ1LmNqkob
         wcw8WMKsY3bgdXrs4m2e+/wzQ5GM58axt26ehPJgdFymLQ65tciid6pbw5SGvmIUQT
         3a1dVjigZDVk8qtet3AIiHboCLlz1ICgScJl/b9+vNAlS8ZuSMJPUoxtiwLUrunxGU
         GiywkL4AkOhEQ==
Message-ID: <a24f920b-60e2-f32b-96e5-9bafee6be8e6@kernel.org>
Date:   Fri, 9 Sep 2022 10:02:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 1/2] dt-bindings: arm: Add i.MX8M Mini Gateworks GW7904
 board
Content-Language: en-US
To:     Tim Harvey <tharvey@gateworks.com>, Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
References: <20220902230500.2624739-1-tharvey@gateworks.com>
 <20220908211916.GA3348959-robh@kernel.org>
 <CAJ+vNU1NEYWvev3s=1rPPNCRovBqa0p=JTXLHLpV7fOWf-dFLg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <CAJ+vNU1NEYWvev3s=1rPPNCRovBqa0p=JTXLHLpV7fOWf-dFLg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/09/2022 23:44, Tim Harvey wrote:
> On Thu, Sep 8, 2022 at 2:19 PM Rob Herring <robh@kernel.org> wrote:
>>
>> On Fri, Sep 02, 2022 at 04:04:59PM -0700, Tim Harvey wrote:
>>> Add DT compatible string for i.MX8M Mini based Gateworks GW7904 board.
>>>
>>> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
>>> Cc: Rob Herring <robh+dt@kernel.org>
>>> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
>>> Cc: Shawn Guo <shawnguo@kernel.org>
>>> Cc: Sascha Hauer <s.hauer@pengutronix.de>
>>> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
>>> Cc: Fabio Estevam <festevam@gmail.com>
>>> Cc: NXP Linux Team <linux-imx@nxp.com>
>>> ---
>>>  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
>>> index 7431579ab0e8..ce89fac1898e 100644
>>> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
>>> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
>>> @@ -831,6 +831,7 @@ properties:
>>>                - gw,imx8mm-gw7901          # i.MX8MM Gateworks Board
>>>                - gw,imx8mm-gw7902          # i.MX8MM Gateworks Board
>>>                - gw,imx8mm-gw7903          # i.MX8MM Gateworks Board
>>> +              - gateworks,imx8mm-gw7904   # i.MX8MM Gateworks Board
>>
>> A useful comment would be ones that distuiguish these boards. It's
>> obvious from the compatible it's a i.MX8MM board from Gateworks.
> 
> But isn't it clear that you need to go to the device-tree itself to
> understand the details?
> 
> As far as basic features go sometimes there is very little difference
> in these board models. It would be a struggle to list all the board
> details (which I do in the dts commit) in a way that doesn't take up
> too much space in fsl.yaml.
> 

But then the comment you added is useless. So either add useful comment
or no comment. :)


Best regards,
Krzysztof
