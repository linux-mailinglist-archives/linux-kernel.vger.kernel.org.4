Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1877632FCB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 23:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbiKUW1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 17:27:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiKUW1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 17:27:10 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693986712B;
        Mon, 21 Nov 2022 14:27:09 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2ALMQtiR096664;
        Mon, 21 Nov 2022 16:26:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1669069615;
        bh=L51a/5bRsRQGZyPqbD7sDXRc2P6dZnq5hISop27qB84=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=S7qJ4TG6POuypzTq+S2Uu+C6u1lS6szsZXLxYEY0i/553/BVRo/ljDZ/atqEq2K6B
         Qek1wp3P2gYLmVSyL3vw860nXrmyt2rQpq2sGUNuM53VFOc54G/UCeeER6QeejPnw4
         +lbjkHkFC0998rz23jGlagx2l99Y48HoMZpfVIr4=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2ALMQtEi067690
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 21 Nov 2022 16:26:55 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 21
 Nov 2022 16:26:55 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 21 Nov 2022 16:26:55 -0600
Received: from [10.250.135.52] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2ALMQkFJ123867;
        Mon, 21 Nov 2022 16:26:47 -0600
Message-ID: <3c0b2937-2a9e-867b-aa86-c791bd192a6b@ti.com>
Date:   Tue, 22 Nov 2022 00:26:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v4 1/5] dt-bindings: ti, sci: Add lpm region and
 firmware-name
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Vibhore Vardhan <vibhore@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>
References: <20221116181307.198209-1-g-vlaev@ti.com>
 <20221116181307.198209-2-g-vlaev@ti.com>
 <c55e26fe-b884-e4e8-525e-f69f408410cd@linaro.org>
From:   Georgi Vlaev <g-vlaev@ti.com>
In-Reply-To: <c55e26fe-b884-e4e8-525e-f69f408410cd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
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

On 11/18/22 14:59, Krzysztof Kozlowski wrote:
> On 16/11/2022 19:13, Georgi Vlaev wrote:
>> From: Dave Gerlach <d-gerlach@ti.com>
>>
>> Add documentation for the lpm region which tells the ti-sci driver where
>> to load the FS Stub low power mode firmware and also the firmware-name
>> which tells the driver which binary to load. Both of these are optional
>> for normal system operation but required to enabled suspend-to-mem usage
>> of Deep Sleep state.
>>
> 
> I think you got here Rob's tag after sending v4.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> 

I will pick it up in v5.
Thanks.

> Best regards,
> Krzysztof
> 

-- 
Regards,
Georgi
