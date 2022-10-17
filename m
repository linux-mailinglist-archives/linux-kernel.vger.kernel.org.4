Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2DDD600F48
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 14:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbiJQMfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 08:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbiJQMfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 08:35:04 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12122316F;
        Mon, 17 Oct 2022 05:34:49 -0700 (PDT)
Received: from p508fc122.dip0.t-ipconnect.de ([80.143.193.34] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1okPKN-00087p-6N; Mon, 17 Oct 2022 14:34:43 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Rob Herring <robh+dt@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC support" 
        <linux-rockchip@lists.infradead.org>,
        "moderated list:ARM/Rockchip SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Aurelien Jarno <aurelien@aurel32.net>
Cc:     Heiko Stuebner <heiko@sntech.de>, Dongjin Kim <tobetter@gmail.com>
Subject: Re: [PATCH v3 00/13] Add support for the Hardkernel ODROID-M1 board
Date:   Mon, 17 Oct 2022 14:34:34 +0200
Message-Id: <166601006781.173248.3484905411255334567.b4-ty@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220930051246.391614-1-aurelien@aurel32.net>
References: <20220930051246.391614-1-aurelien@aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Sep 2022 07:12:33 +0200, Aurelien Jarno wrote:
> On the ODROID forum, Dongjin Kim said he is not planning to submit a new
> version of the patchset adding support for the Hardkernel ODROID-M1
> board. I therefore decided to address the issues reported during the
> initial review, and I also did some small fixes either because some
> things changed in the meantime on the kernel side or because I noticed
> some warning or issues when using the hardware.
> 
> [...]

Applied, thanks!

[01/13] dt-bindings: rockchip: Add Hardkernel ODROID-M1 board
        commit: 19cc53eb2ce63c0e5adc2fd89494fb16f383ac10
[02/13] arm64: dts: rockchip: Add Hardkernel ODROID-M1 board
        commit: fd35832677032980df230f02509d6c016664cc89
[03/13] arm64: dts: rockchip: add thermal support to ODROID-M1
        commit: f5511bd8498da222b6455038a0cf3e7d2b2dfc7e
[04/13] arm64: dts: rockchip: Add NOR flash to ODROID-M1
        commit: 9f96204b7dcf94d03cad41194447c665d10675b7
[05/13] arm64: dts: rockchip: Add analog audio on ODROID-M1
        commit: 78f858447cb78cac7259093d095fb783328b835c
[06/13] arm64: dts: rockchip: Enable vop2 and hdmi tx on ODROID-M1
        commit: 913404aa2e60610f9cae375069dae97e11d726ed
[07/13] arm64: dts: rockchip: Enable HDMI audio on ODROID-M1.
        commit: 1ca7ddddf36494f0f6afd4f35d37827323271f39
[08/13] arm64: dts: rockchip: Enable the GPU on ODROID-M1
        commit: cb80b3455c7cadc4c1157879930e919f607d557c
[09/13] arm64: dts: rockchip: Enable the USB 2.0 ports on ODROID-M1
        commit: 4685d7b68aaac199ab0d950d2047405bf551f964
[10/13] arm64: dts: rockchip: Enable the USB 3.0 ports on ODROID-M1
        commit: 9984ef562653c8d0beb51021fc286706b6ec4802
[11/13] arm64: dts: rockchip: Add SATA support to ODROID-M1
        commit: 6a5a04d52ccc42e0e59ff69fca9c1db7e08ba44b
[12/13] arm64: dts: rockchip: Add PCIEe v3 nodes to ODROID-M1
        commit: 35b28582aa3dfd7b6861b7ebc72798b0ff50ed41
[13/13] arm64: dts: rockchip: Add IR receiver node to ODROID-M1
        commit: d6882992fe8182e3122be34af3f491948a8b9069

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
