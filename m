Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5432C6B7CF4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 17:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbjCMQBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 12:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbjCMQBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 12:01:11 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32BBC6F607;
        Mon, 13 Mar 2023 09:01:10 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32DG0sBG063173;
        Mon, 13 Mar 2023 11:00:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678723254;
        bh=Awmvg1GDhNnVInkQk6Cb2o9UZJ+KkyEbkoZRO2S9CfQ=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=fEjwJmr27zRBtt6dLvWrhTdFBT10sdrlo+mddNmVZXVTkED7EB/1qPuVCmah4vvwm
         pxE6m6w1klpvdK3kd2P3ZjOhpRvojy4I2zlIuBunlXGA2qjHlxeHN7seTrX1clnPR/
         copTvxlSqAmCkbCFnqga5iEvGbCcFdhn/P2NB/+k=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32DG0sQv010488
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 13 Mar 2023 11:00:54 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 13
 Mar 2023 11:00:54 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 13 Mar 2023 11:00:54 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32DG0suI017825;
        Mon, 13 Mar 2023 11:00:54 -0500
Date:   Mon, 13 Mar 2023 11:00:54 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Julien Panis <jpanis@baylibre.com>, Bryan Brattlof <bb@ti.com>,
        Jason Kridner <jkridner@gmail.com>,
        Robert Nelson <robertcnelson@gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: arm: ti: Add bindings for BeaglePlay
Message-ID: <20230313160054.zd2giwg7yp7g7a72@civil>
References: <20230311111022.23717-1-nm@ti.com>
 <20230311111022.23717-2-nm@ti.com>
 <9b6fbb54-705d-3e3a-b7e7-ec62297929cb@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9b6fbb54-705d-3e3a-b7e7-ec62297929cb@linaro.org>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17:00-20230311, Krzysztof Kozlowski wrote:
> On 11/03/2023 12:10, Nishanth Menon wrote:
> > From: Robert Nelson <robertcnelson@gmail.com>
> > 
> > This board is based on ti,am625
> 
> Subject: drop second/last, redundant "bindings for". The "dt-bindings"
> prefix is already stating that these are bindings.
> 
> > 
> > https://beagleplay.org/
> > https://git.beagleboard.org/beagleplay/beagleplay
> > 
> > Co-developed-by: Nishanth Menon <nm@ti.com>
> > Signed-off-by: Nishanth Menon <nm@ti.com>
> > Signed-off-by: Robert Nelson <robertcnelson@gmail.com>
> 
> Your chain order is not correct. If Robert is the author, his SoB is first.

Thanks for reviewing. will fixup and redo the series.
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
