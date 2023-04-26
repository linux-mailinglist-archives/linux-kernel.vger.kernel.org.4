Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6C7C6EF4BF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 14:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240929AbjDZMxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 08:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240523AbjDZMxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 08:53:47 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32918E3;
        Wed, 26 Apr 2023 05:53:46 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33QCrZ9d039011;
        Wed, 26 Apr 2023 07:53:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1682513615;
        bh=LkGXVsPxoachHj8O1ivE5mcz8LfOYbVHeiXClAWVlMQ=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=Di7x2By6Ocjw3LMrPBT6ersBOHLzZnALb4oj8VmF2Fz4iJ+Yh7pxhz+t47LQzG/y8
         tu6iXQNyGqbI7LpOZCdrvOVaxgei+Xy/XVdv2rBboGWHP2nRBojJ6dg/Tgn3deWLop
         4Jc9GtWO+BVMe2g75lFrRf8JwahGmWwEcBsKPujs=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33QCrZXr025291
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 Apr 2023 07:53:35 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 26
 Apr 2023 07:53:35 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 26 Apr 2023 07:53:34 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33QCrZuA048113;
        Wed, 26 Apr 2023 07:53:35 -0500
Date:   Wed, 26 Apr 2023 07:53:34 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Aradhya Bhatia <a-bhatia1@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>, Andrew Davis <afd@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        Tomi Valkeinen <tomba@kernel.org>,
        Praneeth Bajjuri <praneeth@ti.com>,
        Rahul T R <r-ravikumar@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Jai Luthra <j-luthra@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>
Subject: Re: [PATCH v2 1/2] arm64: dts/ti: am65x: Add Rocktech OLDI panel DT
 overlay
Message-ID: <20230426125334.flj6ndo6s7esmcho@scotch>
References: <20230426060612.19271-1-a-bhatia1@ti.com>
 <20230426060612.19271-2-a-bhatia1@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230426060612.19271-2-a-bhatia1@ti.com>
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

On 11:36-20230426, Aradhya Bhatia wrote:
[...]
>  # Boards with J7200 SoC
>  dtb-$(CONFIG_ARCH_K3) += k3-j7200-common-proc-board.dtb
> diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board-rocktech-rk101-panel.dtso b/arch/arm64/boot/dts/ti/k3-am654-base-board-rocktech-rk101-panel.dtso
> new file mode 100644
> index 000000000000..aed6dcf3bd7d
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-am654-base-board-rocktech-rk101-panel.dtso
> @@ -0,0 +1,69 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/**
> + * OLDI-LCD1EVM Rocktech integrated panel and touch DT overlay for AM654-EVM.

product link please.


-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
