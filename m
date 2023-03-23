Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00D3E6C6586
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 11:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbjCWKp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 06:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbjCWKpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 06:45:38 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D711F5CC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 03:42:49 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32NAgEYn056822;
        Thu, 23 Mar 2023 05:42:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1679568134;
        bh=E4rdywlZLd6OFW6mRF/hSG9kVG8nUo2k7DasmHV0LFU=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=Ps8dkDvl5BfUWks1wKS4knzNhY7h56Ie7FuWDAGZd7wqQgGETSwLEQnZMJ4flQvyz
         8vwq13y1CAOSLq83a91NzCF1QEuzIOH3wF0qaFiQ82VeqSCvOfpZFMGT/pq+DZF5DL
         6gXoueLRpOIa0xp5qJV71am2wabPWp9251MPVjEM=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32NAgDbT113874
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 23 Mar 2023 05:42:13 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 23
 Mar 2023 05:42:13 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 23 Mar 2023 05:42:13 -0500
Received: from [172.24.145.83] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32NAg9Je063582;
        Thu, 23 Mar 2023 05:42:10 -0500
Message-ID: <9879d72c-18af-5687-7ad6-56146009274b@ti.com>
Date:   Thu, 23 Mar 2023 16:12:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [EXTERNAL] Re: [PATCH] arm64: defconfig: Enable CAN PHY
 transceiver driver
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <quic_bjorande@quicinc.com>,
        <dmitry.baryshkov@linaro.org>, <arnd@arndb.de>,
        <krzysztof.kozlowski@linaro.org>, <nfraprado@collabora.com>,
        <broonie@kernel.org>, <rafal@milecki.pl>
References: <20230323100624.337354-1-b-kapoor@ti.com>
 <CAMuHMdWF0yGwM5hk=o+te2fPw-G8XhGZ6TGfF-KvnVnasPjKNQ@mail.gmail.com>
From:   Bhavya Kapoor <b-kapoor@ti.com>
In-Reply-To: <CAMuHMdWF0yGwM5hk=o+te2fPw-G8XhGZ6TGfF-KvnVnasPjKNQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 23/03/23 15:44, Geert Uytterhoeven wrote:
> Hi Bhavya,
>
> On Thu, Mar 23, 2023 at 11:06 AM Bhavya Kapoor <b-kapoor@ti.com> wrote:
>> Enable CAN PHY transceiver driver to be built as a module.
>>
>> Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
> Thanks for your patch!
> (I wanted to send a similar patch soon ;-)
>
>> --- a/arch/arm64/configs/defconfig
>> +++ b/arch/arm64/configs/defconfig
>> @@ -368,6 +368,7 @@ CONFIG_REALTEK_PHY=y
>>   CONFIG_ROCKCHIP_PHY=y
>>   CONFIG_DP83867_PHY=y
>>   CONFIG_VITESSE_PHY=y
>> +CONFIG_PHY_CAN_TRANSCEIVER=m
> This doesn't look like the right spot to insert this?
>
> Based on "make savedefconfig", I'd say:
>
>       CONFIG_PHY_XGENE=y
>     +CONFIG_PHY_CAN_TRANSCEIVER=m
>       CONFIG_PHY_SUN4I_USB=y

Yeah . Thanks Geert. I will send a v2 ensuring its in correct spot,

>>   CONFIG_CAN_FLEXCAN=m
>>   CONFIG_CAN_RCAR=m
>>   CONFIG_CAN_RCAR_CANFD=m
>> --
>> 2.34.1
> Gr{oetje,eeting}s,
>
>                          Geert
>
