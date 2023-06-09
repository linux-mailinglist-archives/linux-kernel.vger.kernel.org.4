Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF307294BD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 11:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239332AbjFIJVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 05:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240847AbjFIJUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 05:20:42 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B9B5C5B88;
        Fri,  9 Jun 2023 02:15:26 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1q7XQE-0004Jv-0A; Fri, 09 Jun 2023 10:24:38 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id AC28EC02EE; Fri,  9 Jun 2023 10:23:48 +0200 (CEST)
Date:   Fri, 9 Jun 2023 10:23:48 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "H . Nikolaus Schaller" <hns@goldelico.com>,
        linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, list@opendingux.net
Subject: Re: [PATCH 0/9] MIPS: CI20: Add WiFi / Bluetooth support
Message-ID: <20230609082348.GK8160@alpha.franken.de>
References: <20230604145642.200577-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230604145642.200577-1-paul@crapouillou.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 04, 2023 at 04:56:33PM +0200, Paul Cercueil wrote:
> Hi,
> 
> Here's a set of patches to add support for the WiFi / Bluetooth chip on
> the CI20.
> 
> WiFi works pretty well, provided it is used with the latest firmware
> provided by linux-firmware. Bluetooth does not work very well here, as
> I cannot get my wireless keyboard to pair; but it does detect it, and it
> does see they key presses when I type the pairing code.
> 
> I only tested with a somewhat recent (~2022) Buildroot-based userspace.
> I enabled WEXT compatibility because the CI20 is typically used with a
> very old userspace, but I did not try to use it with old tools like
> ifconfig/iwconfig.
> 
> Cheers,
> -Paul
> 
> Paul Cercueil (9):
>   MIPS: DTS: CI20: Fix regulators
>   MIPS: DTS: CI20: Fix ACT8600 regulator node names
>   MIPS: DTS: CI20: Add parent supplies to ACT8600 regulators
>   MIPS: DTS: CI20: Do not force-enable CIM and WiFi regulators
>   MIPS: DTS: CI20: Misc. cleanups
>   MIPS: DTS: CI20: Parent MSCMUX clock to MPLL
>   MIPS: DTS: CI20: Enable support for WiFi / Bluetooth
>   MIPS: configs: CI20: Regenerate defconfig
>   MIPS: configs: CI20: Enable WiFi / Bluetooth
> 
>  arch/mips/boot/dts/ingenic/ci20.dts | 148 +++++++++++++++++++---------
>  arch/mips/configs/ci20_defconfig    |  47 ++++++---
>  2 files changed, 133 insertions(+), 62 deletions(-)
> 
> -- 
> 2.39.2

series applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
