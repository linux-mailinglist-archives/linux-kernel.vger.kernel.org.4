Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36A0772565C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 09:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239288AbjFGHvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 03:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239239AbjFGHuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 03:50:51 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BBC12729;
        Wed,  7 Jun 2023 00:49:04 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3577mqWf094726;
        Wed, 7 Jun 2023 02:48:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1686124132;
        bh=7NJ+dgk7UIEhM/W0liA02FrdvqzBA1+DSLIPaRM+f54=;
        h=Date:From:Subject:To:CC:References:In-Reply-To;
        b=scZpAPsMMnITZqvfC1KAQZBeGGFS/YOLELQbaYi9/Zgn3ZUhUpxPOkEfnRgV8ybQ8
         zyCniBSnvD5iVhRmypyiPyVVpOPZQRTwRjZgBkr86eaMWdScSmBl+XOtk0HiuOI98b
         IEBCZDCH+DwBORjwAWXBG3vR72MrXR6yDmXh31xs=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3577mqN9007058
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 7 Jun 2023 02:48:52 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 7
 Jun 2023 02:48:52 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 7 Jun 2023 02:48:52 -0500
Received: from [172.24.156.169] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3577mntV024390;
        Wed, 7 Jun 2023 02:48:49 -0500
Message-ID: <9bda1e31-9d4b-151b-fcde-13c1f947ac8d@ti.com>
Date:   Wed, 7 Jun 2023 13:18:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
From:   "Kumar, Udit" <u-kumar1@ti.com>
Subject: Re: [PATCH V2 00/14] arm64: dts: ti: Fix up references to phandles
To:     Nishanth Menon <nm@ti.com>, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, <u-kumar1@ti.com>
References: <20230606182220.3661956-1-nm@ti.com>
Content-Language: en-US
In-Reply-To: <20230606182220.3661956-1-nm@ti.com>
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

On 6/6/2023 11:52 PM, Nishanth Menon wrote:
> When referring to array of phandles, using <> to separate the array
> entries is better notation as it makes potential errors with phandle and
> cell arguments easier to catch. Fix the outliers to be consistent with
> the rest of the usage.
>
> This set was caught by using: git grep '\s&' arch/arm64/boot/dts/ti/
> and manually going through the list.
>
> Changes since V1:
> * Few formatting changes included to keep consistent
> * Picked a Reviewed-by
> * ai64 gets a few fixes as part of the cleanup (patches #3, #4)
> * Picked up Reviewed-by from Jan.
>
> V1:https://lore.kernel.org/all/20230601152636.858553-1-nm@ti.com/
>
> Nishanth Menon (14):
>    arm64: dts: ti: k3-j721e-sk: Fixup reference to phandles array
>    arm64: dts: ti: k3-j721e-som-p0/common-proc-board: Fixup reference to
>      phandles array
>    arm64: dts: ti: k3-j721e-beagleboneai64: Move camera gpio pinctrl to
>      gpio node
>    arm64: dts: ti: k3-j721e-beagleboneai64: Move eeprom WP gpio pinctrl
>      to eeprom node
>    arm64: dts: ti: k3-j721e-beagleboneai64: Fixup reference to phandles
>      array
>    arm64: dts: ti: k3-am642-phyboard-electra-rdk: Fixup reference to
>      phandles array
>    arm64: dts: ti: k3-j7200-som/common-proc-board: Fixup reference to
>      phandles array
>    arm64: dts: ti: k3-j721s2-common-proc-board: Fixup reference to
>      phandles array
>    arm64: dts: ti: k3-am625-sk: Fixup reference to phandles array
>    arm64: dts: ti: k3-am64-evm: Fixup reference to phandles array
>    arm64: dts: ti: k3-am64-sk: Fixup reference to phandles array
>    arm64: dts: ti: k3-am65-iot*: Fixup reference to phandles array
>    arm64: dts: ti: k3-am654-base-board: Fixup reference to phandles array
>    arm64: dts: ti: k3-am68-sk-base-board: Fixup reference to phandles
>      array


Reviewed by : Udit Kumar <u-kumar1@ti.com>

>   arch/arm64/boot/dts/ti/k3-am625-sk.dts        |  3 +-
>   arch/arm64/boot/dts/ti/k3-am642-evm.dts       | 11 +++---
>   .../dts/ti/k3-am642-phyboard-electra-rdk.dts  |  2 +-
>   arch/arm64/boot/dts/ti/k3-am642-sk.dts        | 11 +++---
>   .../boot/dts/ti/k3-am65-iot2050-common.dtsi   | 17 +++++----
>   .../arm64/boot/dts/ti/k3-am654-base-board.dts |  4 +--
>   .../dts/ti/k3-am6548-iot2050-advanced-m2.dts  | 18 +++++-----
>   .../boot/dts/ti/k3-am68-sk-base-board.dts     |  2 +-
>   .../dts/ti/k3-j7200-common-proc-board.dts     |  2 +-
>   arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi   |  8 ++---
>   .../boot/dts/ti/k3-j721e-beagleboneai64.dts   | 36 +++++++++++--------
>   .../dts/ti/k3-j721e-common-proc-board.dts     |  4 +--
>   arch/arm64/boot/dts/ti/k3-j721e-sk.dts        | 20 +++++------
>   arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi   | 18 +++++-----
>   .../dts/ti/k3-j721s2-common-proc-board.dts    |  2 +-
>   15 files changed, 80 insertions(+), 78 deletions(-)
>
