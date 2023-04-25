Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD2D6EE1B9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 14:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233886AbjDYMQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 08:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233407AbjDYMQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 08:16:35 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B99A4EF1;
        Tue, 25 Apr 2023 05:16:33 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33PCGMcH028997;
        Tue, 25 Apr 2023 07:16:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1682424982;
        bh=DcmUqEr18jXBjOZ9gLE7XXP9zUzdrnjYOXhf8sLJgxk=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=BCfQk0i/ZFNimMdMbXtwag1CL6DqwM4+BUPoa0qg6CSjkFbA3IR1lFFNPGaP+BZaD
         WxVEnjzoBhBiTsCsIxt6qUs7LR9eN9lNYYJnOFFGnnHXuYvv5s3Ukn30vsFMEnONv0
         pd9/zFqyZPYNR4v84V9d0a6/VwF9ln3IlfEitdB8=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33PCGMXk115096
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 Apr 2023 07:16:22 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 25
 Apr 2023 07:16:22 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 25 Apr 2023 07:16:22 -0500
Received: from [10.24.69.79] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33PCGIZm006054;
        Tue, 25 Apr 2023 07:16:19 -0500
Message-ID: <b66ea55a-fc9a-8a3f-5b06-247769c50087@ti.com>
Date:   Tue, 25 Apr 2023 17:46:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [EXTERNAL] Re: [PATCH v14 4/8] arm64: dts: ti:
 k3-j721s2-common-proc-board: Enable SERDES0
Content-Language: en-US
To:     Roger Quadros <rogerq@kernel.org>, <nm@ti.com>, <afd@ti.com>,
        <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <s-vadapalli@ti.com>,
        <vaishnav.a@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230331090028.8373-1-r-gunasekaran@ti.com>
 <20230331090028.8373-5-r-gunasekaran@ti.com>
 <86ab17b2-d35a-16e2-7791-9e7a13c8e632@kernel.org>
From:   Ravi Gunasekaran <r-gunasekaran@ti.com>
In-Reply-To: <86ab17b2-d35a-16e2-7791-9e7a13c8e632@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Roger,

On 25/04/23 5:15 pm, Roger Quadros wrote:
> Hi,
> 
> On 31/03/2023 12:00, Ravi Gunasekaran wrote:
>> From: Aswath Govindraju <a-govindraju@ti.com>
>>
>> Configure first lane to PCIe, the second lane to USB and the last two lanes
>> to eDP. Also, add sub-nodes to SERDES0 DT node to represent SERDES0 is
>> connected to PCIe.
> 
> Is USB0 expected to work in super-speed on this board?
> If yes then you need to add USB0 lane information as well.
> Otherwise please ignore my comment.
> 

The SerDes on J721S2 can simultaneously support only two protocols.
By default PCIe and DP will be supported. Due to this, USB is configured
in high-speed and this does not require any SerDes lane configuration.

>>
>> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
>> Signed-off-by: Matt Ranostay <mranostay@ti.com>
>> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>

[...]

> 
> cheers,
> -roger

-- 
Regards,
Ravi
