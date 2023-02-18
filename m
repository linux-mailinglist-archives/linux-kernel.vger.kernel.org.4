Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 016DF69B980
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 11:49:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjBRKts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 05:49:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjBRKtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 05:49:45 -0500
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C639920567;
        Sat, 18 Feb 2023 02:49:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1676717364; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=DsffZtaWvZuCbaZE5EHJ1vFswNstU37dTPw6i3RIq9xufQXDTJw1TPliygnNW+4X0diwWvdgonV2JvzNiMzMKz8JL+MxiOwnDADAsQwZT51g4MaqTKMaZPJg8QqOrYkpQ8+hzwgOPNXrIPikh7zogmluD0efw3ZIjpY0mSGnpWw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1676717364; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=bjWvJA7jye8dKxGeIaACDeBj5ieOquYarDMgtwo/Pgc=; 
        b=MIWFN+x7mBIZh5b+dAG0WC4DSuDmuFYhUnH1nLQijjm8jnO4g0Qp+HKhwg0QmH1cTBzlCngJfHFJ1UgC3o8NEfQ9vnHIrfTagsTRi8P3P/HYRkqKr8wNoCnHi4lXFGd/R8LzRC6yBbD/ZlDrVFGyZFQFGO79yNkLP/AdmlE+aA8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1676717364;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=bjWvJA7jye8dKxGeIaACDeBj5ieOquYarDMgtwo/Pgc=;
        b=AN2iUkq6iC19pz4UBX2M5jGu37WIRJY+mJXpBYTD7hHatDjFHUUU12YJSO1q34UF
        HOhZZemPJRVTcTNEBuydB7oe/g0YLcg+RxZ67YZQOIDip9j5M9XSoYbeQpFm9LTCm+V
        kHm4FIz17yqNjM1w9WkCTjfnfsOYnNomWj71xOEA=
Received: from [10.10.10.3] (37.120.152.236 [37.120.152.236]) by mx.zohomail.com
        with SMTPS id 1676717363028260.89467269078705; Sat, 18 Feb 2023 02:49:23 -0800 (PST)
Message-ID: <27a26da8-8297-5327-7493-54d8359b6970@arinc9.com>
Date:   Sat, 18 Feb 2023 13:49:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: Aw: Re: [PATCH v3 0/5] arm: dts: mt7623: relocate gmacs, mt7530
 switch, and add port@5
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
Content-Language: en-US
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <trinity-dab715b9-3953-40da-bc25-c4c2a5e9b7c3-1676715866453@3c-app-gmx-bap53>
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

On 18.02.2023 13:24, Frank Wunderlich wrote:
> Hi,
> 
> finally get some time to bootup with this series on my r2.
> 
> I see that inserting the port@5 as cpu-port maps this as default-cpu because dsa-core uses first found cpu-port as
> default (dsa_tree_setup_cpu_ports in dsa.c) and because of lower bandwidth (rgmii instead of trgmii) not the best choice.
> 
> But it look worse...network is currently broken (set both gmacs up).
> I see arp-packets reaching remote side, but reponse is not received by r2
> 
> I have tested it on 6.2-rc8 (wan-port), maybe additional patches are needed?...userspace setup should be right.
> 
> so i added series on top of net-next (no additional patches except some basic like build-script,defconfig and such)...same result...
> 
> i'm not sure if i change the mapping from userspace back to eth0, so disabled port@5 in switch, now port6 is
> cpu-port again and it works...so something is wrong with port5 of switch or gmac1.

That's a driver issue and will be fixed once an accepted version of 
these patches [0] [1] [2] are applied to net-next. You should have them 
on your inbox, I specifically told Richard to CC you.

This is devicetree bindings. We're here to describe the hardware. The 
way a driver works should not affect describing the hardware.

To address the lower bandwidth situation you mentioned, a devicetree 
property to designate a CPU port as the default CPU port could be 
introduced. I'm not aware of a similar conversation so I'll send a mail 
to netdev to discuss this. Will CC you.

[0] 
https://lore.kernel.org/netdev/20230212213949.672443-1-richard@routerhints.com/
[1] 
https://lore.kernel.org/netdev/20230212214027.672501-1-richard@routerhints.com/
[2] 
https://lore.kernel.org/netdev/20230212215152.673221-1-richard@routerhints.com/

Arınç
