Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BBB66DFC41
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 19:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjDLRG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 13:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjDLRG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 13:06:56 -0400
Received: from sender4-op-o10.zoho.com (sender4-op-o10.zoho.com [136.143.188.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5197410CC;
        Wed, 12 Apr 2023 10:06:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1681319195; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=Y69vPWipPQQZR1kNAnfaOb4PhISKkqlxdBxMlr4j/rt2P4keljRWb7uvygce3sFWZALiVAnUK0E5YtMh/LKziP/0MqifwbK3HFKGfFzlioyVfA6pE/F+akHuQN8FWq7mursZM+N9taje9IFC2FAWz7OG5IBykWxKgR5jq0mdAYc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1681319195; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=mCBF1dc7P69W5ut4d6TAnzdLNbn/EghSKo06dDcdc8k=; 
        b=Lzvw6ASrVLVtNREB/pBlU+graOEJ6hxX1Fbh1FUda0p1L6B6kcmtmzSuVI0waOtJz21HxwrR02dZ1ycdE9rL264ywtP+1mxkwwangrUHz4pmtCBMHnKVpvC5dgN715FFGWR9Ht9hTbOJz4oQxH+NoodqooPonPpLTxhbZ6OAtsQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1681319195;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=mCBF1dc7P69W5ut4d6TAnzdLNbn/EghSKo06dDcdc8k=;
        b=ZC5woEucKeYFimcb2xKsW6MNSmdx01CZdk7GXPDFykyWRlZrQSWHwSwbHgGMIqDL
        zWfv7rh8R7eWX+N5iiawQ1wF+eLxYAUR3JJ7uz0DUUJXflKFN2KRjjyEwibsOIKDiP7
        aWWll1FGHWR5sBIW53aXcpwCLCEI1Sbn2NczXbEA=
Received: from [10.10.9.4] (149.91.1.15 [149.91.1.15]) by mx.zohomail.com
        with SMTPS id 1681319194453966.1180207770071; Wed, 12 Apr 2023 10:06:34 -0700 (PDT)
Message-ID: <e08c5175-d771-5b87-d065-47942a800419@arinc9.com>
Date:   Wed, 12 Apr 2023 20:06:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: Aw: Re: Re: Re: Re: Re: [PATCH v3 0/5] arm: dts: mt7623: relocate
 gmacs, mt7530 switch, and add port@5
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
 <2dc2fc39-b0d5-c872-36bf-fde851debe4b@arinc9.com>
 <A329B2DF-04B7-40FA-BBCE-1F1012A6DBBD@public-files.de>
 <fb96d8eb-2eb7-db19-1135-1a833294dd67@arinc9.com>
 <trinity-899c01a6-0fc5-4900-aea8-2b43802c8329-1676814734826@3c-app-gmx-bs35>
 <trinity-3f46d325-bc45-4ee7-ae86-c8db4467aa94-1681303779505@3c-app-gmx-bap50>
 <703ad8a8-f84e-6404-4cce-5386bfaa2bd7@arinc9.com>
 <trinity-489cdc3b-e861-49d0-b1ec-e964f00388df-1681312277092@3c-app-gmx-bap50>
 <0d242292-16b7-6837-7d1a-b70c41309e6b@arinc9.com>
 <trinity-990f3b28-d67c-49ef-9094-c3b7d2059e36-1681318402336@3c-app-gmx-bap50>
Content-Language: en-US
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <trinity-990f3b28-d67c-49ef-9094-c3b7d2059e36-1681318402336@3c-app-gmx-bap50>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.04.2023 19:53, Frank Wunderlich wrote:
> Hi
> 
>> Gesendet: Mittwoch, 12. April 2023 um 18:21 Uhr
>> Von: "Arınç ÜNAL" <arinc.unal@arinc9.com>
>>> thanks, it changes the master when i upgrade iproute to 6.1 (from debian bullseye-backports), but i cannot do any traffic on it after switching to gmac1...
>>>
>>> 5: wan@eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
>>>       link/ether f2:d2:51:56:cd:3d brd ff:ff:ff:ff:ff:ff
>>>       inet 192.168.0.11/24 scope global wan
>>>          valid_lft forever preferred_lft forever
>>>
>>> see no p5-TX/gmac-rx
> 
>> Did you apply the vlan and flooding fix patches from Richard?
> 
> have now applied all patches i've found from richard (which are all rejected):
> 
> fe4495bb3cc2 2023-02-12 Fix setting up CPU and User ports to be in the correct mode during setup and when toggling vlan_filtering on a bridge port.  (HEAD -> 6.3-rc)
> b0641f3e1a69 2023-02-12 Fix Flooding: Disable by default on User ports and Enable on CPU ports
> cb04b3451524 2023-02-12 Do not add all User ports to the CPU by default. This will break Multi CPU when added a seperate patch. It will be overwritten by .port_enable and since we are forcing output to a port via the Special Tag this is not needed.
> 
> and now it seems working and is clear ;)
> 
> root@bpi-r2:~# ip l show wan
> 5: wan@eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP mode DEFAULT group default qlen 1000
>      link/ether f2:d2:51:56:cd:3d brd ff:ff:ff:ff:ff:ff
> 
> iperf3
> [ ID] Interval           Transfer     Bitrate         Retr
> [  5]   0.00-10.00  sec  1.09 GBytes   940 Mbits/sec    0             sender
> [  5]   0.00-10.03  sec  1.09 GBytes   936 Mbits/sec                  receiver
> 
> 
> iperf3 -R
> [ ID] Interval           Transfer     Bitrate         Retr
> [  5]   0.00-10.04  sec  1.09 GBytes   936 Mbits/sec    0             sender
> [  5]   0.00-10.00  sec  1.09 GBytes   938 Mbits/sec                  receiver
> 
> 
> how do you deal with these patches? do you include them into your mt7530 fixes series? they (and vladimirs preferred cpu-port) need to be applied before these DTS-changes

Dealing with this is the last step on my tasklist. Take a look:

https://arinc9.notion.site/mt7530-c-improvements-bbfdc2ceb958484b9627297b88bc6d4a

Arınç
