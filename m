Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 371B36B2B47
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 17:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbjCIQ4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 11:56:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbjCIQ4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 11:56:07 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F583B3D4;
        Thu,  9 Mar 2023 08:48:12 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 329Gm1Up087571;
        Thu, 9 Mar 2023 10:48:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678380481;
        bh=gnC04kQptEQ9Ia4i3/2ZlkOrBmNCWxoroUhRnOhhwFY=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=uNuznbS5pJtFbTyyxJOZKbX8vu8gZhFNfSUrLtskR0rbMOcH5waZ995AWRLImLix9
         6gYHyvYNMNo8Rsbf47m3n4bdyaOY4VhJQwbZ/mI2IktV2NFQhNDP7KuMiqimh0F0n2
         TkzvYxWqoHtNOCIfHcvGnT/oJM9FjLM/HC5EaxWM=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 329Gm1k3009012
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 9 Mar 2023 10:48:01 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 9
 Mar 2023 10:48:01 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 9 Mar 2023 10:48:01 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 329Gm0IN096282;
        Thu, 9 Mar 2023 10:48:00 -0600
Date:   Thu, 9 Mar 2023 10:48:00 -0600
From:   Bryan Brattlof <bb@ti.com>
To:     Nitin Yadav <n-yadav@ti.com>
CC:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: ti: k3-am62-main: Fix GPIO numbers in DT
Message-ID: <20230309164800.uhhdol76t3agople@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20230202085917.3044567-1-n-yadav@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20230202085917.3044567-1-n-yadav@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nitin!

On February  2, 2023 thus sayeth Nitin Yadav:
> Fix number of gpio pins in main_gpio0 & main_gpio1
> DT nodes according to AM62x SK datasheet. The Link
> of datasheet is in the following line:
> https://www.ti.com/lit/ds/symlink/am625.pdf?ts=1673852494660
> 
> Section: 6.3.10 GPIO (Page No. 63-67)
>

Thanks for getting this fixed. Should we add a fixes tag to help get 
this back ported?

Fixes: f1d17330a5bedc ("arm64: dts: ti: Introduce base support for AM62x SoC")

> Signed-off-by: Nitin Yadav <n-yadav@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Bryan Brattlof <bb@ti.com>

~Bryan
