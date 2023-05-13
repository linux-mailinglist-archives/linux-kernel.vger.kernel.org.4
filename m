Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7419C7016C0
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 14:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237639AbjEMMgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 08:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232713AbjEMMgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 08:36:09 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1CD44A9;
        Sat, 13 May 2023 05:35:39 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34DCZM3j088989;
        Sat, 13 May 2023 07:35:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1683981322;
        bh=xvqahp41WmH/454iKL1t3iUZ5evTQtMfif9PkjQpEMs=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=uFDaWmxDcEiQvfKPlO4QJ2i1Go9hDJV7VLnlY/ugn77we65CfJKZOFQ5NsMUJTNGp
         0MqtBsEhNrisyXK6GOZEnpW42ybT7h7fyf0CQcRBvQiqIlHg92SowVQjZ4NiaQrsz/
         dMd5VaPDRdQAdAUr4WR6Ipl06wpPu/U00vhVqQ4E=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34DCZMD0067312
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 13 May 2023 07:35:22 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 13
 May 2023 07:35:22 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 13 May 2023 07:35:22 -0500
Received: from [10.24.69.141] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34DCZJwv098749;
        Sat, 13 May 2023 07:35:19 -0500
Message-ID: <ddf22223-f8af-72ec-e8cf-76563f86b7fa@ti.com>
Date:   Sat, 13 May 2023 18:05:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 0/4] arm64: dts: ti: j721e: Add HyperFlash support
Content-Language: en-US
To:     <nm@ti.com>, <afd@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>
References: <20230505141407.15134-1-vaishnav.a@ti.com>
From:   Vaishnav Achath <vaishnav.a@ti.com>
In-Reply-To: <20230505141407.15134-1-vaishnav.a@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 05/05/23 19:44, Vaishnav Achath wrote:
> This series adds hyperflash support for J721E. J721E SoC has HyperBus
> and OSPI controller muxed within the FSS subsystem and the J721E SoM
> has a 64 MiB S28 OSPI flash and a 64 MiB Hyperflash present which is
> muxed externally also.

I have sent a v2 of this series with feedback addressed from a similar
series and also adding the hyperflash partitions:

https://lore.kernel.org/all/20230513123313.11462-1-vaishnav.a@ti.com/

Thanks and Regards,
Vaishnav

> 
> * Patch 1/4 adds the hyperbus controller nodes and fixes DT compile
> warnings.
> * Patch 2/4 adds the hyperflash support in the SoM DTS.
> * Patch 3 and 4/4 enables the pinmux for external mux that selects
> between hyperflash or OSPI NOR flash, this is done for J7200 and 
> J721E platforms since it is required in U-Boot and helps keep the
> DT in sync.
> 
> Patch 1/4 depends on the following patch:
> https://lore.kernel.org/all/20230424184810.29453-1-afd@ti.com/
> 
> Patch 3 depends on the below fix for pinmux offsets in J7200:
> https://lore.kernel.org/all/20230419040007.3022780-2-u-kumar1@ti.com/
> 
> Bootlog and basic hyperflash erase-write-read test:
> https://gist.github.com/vaishnavachath/be652108f3e360f1e2d41b499df844ef
> 
> Thanks and Regards,
> Vaishnav
> 
> Vaishnav Achath (4):
>   arm64: dts: ti: k3-j721e-mcu-wakeup: Add HyperBus node
>   arm64: dts: ti: k3-j721e-som-p0: Add HyperFlash node
>   arm64: dts: ti: k3-j7200-common-proc-board: Add OSPI/Hyperflash select
>     pinmux
>   arm64: dts: ti: k3-j721e-common-proc-board: Add OSPI/Hyperflash select
>     pinmux
> 
>  .../dts/ti/k3-j7200-common-proc-board.dts     | 11 ++++++
>  .../dts/ti/k3-j721e-common-proc-board.dts     | 11 ++++++
>  .../boot/dts/ti/k3-j721e-mcu-wakeup.dtsi      | 25 +++++++++++--
>  arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi   | 35 +++++++++++++++++++
>  4 files changed, 80 insertions(+), 2 deletions(-)
> 
