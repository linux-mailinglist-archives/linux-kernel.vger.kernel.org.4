Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEF166B9808
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 15:32:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbjCNOco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 10:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjCNOcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 10:32:41 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716F03AA6;
        Tue, 14 Mar 2023 07:32:40 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32EC4afX053264;
        Tue, 14 Mar 2023 07:04:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678795476;
        bh=6l53nnX4K+pDVrp9K4RLIv0cfIZwxtsHwbhTfPUcPQs=;
        h=Date:CC:Subject:To:References:From:In-Reply-To;
        b=qUT9KKkRrQzKwqNUxv83bIjmSU5Q0jyYACHJ0WYff3t55Aiut4+B0FqnNzSHcAzCl
         OfWRMO6sVv9fI/tW+49iYHMpHTS5QeLg9WTJReHAHHTOg7L1HnPj3MbctceAaVGhJb
         nK+I3jV+B3LjxuW2U7QfRz0sRdF7KC5CXQmE09Ew=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32EC4aS0008855
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 14 Mar 2023 07:04:36 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 14
 Mar 2023 07:04:35 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 14 Mar 2023 07:04:35 -0500
Received: from [10.250.151.56] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32EC4Viu121153;
        Tue, 14 Mar 2023 07:04:32 -0500
Message-ID: <e112ada0-ae7d-8f5e-cdf9-9844bf42a9a0@ti.com>
Date:   Tue, 14 Mar 2023 17:34:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: Re: [PATCH 0/2] Enable MCU CPSW2G on J7AHP
To:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>
References: <20230314104055.1475054-1-s-vadapalli@ti.com>
Content-Language: en-US
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <20230314104055.1475054-1-s-vadapalli@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 14-03-2023 16:10, Siddharth Vadapalli wrote:
> Hello,
> 
> This series adds missing device id property in mcu_navss device-tree node.
> Also, the device-tree support for enabling MCU CPSW2G is added.
> 
> ---
> NOTE: While this series does not depend on any other series for being,
> merged it depends on the following series for MCU CPSW2G functionality:
> 1. https://lore.kernel.org/r/20230314085500.10597-1-j-choudhary@ti.com/
> 2. https://lore.kernel.org/r/20230308201513.116638-1-j-choudhary@ti.com/

Please do not merge this series until the above two series have been
merged. Otherwise, it will result in an indefinite probe deferral during
boot. By saying that this series does not depend on other series for
being merged, I meant to say that this series will apply cleanly without
any dependencies.

Regards,
Siddharth.

> 
> Siddharth Vadapalli (2):
>   arm64: dts: ti: k3-j784s4-mcu-wakeup: Add device id property for
>     mcu_navss
>   arm64: dts: ti: k3-j784s4-evm: Enable MCU CPSW2G
> 
>  arch/arm64/boot/dts/ti/k3-j784s4-evm.dts      | 47 +++++++++++++++++++
>  .../boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi     |  2 +
>  2 files changed, 49 insertions(+)
> 
