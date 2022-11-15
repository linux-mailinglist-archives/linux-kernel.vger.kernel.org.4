Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19A936290F4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 04:47:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232705AbiKODr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 22:47:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232129AbiKODrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 22:47:53 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6459618B32;
        Mon, 14 Nov 2022 19:47:52 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2AF3lXDl046894;
        Mon, 14 Nov 2022 21:47:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1668484053;
        bh=DAyGAvQcALNNcdOML03ABfBDPkIyZVxBazgfyhiFj8M=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=zDxbXj1NTKdO7ODd/cl3UG5sgS0SKZUaQD17R28prFWYG4WurJ6NlOhwzV5z24qN8
         I3xxIIkkRehhComt7dtdMfnyoCe+w9NhoeBliJl4box6zgklipL0uOlzaaO/t6ja9q
         U8RD/PxhDFQOrQXLDLJOTbgwea9hnW7ip3GRXJCY=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2AF3lXvj015439
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 14 Nov 2022 21:47:33 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Mon, 14
 Nov 2022 21:47:32 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Mon, 14 Nov 2022 21:47:32 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2AF3lWZa125051;
        Mon, 14 Nov 2022 21:47:32 -0600
Date:   Mon, 14 Nov 2022 21:47:32 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Sinthu Raja <sinthu.raja@mistralsolutions.com>
CC:     Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sinthu Raja <sinthu.raja@ti.com>
Subject: Re: [PATCH V2 3/3] arm64: dts: ti: k3-am68-sk: Add support for AM68
 SK base board
Message-ID: <20221115034732.6ssep564capdukrb@smilingly>
References: <20221107123852.8063-1-sinthu.raja@ti.com>
 <20221107123852.8063-4-sinthu.raja@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221107123852.8063-4-sinthu.raja@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18:08-20221107, Sinthu Raja wrote:
> From: Sinthu Raja <sinthu.raja@ti.com>
> 
> The SK architecture comprises of baseboard and a SOM board. The
> AM68 Starter Kit's baseboard contains most of the actual connectors,
> power supply etc. The System on Module (SoM) is plugged on to the base
> board. Therefore, add support for peripherals brought out in the base
> board.
> 
> Schematics: https://www.ti.com/lit/zip/SPRR463
> 
> Signed-off-by: Sinthu Raja <sinthu.raja@ti.com>
> ---
[...]

> +&main_i2c1 {
> +	status = "disabled";
> +};
> +
> +&main_i2c2 {
> +	status = "disabled";
> +};
> +
> +&main_i2c3 {
> +	status = "disabled";
> +};
> +
> +&main_i2c4 {
> +	status = "disabled";
> +};
> +
> +&main_i2c5 {
> +	status = "disabled";
> +};
> +
> +&main_i2c6 {
> +	status = "disabled";
> +};
> +
> +&main_sdhci0 {
> +	status = "disabled";
> +};

Please revisit all of the nodes to ensure that the ones that are
necessary are enabled? I think most of these are already disabled by
default. We just finished doing a major cleanup.

[...]

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
