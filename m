Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE14F62240E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 07:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbiKIGoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 01:44:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiKIGoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 01:44:06 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C23F192BC;
        Tue,  8 Nov 2022 22:44:05 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2A96hs7M092791;
        Wed, 9 Nov 2022 00:43:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1667976234;
        bh=pahvT/KCVENlxvNFzlgOa94MFUVEfTKIVFsvUAo01/Q=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=e1mLZBXaBUPc1bOudtWpYEgoKerfn4amtcCkZ4KGtc+CQkAtnggtUeYKJCZYtSTbs
         7f42yqiRLw1p4dbbys2MQrK8kuPCOjoHG0oma65TSVjy816gU4IUqycuHlhotgRZLk
         JLu4B2FZbTMaQqz3n9BkmMShcz64t89KAFaViRfg=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2A96hscl111444
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Nov 2022 00:43:54 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Wed, 9 Nov
 2022 00:43:54 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Wed, 9 Nov 2022 00:43:54 -0600
Received: from [10.250.234.28] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2A96ho0s079848;
        Wed, 9 Nov 2022 00:43:51 -0600
Subject: Re: [EXTERNAL] Re: [PATCH] arm64: dts: ti: k3-j721s2: Add support for
 ADC nodes
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>, <vigneshr@ti.com>,
        <nm@ti.com>
References: <20221108073252.35169-1-b-kapoor@ti.com>
 <4aaca060-ba53-d387-c556-db485b74fbf1@linaro.org>
From:   Bhavya Kapoor <b-kapoor@ti.com>
Message-ID: <89ce3639-e979-e369-657a-20aea4295970@ti.com>
Date:   Wed, 9 Nov 2022 12:13:55 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <4aaca060-ba53-d387-c556-db485b74fbf1@linaro.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

     its a mistake as i ended up sending the same patch twice

Regards

BK


On 11/8/22 11:48 PM, Krzysztof Kozlowski wrote:
> On 08/11/2022 08:32, Bhavya Kapoor wrote:
>> J721S2 has two instances of 8 channel ADCs in MCU domain. Add DT nodes
>> for 8 channel ADCs for J721S2.
>>
>> Enable ADCs present on J721S2 soc.
>>
>> Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
>> ---
> And this is a v2? Or resend? Or something else?
>
> Best regards,
> Krzysztof
>
