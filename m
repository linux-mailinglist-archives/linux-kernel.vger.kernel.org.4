Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A50F5B683E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 08:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbiIMG5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 02:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiIMG5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 02:57:34 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C081C91C;
        Mon, 12 Sep 2022 23:57:33 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 28D6vMw2107882;
        Tue, 13 Sep 2022 01:57:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1663052242;
        bh=ghPSwh8yLq/NWzjzDD4mLMi0WTVtkeRcUYlzeZWnpH8=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=F4fmZ8C3BB1KpN/XJMRIDmBjJ83M6YlcMAXPgSGaY4bAXlOqpzyBPVOtsQyF3t4f1
         G4Z+gmmeqg9ItXaMidhiPY9ubtjaisqkX4nUFEX1p6IqVUlEqisHM9sqWaDfE9TBnI
         xprwFH9xbxpXbWmipeKgB/68fNi21nBCuQY0ORTY=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 28D6vMpB013241
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 13 Sep 2022 01:57:22 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Tue, 13
 Sep 2022 01:57:22 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Tue, 13 Sep 2022 01:57:22 -0500
Received: from [172.24.145.199] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 28D6vIKR088119;
        Tue, 13 Sep 2022 01:57:19 -0500
Message-ID: <a8c9750f-9dc1-3e73-69a4-1f687f3681c3@ti.com>
Date:   Tue, 13 Sep 2022 12:27:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 0/5] arm64: dts: ti: Add support for AM62A family of
 SoCs
Content-Language: en-US
To:     Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, Bryan Brattlof <bb@ti.com>
References: <20220901141328.899100-1-vigneshr@ti.com>
From:   Devarsh Thakkar <devarsht@ti.com>
In-Reply-To: <20220901141328.899100-1-vigneshr@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SCC_BODY_URI_ONLY,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/09/22 19:43, Vignesh Raghavendra wrote:
> This series adds basic boot support for AM62A SoCs with UART, MMC/SD and
> GPIO support on AM62A SK EVM
> 
> Bootlog: https://gist.github.com/r-vignesh/4d88f53bb0489f1675fa78f993e95d3f
> Tech Ref manual: https://www.ti.com/lit/zip/spruj16
> Schematics: https://www.ti.com/lit/zip/sprr459
> 
Tested-By: Devarsh Thakkar <devarsht@ti.com>
Boot logs: https://gist.github.com/devarsht/f7f95e77d8019bdf7ce7265a20ea64a4
