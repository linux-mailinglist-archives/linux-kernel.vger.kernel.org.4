Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 607456F5771
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 13:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjECLwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 07:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjECLwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 07:52:33 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0185E619C;
        Wed,  3 May 2023 04:52:08 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 343BpUc4116898;
        Wed, 3 May 2023 06:51:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1683114690;
        bh=0bc4uxJ3QNL7TupRSDyhXckx3Cj2zST7F454qt74Zto=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=YhxYkWGSIMRRwqQzPRTaBoBS0N1YVjsBP8PWwG2rLyOJX2o3LcxBd7yYjnclnBkJY
         MYI/6oCOVZg3x36jcAiTyOUdnkb5PX0L4kVmRr2v0wCG2nDRV0Gq1TVVV9vREO1NNM
         a8wHN2ShQH0xallvoTpa9jaUXsI9myEDbxOAAVJg=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 343BpUOe124374
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 3 May 2023 06:51:30 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 3
 May 2023 06:51:30 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 3 May 2023 06:51:30 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 343BpUHB045349;
        Wed, 3 May 2023 06:51:30 -0500
Date:   Wed, 3 May 2023 06:51:30 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Vaishnav Achath <vaishnav.a@ti.com>
CC:     <kristo@kernel.org>, <vigneshr@ti.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <u-kumar1@ti.com>
Subject: Re: [PATCH 0/4] arm64: dts: ti: Describe flash partitions for J7
 platforms
Message-ID: <20230503115130.c7m4a7crub7kmfjw@gluten>
References: <20230503091218.25899-1-vaishnav.a@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230503091218.25899-1-vaishnav.a@ti.com>
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

On 14:42-20230503, Vaishnav Achath wrote:
> This series adds flash partition description through DT, currently
> the flash partitions for J7 platforms is described through the mtdparts
> commandline parameter passed from bootloader, this requires maintenance
> of the partition information in a mtdparts string which is error prone.
> 
> Once the flash partitions are described through DT, the support for
> mtdparts can be removed for these platforms from u-boot also.
> 
> Vaishnav Achath (4):
>   arm64: dts: ti: k3-j721e-som: Describe OSPI flash partition info
>   arm64: dts: ti: k3-j721e-som: Describe QSPI flash partition info
>   arm64: dts: ti: k3-j721e-sk: Describe OSPI flash partition info
>   arm64: dts: ti: k3-j7200-som: Describe OSPI and Hyperflash partition
>     info
> 
>  arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi   | 72 +++++++++++++++++++
>  .../dts/ti/k3-j721e-common-proc-board.dts     | 46 ++++++++++++
>  arch/arm64/boot/dts/ti/k3-j721e-sk.dts        | 46 ++++++++++++
>  arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi   | 46 ++++++++++++
>  4 files changed, 210 insertions(+)

Please address the feedback in [1] prior to adding the partitions? and
could you ensure it is done for all the impacted k3 SoCs?


[1] https://lore.kernel.org/all/f5861b8b-637a-e127-2945-8994a472015a@ti.com/

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
