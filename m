Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B245B6CD041
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 04:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjC2ClG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 22:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjC2ClA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 22:41:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F9573C3A;
        Tue, 28 Mar 2023 19:40:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 718E3B81FAD;
        Wed, 29 Mar 2023 02:40:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B4C9C433D2;
        Wed, 29 Mar 2023 02:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680057634;
        bh=Ch0NsSuJTofP/QNhdjknf2Lga+tdY9yLg7bYCRUolUE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=foswPpRoMJliPAdXiG5AOjAf21bbb/bwHCGPfawiYvgAdA+/Vdyi4I6otG9XbPSy1
         w/mRN0ovJGT1YaJL1KuO7TQ8ME86rlzo08NvZSZ1I8oiApu5i527hmtgdfIF18olve
         ReSoUitWHGprNTlCNRzMwhYNlXN0a68Wt/wKRLbSNNS2vTIG7fYXWEuOU4KVp2WR4w
         Lyvrsy0M0Vmh3Gif+a/SF4E0WJ0UK0se9zE4I3sKQ0GjvdzP6au4T0fssRJJEmqYvZ
         6+xLXMxjjBAY9TP+jAXT3sNH5LIC191RLg8AtIc+jNf11gyoaSdwIj7f5h5CMDy6kk
         Fr98/Yzn/WRZw==
Message-ID: <22c217f49b5894f2b560500360036689.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230312161512.2715500-28-u.kleine-koenig@pengutronix.de>
References: <20230312161512.2715500-1-u.kleine-koenig@pengutronix.de> <20230312161512.2715500-28-u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 27/30] clk: ti: Convert to platform remove callback returning void
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-omap@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Michael Turquette <mturquette@baylibre.com>,
        Tero Kristo <kristo@kernel.org>,
        Uwe =?utf-8?q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Date:   Tue, 28 Mar 2023 19:40:32 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Uwe Kleine-K=C3=B6nig (2023-03-12 09:15:09)
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is (mostly) ignored
> and this typically results in resource leaks. To improve here there is a
> quest to make the remove callback return void. In the first step of this
> quest all drivers are converted to .remove_new() which already returns
> void.
>=20
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---

Applied to clk-next
