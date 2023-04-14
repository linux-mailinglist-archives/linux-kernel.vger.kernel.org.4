Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E50386E2607
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 16:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjDNOok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 10:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjDNOoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 10:44:39 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8FCE55;
        Fri, 14 Apr 2023 07:44:34 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33EEi6c3101852;
        Fri, 14 Apr 2023 09:44:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1681483446;
        bh=pV5IAjekorg5JVSq5+Motl8Ut+WnU2xVcZQwXYPd5ZU=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=G+Wr53EGSewSYrWUbhNpzsERWUORrZM7+6WsPkMVNyb1Hk48T4XgC2CL0EtmwRIr9
         +IKh0ntDOBJyNcuMprxOuh+uyOa2WUjiw2BUx1THJ66sZUovtt/bXJAuI+QjS2gIGu
         IvHl34x92EDeGdOEJkIzppaV9MRA9w/xUAnY6zFA=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33EEi69n011416
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 14 Apr 2023 09:44:06 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Fri, 14
 Apr 2023 09:44:06 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Fri, 14 Apr 2023 09:44:06 -0500
Received: from [172.24.145.152] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33EEhwaT115354;
        Fri, 14 Apr 2023 09:43:59 -0500
Message-ID: <2a6393d4-47e6-1526-d68b-f34394b1dca4@ti.com>
Date:   Fri, 14 Apr 2023 20:13:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 1/2] dt-bindings: drm/bridge: Add no-hpd property
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC:     <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <krzysztof.kozlowski@linaro.org>,
        <andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>,
        <rfoss@kernel.org>, <jonas@kwiboo.se>, <jernej.skrabec@gmail.com>,
        <airlied@gmail.com>, <daniel@ffwll.ch>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <sam@ravnborg.org>,
        <jani.nikula@intel.com>, <tzimmermann@suse.de>,
        <javierm@redhat.com>, <ville.syrjala@linux.intel.com>,
        <r-ravikumar@ti.com>, <lyude@redhat.com>,
        <alexander.deucher@amd.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>, <a-bhatia1@ti.com>,
        <tomi.valkeinen@ideasonboard.com>
References: <20230405142440.191939-1-j-choudhary@ti.com>
 <20230405142440.191939-2-j-choudhary@ti.com>
 <20230406014032.GN9915@pendragon.ideasonboard.com>
Content-Language: en-US
From:   Jayesh Choudhary <j-choudhary@ti.com>
In-Reply-To: <20230406014032.GN9915@pendragon.ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/04/23 07:10, Laurent Pinchart wrote:
> Hi Jayesh,
> 
> Thank you for the patch.
> 
> On Wed, Apr 05, 2023 at 07:54:39PM +0530, Jayesh Choudhary wrote:
>> From: Rahul T R <r-ravikumar@ti.com>
>>
>> The mhdp bridge can work without its HPD pin hooked up to the connector,
>> but the current bridge driver throws an error when hpd line is not
>> connected to the connector. For such cases, we need an indication for
>> no-hpd, using which we can bypass the hpd detection and instead use the
>> auxiliary channels connected to the DP connector to confirm the
>> connection.
>> So add no-hpd property to the bindings, to disable hpd when not
>> connected or unusable.
>>
>> Signed-off-by: Rahul T R <r-ravikumar@ti.com>
>> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
>> ---
>>   .../devicetree/bindings/display/bridge/cdns,mhdp8546.yaml   | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8546.yaml b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8546.yaml
>> index c2b369456e4e..3a6c6d837593 100644
>> --- a/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8546.yaml
>> +++ b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8546.yaml
>> @@ -57,6 +57,12 @@ properties:
>>     interrupts:
>>       maxItems: 1
>>   
>> +  cdns,no-hpd:
>> +    type: boolean
>> +    description:
>> +      Set if the HPD line on the bridge isn't hooked up to anything or is
>> +      otherwise unusable.
> 
> I'm fine with the non connected part, but concerned with "otherwise
> unusable". It's very vague and could thus be abused. Do you have
> particular use cases in mind for this ? If so, restricting this to those
> use cases, or at least giving examples, would help.

Okay. Will do that in next version.

Thanks.

> 
>> +
>>     ports:
>>       $ref: /schemas/graph.yaml#/properties/ports
>>   
> 
