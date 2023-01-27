Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64EC567F233
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 00:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbjA0XUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 18:20:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjA0XUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 18:20:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 192898242F;
        Fri, 27 Jan 2023 15:20:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C1565B82205;
        Fri, 27 Jan 2023 23:20:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 542EDC433EF;
        Fri, 27 Jan 2023 23:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674861607;
        bh=hSusYXl+QW4geeuVahIiZccPIu3lQiM8EzFLp84vDOo=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Qh2mWphlrznoc8QFyxl13/qBE0Aqnss7Ng1cYvDHObj1iEagYdR9q8BPRDsn2vOBP
         Lvr5hcdlsjxIRC/3tsWav2hKxBjPvGfoaERY5aOel8XObuwI9Zf+DUpBfQE549sL54
         iBVZSGo8x4j5FATsCBjLTWljJIN82bEOhpCSun0K5GzLvxLf2nOVBBtrPbbqHTpyMA
         ek8eREGpxb48javYQkD276Wh3gyFJco2p/M4/TyTPjiFC3THoL1V5DPMe0Ev5n2d8C
         JSRDom0Ioo6S4MbqbjNX00moF4eu7ZSSjMBVHIfRfLVaHPbQ7DPYYz4otD/18FfR8o
         +2xSHXko7+76w==
Message-ID: <b88b235ea62db6e3200fef3d5abe1e99.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230118031509.29834-4-moudy.ho@mediatek.com>
References: <20230118031509.29834-1-moudy.ho@mediatek.com> <20230118031509.29834-4-moudy.ho@mediatek.com>
Subject: Re: [PATCH v6 3/4] clk: mediatek: remove MT8195 vppsys/0/1 simple_probe
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
Date:   Fri, 27 Jan 2023 15:20:05 -0800
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Moudy Ho (2023-01-17 19:15:08)
> MT8195 VPPSYS0/1 will be probed by the compatible name in
> the mtk-mmsys driver and then probe its own clock driver as
> a platform driver.
>=20
> Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
> ---

Applied to clk-next
