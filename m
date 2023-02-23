Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73BFC6A0E85
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 18:18:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjBWRSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 12:18:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjBWRR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 12:17:58 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7395FF8;
        Thu, 23 Feb 2023 09:17:56 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 31NHHXY2037741;
        Thu, 23 Feb 2023 11:17:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1677172653;
        bh=o2Nb7KbFzvIYkv4sc2lMJ4n5HXWpmBwMln8gTDzt9K0=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=wMrtpCCafkPOnQwzlEcjxQqTlNCsWd4DnQS5l+Sq2uI++DrbqQIimEHXpsvDka0oT
         AzyGhbYvxo2IU9+JFFcrrmN/A8I/voZQOy/QOZIS+gseGrCJDGS7CQe1y1+spFJD7C
         MOoJHPc5W6N2YRtl3hIHBDIKr3TFfDI5LbLSIIck=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 31NHHXUP072344
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 23 Feb 2023 11:17:33 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 23
 Feb 2023 11:17:32 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 23 Feb 2023 11:17:32 -0600
Received: from [10.250.32.101] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 31NHHWVx058665;
        Thu, 23 Feb 2023 11:17:32 -0600
Message-ID: <a3819147-dc7b-ecbf-107e-88f88be33825@ti.com>
Date:   Thu, 23 Feb 2023 11:17:31 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v4 1/2] dt-bindings: arm: omap: add phytec pcm-049 som and
 pcm-959 dev board
Content-Language: en-US
To:     Colin Foster <colin.foster@in-advantage.com>
CC:     <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>,
        <soc@kernel.org>, Olof Johansson <olof@lixom.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
References: <20230222203847.2664903-1-colin.foster@in-advantage.com>
 <20230222203847.2664903-2-colin.foster@in-advantage.com>
 <dd67f7c9-0867-47d0-a201-9316908d9d62@ti.com>
 <Y/eTZONJh8QdJVP8@COLIN-DESKTOP1.localdomain>
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <Y/eTZONJh8QdJVP8@COLIN-DESKTOP1.localdomain>
Content-Type: text/plain; charset="UTF-8"; format=flowed
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

On 2/23/23 10:25 AM, Colin Foster wrote:
> On Thu, Feb 23, 2023 at 10:00:50AM -0600, Andrew Davis wrote:
>> On 2/22/23 2:38 PM, Colin Foster wrote:
>>> Add yaml documentation for TI OMAP devices for the Phytec PCM-049 SoM and
>>> the Phytec PCM-959 development kit.
>>>
>>> Signed-off-by: Colin Foster <colin.foster@in-advantage.com>
>>> ---
>>>
>>> v4
>>>       * New patch, based on a WIP from Andrew Davis <afd@ti.com>
>>>
>>> ---
>>>    .../devicetree/bindings/arm/ti,omap.yaml      | 29 +++++++++++++++++++
>>>    1 file changed, 29 insertions(+)
>>>    create mode 100644 Documentation/devicetree/bindings/arm/ti,omap.yaml
>>
>> How will this work if I add the same file? Why not take my WIP patch, make
>> the suggested changes from Rob, then have it as your first patch in this
>> series?
> 
> Is your WIP intended to convert all omap.txt to ti,omap.yaml? Or chunk
> off devices one at a time?
> 
> If the former, when your patch is done it should be a pretty simple
> rebase conflict resolution. If the latter (which feels more digestable)
> this offers that template. This was Rob's / Tony's suggestion, albeit
> before you sent your patch set.
> 
> 
> Anyway, I'm happy to do any of the following:
> 
> 1. Take Andrew's patches, add these references and re-submit.
> 2. Keep this set as-is (with the typo fix) and when Andrew's WIP is done
>     it should be an easy rebase before submission.
> 3. Wait for Andrew's WIP to be done, then submit with this update.
> 
> 
> I'd like to avoid #3 because I don't know where this might fall on your
> priorities list.

Low priority for me, I'd suggest #1 or they probably will not be
converted anytime soon.

Andrew
