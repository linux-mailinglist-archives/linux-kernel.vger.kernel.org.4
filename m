Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C79E69BBA0
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 20:35:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjBRTfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 14:35:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjBRTfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 14:35:09 -0500
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF8812BC1;
        Sat, 18 Feb 2023 11:35:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1676748888; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=nbuJT5N13TeH0s2uDVBN6q6J4EfA+cZHyG2lPNsFevcwE1RTdf7THNiramRmxJgyMeAgeFMhbV4pt1cOsBiKN/2JQMyfypnox9cf5qFKmkENphyYEgAJGEYz+a4uXsEj21XX/LwC4au9OY2B/XP+GIAQb2adu5wy+Iz/fs4HPGs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1676748888; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=tZV+QS57xsYCZFRjiUvfqscADao5AlRSJDkNzJS67Jo=; 
        b=ZzVeOw9NfZ49XetplJ7gErWVHkh+k8IITZl6KV8bYn/jSFPgZaA0EQIOYYkIwZO/Wqf/ZEDZKFdKXnpF68yfjDuEF3rdhXAIwRiwcb8ebgsK/sgOeAxZHv+PD6eMaJJ5YQ2/2AZGAFfhMwKEZSyxCiq8Fuzt1MZDO6PQbRiumYg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1676748888;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=tZV+QS57xsYCZFRjiUvfqscADao5AlRSJDkNzJS67Jo=;
        b=Ju//1x+hgPkzxOici3o4d7jc820tjW2rZjFC0noy+s7BVa2d8vWdMxNVZ5q8V6nl
        vSGGmmO/ie9Q7I+WtLxQQvhjbFZ/uuOQTWUdjFbVw0BRS3sdwwl6J/tqWmd6EzuHCCr
        7s9joq8ZR5EvUa0uhddKOj+HxrpszwuFNFq6Vl04=
Received: from [10.10.10.3] (37.120.152.236 [37.120.152.236]) by mx.zohomail.com
        with SMTPS id 1676748886869326.9651514920499; Sat, 18 Feb 2023 11:34:46 -0800 (PST)
Message-ID: <fb96d8eb-2eb7-db19-1135-1a833294dd67@arinc9.com>
Date:   Sat, 18 Feb 2023 22:34:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: Aw: Re: Re: [PATCH v3 0/5] arm: dts: mt7623: relocate gmacs,
 mt7530 switch, and add port@5
To:     frank-w@public-files.de
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, erkin.bozoglu@xeront.com
References: <20230210182505.24597-1-arinc.unal@arinc9.com>
 <c3ab9a9b-3eb2-8fb0-d5d7-c0b7c684d3a7@arinc9.com>
 <trinity-dab715b9-3953-40da-bc25-c4c2a5e9b7c3-1676715866453@3c-app-gmx-bap53>
 <27a26da8-8297-5327-7493-54d8359b6970@arinc9.com>
 <trinity-dd260791-3637-4193-8f93-a9fcdb013dcb-1676722705920@3c-app-gmx-bap53>
 <2dc2fc39-b0d5-c872-36bf-fde851debe4b@arinc9.com>
 <A329B2DF-04B7-40FA-BBCE-1F1012A6DBBD@public-files.de>
Content-Language: en-US
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <A329B2DF-04B7-40FA-BBCE-1F1012A6DBBD@public-files.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.02.2023 22:11, Frank Wunderlich wrote:
> Am 18. Februar 2023 18:02:11 MEZ schrieb "Arınç ÜNAL" <arinc.unal@arinc9.com>:
>> On 18.02.2023 15:18, Frank Wunderlich wrote:
>>> Hi,
>>>
>>>> Gesendet: Samstag, 18. Februar 2023 um 11:49 Uhr
>>>> Von: "Arınç ÜNAL" <arinc.unal@arinc9.com>
>>>> An: "Frank Wunderlich" <frank-w@public-files.de>
>>>
>>>> On 18.02.2023 13:24, Frank Wunderlich wrote:
> 
>> Ok, so according to your tests, traffic through gmac1 is not very good. gmac0 should be the default DSA master.
> 
>> By the way, did you make a bug report of this, by sending a mail to netdev mailing list or some other way?
> 
> No,not yet, because gmac1 is not yet used and i had very limited time. I'm not sure it is an issue in mt7530 driver or mtk_soc_eth, not idea how to figure this out. Maybe it can be fixed with a delayed rgmii phy-mode (rgmii-rx-id i guess as traffic affected is rx on switch,tx on gmac).

My experience with rgmii delays is that if the correct delay is not set 
for tx or rx, that tx or rx will just not work at all. But testing it 
anyway won't hurt.

Can you also remove this from mt7530.c and do the test again? See if the 
performance changes at all.

         /* Set core clock into 500Mhz */
         core_write(priv, CORE_GSWPLL_GRP2,
                    RG_GSWPLL_POSDIV_500M(1) |
                    RG_GSWPLL_FBKDIV_500M(25));

> 
>>> isn't there a way to leave ports by default on the the better gmac (gmac0=trgmii)?
>>> maybe moving port5 below port6...not nice, but then port6 is the first cpu found.
>>
>> This could be done but it comes off as an improper way to me.
> 
> Just thought about a way without the need of changing driver or adding a new dt property which can be wrongly used (who prevents anybody set the "default-cpu" property on more than 1 cpu-port?), Or define it at switch node level not port level (e.g. via phandle).

This is why we write json-schema documentation.

> 
> If the 5-below-6 way is not the right one i would prefer a driver solution, e.g. let driver choose the best cpu based on fixed value (constant via define) or on highest throughput (trgmii > rgmii),but last may fail if both cpu-ports have same speed like mt7531.
> 
> These are the possible solutions i see atm. Maybe dsa people can share their opinion.

You should share your opinion on my mail to netdev mailing list I 
recently CC'd you.

> 
>>> set master in userspace-config? i remember you've sent a patch adding callback for it.
>>
>> You can change the DSA master using iproute2-6.1.0 and above with this patch which should be in your inbox as well.
>>
>> https://lore.kernel.org/netdev/20230211184101.651462-1-richard@routerhints.com/
> 
> I try to test it.
> 
>> The only issue I see here is that, with this patch series, port5 becomes the default CPU port which is not preferred for the reasons you explained.
>>
>> So once we can have port6 to be the default CPU port of the DSA slaves, there's no issues left.
> 
> For me this would be ok if the current configuration does not change, right :)

Userspace configuration won't change, not with the current patch, not ever.

Arınç
