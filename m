Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E87F76B8153
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 20:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbjCMTBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 15:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbjCMTBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 15:01:08 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B6C24BCD;
        Mon, 13 Mar 2023 12:00:59 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32DJ0nQM100215;
        Mon, 13 Mar 2023 14:00:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678734049;
        bh=f7SibJ0g7OCvEYjlRgKkp2c4sXa39uu+i19Q2bLGy2c=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=htI2+aZVFxWYs6TyHljSeQeD9l3GrM89iJ+BECtsO6LmReoY6leU8Txp2VOsvoapI
         XdOEJ5PHYzGJkyZ9kRwVMJ/i32e80ohTJIqQcHk3IwuZvaA+LyXvG4Fl8tAWeTxG3q
         sl7qPV/UtiGYBV+tbiZvMKzQ6Hrpuyd6fPcCZvMI=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32DJ0nPF062095
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 13 Mar 2023 14:00:49 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 13
 Mar 2023 14:00:48 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 13 Mar 2023 14:00:48 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32DJ0mPj096301;
        Mon, 13 Mar 2023 14:00:48 -0500
Date:   Mon, 13 Mar 2023 14:00:48 -0500
From:   Bryan Brattlof <bb@ti.com>
To:     Devarsh Thakkar <devarsht@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <kristo@kernel.org>, <nm@ti.com>, <vigneshr@ti.com>,
        <hnagalla@ti.com>, <praneeth@ti.com>, <a-bhatia1@ti.com>,
        <j-luthra@ti.com>
Subject: Re: [PATCH v2] arm64: dts: ti: k3-am62a7-sk: Fix DDR size to full 4GB
Message-ID: <20230313190048.w74clxxsdqxzuhor@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20230210180317.6157-1-devarsht@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20230210180317.6157-1-devarsht@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Devarsh!

On February 10, 2023 thus sayeth Devarsh Thakkar:
> All revisions of AM62A7-SK board have 4GB LPDDR4 Micron
> MT53E2G32D4DE-046 AUT:B memory. Commit 38c4a08c820c ("arm64: dts: ti:
> Add support for AM62A7-SK") enabled just 2GB due to a schematics error
> in early revision of the board. Fix it by enabling full 4GB available on
> the platform.
> 
> Design docs: Link: https://www.ti.com/lit/zip/spruj16

Patch looks great! Though this link doesn't seem to be working. Should 
we use: https://www.ti.com/lit/zip/sprr459 ?

> 
> Fixes: 38c4a08c820c ("arm64: dts: ti: Add support for AM62A7-SK")
> 
> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
> ---
> Logs:
> https://gist.github.com/devarsht/e85b6af89c01ddadb3a62f3e5f196af8
> 
> Changelog:
> V2: Update commit message with mention of schematics error
> ---
>  arch/arm64/boot/dts/ti/k3-am62a7-sk.dts | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 

A part from that

Reviewed-by: Bryan Brattlof <bb@ti.com>

Thanks for getting this fixed up
~Bryan
