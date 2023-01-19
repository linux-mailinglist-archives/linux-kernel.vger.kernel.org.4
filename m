Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0E60673404
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 09:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjASIyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 03:54:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbjASIyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 03:54:51 -0500
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CDA54FC1D;
        Thu, 19 Jan 2023 00:54:49 -0800 (PST)
Received: from toolbox.toradex.int ([31.10.206.125]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1M4JBN-1pI9Zd4Bzl-000KPT;
 Thu, 19 Jan 2023 09:54:29 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v1 0/2] ARM: arm64: dts/clk: imx: indentation permission whitespace cleanup 2
Date:   Thu, 19 Jan 2023 09:54:19 +0100
Message-Id: <20230119085421.102804-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:vWuOTF3Cmn5I3Dc5W+An3aVQczJy3zXtoUMHW0dXoUy0viH+2s8
 Hw4Bx2mnzqppb6yab8MudfWEpnqe0VOV6+IwkZ9JFF/zp9fsiOAQY4Y/HYp8Z1Z0XShDWk4
 s2Pefynwh/fmGapn7TeWfdG7MLL1h8B7pbv797W5cU3wBIdiB5pTl3cgGOVv/v+mp5pvaEp
 p1bMJVkGvZ5lGSCxYGo4A==
UI-OutboundReport: notjunk:1;M01:P0:sBVtXiRoxKg=;uIfADV5P33XUYPIQp+jbLE7riVy
 K1c4vBko72e+sx6KPbALp9JNOvW39GgDp9/WsxnAFsPRxing8hOC7GVSl2ijcniwkprjAEXWO
 brP6BB5oTmI5UvbAjlaDCsJTsMwmBSkdPAktxsIUkPeY4gVvrjc6DL9pzH3wM5iyz1uYLXKUl
 R34dJjRC3NiKz8wMxNbBeywH/0I917K96b6EwGsEbETeYZqJVvjkNAXeBKUhMQxXOt9zveZRm
 UTxffksTRsGzdIrDpy7soJbfSKt604Ezjq95xRiD4ahfKUzcT38woPBPfitC3hvTbdKomihif
 ewDeZKHHgWFaJUrsodFSyXllMZvjcWvli20z/h9FoIfceG0z73/d2cgIoXFnx1+bP8/5Osh/l
 ySoFmsCE6+tMr+rhJplKw59jOFukdokBEKQLcxfItYXufhcZMM1ylkIYGkJi9q+El0mTzjXrR
 hRiwREz4TbzFD3Q7xavRP2EWsbf0J2k0vZ3Mzi4rfd3K34y0/BG/X6fEHVs0/sytoQ9krBiKz
 HBFb/+YMBscNaeiZ8JQ/jpTHccPRa9trTje2uETAru+EPDV0E1IyghPEazUnTxA8EMQNO+YEl
 Bi4NaKRkA59N9Ytw/tKb0YxJV2gqV0WENsDDtQnnM4c+YwKIAxwO+E6R9o+6F5NH5jxpONYP1
 /rRsaL64xrRC39AcGc/VMCTJwWtvXo/Z7sGtsaqFVg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>


While further synchronising them imx device trees with U-Boot I stumbled
over more checkpatch warnings. This series addresses those trivial
indentation, file permission and/or whitespace cleanups.


Marcel Ziswiler (2):
  clk: imx6sll: add proper spdx license identifier
  dt-bindings: imx8ulp: clock: no spaces before tabs

 include/dt-bindings/clock/imx6sll-clock.h | 2 +-
 include/dt-bindings/clock/imx8ulp-clock.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.36.1

