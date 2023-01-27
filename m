Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD92367F238
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 00:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232953AbjA0XUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 18:20:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbjA0XUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 18:20:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D53717C33F;
        Fri, 27 Jan 2023 15:20:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8CFC5B82205;
        Fri, 27 Jan 2023 23:20:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 361A9C4339B;
        Fri, 27 Jan 2023 23:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674861631;
        bh=UyaO3WR5aL8yEkRqNVSm+n33GhHMoZg7aozy4Wia9d4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=R0iXXNKZTQq+HOgAa+/shUbeB1WBWpsW8L9+USEom4RNG2pjozXcEnmgYY6Wt7N23
         o7GNy095skW/Vm/0pZR/LZ//INSeeZin3QJOTWeDD6C3nWnZoK/xiz17D91KENnQDa
         fdLOVf+oZ4RPtWQkQ2mFGPaAGrMTbHf0yPpcU/PO4zEE/rV7nDNBUbS4UIZYs4wLTF
         9xNfqq5WOJjXe3b6IvLxGtsmTo05m4C6r9kjJtsK7GByEY/sKUAQqOcdQ0sMKKSKfL
         05k81wKBZB7Tp/fp3nxhrJpihKvCTOOcy/0Esk/qDAiFpnQJF6Si5ky0L5Bp7af+km
         /054vMYwSPYEg==
Message-ID: <cb7ecbcfd5cebc81172003b77f2d2f3c.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230118031509.29834-2-moudy.ho@mediatek.com>
References: <20230118031509.29834-1-moudy.ho@mediatek.com> <20230118031509.29834-2-moudy.ho@mediatek.com>
Subject: Re: [PATCH v6 1/4] dt-bindings: arm: mediatek: migrate MT8195 vppsys0/1 to mtk-mmsys driver
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Moudy Ho <moudy.ho@mediatek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Moudy Ho <moudy.ho@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>
Date:   Fri, 27 Jan 2023 15:20:28 -0800
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Moudy Ho (2023-01-17 19:15:06)
> MT8195 VPPSYS 0/1 should be probed from mtk-mmsys driver to
> populate device by platform_device_register_data then start
> its own clock driver.
>=20
> Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
> ---

Applied to clk-next
