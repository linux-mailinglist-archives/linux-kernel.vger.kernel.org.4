Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E288E72D6BB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 03:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjFMBL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 21:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjFMBL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 21:11:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1676101;
        Mon, 12 Jun 2023 18:11:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B1DF63023;
        Tue, 13 Jun 2023 01:11:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73DA8C433D2;
        Tue, 13 Jun 2023 01:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686618685;
        bh=4yOOHM3f8bzdNEO4wvtuMeRBE54XcGi5DSa0P/ae2Dk=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=XfdI2WfMpl9y0zq5/f7mB5PsfB1idvHuiA6n0L28AjTFe7j/z+DSqQY9fQHJTarVe
         eaGthBayXQ4pqYW341EFl0WUTIjRV3k7D7GEB5Igtx51HyqgHgjtJrQoCUKZW2+Afm
         B4kbe2jCsb7upOUW0FwS72w+Pdr2K459v2SEQC4gMK/IP1aTjTaLkyNPWow1S+4l4g
         Rz70I80pUkJmfY6itZzBtGvn41MI3GSn8nCZdZ4n7K2pMLF5bIy/zCA9vp1P9fvBUf
         Ql7ke7SbG+mt17O7J944N9kiywrFu9ARnPS6r0oa/n/wRNE8/M4I7i+dxC+qmbzyof
         bY+wsaEO6dVvg==
Message-ID: <ca6a5f0cd1f64368045df05ba048e31d.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <7ha5x8xzrp.fsf@baylibre.com>
References: <20230511133226.913600-1-msp@baylibre.com> <20230523114618.laajn2et5nbcxszv@blmsp> <7hsfbjxcqs.fsf@baylibre.com> <7ha5x8xzrp.fsf@baylibre.com>
Subject: Re: [PATCH] clk: mediatek: mt8365: Fix inverted topclk operations
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Alexandre Mergnat <amergnat@baylibre.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Kevin Hilman <khilman@kernel.org>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>
Date:   Mon, 12 Jun 2023 18:11:23 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kevin Hilman (2023-06-09 11:21:30)
> Kevin Hilman <khilman@kernel.org> writes:
>=20
> > Markus Schneider-Pargmann <msp@baylibre.com> writes:
> >
> >> just wanted to ask if I need to do something specific for it to go into
> >> a rc? Sorry if I missed doing something for that, I haven't had to fix
> >> something in an rc that often before.
> >
> > I think the  Fixes tag is enough to indicate that.
> >
> > Steven, is there still time for this fix be queued up for v6.4-rc?
>=20
> Steven: gentle reminder ping.

Who's Steven :)
