Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 669B06BE181
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 07:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbjCQGrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 02:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjCQGre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 02:47:34 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D47B6D19;
        Thu, 16 Mar 2023 23:47:31 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32H6lJka125450;
        Fri, 17 Mar 2023 01:47:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1679035639;
        bh=Kj4OXlE4Q03VX7jLUMN8AZkRKlE0uMcb0SFcR/vo/lk=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=iAy2at1U05gxphTigmccUa8o/oQ7tCCq6LLxvcIEOTc7lZpyUcMK+82+tet8sTlPd
         TOhFkHFZf4RFGWyda2dA5TmTtlltPgu7Iet7xfvSJX5FZcoWGjZsN2C0wvcLOPhcxp
         WHssbNHANunVZtPOjJaVQX4oS6ZXPO6Rw2vkkA6o=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32H6lJ6E118052
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 17 Mar 2023 01:47:19 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Fri, 17
 Mar 2023 01:47:19 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Fri, 17 Mar 2023 01:47:19 -0500
Received: from [10.249.132.105] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32H6lCZC060956;
        Fri, 17 Mar 2023 01:47:13 -0500
Message-ID: <53d78cde-1316-4b07-bf07-525b3f6c77c1@ti.com>
Date:   Fri, 17 Mar 2023 12:17:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH V2 0/3] arm64: dts/defconfig/binding: Add support for
 BeaglePlay
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Julien Panis <jpanis@baylibre.com>, Bryan Brattlof <bb@ti.com>,
        Andrew Davis <afd@ti.com>, Jason Kridner <jkridner@gmail.com>,
        Robert Nelson <robertcnelson@gmail.com>
References: <20230316152143.2438928-1-nm@ti.com>
From:   Dhruva Gole <d-gole@ti.com>
In-Reply-To: <20230316152143.2438928-1-nm@ti.com>
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

Thanks for upstreaming!

On 16/03/23 20:51, Nishanth Menon wrote:
> Hi,
>
> BeagleBoard.org BeaglePlay[1][2] is an easy to use, affordable open source
> hardware single board computer based on the Texas Instruments AM625
> SoC. Add the base support for the same.
>
> Bootlog: https://gist.github.com/nmenon/2e7647970a4d6af05017e545ac0f8218
>
> Changes Since v1: (major ones)
> - All patches updated
> - signed-off-by order fixups
> - Cleanup to drop errant pre-production board vestiges
> - defconfig adds SPI to get to mikrobus spi interface.
>
> V1: https://lore.kernel.org/all/20230311111022.23717-1-nm@ti.com/
>
> Nishanth Menon (1):
>   arm64: defconfig: Enable drivers for BeaglePlay
>
> Robert Nelson (2):
>   dt-bindings: arm: ti: Add BeaglePlay
>   arm64: dts: ti: Add k3-am625-beagleplay
>
>  .../devicetree/bindings/arm/ti/k3.yaml        |   1 +
>  arch/arm64/boot/dts/ti/Makefile               |   1 +
>  .../arm64/boot/dts/ti/k3-am625-beagleplay.dts | 757 ++++++++++++++++++
>  arch/arm64/configs/defconfig                  |   8 +
>  4 files changed, 767 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
>
> [1] https://beagleplay.org/
> [2] https://git.beagleboard.org/beagleplay/beagleplay

For the series,
Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

