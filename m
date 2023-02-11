Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88D71692BC3
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 01:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjBKAJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 19:09:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjBKAJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 19:09:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF3D7D3F7;
        Fri, 10 Feb 2023 16:09:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 76DC661ECD;
        Sat, 11 Feb 2023 00:09:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD8CCC4339B;
        Sat, 11 Feb 2023 00:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676074186;
        bh=JpPrhT2vVnzQiP5rBpSlpuo4AwVIj10bAclyrzmf5ZY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=St2jEyoVlTE9fWjmGHdkRP6Z4gRt3kLUhlK4ikBJ55rY1bbo9xw6YizY+t/Dpz5bk
         XB+nhdGs/1HoEL2G5B5OvwMm1V8fc20X9d4jQ07v/oB70HXOGkGqdeShy1hdtk6Juj
         AqfLv5fJk7FfpGTR8tUL8KPOq2bWnX2JYjw24jsjkgcK8GduQBvf9Wra0HCkitIS41
         jOcg4QAhejNkYaluNlJiATWycfZ/8bIuVaDj8Wn0TeclkWnMs0OGMC8h1OlC2f3h2y
         GqTI1h93gUO3rrXdJja0eutqxEnHEekLHk/m0fI3/FIOLLzMqx63aNkkSacgUQYCuG
         OkapB+G9uoOXA==
Message-ID: <b112829214b37d53846c0a4588dbcfe8.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAGXv+5Eo4es6XF6m9LQDhHdrFs=18_S-VGGvn4wQF1KWmzGcEg@mail.gmail.com>
References: <20230207014800.7619-1-moudy.ho@mediatek.com> <20230207014800.7619-2-moudy.ho@mediatek.com> <CAGXv+5Eo4es6XF6m9LQDhHdrFs=18_S-VGGvn4wQF1KWmzGcEg@mail.gmail.com>
Subject: Re: [PATCH v7 1/1] clk: mediatek: remove MT8195 vppsys/0/1 simple_probe
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
To:     Chen-Yu Tsai <wenst@chromium.org>, Moudy Ho <moudy.ho@mediatek.com>
Date:   Fri, 10 Feb 2023 16:09:44 -0800
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chen-Yu Tsai (2023-02-06 20:29:21)
> On Tue, Feb 7, 2023 at 9:48 AM Moudy Ho <moudy.ho@mediatek.com> wrote:
> >
> > MT8195 VPPSYS0/1 will be probed by the compatible name in
> > the mtk-mmsys driver and then probe its own clock driver as
> > a platform driver.
> >
> > Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
> > Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> > Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
>=20
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> Tested-by: Chen-Yu Tsai <wenst@chromium.org>
>=20
> Stephen, could you pick this up for v6.3?  Otherwise we'll end up with
> two drivers targeting the same compatible strings.
>=20

I applied v6 after fixing it by hand.
