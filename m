Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B28326D246B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 17:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232429AbjCaPvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 11:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbjCaPvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 11:51:22 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C02D10D7;
        Fri, 31 Mar 2023 08:51:20 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32VFp7Fx012260;
        Fri, 31 Mar 2023 10:51:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1680277867;
        bh=KzNPFDwn0T4o8QT/2LSy+LHjEGMgXMG4CGFKSBrVnNM=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=W5bOFiRdkhRPIF5bO4KhG1DQl6G0hulg7kRxvGp4j/AtZqs5vrLmErV6xNuAYiGJJ
         D6yod955YD+CtmkmCJWEAQI+eAqsUV700cNU6NGfUmocJZ+n6Gj9zuk1A2qFnK+PEI
         GG9lsnX9XPHNc+Y8rbW30hZuFGSZXNKG4MED3aOc=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32VFp7rh107299
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 31 Mar 2023 10:51:07 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Fri, 31
 Mar 2023 10:51:06 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Fri, 31 Mar 2023 10:51:07 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32VFp6jB093159;
        Fri, 31 Mar 2023 10:51:06 -0500
Date:   Fri, 31 Mar 2023 10:51:06 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Hari Nagalla <hnagalla@ti.com>
CC:     <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] Add R5F and C71 DSP nodes for J784S4 SoC
Message-ID: <20230331155106.fqz34ocerrgd6vnw@facility>
References: <20230330141536.22480-1-hnagalla@ti.com>
 <20230330145518.icy53f4jdmqqonzt@shrink>
 <28d0ce4d-afca-55ee-b471-fe02e71ab262@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <28d0ce4d-afca-55ee-b471-fe02e71ab262@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04:31-20230331, Hari Nagalla wrote:
> On 3/30/23 09:55, Nishanth Menon wrote:
> > >   arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi    | 168 ++++++++++++++++++
> > >   .../boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi     |  40 +++++
> > >   2 files changed, 208 insertions(+)
> > > 
> > > -- 
> > > 2.17.1
> > > 
> > No specific need for board file memory reservations for DDR?
> They are needed in board file, but to be submitted in separate patch set.

Sorry, NAK, please submit as a single series.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
