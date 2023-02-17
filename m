Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 763EB69A9A9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 12:05:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbjBQLFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 06:05:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjBQLFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 06:05:40 -0500
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AF8F42C660;
        Fri, 17 Feb 2023 03:05:10 -0800 (PST)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1pSyXr-0008WE-01; Fri, 17 Feb 2023 12:04:51 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 07845C28A0; Fri, 17 Feb 2023 12:03:07 +0100 (CET)
Date:   Fri, 17 Feb 2023 12:03:06 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     arinc9.unal@gmail.com
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, erkin.bozoglu@xeront.com
Subject: Re: [PATCH 2/2] mips: dts: ralink: mt7621: add port@5 as CPU port
Message-ID: <20230217110306.GB7138@alpha.franken.de>
References: <20230211104915.116253-1-arinc.unal@arinc9.com>
 <20230211104915.116253-2-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230211104915.116253-2-arinc.unal@arinc9.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 11, 2023 at 01:49:15PM +0300, arinc9.unal@gmail.com wrote:
> From: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> On MT7621AT, MT7621DAT, and MT7621ST SoCs, port 5 of the MT7530 switch is
> connected to the second MAC of the SoC as a CPU port. Add the port and set
> up the second MAC on the bindings. Revert PHY muxing on GB-PC1.
> 
> There's an external PHY connected to the second MAC of the SoC on GB-PC2,
> therefore, disable port@5 for this device.
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---
>  .../boot/dts/ralink/mt7621-gnubee-gb-pc1.dts  | 16 +++++-----------
>  .../boot/dts/ralink/mt7621-gnubee-gb-pc2.dts  |  9 ++++++++-
>  arch/mips/boot/dts/ralink/mt7621.dtsi         | 19 ++++++++++++++++++-
>  3 files changed, 31 insertions(+), 13 deletions(-)

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
