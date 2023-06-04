Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7225E721768
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 15:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbjFDN0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 09:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbjFDN0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 09:26:13 -0400
Received: from sender3-op-o18.zoho.com (sender3-op-o18.zoho.com [136.143.184.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 688DFDB;
        Sun,  4 Jun 2023 06:26:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1685885132; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=Bywjwr7BNZlcxr5xW8ywb/LUrth01TtuaIEzUscw5rmX06leIr3v9HwiIgRRsBgyEJc4eoyelom1Oino5farHt/6sHZURY6YCUS7RoAba0NmYE0NzKTYPHyrqR8cAtsget3hHm+HU64yCSGgpUg0A8CkA9QoJjdM/59P0AfbRIU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1685885132; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=Cb7bonRujnndbvNIQM4LPU8azHbUPLzM2mZY1a0gQGI=; 
        b=cdNpsrhhpx7GhnTU3QZHNbQJOHRush/nD8ynZ4Vr6QPb56F4zPvSVpb95CUZIbLXKhjJeAgnH45xVaCFvwynvPVqv3Ul0GSLXInhJNlo45vukbffyz6ZtiwHDB3H98aEEqvq8hbVHCW12fQwG/IFn62cV7cU8bKfKbRkpwDk+kc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1685885132;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=Cb7bonRujnndbvNIQM4LPU8azHbUPLzM2mZY1a0gQGI=;
        b=XU6xkZ/2tPG385WlIaSzEZYOyvN4SYWSQsDarOdl4aeSruIqKCUFpqJSywK2srCK
        5JWJRxHug9M8vooCWhCzIpB3mSv/KE/GxqeSgXih2vjpIpZNEpec6RdDx5PoLxXAdxv
        FQUYrgPQ8VznvBx8djyvvcHdODAxEBj1A1CNSvRI=
Received: from [192.168.99.249] (178-147-169-233.haap.dm.cosmote.net [178.147.169.233]) by mx.zohomail.com
        with SMTPS id 1685885131523433.411804914748; Sun, 4 Jun 2023 06:25:31 -0700 (PDT)
Message-ID: <77906053-62f4-bfbb-6b76-cb22c30bd102@arinc9.com>
Date:   Sun, 4 Jun 2023 16:25:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH net-next 24/30] net: dsa: mt7530: rename MT7530_MFC to
 MT753X_MFC
Content-Language: en-US
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Sean Wang <sean.wang@mediatek.com>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Richard van Schagen <richard@routerhints.com>,
        Richard van Schagen <vschagen@cs.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Bartel Eerdekens <bartel.eerdekens@constell8.be>,
        erkin.bozoglu@xeront.com, mithat.guner@xeront.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230522121532.86610-1-arinc.unal@arinc9.com>
 <20230522121532.86610-25-arinc.unal@arinc9.com>
 <20230526154258.skbkk4p34ro5uivr@skbuf>
 <ZHDVUC1AqncfF2mK@shell.armlinux.org.uk>
 <e4aff9aa-d0c6-1f2e-7f16-35df59d51b90@arinc9.com>
 <20230604131735.f2clcinq67wspuun@skbuf>
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20230604131735.f2clcinq67wspuun@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4.06.2023 16:17, Vladimir Oltean wrote:
> On Sun, Jun 04, 2023 at 11:06:32AM +0300, Arınç ÜNAL wrote:
>>> Even better are:
>>> #define  MT7531_MIRROR_PORT_GET(x)	FIELD_GET(MT7531_MIRROR_MASK, x)
>>>
>>>>> +#define  MT7531_MIRROR_PORT_SET(x)	(((x) & 0x7) << 16)
>>>>
>>>> and here: (((x) << 16) & GENMASK(18, 16))
>>>
>>> #define  MT7531_MIRROR_PORT_SET(x)	FIELD_PREP(MT7531_MIRROR_MASK, x)
>>>
>>> No need to add parens around "x" in either of these uses as we're not
>>> doing anything with x other than passing it into another macro.
>>
>> Thanks. I suppose the GENMASK, FIELD_PREP, and FIELD_GET macros can be
>> widely used on mt7530.h? Like GENMASK(2, 0) on MT7530_MIRROR_MASK and
>> FIELD_PREP(MT7530_MIRROR_MASK, x) on MT7530_MIRROR_PORT(x)?
> 
> I suppose the answer would be "yes, they can be used", but then, I'm not
> really sure what answer you're expecting.

I was thinking of replacing all manual definitions with these macros on 
mt7530.h. For now, I'll just make sure my current changes use them.

Arınç
