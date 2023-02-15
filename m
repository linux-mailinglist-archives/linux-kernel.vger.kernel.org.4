Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50C3B698711
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 22:10:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbjBOVKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 16:10:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjBOVKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 16:10:22 -0500
Received: from stravinsky.debian.org (stravinsky.debian.org [IPv6:2001:41b8:202:deb::311:108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A794484;
        Wed, 15 Feb 2023 13:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
        s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Reply-To:Content-ID:Content-Description;
        bh=bJ4XhLfeX5YRtgDDbsDogMT87rAGutSNEOEm7YHb434=; b=uiMhdPvn1NBtP5oMOSp+a7gMqv
        Lh61I64BFZ2epzBcHSVoISW+weS2ffALOna+WUIUXrJAym+wmgugwmgtA24ZuaKiel5I0e4uNiwQm
        B46hBTo3D5HIqb8Du5ka9fR6Aw+OETsWmhEqdCd/umw3QT+hXlD++lgE4vX00YbzRfTtY8M6LRco6
        qdi9MoZ6t14+XOzURORF2/VcJq2/iwoj/kMiIS+rQWg8P4rVAb2rbxT6EQ3fhcvLLxNXt2Jx+7KGG
        WGm/0YyCzUD3vVcK1oORGWAE314q4FGaP0jo6xAhuD2CU9qIW45FVjI8CU+kDlzUfuojVnxFfNPvD
        RUPBjlSg==;
Received: from authenticated user
        by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
        (Exim 4.94.2)
        (envelope-from <bage@debian.org>)
        id 1pSOiP-002je6-UO; Wed, 15 Feb 2023 20:49:22 +0000
Message-ID: <f1041e65-8058-ab82-3d6a-0bc2426b64bf@debian.org>
Date:   Wed, 15 Feb 2023 21:49:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v2 3/5] dt-bindings: hwlock: sun6i: Add missing names
Content-Language: en-US
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Wilken Gottwalt <wilken.gottwalt@posteo.net>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        devicetree@vger.kernel.org
References: <20230215203711.6293-1-bage@debian.org>
 <20230215203711.6293-4-bage@debian.org>
 <20230215204514.613a9a96@slackpad.lan>
From:   Bastian Germann <bage@debian.org>
In-Reply-To: <20230215204514.613a9a96@slackpad.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Debian-User: bage
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 15.02.23 um 21:45 schrieb Andre Przywara:
> On Wed, 15 Feb 2023 21:37:08 +0100
> Bastian Germann <bage@debian.org> wrote:
> 
>> The allwinner,sun6i-a31-hwspinlock.yaml binding needs clock-names
>> and reset-names set to "ahb" as required by the Linux driver.
> 
> Mmmh, but I thought that Krzysztof pretty clearly NAKed this?
> So we have to either reach consensus on this or find another solution,
> like teaching the driver to comply with the existing binding.
> We could for instance get the first clock, should the devm_clk_get()
> call fail.

Either way - I wanted to send a fix for the dt-binding example as Rob requested.
This is not to say that I want to ignore the NAK.

> Cheers,
> Andre
> 
> 
>>
>> Fixes: f9e784dcb63f ("dt-bindings: hwlock: add sun6i_hwspinlock")
>> Signed-off-by: Bastian Germann <bage@debian.org>
>> ---
>>   .../hwlock/allwinner,sun6i-a31-hwspinlock.yaml       | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/hwlock/allwinner,sun6i-a31-hwspinlock.yaml b/Documentation/devicetree/bindings/hwlock/allwinner,sun6i-a31-hwspinlock.yaml
>> index 38478dad8b25..6cdfe22deb3c 100644
>> --- a/Documentation/devicetree/bindings/hwlock/allwinner,sun6i-a31-hwspinlock.yaml
>> +++ b/Documentation/devicetree/bindings/hwlock/allwinner,sun6i-a31-hwspinlock.yaml
>> @@ -23,9 +23,17 @@ properties:
>>     clocks:
>>       maxItems: 1
>>   
>> +  clock-names:
>> +    items:
>> +      - const: ahb
>> +
>>     resets:
>>       maxItems: 1
>>   
>> +  reset-names:
>> +    items:
>> +      - const: ahb
>> +
>>     '#hwlock-cells':
>>       const: 1
>>   
>> @@ -33,7 +41,9 @@ required:
>>     - compatible
>>     - reg
>>     - clocks
>> +  - clock-names
>>     - resets
>> +  - reset-names
>>     - "#hwlock-cells"
>>   
>>   additionalProperties: false
>> @@ -47,7 +57,9 @@ examples:
>>           compatible = "allwinner,sun6i-a31-hwspinlock";
>>           reg = <0x01c18000 0x1000>;
>>           clocks = <&ccu CLK_BUS_SPINLOCK>;
>> +        clock-names = "ahb";
>>           resets = <&ccu RST_BUS_SPINLOCK>;
>> +        reset-names = "ahb";
>>           #hwlock-cells = <1>;
>>       };
>>   ...
> 

