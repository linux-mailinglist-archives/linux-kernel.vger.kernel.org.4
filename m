Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5B3A62FF29
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 22:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbiKRVIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 16:08:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiKRVIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 16:08:39 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8741F12636;
        Fri, 18 Nov 2022 13:08:36 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2AIL8Pjs098709;
        Fri, 18 Nov 2022 15:08:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1668805705;
        bh=Yr4LSYGMtRX7f6gDoB3pzPK7VDSrGB+Mip9zdhZE6vY=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=pg20JjDTtULID4xVlEvXyUlUafjzZhVP48+U3vrSY7Kj8EzhZGkbUXODNcNIUpQnR
         pTFqmHHd4D5Rk45dCVDgqmf8jNus6PXqlQUgS9EQWdHA51ZcMjgWVArO4cJ9dxUzzL
         LEUg+foyGY8CZoHE4zSnYyQA8sG71fBn1PuI0H1k=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2AIL8PhZ102998
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 18 Nov 2022 15:08:25 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Fri, 18
 Nov 2022 15:08:25 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Fri, 18 Nov 2022 15:08:24 -0600
Received: from [10.250.38.44] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2AIL8Op3017735;
        Fri, 18 Nov 2022 15:08:24 -0600
Message-ID: <3d5e41f6-16a8-4298-ccd3-6db60f94eb47@ti.com>
Date:   Fri, 18 Nov 2022 15:08:23 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3 4/4] arm64: dts: ti: Add support for J784S4 EVM board
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>
CC:     Apurva Nandan <a-nandan@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, Hari Nagalla <hnagalla@ti.com>
References: <20221116130428.161329-1-a-nandan@ti.com>
 <20221116130428.161329-5-a-nandan@ti.com>
 <b57433e7-b309-bd1c-f794-3da74021f03c@ti.com>
 <20221118174754.y37pq77drvla2uxj@tinderbox>
 <8c123fa2-caab-d2dd-5eb4-688f1c6abb33@ti.com>
 <20221118180808.wnel7d6gswsnooww@junkman>
 <93242211-95e7-09a0-fced-5ef2deb9fc08@ti.com>
 <20221118192744.wish2vrxgy7dg7c2@unnerving>
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <20221118192744.wish2vrxgy7dg7c2@unnerving>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/18/22 1:27 PM, Nishanth Menon wrote:
> On 12:15-20221118, Andrew Davis wrote:
>> I don't see either of those addressed in that thread, only that
>> the aliases should go in the .dts files and be trimmed, nothing
> 
> Key is trimmed to what the system and ecosystem needs.
> 
>> stops us from:
>>
>> chosen {
>> 	stdout-path = "serial10:115200n8";
>> };
>>
>> aliases {
>> 	serial10 = &main_uart8;
>> };
> 
> Do we need 10 serial aliases? There are'nt 10 serial ports exposed in
> j782s2. ok - lets say we do this, then: [1] is needed to boot? but why
> do we need to do that for all armv8 platforms when aliases allows us

Why do we need SERIAL_8250_NR_UARTS at all, might be a better question.
These should be dynamically allocated if the number goes over the
default count imposed by the TTY framework. Maybe folks are still a
bit too afraid to touch the TTY subsystem core, I don't blame them..

> to trim it to just the 3 or 4 serial ports the platform really needs
> That + being able to use the convention that serial2 is always linux
> console, is'nt that a good thing? Hence recommending to just expose the
> serialports as aliases to exactly what we need while keeping serial2 as
> the linux console (which in this case happens to be main_uart8 - example
> as j721s2 does).
> 

"serial2 as the linux console" is *not* a convention, we just don't want to
fix up our bootloader/userspace to actually reason about what serial ports to
put logins on. Why not make ttyS10 the default, or ttyS666, it doesn't solve
your multi-distro issue either way since they usually only start a login on
ttyS0, console=, and/or the first virtual tty. Never on ttyS2. So you are
hacking up DT for a solution that doesn't do what you want in the end.

Andrew

> [1] https://lore.kernel.org/lkml/3ab9addf-7938-fcf3-6147-15a998e37d2d@ti.com/
> 
