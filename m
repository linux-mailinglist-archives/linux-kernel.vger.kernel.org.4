Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB386F6A89
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 13:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbjEDLzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 07:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjEDLzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 07:55:48 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA4159F0;
        Thu,  4 May 2023 04:55:46 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 344BtbM1092376;
        Thu, 4 May 2023 06:55:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1683201337;
        bh=WC6oIIO/22jmcXZttH1IXenhUH8kh9jihyl5MKkpGi0=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=EqaIT48NH7AO+M5DIw9VQqnOH2elU+aHTnSWcMgNwSTwPtNIHWD514ZG8ht2fKTwW
         sxKyKeVGK1b8rljt+4OO1Owr9yEDPjdtfiE1eZF5fxIwZ993jx78cdIF8bs2lL0+dR
         XQqpjewooc1vhSa1gLfrzsT611w1qxtYeuX2hRjI=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 344BtbXX065862
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 4 May 2023 06:55:37 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 4
 May 2023 06:55:37 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 4 May 2023 06:55:37 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 344Btbvt025256;
        Thu, 4 May 2023 06:55:37 -0500
Date:   Thu, 4 May 2023 06:55:37 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Sinthu Raja <sinthu.raja@mistralsolutions.com>
CC:     Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sinthu Raja <sinthu.raja@ti.com>,
        Thejasvi Konduru <t-konduru@ti.com>
Subject: Re: [PATCH V5 1/2] arm64: dts: ti: k3-j721s2: fix wkup pinmux range
Message-ID: <20230504115537.aqdlcz3233eyu56q@pounce>
References: <20230504073432.6438-1-sinthu.raja@ti.com>
 <20230504073432.6438-2-sinthu.raja@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230504073432.6438-2-sinthu.raja@ti.com>
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

minor comment: $subject: s/fix/Fix - Vignesh might fix it up prior to
picking up the series.. but anyways.. just making a side note.

On 13:04-20230504, Sinthu Raja wrote:
> From: Sinthu Raja <sinthu.raja@ti.com>
> 
> The WKUP_PADCONFIG register region in J721S2 has multiple non-addressable
> regions, accordingly split the existing wkup_pmx region as follows to avoid
> the non-addressable regions and include the rest of valid WKUP_PADCONFIG
> registers. Also update references to old nodes with new ones.
> 
> wkup_pmx0 -> 13 pins (WKUP_PADCONFIG 0 - 12)
> wkup_pmx1 -> 11 pins (WKUP_PADCONFIG 14 - 24)
> wkup_pmx2 -> 72 pins (WKUP_PADCONFIG 26 - 97)
> wkup_pmx3 -> 1 pin (WKUP_PADCONFIG 100)
> 
> Fixes: b8545f9d3a54 ("arm64: dts: ti: Add initial support for J721S2 SoC")
> Signed-off-by: Thejasvi Konduru <t-konduru@ti.com>
> Signed-off-by: Sinthu Raja <sinthu.raja@ti.com>
> ---

is this mcu only ?

Could you provide a link to the output of:
$ cat /sys/kernel/debug/pinctrl/*/pins

Before and after the fixup? gist.github.com or some similar pastebin
link to the log will suffice.

[..]


-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
