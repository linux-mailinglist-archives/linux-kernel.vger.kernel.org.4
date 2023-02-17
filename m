Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 176FA69A9AD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 12:05:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbjBQLFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 06:05:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjBQLFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 06:05:40 -0500
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C5398642FB;
        Fri, 17 Feb 2023 03:05:10 -0800 (PST)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1pSyXr-0008WE-00; Fri, 17 Feb 2023 12:04:51 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 0C3AAC2860; Fri, 17 Feb 2023 12:02:48 +0100 (CET)
Date:   Fri, 17 Feb 2023 12:02:47 +0100
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
Subject: Re: [PATCH 1/2] mips: dts: align LED node names with dtschema
Message-ID: <20230217110247.GA7138@alpha.franken.de>
References: <20230211104915.116253-1-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230211104915.116253-1-arinc.unal@arinc9.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 11, 2023 at 01:49:14PM +0300, arinc9.unal@gmail.com wrote:
> From: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> The node names should be generic and DT schema expects certain pattern:
> 
>   mt7621-gnubee-gb-pc1.dtb: gpio-leds: 'power', 'system' do not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---
>  .../dts/cavium-octeon/dlink_dsr-1000n.dts     | 10 ++++-----
>  .../boot/dts/cavium-octeon/dlink_dsr-500n.dts |  6 ++---
>  arch/mips/boot/dts/ingenic/ci20.dts           |  8 +++----
>  arch/mips/boot/dts/pic32/pic32mzda_sk.dts     |  6 ++---
>  .../boot/dts/qca/ar9132_tl_wr1043nd_v1.dts    |  8 +++----
>  .../mips/boot/dts/qca/ar9331_dragino_ms14.dts |  8 +++----
>  arch/mips/boot/dts/qca/ar9331_omega.dts       |  2 +-
>  arch/mips/boot/dts/qca/ar9331_tl_mr3020.dts   |  8 +++----
>  .../ralink/gardena_smart_gateway_mt7688.dts   | 22 +++++++++----------
>  .../boot/dts/ralink/mt7621-gnubee-gb-pc1.dts  |  4 ++--
>  .../boot/dts/ralink/mt7621-gnubee-gb-pc2.dts  | 12 +++++-----
>  11 files changed, 47 insertions(+), 47 deletions(-)

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
