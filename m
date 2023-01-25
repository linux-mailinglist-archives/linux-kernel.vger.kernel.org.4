Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C916367AA37
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 07:11:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234421AbjAYGLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 01:11:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbjAYGLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 01:11:30 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D25522A06;
        Tue, 24 Jan 2023 22:11:29 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 30P6BG0p062244;
        Wed, 25 Jan 2023 00:11:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1674627076;
        bh=rkXjSbS/atDR1vASQgAIQYr6tFwkmXqujiSl7fl1ED4=;
        h=Date:CC:Subject:To:References:From:In-Reply-To;
        b=dcA7nDOmxDK3bacVTxmnkSgGnsdL0bDcv4PVDa1QasePn3HezKYC7audTDYsrEs5L
         cl/96ugT1L3cJWa8tIsAeLo8rz3pXOVtUeKUk9qA6VK8MmsjhyGKlrsbuCPYJsYe50
         df0H6Dq/7xqaSEWlG2UCvFVycycn47RnCCBDBFfA=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 30P6BG2M058970
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 25 Jan 2023 00:11:16 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 25
 Jan 2023 00:11:16 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 25 Jan 2023 00:11:16 -0600
Received: from [172.24.145.61] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 30P6BCYW108241;
        Wed, 25 Jan 2023 00:11:12 -0600
Message-ID: <e6bba62a-d4c2-50d8-f818-007b6b3e2ca8@ti.com>
Date:   Wed, 25 Jan 2023 11:41:11 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Bao Cheng Su <baocheng.su@siemens.com>,
        Chao Zeng <chao.zeng@siemens.com>, <s-vadapalli@ti.com>
Subject: Re: [PATCH v2 3/3] arm64: dts: ti: iot2050: Add support for M.2
 variant
Content-Language: en-US
To:     Jan Kiszka <jan.kiszka@siemens.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <cover.1674110442.git.jan.kiszka@siemens.com>
 <878e3a023767b5a6d9d2cff09015678aaba13fce.1674110442.git.jan.kiszka@siemens.com>
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <878e3a023767b5a6d9d2cff09015678aaba13fce.1674110442.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/01/23 12:10, Jan Kiszka wrote:
> From: chao zeng <chao.zeng@siemens.com>
> 
> The M.2 variant comes with 2 slots, one B-keyed and another one E-keyed.
> They are configured by the firmware during startup. Also the device tree
> will be adjusted according to the detect or manually configured
> interface mode by the firmware. The kernel only carries a single
> configuration as base device tree. It has to be built with a symbols
> node so that the firmware can apply overlays for the connector modes.
> 
> Signed-off-by: chao zeng <chao.zeng@siemens.com>
> [Jan: refactored to a single DT]
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  arch/arm64/boot/dts/ti/Makefile               |   3 +
>  .../dts/ti/k3-am6548-iot2050-advanced-m2.dts  | 121 ++++++++++++++++++
>  2 files changed, 124 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-m2.dts

Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Regards,
Siddharth.
