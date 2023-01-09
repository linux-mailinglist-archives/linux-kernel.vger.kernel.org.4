Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE7056626CF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 14:21:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237189AbjAINVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 08:21:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237116AbjAINUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 08:20:45 -0500
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0039A16591;
        Mon,  9 Jan 2023 05:20:39 -0800 (PST)
Received: from toolbox.toradex.int ([31.10.206.125]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0LtYx8-1onbp218ia-010tp1;
 Mon, 09 Jan 2023 14:20:12 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH v1 0/4] ARM/arm64: apalis/colibri-imx6/6ull/7/verdin-imx8mp: gpio-key node names
Date:   Mon,  9 Jan 2023 14:19:57 +0100
Message-Id: <20230109132001.43489-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:PVyVkjLdTrkbSIhoV53oQGbArBkzTlCDFhx2CbUkS3pfSpuYz2t
 paIunayLzgu5MDPBfLhnpHoF3524f8wLchbVO7bOp6PvSAw4vCybCJbs5Pb6SfpdxtNQwqT
 EVOilW0/B9lxK5HTyLNb2uF+sZGbDzgHy8+J236TVkqVeCH/eZKh7PmcRVWZ3CcLq0RVKqD
 Q8+QoeM6P3H9k59dSwhHA==
UI-OutboundReport: notjunk:1;M01:P0:q3DxjFqXfOg=;aXNDefys6sCzBQw7pNfqALyT2Rf
 1Bhoyi2Z1RSz6KnhRffiGlDez90tlAQXS0qjYbGPGXpCqCWl102grjVNWEv6ED5pHULuLvCwA
 rdFJxlWrcvSZmyvQTo7Z3qCwBuQA6w7rBO5st2bY3rF4Ebqrocft8vMVlUvXif6Kgf9VUYVU4
 B+19LiqhjwhJKUGo8YHM+UTCPy678db04H7o9anSs2zu6KDM5jwoPivT5T0jyLSVCLhPNaygv
 2m+uEOWrIYA7f4N0cp4/GMBXxQOiNlliBYUurm0hwF2QmSqm4+y0Nh+wgk+WpaD80idsBTBaF
 w1epN/8y1m49+1QcFV3+Bgl4QdnmhQ/q4+TCLBe5k6AtHe9rHn1n0LZckxyUb0tpdJtktowpI
 e/Uf9o1cSaV/+10mVyLSzbdQpEPcrZixmUgyEYDr6C8AeamgJolb0P2zafogKFs+FPZVNbZmS
 qSH1xwvxgX7GAvVpzu4hyQKnvHyu4JPPK+v9sTWjVmS7k9+L9FCNDeUburDN1NKQgiXifwerp
 Z25gH38tSsBcGk1HfNDSYBZhe722Ga7GgHbtj5pWV8EQM+We9g+aRn8wQ5MkSQyTXSOgYKVkp
 umRl9Jku2z1FdnuZctaNqqwRCUv7rhsYlv2YfHAM/WNiMqWaofD6NYw7PCqqs9slINpYlAvvr
 6rzT6sbkHwhVsDYcSZanrtIqlAdtmkA2IzzUdlZDGg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>


This series unifies/fixes wakeup gpio-key node names across all Toradex
modules. And yes, the Tegra-based Apalis/Colibri T20/T30/TK1 already
look good (;-p).


Marcel Ziswiler (4):
  ARM: dts: colibri-imx6: improve wake-up with gpio key
  ARM: dts: colibri-imx6ull: improve wake-up with gpio key
  ARM: dts: apalis/colibri-imx6/6ull/7: proper gpio-key node names
  arm64: dts: verdin-imx8mp: unify gpio-key node name

 arch/arm/boot/dts/imx6qdl-apalis.dtsi            | 2 +-
 arch/arm/boot/dts/imx6qdl-colibri.dtsi           | 4 ++--
 arch/arm/boot/dts/imx6ull-colibri.dtsi           | 4 ++--
 arch/arm/boot/dts/imx7-colibri.dtsi              | 2 +-
 arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi | 2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)

-- 
2.35.1

