Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0766C343B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 15:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbjCUO3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 10:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231195AbjCUO3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 10:29:35 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E140A24C97;
        Tue, 21 Mar 2023 07:29:00 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32LESQ3k015761;
        Tue, 21 Mar 2023 09:28:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1679408906;
        bh=turgaoA9Ps4HYc5Mt71Um0EHMFBvj+SVE4LLMNT2DvA=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=Na8LYsDCy7RuAmRlYZtcLqN7GyZVuXDfCqqy4G/VWVV+/YzCXGOLGNUTlqGHMhy3J
         SKi7nn7XLeJRuYuJ0Lapk0WqdxR8l4nQvHez1hJQojpn2PLlNXH2j2cCceIYf68tjq
         gcBzxA9t/f8IpzhnKuLMXmx4E9+hgNXlTxE0K0/A=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32LESQqO130105
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 21 Mar 2023 09:28:26 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 21
 Mar 2023 09:28:26 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 21 Mar 2023 09:28:26 -0500
Received: from [172.24.145.160] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32LESJH6002836;
        Tue, 21 Mar 2023 09:28:19 -0500
Message-ID: <d72bf0df-28d7-6419-56a5-58e04dcb30f2@ti.com>
Date:   Tue, 21 Mar 2023 19:58:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/2] dt-bindings: drm/bridge: Add no-hpd property
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>,
        <rfoss@kernel.org>, <Laurent.pinchart@ideasonboard.com>,
        <jonas@kwiboo.se>, <jernej.skrabec@gmail.com>, <airlied@gmail.com>,
        <daniel@ffwll.ch>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <sam@ravnborg.org>,
        <jani.nikula@intel.com>, <tzimmermann@suse.de>,
        <javierm@redhat.com>, <ville.syrjala@linux.intel.com>,
        <r-ravikumar@ti.com>, <lyude@redhat.com>,
        <alexander.deucher@amd.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>, <a-bhatia1@ti.com>
References: <20230316140823.234263-1-j-choudhary@ti.com>
 <20230316140823.234263-2-j-choudhary@ti.com>
 <dbc43c09-f8ec-f877-598a-adff47d44b0e@linaro.org>
 <79ce5fe8-9fb0-5caa-67a0-87dee7867856@ti.com>
 <55cfacf6-03e0-b9bc-83f3-3e9f2d7b2d4d@linaro.org>
From:   Jayesh Choudhary <j-choudhary@ti.com>
In-Reply-To: <55cfacf6-03e0-b9bc-83f3-3e9f2d7b2d4d@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/03/23 18:08, Krzysztof Kozlowski wrote:
> On 21/03/2023 13:02, Jayesh Choudhary wrote:
>>>
>>>> +    type: boolean
>>>> +    description:
>>>> +      Set if the HPD line on the bridge isn't hooked up to anything or is
>>>> +      otherwise unusable.
>>>
>>> It's the property of the panel, not bridge. Unless you want to say that
>>> bridge physically does not have HPD? Does it follow the standard in such
>>> case?
>>
>> MHDP does have hpd. But the mhdp driver should handle the cases when the
> 
> This is about bindings, not driver. Your driver can still handle this as
> it wishes.
> 
>> hpd pin of bridge is not connected to that of the DP-connector. This is
>> to add support for that. (optional property)
> 
> Which is indicated by panel no-hpd, right?

Actually no panel is involved in this. For TI SoC J721S2, the data 
pipeline involves the bridge whose endpoint is directly the DP connector 
with compatible 'dp-connector'. And in the binding dp-connector.yaml, 
there isn't any 'no-hpd' property for this indication.

Does this clarifies the issue? Or did I misinterpret your comment?

> Or you mean now that HPD
> physically cannot go to panel because it is cut on the bridge side? But
> isn't this the same case (from hardware/bindings point, not driver) as
> panel would not have HPD?
Warm Regards,
-Jayesh
