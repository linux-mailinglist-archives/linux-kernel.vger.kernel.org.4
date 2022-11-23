Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA0F2634BCE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 01:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235114AbiKWArO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 19:47:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235329AbiKWArM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 19:47:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F460D5A1B;
        Tue, 22 Nov 2022 16:47:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F00796194A;
        Wed, 23 Nov 2022 00:47:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5245DC433D7;
        Wed, 23 Nov 2022 00:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669164430;
        bh=lDXdSzw4PMXXXF3nLrHVxQyZSnT026dh4Nn6IkU0BoE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=fONDl5k1h7xPaYRhwR/ZemCKa1Gug8LSReGg8z2vWwv7Uv0JSpU41MJlxzUlsuK91
         SwRGmf/yw1FozuNeod0H7EdllsB067ZT4XnurkY+bjamJoVclq8WDH7pDeYFv6Hw49
         GkPj0rQP3qpv4DkIdBuyoo6rDN7GtTCIRNgzxaXI6Vjmj6adT5BrcYLdDoMQOWiOdD
         VWDBx8Y05U24utxAk0MUzFeq8K5aCsMkzhm045ZpDpGVLHasrj1J81oISP949JY0Gy
         3ckwwR5QyAyhOdkQnbm76ZxvfAS7EsWw/vdyiebEy4IhMkyJG83ef8I4AdkyozVn+0
         G3IXfxIetxfYQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20221116092616.17960-1-krzysztof.kozlowski@linaro.org>
References: <20221116092616.17960-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [GIT PULL] clk: samsung: Pull for v6.2
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-clk@vger.kernel.org, Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>
Date:   Tue, 22 Nov 2022 16:47:08 -0800
User-Agent: alot/0.10
Message-Id: <20221123004710.5245DC433D7@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Krzysztof Kozlowski (2022-11-16 01:26:16)
> The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc7=
80:
>=20
>   Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)
>=20
> are available in the Git repository at:
>=20
>   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/sam=
sung-clk-6.2
>=20
> for you to fetch changes up to 2bc5febd05abe86c3e3d4b4f18dff4bc4316c1be:
>=20
>   clk: samsung: Revert "clk: samsung: exynos-clkout: Use of_device_get_ma=
tch_data()" (2022-11-15 10:36:54 +0100)
>=20
> ----------------------------------------------------------------

Thanks. Pulled into clk-fixes even though the subject says v6.2 they
look like fixes that we really want now instead of later.
