Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 332606C1867
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 16:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232821AbjCTPXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 11:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232702AbjCTPXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 11:23:35 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3446133472;
        Mon, 20 Mar 2023 08:16:53 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32KFGYpv034602;
        Mon, 20 Mar 2023 10:16:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1679325394;
        bh=C9sXXqW2iF825oetaIpIvqN4rM2y0QzN0WmcolpGLEU=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=Hy9maGONjv3d3cPhTvKmWCN6hOalxwMV49HeaY8p/bvNTP4azdSkKlqyrGqujhhzz
         shAHlbGtz+OgJ/HSA7VRHcfjRgzPhgVieOb5OqCTXSaH26WVfwOhHIGT7yHwHrWxyi
         ZgJoojGX59mm6KB7mxtcKfodyQWzzO3dKZD5kf/c=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32KFGYAw080499
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 20 Mar 2023 10:16:34 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 20
 Mar 2023 10:16:34 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 20 Mar 2023 10:16:34 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32KFGYuc075071;
        Mon, 20 Mar 2023 10:16:34 -0500
Date:   Mon, 20 Mar 2023 10:16:34 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Vaishnav Achath <vaishnav.a@ti.com>
CC:     <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <j-keerthy@ti.com>, <u-kumar1@ti.com>
Subject: Re: [PATCH 0/8] arm64: dts: ti: j7: Add device-tree nodes for MCSPI
Message-ID: <20230320151634.xxcqlqidtqfnhvdt@unknowing>
References: <20230320053022.11093-1-vaishnav.a@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230320053022.11093-1-vaishnav.a@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11:00-20230320, Vaishnav Achath wrote:
> This series adds device tree nodes for Multi Channel Serial Peripheral
> Interface (MCSPI) on J721E, J7200, J721S2 and J784S4 platforms. All the
> MCSPI instances are disabled by default and can be enabled through overlays
> as required, the changes were tested using spidev loopback test for all
> instances and the data verified only for main_spi4 which is connected
> internally as slave to mcu_spi2 for all existing J7 devices.
> 
> Vaishnav Achath (8):
>   arm64: dts: ti: k3-j721e-main: Add MCSPI nodes
>   arm64: dts: ti: k3-j721e-mcu-wakeup: Add MCSPI nodes
>   arm64: dts: ti: k3-j7200-main: Add MCSPI nodes
>   arm64: dts: ti: k3-j7200-mcu-wakeup: Add MCSPI nodes
>   arm64: dts: ti: k3-j721s2-main: Add MCSPI nodes
>   arm64: dts: ti: k3-j721s2-mcu-wakeup: Add MCSPI nodes
>   arm64: dts: ti: k3-j784s4-main: Add MCSPI nodes
>   arm64: dts: ti: k3-j784s4-mcu-wakeup: Add MCSPI nodes

Why split the patches per bus? why not club the patches at SoC level?

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
