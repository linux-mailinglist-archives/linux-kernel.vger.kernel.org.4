Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9834472CE6F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 20:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238037AbjFLSb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 14:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237548AbjFLSaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 14:30:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B060FCE;
        Mon, 12 Jun 2023 11:30:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4CFCC617E6;
        Mon, 12 Jun 2023 18:30:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94604C433D2;
        Mon, 12 Jun 2023 18:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686594653;
        bh=QxpJzmrhs/s31q92ok3v7gD12r5Tp5raaCXLllOa6g0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=UvXzMCZI4lZ0ZAohnpSdiE521Tv/m8RJSWTongiULPGyPP05a4Yu7ILM7Og6cN/0m
         g178wqzsU0l2t7XKDslRurm1hTvuZGc4nqEMFN67TBRzHTpI11YZSI6qxx6rkFIoBn
         cgpKYbBRKUGMj0vcN24QD4eXLuLNfKZjFdvHxgmsf4G9qoqWro7MfSoc8e7577xHmG
         eTUlxVa8heGtfQlyKSsbtoSv0+EV29H8RK/U40zrLRXKUw0ry2R/YcylDB+HP5V8Qi
         QkfAs0fJAi6HueM9Rc4ayhnkkgx20dwJGEnQj2/9yqIY7vccK1am2M70zWE3acv2Uk
         mhkdV5zflbBYg==
Message-ID: <c602fd10aed6f16e6ff2be772dfc5ba3.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230612175910.289428-1-krzysztof.kozlowski@linaro.org>
References: <20230612175910.289428-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [GIT PULL] clk: samsung: drivers for v6.5
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
Date:   Mon, 12 Jun 2023 11:30:51 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Krzysztof Kozlowski (2023-06-12 10:59:10)
> The following changes since commit ac9a78681b921877518763ba0e89202254349d=
1b:
>=20
>   Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)
>=20
> are available in the Git repository at:
>=20
>   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/sam=
sung-clk-6.5
>=20
> for you to fetch changes up to 2aac2d8b95923203e683c60124877ab434133679:
>=20
>   clk: samsung: add CONFIG_OF dependency (2023-06-12 11:45:20 +0200)
>=20
> ----------------------------------------------------------------

Thanks. Pulled into clk-next
