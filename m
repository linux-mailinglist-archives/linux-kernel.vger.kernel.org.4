Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38A55634D74
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 02:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235260AbiKWBwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 20:52:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233459AbiKWBw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 20:52:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AAAB19D;
        Tue, 22 Nov 2022 17:52:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26F27619A9;
        Wed, 23 Nov 2022 01:52:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F839C433D6;
        Wed, 23 Nov 2022 01:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669168344;
        bh=dTA0Ua0yEjDRaEG6ZxMKIqle9mnBNl2ZpQuwd5Bx88g=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=mCyRDXCG9YB364voD4uLV7TbJ1zVps9MntGPHH4g0extA883uE4AEEcybirjSVbMD
         WxKOMzbtow5+8oSIO/ek7EPyZjf/9r9NembrNDsSWiOoHrfUNfvGmdWpFw8Yy30Jbg
         3iF1aVcThk3r6Lme3oVP+nzDpckIsLhEUdYt6YiMlwK8pKz+D59lax2WamQ4+6QSFB
         rL2FgQlgO9RcoYJ1drnyvlab7ra0sEDuijwS67m8SY0I+U9S02CW4PixRzg8ruY3sO
         uT3pXTqEzjaN0dQSEge6Is3l0T/ebPNORfo7KPMqSbs9KFmM8llwBLdPCo8YlQvxkH
         WpW1nwnRJj45g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <12dd5cb49efa7714f8e0389e4c7b3bc829e8a90e.1668289299.git.christophe.jaillet@wanadoo.fr>
References: <12dd5cb49efa7714f8e0389e4c7b3bc829e8a90e.1668289299.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] clk: Remove a useless include
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Heiko Stuebner <heiko@sntech.de>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>
Date:   Tue, 22 Nov 2022 17:52:22 -0800
User-Agent: alot/0.10
Message-Id: <20221123015224.6F839C433D6@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Christophe JAILLET (2022-11-12 13:43:03)
> <linux/rational.h> is not needed for these drivers. Remove the
> corresponding #include.
>=20
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---

Applied to clk-next
