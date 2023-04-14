Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C06426E29CC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 20:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjDNSGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 14:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjDNSGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 14:06:03 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D256E76B8;
        Fri, 14 Apr 2023 11:06:01 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33EI5qop014321;
        Fri, 14 Apr 2023 13:05:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1681495552;
        bh=X1SdExqvfx5FdfEA/Qn/8Klzwhw2Y3/GMO1ZCfn3KdM=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=QJrFPi17Jr2FsW966nV9Nc9AZmtfS2KYLOmbYgWljdChxXpsPeoUgH0eobC7rlQ44
         OyBna8JDUUsV8qUpBL/SBiFU/oE95iO4t3cqOrmFSOFdK68ZSYAi1mK/28hhNF2CNe
         KwRy6NbgOsP46yapqu7+6aqtqs4XrMcr14XmkgS4=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33EI5qOl015780
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 14 Apr 2023 13:05:52 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Fri, 14
 Apr 2023 13:05:52 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Fri, 14 Apr 2023 13:05:52 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33EI5pvl074632;
        Fri, 14 Apr 2023 13:05:51 -0500
Date:   Fri, 14 Apr 2023 13:05:51 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Esteban Blanc <eblanc@baylibre.com>
CC:     <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sterzik@ti.com>, <u-kumar1@ti.com>, <jneanne@baylibre.com>,
        <jpanis@baylibre.com>, <aseketeli@baylibre.com>
Subject: Re: [PATCH v2 0/5] arm64: dts: ti: k3-j7200-som-p0: Add TP6594
 family PMICs
Message-ID: <20230414180551.urqvxtxtaewoz5xa@lustfully>
References: <20230414112843.1358067-1-eblanc@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230414112843.1358067-1-eblanc@baylibre.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13:28-20230414, Esteban Blanc wrote:
> TPS6594 is a Power Management IC which provides regulators and others
> features like GPIOs, RTC, watchdog, ESMs (Error Signal Monitor), and
> PFSM (Pre-configurable Finite State Machine). The SoC and the PMIC can
> communicate through the I2C or SPI interfaces.
> TPS6594 is the super-set device while TPS6593 and LP8764 are derivatives.
> 
> This should be applied on top of other patch series:
> - https://lore.kernel.org/all/20230406075622.8990-1-jpanis@baylibre.com/
>   For core MFD driver
> - https://lore.kernel.org/lkml/20230414101217.1342891-1-eblanc@baylibre.com/
>   For regulator driver
> 

https://lore.kernel.org/lkml/20230330030046.qr5dnft6klejkxkp@ungreased/

has anything changed?
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
