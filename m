Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9488B6E0699
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 07:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjDMF5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 01:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjDMF5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 01:57:30 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13FA5585;
        Wed, 12 Apr 2023 22:57:28 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33D5v5dN059915;
        Thu, 13 Apr 2023 00:57:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1681365425;
        bh=G6ODU/Sq/zhDFWN1N8pHqgDsQTapR9jOvHHXUxHDArk=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=Rhd67xkN1iNUUPK2BRdYsNOXRglC18mKZDBYgRRt/dWTelN/n/3dTtQ3v5hg5Ee0i
         tudeBujO40YL4fwgxiBevrS35lDWzqjL8HyptdsCoDC5WMH/Scnm3l62iLmv9/AhmC
         wFipcr+t+xB92LpSBpJ8jCDqWME+Mb8lrcaGm3Uc=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33D5v59g046719
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 13 Apr 2023 00:57:05 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 13
 Apr 2023 00:57:04 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 13 Apr 2023 00:57:04 -0500
Received: from [172.24.145.109] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33D5v1Fv063161;
        Thu, 13 Apr 2023 00:57:02 -0500
Message-ID: <ff08d186-ee40-0615-9616-8620f35028c8@ti.com>
Date:   Thu, 13 Apr 2023 11:27:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] arm64: dts: ti: k3-j721s2-main: fix msmc node
To:     Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <a-govindraju@ti.com>,
        <kishon@ti.com>, <n-dasan@ti.com>
References: <20230412173609.1307837-1-u-kumar1@ti.com>
 <20230412195656.a53nalvjuhelniz4@populace>
 <36fc3872-96ba-e503-cfff-754036e561e1@ti.com>
 <89b6b67b-1ccb-87fb-211d-f4427ef131b3@ti.com>
Content-Language: en-US
From:   Udit Kumar <u-kumar1@ti.com>
In-Reply-To: <89b6b67b-1ccb-87fb-211d-f4427ef131b3@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Raghavendra

On 13/04/23 10:53, Vignesh Raghavendra wrote:
> Hi Udit,
>
> On 13/04/23 10:45, Udit Kumar wrote:
>> Hi Nishanth,
>>
>> On 13/04/23 01:26, Nishanth Menon wrote:
>>> On 23:06-20230412, Udit Kumar wrote:
>>>> [..]
>>> Are you saying that j721s2 is incapable of l3 cache? say some level 1
>>> errata?
>> No
>>> or is it because, the chip is really capable of l3 cache and we are
>>> really setting it to 0?
>>>
>>> https://git.ti.com/cgit/k3-image-gen/k3-image-gen/tree/soc/j721s2/evm/board-cfg.c#n71
>> This is because, l3 cache size is set to zero.
>>> unless the chip has an errata, you are supposed to fix it up based on
>>> configuration by using the API and this patch is a NAK
>>> https://software-dl.ti.com/tisci/esd/latest/2_tisci_msgs/general/core.html#tisci-query-msmc
>> ok
> U-Boot already does this. See fdt_fixup_msmc_ram() at board/ti/j721s2/evm.c
>
> tifs-sram fixup probably is still needed and possible bug in the original patch?


Let me fix in u-boot


Regards

Udit

>
