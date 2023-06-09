Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 302BB7294D6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 11:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241501AbjFIJXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 05:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239432AbjFIJXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 05:23:05 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7D5EE4685;
        Fri,  9 Jun 2023 02:17:24 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1q7XQE-0004Jv-0B; Fri, 09 Jun 2023 10:24:38 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id AE685C02EE; Fri,  9 Jun 2023 10:24:10 +0200 (CEST)
Date:   Fri, 9 Jun 2023 10:24:10 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Liviu Dudau <liviu@dudau.co.uk>
Cc:     =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        Paul Burton <paulburton@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 0/2] mips: dts: ralink: Add support for TP-Link HC220
 G5 v1 board
Message-ID: <20230609082410.GL8160@alpha.franken.de>
References: <20230606211600.1601694-1-liviu@dudau.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606211600.1601694-1-liviu@dudau.co.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 10:15:58PM +0100, Liviu Dudau wrote:
> Add device tree and bindings for the TP-Link HC220 G5 v1 wireless AP,
> a consumer product from TP-Link based on MT7621.
> 
> Changes since v3:
>  - Turns out that adding sub-nodes to the pcie invites more warnings from
>    dtbs_check so we're dropping those
>  - Running dtbs_check made me realise that I need to re-order the patches
>    so that the bindings are introduced first. Hence the major change in v4
>    is the re-ordering of patches
>  - Renamed the LEDs nodes to match the schema.
> 
> Changes since v2:
>  - Remove WIP nodes for NAND flash that accidentally got included in v2
>  - Fix commit message with the actual 5GHz WiFi chip name
>  - Remove gmac and mdio nodes from device tree as defaults are sufficient
>  - Added sub-nodes under pcie for each of the WiFi chip with appropriate
>    compatible string.
>  - Collect Acks received for the device tree bindings patch
> 
> Changes since v1:
>  - Changed compatible for the board to "tplink,hc220-g5-v1"
>  - Updated the DSA switch nodes to better reflect actual usage.
>  - Disabled the fixed-link in gmac1
>  - Added device tree bindings in Documentation/
> 
> v3: https://lore.kernel.org/linux-mips/20230605150114.601102-1-liviu@dudau.co.uk/
> v2: https://lore.kernel.org/linux-mips/20230529150833.526084-1-liviu@dudau.co.uk/
> v1: https://lore.kernel.org/linux-mips/20230509200125.309026-1-liviu@dudau.co.uk/
> 
> Liviu Dudau (2):
>   dt-bindings: mips: Add bindings for TP-Link HC220 G5 v1 board
>   mips: dts: ralink: Add support for TP-Link HC220 G5 v1 board
> 
>  .../devicetree/bindings/mips/ralink.yaml      |  1 +
>  arch/mips/boot/dts/ralink/Makefile            |  3 +-
>  .../dts/ralink/mt7621-tplink-hc220-g5-v1.dts  | 84 +++++++++++++++++++
>  3 files changed, 87 insertions(+), 1 deletion(-)
>  create mode 100644 arch/mips/boot/dts/ralink/mt7621-tplink-hc220-g5-v1.dts
> 
> -- 
> 2.40.1

series applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
