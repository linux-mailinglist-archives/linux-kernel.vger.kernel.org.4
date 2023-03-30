Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 379C26D08DE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 16:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232580AbjC3O4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 10:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232587AbjC3O4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 10:56:42 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76BF24693;
        Thu, 30 Mar 2023 07:56:15 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32UEtJHC075277;
        Thu, 30 Mar 2023 09:55:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1680188119;
        bh=wNm+G8JZpsdj/a6eZfrH8Tk+PMcuu9QE5Gnk8uY1tKk=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=ORFaE0T2lAXaCAcM4twLBnD1QtZ0qLrHN4Xr46VAoxWDT0GINyhtl1A3are8C0I1M
         QuS9X05pe5UI/WMdV9kq/HgM5iYTTjBz+l2Ia/1sTSm2e1f8Uv2koqU+chdviO3y0R
         R6S5MGFfiAV9M257mMNcXQYUw7VVTukTiqnvLmeM=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32UEtJM8005145
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 30 Mar 2023 09:55:19 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 30
 Mar 2023 09:55:18 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 30 Mar 2023 09:55:18 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32UEtIpl092701;
        Thu, 30 Mar 2023 09:55:18 -0500
Date:   Thu, 30 Mar 2023 09:55:18 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Hari Nagalla <hnagalla@ti.com>
CC:     <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] Add R5F and C71 DSP nodes for J784S4 SoC
Message-ID: <20230330145518.icy53f4jdmqqonzt@shrink>
References: <20230330141536.22480-1-hnagalla@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230330141536.22480-1-hnagalla@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09:15-20230330, Hari Nagalla wrote:
> This series adds the R5F cluster and C71 DSP processor nodes for
> J784S4 SoC.
> 
> The first patch adds R5F cluster nodes to the MAIN and MCU voltage 
> domains of J784S4 SoC. The second patch adds the C71 DSP processor 
> nodes to the MAIN voltage domain of J784S4 SoC.
> 
> Changes in V2:
> - Removed default disable of R5F nodes in the SoC device tree.
> - Consolidated R5F nodes into one patch.
> 
> V1: https://lore.kernel.org/all/20230329093627.30719-1-hnagalla@ti.com/
> 
> Hari Nagalla (2):
>   arm64: dts: ti: k3-j784s4-main: Add R5F cluster nodes
>   arm64: dts: ti: k3-j784s4-main: Add C71x DSP nodes
> 
>  arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi    | 168 ++++++++++++++++++
>  .../boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi     |  40 +++++
>  2 files changed, 208 insertions(+)
> 
> -- 
> 2.17.1
> 

No specific need for board file memory reservations for DDR?

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
