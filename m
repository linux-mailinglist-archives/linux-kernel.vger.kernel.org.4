Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 180CA737497
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 20:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjFTSyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 14:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjFTSx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 14:53:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C532C2;
        Tue, 20 Jun 2023 11:53:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0BA2C6141D;
        Tue, 20 Jun 2023 18:53:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FCBFC433C8;
        Tue, 20 Jun 2023 18:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687287237;
        bh=YGBzCoLYLJcR3RjLUJw0fAYEk/ZC/rwN9dRo76RYMao=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=NyEON1aFPXuTqKb+PU1rUbfAtO2BmQp1JjT3NG4eTSRLfmPD/gxv+TofaW1mj4zQM
         c+WkBpcR9lMHf07eXf0T3m/cCyd4RGk98+nPDlvO9SfKw4Ll6SI+ooBkeIXY5r6KuH
         elsVcc/1D3Iajs7QlsH9dyD1EXIhHrku1wJgpVUICKxAJzdnVU/uozI/oGBcqsV6AK
         zzm5c7bhtPKs217FLczKUQVrlFOcTZgQMLe+Yi3E3C/lNqBR46+ZYrOAQezwA4mwV+
         OGsN0hm7HZu1OvNgmNzbrlcBLTLH7GiyMFuGVjxPcWBEVYwHrFNgy4+YNL8Tt95ooC
         wFRhcen01sOBA==
Message-ID: <4287595f7f2b588fb341ff8a710b6857.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230530093913.1656095-2-claudiu.beznea@microchip.com>
References: <20230530093913.1656095-1-claudiu.beznea@microchip.com> <20230530093913.1656095-2-claudiu.beznea@microchip.com>
Subject: Re: [PATCH 1/8] clk: vc5: check memory returned by kasprintf()
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
Date:   Tue, 20 Jun 2023 11:53:53 -0700
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

Quoting Claudiu Beznea (2023-05-30 02:39:06)
> kasprintf() returns a pointer to dynamically allocated memory.
> Pointer could be NULL in case allocation fails. Check pointer validity.
> Identified with coccinelle (kmerr.cocci script).
>=20
> Fixes: f491276a5168 ("clk: vc5: Allow Versaclock driver to support multip=
le instances")
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---

Applied to clk-next
