Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2580B724131
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 13:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237110AbjFFLlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 07:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237257AbjFFLku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 07:40:50 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F47410C2;
        Tue,  6 Jun 2023 04:40:44 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 356BeSOp108309;
        Tue, 6 Jun 2023 06:40:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1686051628;
        bh=mDNAxOdRFHKWWkcbYdc4LhKHrvJv1X2OIGRqqEmTtR4=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=GnhYJb4LExQCtNmwcxpdvXYpY0it7mkD3Ahwvfn01biS26NXJKaJOKqEeqSHLD+Nj
         EnA+OYsT17ZlajPTxaRYcFolX/GZHoHJUOUSUnujt3D/5ppVAu79Dz3qnkyvd0di0+
         yV4niOGVFFFkeJKjv6/Hh3LnScISbvatVZtA0EeI=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 356BeSI9117720
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 6 Jun 2023 06:40:28 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 Jun 2023 06:40:28 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 Jun 2023 06:40:28 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 356BeSj4075600;
        Tue, 6 Jun 2023 06:40:28 -0500
Date:   Tue, 6 Jun 2023 06:40:28 -0500
From:   Nishanth Menon <nm@ti.com>
To:     "Kumar, Udit" <u-kumar1@ti.com>
CC:     Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Nitin Yadav <n-yadav@ti.com>,
        Neha Malcom Francis <n-francis@ti.com>,
        Sinthu Raja <sinthu.raja@ti.com>
Subject: Re: [PATCH 3/6] arm64: dts: ti: k3-am68-sk-base-board: Add uart
 pinmux
Message-ID: <20230606114028.croeykqxsf6zvhhh@boxer>
References: <20230602153554.1571128-1-nm@ti.com>
 <20230602153554.1571128-4-nm@ti.com>
 <fb128289-f459-4fe2-0426-6cd6cac93c1a@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <fb128289-f459-4fe2-0426-6cd6cac93c1a@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15:23-20230606, Kumar, Udit wrote:
[...]
> Series look good.

Could you confirm by providing a Reviewed-by Tag to the cover-letter?

> 
> One small question, We don't have CTS and RTS Pin for mcu uart ,
> 
> is this due to board connections ?

yup.
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
