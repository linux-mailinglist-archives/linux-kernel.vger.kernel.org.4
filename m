Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD449668872
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 01:32:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbjAMAcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 19:32:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjAMAcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 19:32:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 799CB60CC0;
        Thu, 12 Jan 2023 16:32:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E3CC621D8;
        Fri, 13 Jan 2023 00:32:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5939BC433D2;
        Fri, 13 Jan 2023 00:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673569957;
        bh=D+CLx71N7hh+aMCrNFwner/r2ssmRTSXXThuDIxd478=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=jY0ccoL8B48ZokoTeh5+PEtKN6kWxbJxS0xC7fk4NF+f0OyUPiKiZYDK/nOD14oid
         tLz7NLzF3Tx0Xwg9MEZaKi2SudIgyVHThZJfATddeqtW/zbtKYZKlEdKnn/oKOUiWO
         R/pgDXxWBTAeDYOJCK2j2rGbe+UOwXa26bbjOPXoTF2KxBtke+2UnxsnRHhmKn9O17
         uiBWTtjprisS5+XIq8dEjy4bdTZInkEdsQTnAWM9QBXTFwkd5z57v4Opxh/A9QzWx+
         y+TxrCELwlTHXPeWWjKpVnjYDdYmORSIanvLI1oB6z0tfPEy1vZIzjGuWMvCSydUIJ
         WnrJCnWZMKtkg==
Message-ID: <b19614d43df2dbd3614b9241d2c3cfc1.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20221225212632.2760126-1-martin.blumenstingl@googlemail.com>
References: <20221225212632.2760126-1-martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH v1 0/4] clk: meson: switch from .round_rate to .determine_rate
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        jbrunet@baylibre.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org
Date:   Thu, 12 Jan 2023 16:32:35 -0800
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Martin Blumenstingl (2022-12-25 13:26:28)
> The goal of this series is to switch the meson sub-drivers to use
> clk_ops.determine_rate instead of clk_ops.round_rate. The former has
> lower precision (2^31 instead of 2^32 on 32-bit systems). Also the idea
> of the .determine_rate callback is that is replaces .round_rate so the
> latter can be removed at some point.
>=20
> No functional changes (apart from the 2^31 to 2^32 difference mentioned
> bove) intended.
>=20
>=20
> Martin Blumenstingl (4):
>   clk: meson: mpll: Switch from .round_rate to .determine_rate
>   clk: meson: dualdiv: switch from .round_rate to .determine_rate
>   clk: meson: sclk-div: switch from .round_rate to .determine_rate
>   clk: meson: clk-cpu-dyndiv: switch from .round_rate to .determine_rate
>=20

Acked-by: Stephen Boyd <sboyd@kernel.org>
