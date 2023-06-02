Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24CF7720AF4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 23:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236494AbjFBVY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 17:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234676AbjFBVYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 17:24:55 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C09EE48;
        Fri,  2 Jun 2023 14:24:53 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 352LOhKJ098321;
        Fri, 2 Jun 2023 16:24:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1685741083;
        bh=RCcliWkAS05ERjj+1p4ib8PPrDkwvU8L32PWoE2CMjQ=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=QpmJFj4r7WOUzeObc8oO7geeXZXbT6+r5FZowcLtdhpXLwRNAQhewv0AGRF7Z+eBr
         BgqEANZO4mjmmiofBtZTPLOqrJrgvdBfgl1HOdPPBt1VNUt+Mm9Bdt7kpo5MVKw5EE
         AwA7ZHqxWcddj2UgcT6C6TfjnAPP/TiN85ZUYbFI=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 352LOhvc003170
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 2 Jun 2023 16:24:43 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 2
 Jun 2023 16:24:43 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 2 Jun 2023 16:24:43 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 352LOhKP059668;
        Fri, 2 Jun 2023 16:24:43 -0500
Date:   Fri, 2 Jun 2023 16:24:43 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Thejasvi Konduru <t-konduru@ti.com>
CC:     Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis <afd@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Apurva Nandan <a-nandan@ti.com>, Udit Kumar <u-kumar1@ti.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-j784s4: Fix wakeup pinmux range and
 pinctrl node offsets
Message-ID: <20230602212443.diuhlfah7an4b4cj@unrigged>
References: <20230503083143.32369-1-t-konduru@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230503083143.32369-1-t-konduru@ti.com>
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

On 14:01-20230503, Thejasvi Konduru wrote:
> The wkup_pmx register region in j784s4 has multiple non-addressable
> regions, hence the existing wkup_pmx region is split as follows to
> avoid the non-addressable regions. The pinctrl node offsets are
> also corrected as per the newly split wkup_pmx* nodes.
> 
> wkup_pmx0 -> 13 pins (WKUP_PADCONFIG 0 - 12)
> wkup_pmx1 -> 11 pins (WKUP_PADCONFIG 14 - 24)
> wkup_pmx2 -> 72 pins (WKUP_PADCONFIG 26 - 97)
> wkup_pmx3 -> 1 pin (WKUP_PADCONFIG 100)
> 
> Fixes: 4664ebd8346a ("arm64: dts: ti: Add initial support for J784S4 SoC")
> Signed-off-by: Thejasvi Konduru <t-konduru@ti.com>


Reviewed-by: Nishanth Menon <nm@ti.com>
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
