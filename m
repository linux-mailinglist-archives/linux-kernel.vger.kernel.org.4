Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4AA7374B6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 20:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjFTSzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 14:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbjFTSzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 14:55:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665A41FC8;
        Tue, 20 Jun 2023 11:55:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF5A661440;
        Tue, 20 Jun 2023 18:55:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12034C433C9;
        Tue, 20 Jun 2023 18:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687287328;
        bh=QlAJCzL8BTX4LVXa3CW+wyvWD3oVtqaBOjKNeo4V16U=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=RPnuGFMsLHFKTQ2T8otYCZkaiPaJGNXKB0Ij3S/nYYp88feMeE3I+iHttKcwp4lUY
         4LbmOuCtyfad44+gU/FTZLOF/Ypmjp3BzPg4yMYUpaeobs1jXk3wwkEys0w2S1IxUN
         7YTZuC8yYeiQ7uFeZO6EaDMHqXLZSRK6trjsyQEcqTeACvo8FdOX5bWdRRpdZVkIsw
         pyWSa9L8rpt8qBLiZFTRRZAJO0ZdAO0fg2ZJ0HIpTAYeM/BxhDQjslYiGNwS3RI0XX
         zBcM17LHdBwrc9PSBZ1s9PH4VM2LFVFj+d/GXqF6QjCwFmaY1xbZyYqXu9rYVC9B5R
         XHzqZQc+6avlg==
Message-ID: <27b86576fa46cb17a904e6ccc66117be.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230530093913.1656095-7-claudiu.beznea@microchip.com>
References: <20230530093913.1656095-1-claudiu.beznea@microchip.com> <20230530093913.1656095-7-claudiu.beznea@microchip.com>
Subject: Re: [PATCH 6/8] clk: keystone: sci-clk: check return value of kasprintf()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     aford173@gmail.com, mike.looijmans@topic.nl,
        robert.hancock@calian.com, shawn.guo@linaro.org,
        fabio.estevam@freescale.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>, kristo@kernel.org,
        luca.ceresoli@bootlin.com, michal.simek@xilinx.com,
        mturquette@baylibre.com, nm@ti.com, ssantosh@kernel.org
Date:   Tue, 20 Jun 2023 11:55:24 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Claudiu Beznea (2023-05-30 02:39:11)
> kasprintf() returns a pointer to dynamically allocated memory.
> Pointer could be NULL in case allocation fails. Check pointer validity.
> Identified with coccinelle (kmerr.cocci script).
>=20
> Fixes: b745c0794e2f ("clk: keystone: Add sci-clk driver support")
> Depends-on: 96488c09b0f4 ("clk: keystone: sci-clk: cut down the clock nam=
e length")
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---

Applied to clk-next
