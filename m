Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C68FD7339CA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 21:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345871AbjFPT0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 15:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346295AbjFPTY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 15:24:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233A6449D;
        Fri, 16 Jun 2023 12:23:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA7D661EFA;
        Fri, 16 Jun 2023 19:21:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CC29C433CA;
        Fri, 16 Jun 2023 19:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686943301;
        bh=L4njF+AvSfGwSpC5S8bdEJXRtDhN9ofxkN4Ykn9oo1Q=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=N3z0gpe9AP8MGv+Wq25q5CH0qG+PR2ZNZCAUqZ+I2Q+Q+XqKyNnIL+R4E0EiApVeT
         amBJxxB0JBgi6xUqb8ZeNle+BAu4/8TegliuntSSHjLE3VSAbiLmODnx+W3v5Ck+7i
         r229GOM8FQ/YZHJBqGH3idkZoAvER629V0FpGTFg0a957q7GIEpMletFYkApvwisF7
         oiY7LDHeS8EeFDIf4nMItdj0sE72N3hsKJWb60I6NnoZlPX39mJmpRukgHW+Wks1TF
         K6ju6Exmdz3FQCYxosfZg9JW9KgOdQYA9utQlZN9tWy7hwD16ZOHs6LYoYVJY4mHhK
         ETet3taf21zaQ==
Message-ID: <2f59dfceaac859591b4b97b6fe928b62.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230615122051.546985-4-angelogioacchino.delregno@collabora.com>
References: <20230615122051.546985-1-angelogioacchino.delregno@collabora.com> <20230615122051.546985-4-angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH 3/3] clk: mediatek: clk-mt8173-apmixedsys: Fix iomap not released issue
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     mturquette@baylibre.com, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, wenst@chromium.org,
        u.kleine-koenig@pengutronix.de, msp@baylibre.com,
        miles.chen@mediatek.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Date:   Fri, 16 Jun 2023 12:21:39 -0700
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

Quoting AngeloGioacchino Del Regno (2023-06-15 05:20:51)
> In case of error after of_ioremap() the resource must be released:
> call iounmap() where appropriate to fix that.
>=20
> Fixes: 41138fbf876c ("clk: mediatek: mt8173: Migrate to platform driver a=
nd common probe")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---

Applied to clk-next
