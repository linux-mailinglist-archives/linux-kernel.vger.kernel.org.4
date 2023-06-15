Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68AA2730E9E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 07:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243019AbjFOFW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 01:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbjFOFW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 01:22:27 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE231715;
        Wed, 14 Jun 2023 22:22:25 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 35F5MBl3003020;
        Thu, 15 Jun 2023 00:22:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1686806531;
        bh=wR6z+d+RLamaqgevVPC9toHtOMecd6GPf6cmcJJyoy8=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=w+hqawVdOVh0VoT6fA7JRY6isZeAFJ8avgO8TLSCtbnErL1YIbFpWZPdY5HDfZl6U
         XYUgfwb1ge8X7FduIDnhKMV/zTE5c56PHBPav2Du9/1e6FslD/lmDbr/HE7A6SwdHS
         NK8nDtmw6wkfHRgz5K2SVQBQZzybz2jl8lYmMtRs=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 35F5MBGY021965
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 15 Jun 2023 00:22:11 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 15
 Jun 2023 00:22:11 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 15 Jun 2023 00:22:11 -0500
Received: from [172.24.145.182] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 35F5M8TC106218;
        Thu, 15 Jun 2023 00:22:09 -0500
Message-ID: <b8f36b2d-3b61-c9af-24d1-cb826e037c78@ti.com>
Date:   Thu, 15 Jun 2023 10:52:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 0/2] Add R5F and C7x DSP nodes for AM62a SoC
Content-Language: en-US
To:     Hari Nagalla <hnagalla@ti.com>, <nm@ti.com>
CC:     <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230502141416.9924-1-hnagalla@ti.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <20230502141416.9924-1-hnagalla@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/05/23 19:44, Hari Nagalla wrote:
> This series adds the R5F processor nodes and C7x DSP node for
> AM62a SoC.
> 
> The first patch adds the nodes to the SoC device tree and the second
> patch reserves the memory for remote rpoc IPCs on AM62a-SK.
> 
> Hari Nagalla (2):
>   arm64: dts: ti: k3-am62a: Add remote proc nodes
>   arm64: dts: ti: k3-am62a7-sk: Enable remote proc nodes
> 
>  arch/arm64/boot/dts/ti/k3-am62a-main.dtsi   | 11 ++++
>  arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi    | 23 +++++++
>  arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi | 23 +++++++
>  arch/arm64/boot/dts/ti/k3-am62a7-sk.dts     | 69 +++++++++++++++++++++
>  4 files changed, 126 insertions(+)
> 

Please fix dtbs_check issues:

+arch/arm64/boot/dts/ti/k3-am62a7-sk.dts: /bus@f0000/mailbox@29020000/mbox-mcu_r5-0: Character '_' not recommended in node name
+/workdir/arch/arm64/boot/dts/ti/k3-am62a7-sk.dtb: dsp@7e000000: reg: [[0, 2113929216, 0, 1048576]] is too short
+/workdir/arch/arm64/boot/dts/ti/k3-am62a7-sk.dtb: dsp@7e000000: reg-names: ['l2sram'] is too short
+/workdir/arch/arm64/boot/dts/ti/k3-am62a7-sk.dtb: dsp@7e000000: Unevaluated properties are not allowed ('reg', 'reg-names' were unexpected)
+arch/arm64/boot/dts/ti/k3-am62a7-sk.dts: /bus@f0000/mailbox@29020000/mbox-mcu_r5-0: Character '_' not recommended in node name
+/workdir/arch/arm64/boot/dts/ti/k3-am62a7-sk.dtb: mailbox@29020000: 'mbox-mcu_r5-0' does not match any of the regexes: '^mbox-[a-z0-9-]+$', 'pinctrl-[0-9]+'


-- 
Regards
Vignesh
