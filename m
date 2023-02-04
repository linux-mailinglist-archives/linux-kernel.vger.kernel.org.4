Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C561868A9BC
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 13:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbjBDMNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 07:13:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbjBDMNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 07:13:11 -0500
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28BBD113CB;
        Sat,  4 Feb 2023 04:13:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1675512768; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=QJPGyrAD2LHtgecbWVct0BBn7uYU5cIVK2az330iVYkXdhu0te0SMpwqMkuLggH7W4SA+KVxuKr2j3xS6Nt4X3HKg2dafCCNQNeAt4Fwi3kt2wIcNRyQnD18namJlYnWiY3wbigi+ewNwGRSxoeOJ8NbE6eK9exPEupWMBh5dR4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1675512768; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=AI2UclE70CY6n/uYrDJRU2Tla/wSoenndZymbUC+hn8=; 
        b=Vi8xRrDuogPogjsF8JuDqxxl1R6tA+qglmFfoD8FRw0I3aWCKfG4My2Ht7/7lDwRw54RGJ155A4Ws2G8T7i74XFRyZq0C5Uto2I0ZUqJaLwYy/PAxyywvRegtLvHgAYk9Dd7C98CRI3qmk8/UoE9GKo0p6ZGeZanjLWtpNLuD5c=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1675512768;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=AI2UclE70CY6n/uYrDJRU2Tla/wSoenndZymbUC+hn8=;
        b=b1iEuwlhWn5UBOTzBHED2CFGpRk17SIogoN80krsMZcUwQ5tWyHUqcO0dHM0hUAv
        mXEd9X7x8FY68maw1k1bgm6c9h2BSn/xoVnyLqvVvpAQjaJXoWnMIspuBToDx/PblT2
        jvo3L1rW3fRtJIi6TICSWM7VOzgjdlqMjOknhZ2Q=
Received: from [10.10.10.3] (37.120.152.236 [37.120.152.236]) by mx.zohomail.com
        with SMTPS id 1675512766438793.461234528659; Sat, 4 Feb 2023 04:12:46 -0800 (PST)
Message-ID: <f628db9c-cf61-e1bc-2160-0c8d1caa0fbe@arinc9.com>
Date:   Sat, 4 Feb 2023 15:12:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: Aw: Re: [PATCH v2 4/5] arm: dts: mt7623: mux phy0 on Bananapi
 BPI-R2
Content-Language: en-US
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     arinc9.unal@gmail.com, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        erkin.bozoglu@xeront.com, Sean Wang <sean.wang@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>
References: <20230201185656.17164-1-arinc.unal@arinc9.com>
 <20230201185656.17164-5-arinc.unal@arinc9.com>
 <AC473057-266B-4403-9270-8007E0EC257C@public-files.de>
 <75d3758a-5502-03a4-b3a2-990f9339705b@arinc9.com>
 <trinity-ec3920c5-a96a-4edf-9ff1-4bf07e7b4d07-1675506452617@3c-app-gmx-bs72>
 <trinity-a01f321e-0973-417e-9a25-9350f63ece37-1675511027203@3c-app-gmx-bs72>
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <trinity-a01f321e-0973-417e-9a25-9350f63ece37-1675511027203@3c-app-gmx-bs72>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4.02.2023 14:43, Frank Wunderlich wrote:
>> Gesendet: Samstag, 04. Februar 2023 um 11:27 Uhr
>> Von: "Frank Wunderlich" <frank-w@public-files.de>
>> An: "Arınç ÜNAL" <arinc.unal@arinc9.com>
>> Cc: arinc9.unal@gmail.com, "Rob Herring" <robh+dt@kernel.org>, "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>, "Matthias Brugger" <matthias.bgg@gmail.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, erkin.bozoglu@xeront.com, "Sean Wang" <sean.wang@mediatek.com>, "DENG Qingfang" <dqfext@gmail.com>
>> Betreff: Aw: Re: [PATCH v2 4/5] arm: dts: mt7623: mux phy0 on Bananapi BPI-R2
>>
>> Hi aranc,
>>
>> have tested this series, basicly it works, but i get only ~620 Mbits/sec (much more i will need on wan) in tx-mode of r2, rx-mode (iperf3 -c IP -R on r2) gets full 939 Mbits/sec. Both no retransmitts.
>>
>> tried with my laptop which gets 940Mbit/sec in tx mode too...other end is a R2 with 5.15 connected to lan0 (and eth1+aux enabled, dmesg clean so far...for the "kernel log flooded"-comment).
>>
>> maybe gmac1 needs to be tweaked a bit (clock-settings)?
>>
>> can you confirm this with your board?
> 
> tested the vlan_aware way with 5.15.80 and got better result
> 
> ip link add br0 type bridge vlan_filtering 1
> ip l set aux master br0
> ip l set wan master br0
> bridge vlan add vid 99 dev wan
> bridge vlan add vid 99 dev aux
> bridge vlan
> ip l s eth1 up
> ip l s wan up
> ip a a 192.168.0.11/24 dev eth1
> ip l s br0 up
> ip l s aux up
> 
> i see traffic on eth1 increasing and iperf3 shows in both directions ~940Mbit/s, no strange mesages in dmesg while testing...where do you see these?

You didn't put eth1 on a bridge. I suggest you read my mails with higher 
attention so both of our time is spent efficiently.

> 
> tested vlan-way with 6.2 and felix' Patches to more comparable with your test...and got same result (~625Mbit/s in tx and 940Mbit/s in rx-mode=-R on r2)...so it seems anything between 5.15 and 6.2 reduced gmac1 tx bandwidth.

I don't see an incentive to investigate unless the issue is confirmed on 
a daily netdev/net-next.git main tree.

> 
> to summarize:
> 
> i get same result with your patches and my old vlan_bridge way with same codebase...how do i see your problem with the vlan-bridge-way? Do you test with bpi-r2 or only any other board and change r2 to have same DT?

I tested this only on a Bananapi BPI-R2 using the devicetree with this 
series applied on a few days old netdev/net-next.git main tree.

Arınç
