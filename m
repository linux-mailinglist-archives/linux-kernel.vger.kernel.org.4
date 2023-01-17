Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C37066E145
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 15:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbjAQOtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 09:49:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbjAQOt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 09:49:29 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C943B0C5;
        Tue, 17 Jan 2023 06:49:27 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 30HEnLro057971;
        Tue, 17 Jan 2023 08:49:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1673966961;
        bh=5+/kXxi2YlDMZkueyyvxa62mN6egOAn9YBd8b5IS9Yc=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=bhMYtKG3lfgAhsuKJ0HQIjnjkVHGT49W6qCtEJO5ECcAvCbHKnKsU1ZbN+uMgl/Z8
         eNWMOGpTMt8ySGdPEhLPlgnn5S9pkM6E1yjkMpAt4dVdxwC1uN2Tye0b+owKEUJ5/K
         nQnFW7RnGkx4B/sX1S+aQNSK2sa7UquNhThpE31A=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 30HEnLYB024635
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 17 Jan 2023 08:49:21 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 17
 Jan 2023 08:49:21 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 17 Jan 2023 08:49:21 -0600
Received: from [10.250.235.217] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 30HEnGZ3019770;
        Tue, 17 Jan 2023 08:49:16 -0600
Message-ID: <cfd56381-e9b1-b316-319c-c1f504daf1d9@ti.com>
Date:   Tue, 17 Jan 2023 20:19:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v6 2/3] dt-bindings: remoteproc: ti: Add new compatible
 for AM62 SoC family
Content-Language: en-US
To:     Devarsh Thakkar <devarsht@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <andersson@kernel.org>, <devicetree@vger.kernel.org>,
        <mathieu.poirier@linaro.org>, <p.zabel@pengutronix.de>,
        <linux-remoteproc@vger.kernel.org>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <s-anna@ti.com>
CC:     <hnagalla@ti.com>, <praneeth@ti.com>, <nm@ti.com>,
        <a-bhatia1@ti.com>, <j-luthra@ti.com>
References: <20230116151906.549384-1-devarsht@ti.com>
 <20230116151906.549384-3-devarsht@ti.com>
 <1a70a28b-b406-4d84-ced9-4d66bad94652@linaro.org>
 <bd0460de-eff2-9162-4edb-d3527041d7a6@ti.com>
From:   "Raghavendra, Vignesh" <vigneshr@ti.com>
In-Reply-To: <bd0460de-eff2-9162-4edb-d3527041d7a6@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Devarsh,

On 1/17/2023 10:54 AM, Devarsh Thakkar wrote:
> Hi Krzysztof,
> 
> On 17/01/23 00:36, Krzysztof Kozlowski wrote:
>> On 16/01/2023 16:19, Devarsh Thakkar wrote:
>>> AM62 family of devices don't have a R5F cluster, instead
>>> they have single core DM R5F.
>>> Add new compatible string ti,am62-r5fss to support this scenario.
>>>
>>
>> This is a friendly reminder during the review process.
>>
>> It looks like you received a tag and forgot to add it.
>>
>> If you do not know the process, here is a short explanation:
>> Please add Acked-by/Reviewed-by/Tested-by tags when posting new
>> versions. However, there's no need to repost patches *only* to add the
>> tags. The upstream maintainer will do that for acks received on the
>> version they apply.
>>
>> https://elixir.bootlin.com/linux/v5.17/source/Documentation/process/submitting-patches.rst#L540
>>
>> If a tag was not added on purpose, please state why and what changed.
> I apologize if it was not clear but yes I didn't put the tag as
> patch was updated to use cluster-mode=3 for am62x as per review comments on
> https://lore.kernel.org/all/20230110183505.GA2741090@p14s/

It would be helpful in future if you document why tag was dropped as
part of change log (below tearline) to indicate its intentional.

> 
> I'll append a note below commit message on Reviewed-By
> removal when I post the next series.

> Regards
> Devarsh
>>
>>
>> Best regards,
>> Krzysztof
>>
