Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 794156B1B6A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 07:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjCIGZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 01:25:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbjCIGZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 01:25:45 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D81530B36
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 22:25:45 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3296PeAw086909;
        Thu, 9 Mar 2023 00:25:40 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678343140;
        bh=ajpyBbTwf4kbcyZJsYNxPxeOERAzLxfrp0uFekWIJnk=;
        h=Date:CC:Subject:To:References:From:In-Reply-To;
        b=gR8Yt772IBWl/Y9A0HKeBLrId6lV7wiq8GKt8OcFVdGSxJ2VWCeMxe2l+Ua0m6jCi
         01jMb/3nLQTwuDW+eqzdCu22F/WD2HZUsSDWUAfVuEuaQut4oUCK4c69+BoKydtjhe
         2WgeugVC2lecwBL3fSz2lURYtyn+ONyZMZS8AkHE=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3296PesV105084
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 9 Mar 2023 00:25:40 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 9
 Mar 2023 00:25:40 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 9 Mar 2023 00:25:40 -0600
Received: from [172.24.145.61] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3296PbO9090700;
        Thu, 9 Mar 2023 00:25:38 -0600
Message-ID: <8209c930-a13e-d8ef-8c36-b47be7d4ad97@ti.com>
Date:   Thu, 9 Mar 2023 11:55:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
CC:     <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: Re: [PATCH 0/3] PHY-GMII-SEL: Add support for SGMII mode
Content-Language: en-US
To:     <vkoul@kernel.org>, <kishon@kernel.org>, <rogerq@kernel.org>
References: <20230309062237.389444-1-s-vadapalli@ti.com>
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <20230309062237.389444-1-s-vadapalli@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Please ignore this series. There are a few changes required. I will update and
post the v2 series.

Regards,
Siddharth.

On 09/03/23 11:52, Siddharth Vadapalli wrote:
> Hello,
> 
> This series adds support to configure the CPSW MAC's PHY in SGMII mode.
> Also, SGMII mode is enabled for TI's J7200 and J721E SoCs.
> 
> Siddharth Vadapalli (3):
>   phy: ti: phy-gmii-sel: Add support for SGMII mode
>   phy: ti: gmii-sel: Enable SGMII mode for J7200
>   phy: ti: gmii-sel: Enable SGMII mode for J721E
> 
>  drivers/phy/ti/phy-gmii-sel.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
