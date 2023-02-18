Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC0769BB1F
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 18:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjBRRCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 12:02:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjBRRCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 12:02:36 -0500
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800CF17155;
        Sat, 18 Feb 2023 09:02:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1676739735; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=IrY6+2wmINrLPE1OjKcB2ftD4ccOzw5BpiBi0R0gVKen+POoOX0nRyc4CbF3R2Ecq47LsgrmnA9i8sXIjQarXb+fShvX9hzARLAUr9NAV8p6EEC8aEww2673Dib2GPdZ8B+M0oIgBuuejETKnc4oApmkVTCukLVpSLV8SqLPvxk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1676739735; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=OU76lksV218JbmTGP0WWsGt/RPb9VxwBOFGAGP4HBCA=; 
        b=T/Gwn/cJQNPVDf+K9lHzvHk9mlqIvuXpQjl5H7L3tpfHnMqG0VM6WUz8ugfPctJfrg8FG6qUZCUUbopeHDhFgeL+Oi5iBIH3hcOB0uD2N/WDUocnqrJT06MQU0+/AnRebVuPHRQ+kPeXHi4GR2iFctXdUfYOeAt098TBg4jA6x8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1676739735;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=OU76lksV218JbmTGP0WWsGt/RPb9VxwBOFGAGP4HBCA=;
        b=TK/dPcM+saXOQFgC1mGPenDl9cpY35A0E2N06iX4HcZkXM7Pt8UDqv+lKo6zjz82
        Zw/dOIYkZEpF5nag1CxoSVOWtn6YgCgYtfSqvpOJMhnLcjgHXoPglLleahoElc6xk55
        t6wihmgIAKvkH3ILcdSEHCoAqwR4TWeCicfCjmG4=
Received: from [10.10.10.3] (37.120.152.236 [37.120.152.236]) by mx.zohomail.com
        with SMTPS id 1676739734907626.1261199347749; Sat, 18 Feb 2023 09:02:14 -0800 (PST)
Message-ID: <2dc2fc39-b0d5-c872-36bf-fde851debe4b@arinc9.com>
Date:   Sat, 18 Feb 2023 20:02:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: Aw: Re: Re: [PATCH v3 0/5] arm: dts: mt7623: relocate gmacs,
 mt7530 switch, and add port@5
To:     Frank Wunderlich <frank-w@public-files.de>
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
Content-Language: en-US
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <trinity-dd260791-3637-4193-8f93-a9fcdb013dcb-1676722705920@3c-app-gmx-bap53>
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

On 18.02.2023 15:18, Frank Wunderlich wrote:
> Hi,
> 
>> Gesendet: Samstag, 18. Februar 2023 um 11:49 Uhr
>> Von: "Arınç ÜNAL" <arinc.unal@arinc9.com>
>> An: "Frank Wunderlich" <frank-w@public-files.de>
> 
>> On 18.02.2023 13:24, Frank Wunderlich wrote:
>>> Hi,
>>>
>>> finally get some time to bootup with this series on my r2.
>>>
>>> I see that inserting the port@5 as cpu-port maps this as default-cpu because dsa-core uses first found cpu-port as
>>> default (dsa_tree_setup_cpu_ports in dsa.c) and because of lower bandwidth (rgmii instead of trgmii) not the best choice.
>>>
>>> But it look worse...network is currently broken (set both gmacs up).
>>> I see arp-packets reaching remote side, but reponse is not received by r2
>>>
>>> I have tested it on 6.2-rc8 (wan-port), maybe additional patches are needed?...userspace setup should be right.
>>>
>>> so i added series on top of net-next (no additional patches except some basic like build-script,defconfig and such)...same result...
>>>
>>> i'm not sure if i change the mapping from userspace back to eth0, so disabled port@5 in switch, now port6 is
>>> cpu-port again and it works...so something is wrong with port5 of switch or gmac1.
>>
>> That's a driver issue and will be fixed once an accepted version of
>> these patches [0] [1] [2] are applied to net-next. You should have them
>> on your inbox, I specifically told Richard to CC you.
> 
> yes, i've got them, but not applied when starting these tests. Not thought, that this change is necessary
> as we use both gmac on mt7531/bpi-r3 with out problems.
> 
> with these 3 Patches network-connection works, but only at ~624 Mbit/s in TX-Mode (started iperf3-client on r2 without -R) and massive retransmitts on first run, other direction is clean.

Ok, so according to your tests, traffic through gmac1 is not very good. 
gmac0 should be the default DSA master.

By the way, did you make a bug report of this, by sending a mail to 
netdev mailing list or some other way?

> 
> and these Patches need to be applied first (when fixed up) else network is broken.

That's true.

> 
>> This is devicetree bindings. We're here to describe the hardware. The
>> way a driver works should not affect describing the hardware.
> 
> thats right, but it should not break/change behaviour like now all ports have only ~600Mbit because of
> moving them all to the other gmac which has obvious issues.

Makes sense.

> 
>> To address the lower bandwidth situation you mentioned, a devicetree
>> property to designate a CPU port as the default CPU port could be
>> introduced. I'm not aware of a similar conversation so I'll send a mail
>> to netdev to discuss this. Will CC you.
> 
> isn't there a way to leave ports by default on the the better gmac (gmac0=trgmii)?
> maybe moving port5 below port6...not nice, but then port6 is the first cpu found.

This could be done but it comes off as an improper way to me.

> or maybe defined the default cpu in driver which gets picked up by core (define port6 if available as default).
> Imho additional dts-propperty is wrong approch...it should be handled by driver. But cpu-port-selection is
> currently done in dsa-core which makes it a bit difficult.
> 
> I'm not sure how the multi-cpu support in dsa-core ended and how you use the other gmac not used by dsa-core
> 
> set master in userspace-config? i remember you've sent a patch adding callback for it.

You can change the DSA master using iproute2-6.1.0 and above with this 
patch which should be in your inbox as well.

https://lore.kernel.org/netdev/20230211184101.651462-1-richard@routerhints.com/

> 
> imho dts change should be applied if these points are cleared...

The only issue I see here is that, with this patch series, port5 becomes 
the default CPU port which is not preferred for the reasons you explained.

So once we can have port6 to be the default CPU port of the DSA slaves, 
there's no issues left.

Arınç
