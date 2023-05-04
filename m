Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2C5E6F647E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 07:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjEDFkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 01:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjEDFj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 01:39:59 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABCB91BD1;
        Wed,  3 May 2023 22:39:57 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3445dmJJ047770;
        Thu, 4 May 2023 00:39:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1683178788;
        bh=oR2MHd3HvqUBnw7oAdxihcalkQQ9fQ3xU3sIFl4ma98=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=AbVfQZuIxnoGSNP0PDhj51lcVuhvPN978HzniFv8ZcA29+amwByDjCEqQKDgKlooW
         AhVQ+2MTgcqij8qDAFkoy9SneVti5bee0SFbsVqTQHC4pbRaLBn7GUrzpP1snteEvW
         4LKIRauFITvo/pFvOwWYSTmM+oVrirzjKSeiZ5zI=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3445dmT5010711
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 4 May 2023 00:39:48 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 4
 May 2023 00:39:47 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 4 May 2023 00:39:47 -0500
Received: from [10.24.69.141] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3445dhBP094370;
        Thu, 4 May 2023 00:39:44 -0500
Message-ID: <2a7f3c1f-a7c3-149b-5678-b9108b859c71@ti.com>
Date:   Thu, 4 May 2023 11:09:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 0/4] arm64: dts: ti: Describe flash partitions for J7
 platforms
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>
CC:     <kristo@kernel.org>, <vigneshr@ti.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <u-kumar1@ti.com>
References: <20230503091218.25899-1-vaishnav.a@ti.com>
 <20230503115130.c7m4a7crub7kmfjw@gluten>
From:   Vaishnav Achath <vaishnav.a@ti.com>
In-Reply-To: <20230503115130.c7m4a7crub7kmfjw@gluten>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-8.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nishanth,

On 03/05/23 17:21, Nishanth Menon wrote:
> On 14:42-20230503, Vaishnav Achath wrote:
>> This series adds flash partition description through DT, currently
>> the flash partitions for J7 platforms is described through the mtdparts
>> commandline parameter passed from bootloader, this requires maintenance
>> of the partition information in a mtdparts string which is error prone.
>>
>> Once the flash partitions are described through DT, the support for
>> mtdparts can be removed for these platforms from u-boot also.
>>
>> Vaishnav Achath (4):
>>   arm64: dts: ti: k3-j721e-som: Describe OSPI flash partition info
>>   arm64: dts: ti: k3-j721e-som: Describe QSPI flash partition info
>>   arm64: dts: ti: k3-j721e-sk: Describe OSPI flash partition info
>>   arm64: dts: ti: k3-j7200-som: Describe OSPI and Hyperflash partition
>>     info
>>
>>  arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi   | 72 +++++++++++++++++++
>>  .../dts/ti/k3-j721e-common-proc-board.dts     | 46 ++++++++++++
>>  arch/arm64/boot/dts/ti/k3-j721e-sk.dts        | 46 ++++++++++++
>>  arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi   | 46 ++++++++++++
>>  4 files changed, 210 insertions(+)
> 
> Please address the feedback in [1] prior to adding the partitions? and
> could you ensure it is done for all the impacted k3 SoCs?
> 

I will do both of these in corresponding next revisions.

Thanks and Regards,
Vaishnav

> 
> [1] https://lore.kernel.org/all/f5861b8b-637a-e127-2945-8994a472015a@ti.com/
> 


