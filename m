Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 778477174E8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 06:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232880AbjEaEMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 00:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbjEaEML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 00:12:11 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 699B6D9;
        Tue, 30 May 2023 21:12:08 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 7405880FC;
        Wed, 31 May 2023 04:12:07 +0000 (UTC)
Date:   Wed, 31 May 2023 07:12:06 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        luca.ceresoli@bootlin.com, nm@ti.com, kristo@kernel.org,
        ssantosh@kernel.org, michal.simek@xilinx.com, aford173@gmail.com,
        mike.looijmans@topic.nl, robert.hancock@calian.com,
        shawn.guo@linaro.org, fabio.estevam@freescale.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH 7/8] clk: ti: clkctrl: check return value of kasprintf()
Message-ID: <20230531041206.GF14287@atomide.com>
References: <20230530093913.1656095-1-claudiu.beznea@microchip.com>
 <20230530093913.1656095-8-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530093913.1656095-8-claudiu.beznea@microchip.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Claudiu Beznea <claudiu.beznea@microchip.com> [230530 09:41]:
> kasprintf() returns a pointer to dynamically allocated memory.
> Pointer could be NULL in case allocation fails. Check pointer validity.
> Identified with coccinelle (kmerr.cocci script).

Reviewed-by: Tony Lindgren <tony@atomide.com>
