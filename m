Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8799B6CF4DF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 22:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjC2Uzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 16:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbjC2Uzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 16:55:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D788611A;
        Wed, 29 Mar 2023 13:55:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 20B68B819BA;
        Wed, 29 Mar 2023 20:55:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5B7AC433D2;
        Wed, 29 Mar 2023 20:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680123346;
        bh=YHSa74NBZoM4DDRq0kBF+aOIFsGiD6uRDVS4Y0661fk=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=VDBtD1A7Ajkp+2PTy94jKbCEVwBzKoSCeNWw9NWR29xeF2WJYdCu9ABn0btj0ITPl
         cwcGw1QMcAsmMUXNlaXVi3MsoRd1X4L8c2xKZfbLLbIFqMbSx6O7tQhIyPChknwzho
         PrAJJxsNHkiWmq7weuoG+aWVKB2PS9Hj14sOI5qAbUyc8Ek5kSoVl7Yrd172LFcIDC
         umH6ZW+Hb4bZM2okhzIn7TX1L21Rusg/aOz7RG3kIXSFLvjlvpu8VhGoYJv+DfnVpU
         1WmzB8oUUz/zw/lP//XblT3NpQlQ7HyVqKh2QbbuQ9IK86RFGCFHiOwVa+FWCIAYvj
         4Ra6PVdv9RO4Q==
Message-ID: <efd25452d3c9bb6834f2b7bac6027fe2.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230131083227.10990-1-clement.leger@bootlin.com>
References: <20230131083227.10990-1-clement.leger@bootlin.com>
Subject: Re: [PATCH v2] clk: add missing of_node_put() in "assigned-clocks" property parsing
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <clement.leger@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <clement.leger@bootlin.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Date:   Wed, 29 Mar 2023 13:55:44 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Cl=C3=A9ment L=C3=A9ger (2023-01-31 00:32:27)
> When returning from of_parse_phandle_with_args(), the np member of the
> of_phandle_args structure should be put after usage. Add missing
> of_node_put() calls in both __set_clk_parents() and __set_clk_rates().
>=20
> Fixes: 86be408bfbd8 ("clk: Support for clock parents and rates assigned f=
rom device tree")
> Signed-off-by: Cl=C3=A9ment L=C3=A9ger <clement.leger@bootlin.com>
> ---

Applied to clk-next
