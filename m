Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5A41716A18
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 18:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232923AbjE3QyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 12:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232735AbjE3QyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 12:54:10 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6035798;
        Tue, 30 May 2023 09:54:09 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34UGrpxp100113;
        Tue, 30 May 2023 11:53:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1685465631;
        bh=qHCVx3BIq9X1uACaU8mCt5w9MrSWYDRDLVsof4y5rJA=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=Eh8lb9rC33+6TEeutiEhe7UQZK1BV5ANIhjVsk8zqYuioZqdjZaaZIogRh6NoV821
         xd/HWQ5bprqWnTEbGU3HFaOxBJsZDstsYiaPbIzwc9kkQ3MMaiytENqkqRumH+k5ba
         +Lq7bP2VaTrjnYArk7gmvpEKQ2jIjLnTlOs7tpvo=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34UGrpVL015854
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 30 May 2023 11:53:51 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 30
 May 2023 11:53:51 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 30 May 2023 11:53:51 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34UGrpJF033406;
        Tue, 30 May 2023 11:53:51 -0500
Date:   Tue, 30 May 2023 11:53:51 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Francesco Dolcini <francesco@dolcini.it>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 3/5] arm64: dts: ti: add verdin am62
Message-ID: <20230530165351.rqpu7go3kw6j3upc@storable>
References: <20230524143631.42471-1-francesco@dolcini.it>
 <20230524143631.42471-4-francesco@dolcini.it>
 <20230530121044.sjhv452b4hs4lyiy@flyer>
 <ZHYl8/8k4CTm/2LW@francesco-nb.int.toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZHYl8/8k4CTm/2LW@francesco-nb.int.toradex.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18:36-20230530, Francesco Dolcini wrote:
> On Tue, May 30, 2023 at 07:10:44AM -0500, Nishanth Menon wrote:
> > On 16:36-20230524, Francesco Dolcini wrote:
> > > +/* Verdin I2C_2_DSI */
> > > +&main_i2c2 {
> > > +	status = "okay";
> > 
> > Here and few other dtsis:
> > you should set status along with pinmux.
> This is already done in the SoM dtsi, same applies to the other comment
> you have on this pinmux topic.
> 
> To rephrase what's hopefully is already written in the commit
> message/series description, or at least it was in my intention.
> 
> The system is modular, with multiple SoM variant and multiple carrier
> boards. Standard interfaces are defined at the family level, e.g.
> already in the SoM, in the carrier board DT file peripherals are just
> enabled, the pinmux is already defined in the common som.dtsi [1][2][3]
> files and the carrier board just use those unless there is some kind of
> non-standard deviation.
> 
> This prevents duplication and simplify writing device tree file for board
> that use standard Verdin family interfaces. This should be visible
> looking at this series in which 3 different boards (Dev, Yavia and
> Dahlia) are added.

It helps clarity if the node is marked "okay" when all the necessary
properties required for operation (in this case pinmux) is enabled. I
don't see a big change as a result. Just stops people from hunting for
where pinmux is actually done.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
