Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC8CF6C1CDC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 17:53:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbjCTQxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 12:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232119AbjCTQwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 12:52:42 -0400
Received: from sender3-op-o18.zoho.com (sender3-op-o18.zoho.com [136.143.184.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9BAC2B294
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 09:44:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1679330597; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=h/+PbCZE5l6XCKBrHAhhdQNPbbcbZrIwO4OUE1rQf8sncft0ZctlEScVikknpqW20Ho5CYHEWL2W35J2wvlCkdV4WQgI79twaJgi7CGkn1Hf9/+0VkG68nOFhFTPy/TVpN79TjmwQk/yIz+/xpi5CwsVdb8FDV7l6h8si50VPkI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1679330597; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=2NprtxqNiitwbY2F8dbISBFoRDQEsNs4+aP+35cmoTs=; 
        b=KU77Cl2bnOrMSP9UEoQmtKnEauUir9k8qO3kSwiTgFGNzEJcSedhdLhK7Oh2QwhJiR5ST8G/8DzP9N+Syroo298Vr1Cz2D5JX3fxiN353Y7lTVDVlM0PcLYAeisz11ovGbMLCgluokO3HhiVfE/RM5RDprYkJUD9xb9HrZV0WJc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1679330597;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=2NprtxqNiitwbY2F8dbISBFoRDQEsNs4+aP+35cmoTs=;
        b=V9JUA8ia0cZHiYVePihLYBSm+u/PE2Z19t7LIe8jIUa93oItI1r5Enc1aYw68niz
        XO3obKHoS0JZniS2QDP9b6LpKgpqzbmHvE5l/gmVuQKcfZQAfWWGSKK8SoECbD3aMBG
        lpIlrbJqNYWLe1Y8CLd9JNd3lsGfXT7mNIcSONCI=
Received: from [10.10.10.3] (149.91.1.15 [149.91.1.15]) by mx.zohomail.com
        with SMTPS id 1679330596642147.2366316206377; Mon, 20 Mar 2023 09:43:16 -0700 (PDT)
Message-ID: <b98429b7-2932-6bd5-39bc-f82c747b4333@arinc9.com>
Date:   Mon, 20 Mar 2023 19:43:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 01/10] dt: bindings: clock: add mtmips SoCs clock device
 tree binding documentation
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        linux-clk@vger.kernel.org
Cc:     linux-mips@vger.kernel.org, tsbogend@alpha.franken.de,
        john@phrozen.org, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, devicetree@vger.kernel.org
References: <20230320161823.1424278-1-sergio.paracuellos@gmail.com>
 <20230320161823.1424278-2-sergio.paracuellos@gmail.com>
 <1e2f67b4-3bfb-d394-4f60-e6f63ce6a2fd@linaro.org>
Content-Language: en-US
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <1e2f67b4-3bfb-d394-4f60-e6f63ce6a2fd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.03.2023 19:36, Krzysztof Kozlowski wrote:
> On 20/03/2023 17:18, Sergio Paracuellos wrote:
>> Adds device tree binding documentation for clocks and resets in the
>> Mediatek MIPS and Ralink SOCs. This covers RT2880, RT3050, RT3052, RT3350,
>> RT3883, RT5350, MT7620, MT7628 and MT7688 SoCs.
> 
> Use subject prefixes matching the subsystem (which you can get for
> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
> your patch is touching).
> 
> Subject: drop second/last, redundant "device tree binding
> documentation". The "dt-bindings" prefix is already stating that these
> are bindings.
> (BTW, that's the longest redundant component I ever saw)
> 
>>
>> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
>> ---
>>   .../bindings/clock/mtmips-clock.yaml          | 68 +++++++++++++++++++
>>   1 file changed, 68 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/clock/mtmips-clock.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/clock/mtmips-clock.yaml b/Documentation/devicetree/bindings/clock/mtmips-clock.yaml
>> new file mode 100644
>> index 000000000000..c92969ce231d
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/mtmips-clock.yaml
> 
> Filename matching compatible, so vendor prefix and device name (or
> family of names).

I influenced Sergio to use MTMIPS here as I want to designate it the 
family name for the MediaTek MIPS and Ralink SoCs. We can't change the 
compatible string as it's established from my pinctrl patch series we 
don't do that.

Arınç
