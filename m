Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36BDA6CBE08
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 13:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbjC1Lr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 07:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232377AbjC1Lrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 07:47:55 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56BC05FF7;
        Tue, 28 Mar 2023 04:47:54 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32SBlh76060327;
        Tue, 28 Mar 2023 06:47:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1680004063;
        bh=nRCPznyG8qPMq1TD0NttucUdDHIhiajZD9URKVA9jYE=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=HsM/O1c/VajqKfKZY7Vu1YEbwf0aHPBqJY9KjWFWDZp0bS3GA+2Kze66z6vTRmlW5
         W+yTX1XmYqZEiIIau4jdpjGNBY+bHCdEapXkT7e4pg56MMth1UJUFzBnWDA+JhIuM5
         SdgyznJdAvinRp1pl6JfYRPmG1fcG53qNdtup4S4=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32SBlh1J026415
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 28 Mar 2023 06:47:43 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 28
 Mar 2023 06:47:43 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 28 Mar 2023 06:47:43 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32SBlghd120488;
        Tue, 28 Mar 2023 06:47:42 -0500
Date:   Tue, 28 Mar 2023 06:47:42 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Vaishnav Achath <vaishnav.a@ti.com>
CC:     Sinthu Raja <sinthu.raja@mistralsolutions.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sinthu Raja <sinthu.raja@ti.com>
Subject: Re: [PATCH V3 1/2] arm64: dts: ti: k3-j721s2-mcu-wakeup: Fix IO
 PADCONFIG size for wakeup domain
Message-ID: <20230328114742.tnaa5hi3qm3rsgld@ecology>
References: <20230316114102.3602-1-sinthu.raja@ti.com>
 <20230316114102.3602-2-sinthu.raja@ti.com>
 <5f08cb2f-d2de-8e4e-a9be-1ef3a5fd3a39@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5f08cb2f-d2de-8e4e-a9be-1ef3a5fd3a39@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16:48-20230328, Vaishnav Achath wrote:
> Hi Sinthu,
> 
> On 16/03/23 17:11, Sinthu Raja wrote:
> > From: Sinthu Raja <sinthu.raja@ti.com>
> > 
> > The size of wkup domain I/O PADCONFIG register set is incorrect for J721S2.
> > Therefore, update the PADCONFIG total offset size to the correct value for
> > J721S22 SoC.
> > 
> > Fixes: b8545f9d3a54 ("arm64: dts: ti: Add initial support for J721S2 SoC")
> > Signed-off-by: Sinthu Raja <sinthu.raja@ti.com>
> > ---
> > 
> > Changes in V3:
> > - Added Fix tag
> > 
> > Changes in V2:
> > - Update commit description.
> > - Update the offset value to 0x194 because 0x190 is the last register of the
> >   IO PADCONFIG register set.
> > 
> 
> The existing PADCONFIG register region descriptions in the pinctrl nodes seems
> to be incorrect for j721s2-main and j721s2-mcu-wakeup due to non-addressable
> holes in the region which causes bus aborts when the registers are read and
> causes system crash if we read something like,
> /sys/kernel/debug/pinctrl/4301c000.pinctrl-pinctrl-single/pins
> 
> This is what I saw from inspection of the datasheet:
> 
> * WKUP_PADCONFIG13, WKUP_PADCONFIG25 missing in WKUP_PADCONFIG region
> * MAIN_PADCONFIG 64-68 missing in MAIN_PADCONFIG region
> 
> I have verified that your patch does not introduce new issues, but since it is a
> Fix patch, I will defer the decision to the maintainers on whether we should
> split the nodes to avoid non-addressable regions and fix it completely here or
> later do a fix for the split.

Do a single fix-up please.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
