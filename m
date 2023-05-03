Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D63766F5785
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 14:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjECMCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 08:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjECMCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 08:02:09 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA4875585;
        Wed,  3 May 2023 05:02:08 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 343C21r5032374;
        Wed, 3 May 2023 07:02:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1683115321;
        bh=MIf99BfN5GAxrHPaX4Iy2F4CqpygWl3DmZAiV3GRb4k=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=E62KV0rtoPz0Yms9hQ0jCw9GcQfOKDoEArrOh3e+2pcR+orw2TJTqDloY+gPVRwMS
         ZJFQEltbfGkPgszWsdD5fIIxLGRhL+DMx4jf3zBuD5I2/QWT6K7NufAJkIEjKvfivA
         e9Fer8xnpPB2DpQmLNy/zTCPsp7F8/Ed4PgTu4ZM=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 343C21Kn045508
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 3 May 2023 07:02:01 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 3
 May 2023 07:02:01 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 3 May 2023 07:02:01 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 343C20fk030040;
        Wed, 3 May 2023 07:02:00 -0500
Date:   Wed, 3 May 2023 07:02:00 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Neha Malcom Francis <n-francis@ti.com>
CC:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <u-kumar1@ti.com>
Subject: Re: [PATCH v4 2/3] arm64: dts: ti: k3-j721e: Add ESM support
Message-ID: <20230503120200.4xqylyoiczx43esu@gradation>
References: <20230503093310.85779-1-n-francis@ti.com>
 <20230503093310.85779-3-n-francis@ti.com>
 <20230503114827.lutd2ebygxczvali@argue>
 <82a39b8e-96ad-faa2-714f-c8c6bfbcc5d6@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <82a39b8e-96ad-faa2-714f-c8c6bfbcc5d6@ti.com>
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

On 17:25-20230503, Neha Malcom Francis wrote:
> Hi Nishanth,
> 
> On 03/05/23 17:18, Nishanth Menon wrote:
> > On 15:03-20230503, Neha Malcom Francis wrote:
> > > Add address entry mapping ESM on J721E.
> > > 
> > > Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> > > ---
> > >   arch/arm64/boot/dts/ti/k3-j721e.dtsi | 1 +
> > >   1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/arch/arm64/boot/dts/ti/k3-j721e.dtsi b/arch/arm64/boot/dts/ti/k3-j721e.dtsi
> > > index b912143b6a11..52bcde601eb8 100644
> > > --- a/arch/arm64/boot/dts/ti/k3-j721e.dtsi
> > > +++ b/arch/arm64/boot/dts/ti/k3-j721e.dtsi
> > 
> > Why is'nt esm node introduced here?
> > 
> 
> As it stands esm node is already in
> arch/arm/dts/k3-j721e-r5-common-proc-board.dts in u-boot and since this
> patch is motivated to keep the u-boot and kernel dts in sync, I haven't
> added it here.
> 
> Although... I could add it here similar to j7200 and take action to move to
> the same in u-boot... maybe that is better route.

The core problem we have is that part of the hardware description is in
u-boot and a large part is in kernel. That is wrong. eventually, we will
drop u-boot.dtsi and r5-xyz.dts files.. This cleanup journey is towards
that action.

we want kernel to be the canonical description of the hardware. which
means u-boot or zephyr or something else will eventually just copy the
kernel dts and it has information enough about the hardware to be able
to boot.

each of the dependent ecosystems (u-boot, zephyr etc..) have a little
bit of their own binding extensions (such as binman for u-boot), which
is maintained in their own repos. But, the SoC hardware description,
entirely should be available in kernel device tree.

So, please ensure esm is completely described as well.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
