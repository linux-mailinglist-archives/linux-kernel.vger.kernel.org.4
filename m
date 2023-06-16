Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A75A7339C8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 21:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346105AbjFPTYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 15:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346251AbjFPTY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 15:24:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E213C38;
        Fri, 16 Jun 2023 12:22:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED47060E9F;
        Fri, 16 Jun 2023 19:21:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54189C433C9;
        Fri, 16 Jun 2023 19:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686943287;
        bh=KNB1fklmcJeWJr9EZzOH1XKReRXdb2jMbZAPeqc4wB4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=uNVW9km0F4Grt39DBa/dNvvZ5gzp45V1z5yl/Q2Gs3UYsMvNMEod0j0IYmu4h5Ox5
         IV0KwFZoJgLZtTYRf+uMZje/AgzkAwUAVyjUZPGUQmrzZ7ZIIBLO0qC5JJDTH4ffgU
         uSLXJyNMbpg63t9dSxKpo3u1d5r/WaAqWZ0M2U1LNJUorpTaRRFA3Il6JVNr+HZO2U
         BUePMoamTlgydhy/hZLYCbw3ojCuIj7lQgsgWC/NW0yRli1aDWt5o3Qz0EB26PwoWt
         vgHwFyy+v3jXM2SnGHIvLSENe6sohX2LE9mee3W2+dpix3xlt0jxw/the9/yaYMjBs
         9ebausqYwtHFQ==
Message-ID: <dbb4086988fa53686712e0cb06cce75b.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230615122051.546985-3-angelogioacchino.delregno@collabora.com>
References: <20230615122051.546985-1-angelogioacchino.delregno@collabora.com> <20230615122051.546985-3-angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH 2/3] clk: mediatek: clk-mt8173-apmixedsys: Fix return value for of_iomap() error
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     mturquette@baylibre.com, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, wenst@chromium.org,
        u.kleine-koenig@pengutronix.de, msp@baylibre.com,
        miles.chen@mediatek.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Date:   Fri, 16 Jun 2023 12:21:25 -0700
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

Quoting AngeloGioacchino Del Regno (2023-06-15 05:20:50)
> The of_iomap() function returns NULL in case of error so usage of
> PTR_ERR() is wrong!
> Change that to return -ENOMEM in case of failure.
>=20
> Fixes: 41138fbf876c ("clk: mediatek: mt8173: Migrate to platform driver a=
nd common probe")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---

Applied to clk-next
