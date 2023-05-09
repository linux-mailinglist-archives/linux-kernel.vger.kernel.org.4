Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68C446FC161
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 10:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234924AbjEIIKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 04:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235163AbjEIIJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 04:09:53 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A7CDDB4
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 01:09:17 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34988gkg002590;
        Tue, 9 May 2023 03:08:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1683619722;
        bh=ppgfFY3YEbYf7+4gGVzaZtFcc1sTh3HZqZhDb/IzUek=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=pUynhI7F5QXvUfpels7iVVuwCydttOO8oA6+gQaC1g3Wc/AlhmsJywaxVj4lAG+oU
         IAVWQCMCV9zwho7C7Xc7NWabAxUWm3rJjqDJSOkjCPSyPqp+BYbRfpmrHyv466RS0w
         OWz7JSyX5kvTJYJSz9rS/6fm126edQPFLEDkQGHE=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34988giB106201
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 9 May 2023 03:08:42 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 9
 May 2023 03:08:42 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 9 May 2023 03:08:42 -0500
Received: from [172.24.145.182] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34988bP8010303;
        Tue, 9 May 2023 03:08:38 -0500
Message-ID: <de6432db-0da0-b535-1f44-04541116be8b@ti.com>
Date:   Tue, 9 May 2023 13:38:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] arm64: defconfig: enable PCIe controller on TI platforms
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Achal Verma <a-verma1@ti.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "N_colas F . R . A . Prado" <nfraprado@collabora.com>,
        Mark Brown <broonie@kernel.org>,
        Rafa_ Mi_ecki <rafal@milecki.pl>, Nishanth Menon <nm@ti.com>,
        Milind Parab <mparab@cadence.com>,
        Swapnil Kashinath Jakhade <sjakhade@cadence.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230509063431.1203367-1-a-verma1@ti.com>
 <46b0dbd4-5695-1a2d-8d06-0a60a7c3a151@linaro.org>
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <46b0dbd4-5695-1a2d-8d06-0a60a7c3a151@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Achal,

On 09/05/23 12:09, Krzysztof Kozlowski wrote:
> On 09/05/2023 08:34, Achal Verma wrote:
>> Enable PCIe controller and serdes drivers to enable PCIe functionality.
>> * Enable Cadence serdes phy and wrapper driver.
>> * Enable Cadence PCIe controller driver.
> 
> Why? IOW, which boards needs it?
>>
>> Signed-off-by: Achal Verma <a-verma1@ti.com>
>> ---
>>  arch/arm64/configs/defconfig | 15 +++++++++++----
>>  1 file changed, 11 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
>> index a24609e14d50..ff187dd585c2 100644
>> --- a/arch/arm64/configs/defconfig
>> +++ b/arch/arm64/configs/defconfig
>> @@ -230,9 +230,16 @@ CONFIG_PCIE_HISI_STB=y
>>  CONFIG_PCIE_TEGRA194_HOST=m
>>  CONFIG_PCIE_VISCONTI_HOST=y
>>  CONFIG_PCIE_LAYERSCAPE_GEN4=y
>> +CONFIG_PCIE_CADENCE=y
> 
> =m
> 
>> +CONFIG_PCIE_CADENCE_HOST=y
>> +CONFIG_PCIE_CADENCE_EP=y
>> +CONFIG_PCI_J721E=y
> 
> =m

Also, see [0] for history. We really want these to be 
modules unless its necessary for bootup.

You may want to revive [1] and get it to mainline

[0] https://lore.kernel.org/linux-arm-kernel/CAK8P3a2VSBvOn1o+q1PYZaQ6LS9U4cz+DZGuDbisHkwNs2dAAw@mail.gmail.com/
[1] https://lore.kernel.org/linux-arm-kernel/20230110153805.GA1505901@bhelgaas/


[...]

-- 
Regards
Vignesh
