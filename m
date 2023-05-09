Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 973236FCB61
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 18:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjEIQey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 12:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbjEIQet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 12:34:49 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7FC02719;
        Tue,  9 May 2023 09:34:47 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 349GYaa5127619;
        Tue, 9 May 2023 11:34:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1683650076;
        bh=Trbks1TBqJoyKHDqQN1W/FF2lBd35IMrDnskHdmK6Og=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=eMqFgoXV3bNa1TBsWYFAccdwuJJCpVtlImV64ly1fl7CRyRCnv7PROtTKe7alVib6
         S4wlp/Hi709PPOsWMbwZju0juzdMLeudUUsO1XESyJjcRGJ5RZp9Bs+W1r5TozA0kw
         1zt3Yeo3lVZUPJlVKrGZJL7lfGYfFJZlV8k5mcQ4=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 349GYaoA029957
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 9 May 2023 11:34:36 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 9
 May 2023 11:34:35 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 9 May 2023 11:34:36 -0500
Received: from [10.249.131.71] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 349GYVgP090201;
        Tue, 9 May 2023 11:34:32 -0500
Message-ID: <5f523657-ae0a-cef2-4de6-762ce365f20a@ti.com>
Date:   Tue, 9 May 2023 22:04:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 0/2] Add R5F and C7x DSP nodes for AM62a SoC
Content-Language: en-US
To:     Hari Nagalla <hnagalla@ti.com>, <nm@ti.com>, <vigneshr@ti.com>
CC:     <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230502141416.9924-1-hnagalla@ti.com>
From:   Devarsh Thakkar <devarsht@ti.com>
In-Reply-To: <20230502141416.9924-1-hnagalla@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hari,

Thanks for the series.

On 02/05/23 19:44, Hari Nagalla wrote:
> This series adds the R5F processor nodes and C7x DSP node for
> AM62a SoC.
> 
> The first patch adds the nodes to the SoC device tree and the second
> patch reserves the memory for remote rpoc IPCs on AM62a-SK.
> 
> Hari Nagalla (2):
>    arm64: dts: ti: k3-am62a: Add remote proc nodes
>    arm64: dts: ti: k3-am62a7-sk: Enable remote proc nodes
> 

I think good to preserve the authorship if porting from an existing 
tree. Also in my opinion good to keep split patches if coming from 
different authors and to different files.

Regards
Devarsh

>   arch/arm64/boot/dts/ti/k3-am62a-main.dtsi   | 11 ++++
>   arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi    | 23 +++++++
>   arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi | 23 +++++++
>   arch/arm64/boot/dts/ti/k3-am62a7-sk.dts     | 69 +++++++++++++++++++++
>   4 files changed, 126 insertions(+)
> 
