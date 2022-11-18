Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21DEE62ED4D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 06:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240943AbiKRFtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 00:49:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiKRFtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 00:49:16 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A98197AA0;
        Thu, 17 Nov 2022 21:49:15 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2AI5mxgN063292;
        Thu, 17 Nov 2022 23:48:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1668750539;
        bh=A/CnFm74+eUp9+5BgoffWqC4T3FGqkaKQVB/LeY8WG0=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=gSRbqWR2Ul2kdO0idBp58NbbhNZuNClikKbanPT+eezy3zIihs7mQIW/LbgVfgEWk
         UEiAuuW6eoSXqHWMSloh5+ebxz2mkQEAaDJJYm6pz/5dAogzlYn9jRUcL9a6CP72sR
         ltGTn85UZv8RSu0OiXelGybMbxOA1bb3hA5BPh2w=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2AI5mxp2023014
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 17 Nov 2022 23:48:59 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 17
 Nov 2022 23:48:59 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 17 Nov 2022 23:48:59 -0600
Received: from [10.24.69.114] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2AI5mtm5031934;
        Thu, 17 Nov 2022 23:48:55 -0600
Message-ID: <dd1fbe2d-585e-8298-bd36-56b3bd4a9ae1@ti.com>
Date:   Fri, 18 Nov 2022 11:18:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [EXTERNAL] Re: [PATCH v8 1/6] dt-bindings: remoteproc: Add PRU
 consumer bindings
Content-Language: en-US
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>
CC:     MD Danish Anwar <danishanwar@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Suman Anna <s-anna@ti.com>, Roger Quadros <rogerq@kernel.org>,
        "Andrew F . Davis" <afd@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <srk@ti.com>, <linux-remoteproc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20221116121634.2901265-1-danishanwar@ti.com>
 <20221116121634.2901265-2-danishanwar@ti.com>
 <20221116160948.GA169555-robh@kernel.org> <20221116180949.GC61935@p14s>
From:   Md Danish Anwar <a0501179@ti.com>
In-Reply-To: <20221116180949.GC61935@p14s>
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

Hi Mathieu,

On 16/11/22 23:39, Mathieu Poirier wrote:
> On Wed, Nov 16, 2022 at 10:09:48AM -0600, Rob Herring wrote:
>> On Wed, Nov 16, 2022 at 05:46:29PM +0530, MD Danish Anwar wrote:
>>> From: Suman Anna <s-anna@ti.com>
>>>
>>> Add DT schema binding for PRU consumers. The binding includes
>>> all the common properties that can be used by different PRU consumer
>>> or application nodes and supported by the PRU remoteproc driver.
>>> These are used to configure the PRU hardware for specific user
>>> applications.
>>>
>>> The application nodes themselves should define their own bindings.
>>>
>>> Co-developed-by: Tero Kristo <t-kristo@ti.com>
>>> Co-developed-by: Suman Anna <s-anna@ti.com>
>>> Co-developed-by: Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
>>> Co-developed-by: Puranjay Mohan <p-mohan@ti.com>
>>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>>
>> Run checkpatch.pl and fix the warnings with the tags.
> 
> My bad - I asked Danish to remove the SoBs to lighten the changelog
> presentation.  Danish, do you absolutely need to list everyone that touched that
> patchset?  If so I suppose just listing the SoBs would be a compromise.
> 

I started working on this patch series after version 5. In the first version of
this patch series below were the tags.

Co-developed-by: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Suman Anna <s-anna@ti.com>
Co-developed-by: Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
Signed-off-by: Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>

I am not sure whom to drop and whom to keep that's why I have been keeping all
the tags that were present from the beginning.

In the next version I'll keep only the SoBs tags of the the people listed above.

>>
>> You didn't add review/ack tags either.
> 
> Those are important.  
> 
> Please send another patchset that clears checkpatch with review/acks and I'll
> look at it.
> 

I am really sorry for that, I was not aware about adding review tags as I am
very new to upstreaming.

I will share new version after fixing checkpatch errors/warnings and adding
review tags.

Thanks,
Danish.

> Thanks,
> Mathieu
> 
>>
>>> ---
>>>  .../bindings/remoteproc/ti,pru-consumer.yaml  | 60 +++++++++++++++++++
>>>  1 file changed, 60 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/remoteproc/ti,pru-consumer.yaml
