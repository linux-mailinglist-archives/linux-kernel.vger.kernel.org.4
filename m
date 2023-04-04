Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50C2D6D591F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 09:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233724AbjDDHFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 03:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233221AbjDDHFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 03:05:01 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B3118C
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 00:05:00 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33474pfm083483;
        Tue, 4 Apr 2023 02:04:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1680591891;
        bh=Xxal5gx/ThGxtq0kVEmh9gFXlfl/HsO/TSHzc+kJNrI=;
        h=Date:CC:Subject:To:References:From:In-Reply-To;
        b=MIScsozwyq1tFznyozpYDOKWeUbA8TlPjXcAiqdwhKFiuxFpmMP0QdoiPSYGg4ZjK
         HZtbTPcygIorH/i0Cz0CbO2SZXIG7KJf4g8WYLqF/G1NHX9B4qKzhit4H4TKGzCBMa
         c4nMI8KFvoGE3NqKBoYJTfp70lRFIfeDZZHW5/NY=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33474pXB018681
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 4 Apr 2023 02:04:51 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 4
 Apr 2023 02:04:51 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 4 Apr 2023 02:04:51 -0500
Received: from [172.24.145.61] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33474mbe098532;
        Tue, 4 Apr 2023 02:04:49 -0500
Message-ID: <66dbb0f3-cfb1-d6a5-42f9-3f3098ca1b90@ti.com>
Date:   Tue, 4 Apr 2023 12:34:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
CC:     <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: Re: [PATCH v2 0/3] PHY-GMII-SEL: Add support for SGMII mode
Content-Language: en-US
To:     <vkoul@kernel.org>, <kishon@kernel.org>, <rogerq@kernel.org>
References: <20230309063514.398705-1-s-vadapalli@ti.com>
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <20230309063514.398705-1-s-vadapalli@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-3.9 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series applies cleanly as of next-20230404. Please merge this series
followed by the series at:
https://lore.kernel.org/r/20230331062521.529005-1-s-vadapalli@ti.com/
in case of no concerns.

Regards,
Siddharth.

On 09/03/23 12:05, Siddharth Vadapalli wrote:
> Hello,
> 
> This series adds support to configure the CPSW MAC's PHY in SGMII mode.
> Also, SGMII mode is enabled for TI's J7200 and J721E SoCs.
> 
> Changes from v1:
> 1. Add "break" statement within "case PHY_INTERFACE_MODE_SGMII".
> 2. Add newline before "default" case.
> 3. Update commit message of patch 1/3 to follow the existing convention.
> 
> v1:
> https://lore.kernel.org/r/20230309062237.389444-1-s-vadapalli@ti.com/
> 
> Siddharth Vadapalli (3):
>   phy: ti: gmii-sel: Add support for SGMII mode
>   phy: ti: gmii-sel: Enable SGMII mode for J7200
>   phy: ti: gmii-sel: Enable SGMII mode for J721E
> 
>  drivers/phy/ti/phy-gmii-sel.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
