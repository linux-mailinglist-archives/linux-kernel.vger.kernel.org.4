Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEEEE6598A2
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 14:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234966AbiL3NVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 08:21:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiL3NVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 08:21:34 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA641A05B;
        Fri, 30 Dec 2022 05:21:32 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2BUDLIq2048320;
        Fri, 30 Dec 2022 07:21:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1672406478;
        bh=dgtWKiypkfZyZIMMgNnZ1rCIMvsBKWgzAMtTZGyqJDk=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=HvaHtmfz5BgNpQkmjKlxkohl6ShTXsWaahJ7uP+LOgwdiiTPIqDEa7xdM8DR6UqNO
         lDiOoyBrki4D54sCEZTFgUX6QVKJH8yLEi1XdYNM/V0bWjkUlh6UaOn1+UuS9mc199
         2GODsgjbazU/O4BYeyZcEAEOBupPUly9Yoncb8JM=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2BUDLIxO011205
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 30 Dec 2022 07:21:18 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Fri, 30
 Dec 2022 07:21:18 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Fri, 30 Dec 2022 07:21:17 -0600
Received: from [10.249.48.175] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2BUDLHft130087;
        Fri, 30 Dec 2022 07:21:17 -0600
Message-ID: <b746fd70-95eb-307e-0f95-28d009d95f85@ti.com>
Date:   Fri, 30 Dec 2022 07:21:17 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/2] dt-bindings: remoteproc: k3-dsp: update bindings for
 AM62A SoCs
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <andersson@kernel.org>, <devicetree@vger.kernel.org>,
        <mathieu.poirier@linaro.org>, <p.zabel@pengutronix.de>,
        <linux-remoteproc@vger.kernel.org>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <s-anna@ti.com>
CC:     <praneeth@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <a-bhatia1@ti.com>, <j-luthra@ti.com>, <devarsht@ti.com>
References: <20221228123655.15384-1-hnagalla@ti.com>
 <20221228123655.15384-2-hnagalla@ti.com>
 <18a2fd76-c708-0c14-2d5c-b771ab8baee5@linaro.org>
Content-Language: en-US
From:   Hari Nagalla <hnagalla@ti.com>
In-Reply-To: <18a2fd76-c708-0c14-2d5c-b771ab8baee5@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/28/22 06:38, Krzysztof Kozlowski wrote:
>>   
>>     resets:
>>       description: |
>> @@ -111,6 +113,7 @@ else:
>>           enum:
>>             - ti,j721e-c71-dsp
>>             - ti,j721s2-c71-dsp
>> +	  - ti,am62a-c7xv-dsp
> Does not look like you tested the bindings. Please run `make
> dt_binding_check` (see
> Documentation/devicetree/bindings/writing-schema.rst for instructions).
> 
> Wrong indentation.
Seems, i used a wrong option in our patch verify script. Used the 
correct options and fixed it. sending v2 with review comment updates. Thanks

