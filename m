Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E918F7243C2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 15:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238036AbjFFNIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 09:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238011AbjFFNIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 09:08:19 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 297781703;
        Tue,  6 Jun 2023 06:08:02 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 356D7NPM076728;
        Tue, 6 Jun 2023 08:07:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1686056843;
        bh=NuUYsHBctHkJMAM4oZx7kb45p1rXxq5XgORegvDCYw4=;
        h=Date:From:Subject:To:CC:References:In-Reply-To;
        b=pIVjpiVCW0mKGIOZujeX/n3m6RaCdFugM9CfU+/F2P2BcQYVv+uuhArBgxkwu8yz4
         bUckort9opdNxBmjAvL2YqM/scSTqxGEx1/x06o7UVWfSYDchPNtpgo++j/sfObGJt
         dG7IgtXeT2Nfn5QhnaDMrdH97Aaju5jiMTW5z1wA=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 356D7N1X111130
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 6 Jun 2023 08:07:23 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 Jun 2023 08:07:22 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 Jun 2023 08:07:23 -0500
Received: from [10.249.141.75] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 356D7IMd005842;
        Tue, 6 Jun 2023 08:07:19 -0500
Message-ID: <d8336b60-d7cc-0479-2a70-2f707c0a1156@ti.com>
Date:   Tue, 6 Jun 2023 18:37:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
From:   "Kumar, Udit" <u-kumar1@ti.com>
Subject: Re: [PATCH 0/6] arm64: dts: ti: k3-j721s2: Mux fixups and eeprom misc
To:     Nishanth Menon <nm@ti.com>, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Nitin Yadav <n-yadav@ti.com>,
        Neha Malcom Francis <n-francis@ti.com>,
        Sinthu Raja <sinthu.raja@ti.com>, <u-kumar1@ti.com>
References: <20230602153554.1571128-1-nm@ti.com>
Content-Language: en-US
In-Reply-To: <20230602153554.1571128-1-nm@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Nishanth

On 6/2/2023 9:05 PM, Nishanth Menon wrote:
> Hi,
>
> This is an expansion of Sinthu's series[1] for J721s2, fixing a few aspects
> of his patches and adding uart, eeprom detection etc.
>
> This set of changes picksup fixes seen in u-boot and else where an
> consolidates into kernel as the definitive device tree description
>
> Testing logs: https://gist.github.com/nmenon/2acfc566d0b215fe941c42317d9ac955
>
> Changes:
> * Fixups to the wkup_pmx0 patch to limit stable tree to 6.3
> * Fixups to Rpi header patch for mcu_i2c0 pinmux
> * Additional patches for eeprom and wkup/mcu uarts.
>
> -- Sinthu's series history:
> Changes in V5[1]:
> -Remove main padconfig split patch which is not required.
>
> Changes in V4:
> - Address review comments
>    * Update main and wakeup domain IO padconfig
>    * Correct the pinctrl node offsets as per the newly split wkup_pmx*
>      and main_pmx* nodes.
>
> Changes in V3:
> - Add Fixes tag.
>
> Changes in V2:
> - Update commit description.
> - Update the offset value to 0x194 as 0x190 is the last register of the
>    IO PADCONFIG register set.
>
> V1: https://lore.kernel.org/all/20230123135831.4184-1-sinthu.raja@ti.com/
> V2: https://lore.kernel.org/lkml/20230124120311.7323-1-sinthu.raja@ti.com/T/
> V3: https://lore.kernel.org/linux-arm-kernel/20230316114102.3602-2-sinthu.raja@ti.com/T/
> V4: https://lore.kernel.org/lkml/20230424081536.12123-1-sinthu.raja@ti.com/
> V5[1]: https://lore.kernel.org/linux-arm-kernel/20230504073432.6438-1-sinthu.raja@ti.com/
>
> Nishanth Menon (4):
>    arm64: dts: ti: k3-am68-sk-base-board: Add uart pinmux
>    arm64: dts: ti: k3-am68-sk-som: Enable wakeup_i2c0 and eeprom
>    arm64: dts: ti: k3-j721s2-common-proc-board: Add uart pinmux
>    arm64: dts: ti: k3-j721s2-som-p0: Enable wakeup_i2c0 and eeprom
>
> Sinthu Raja (2):
>    arm64: dts: ti: k3-j721s2: Fix wkup pinmux range
>    arm64: dts: ti: k3-am68-sk-base-board: Add pinmux for RPi Header


Reviewed-by: Udit Kumar <u-kumar1@ti.com>


>   .../boot/dts/ti/k3-am68-sk-base-board.dts     | 145 +++++++++++++++---
>   arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi    |  22 +++
>   .../dts/ti/k3-j721s2-common-proc-board.dts    |  99 +++++++-----
>   .../boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi     |  29 +++-
>   arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi  |  22 +++
>   5 files changed, 255 insertions(+), 62 deletions(-)
>
