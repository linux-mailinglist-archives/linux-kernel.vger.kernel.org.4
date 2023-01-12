Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD5BD6684B6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 21:56:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241013AbjALU4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 15:56:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240248AbjALUxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 15:53:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DDA81B9F6;
        Thu, 12 Jan 2023 12:38:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5587CB81FBC;
        Thu, 12 Jan 2023 20:38:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5D9AC433F1;
        Thu, 12 Jan 2023 20:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673555919;
        bh=gjvrulXFQQsIJPhTaPkrnulSY0e6m1bUykAs4O76JSo=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=DNDJysRuALju6JJUrewTVBybpRgH/wVMB372IAG4OcyXVE9z7/rhjJzFWwgz30JSD
         yThQqUpduxY7QbEPKhqWSXx29VjrTuOyLCOgC54NAwA2HoAYQT5Nwk6EsmXEoiRVO5
         98JY6SsNbqTwdmbq6d24+w12f/eIehnRIALFbJnab/8BCindTt3yUV5biR2+nqv+2P
         I56eauJK5CFeavsbv1KaFRJ/f3F8i0PaV5DADit81WjgE+bGdugznmU6rl/7JYNmC6
         U9+YLZsLHuT1XtDDxJ8AvH8eMAplyBoc+AZaX4kFXnz7o4LF99rhhJgACAbhbx9H+/
         XK6kH3DmrMFug==
Message-ID: <50ac63fbb30495504b5ebda08f5e56dc.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230105141231.2006353-1-arnd@kernel.org>
References: <20230105141231.2006353-1-arnd@kernel.org>
Subject: Re: [PATCH] clk: samsung: remove s3c24xx specific pll bits
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Chanwoo Choi <cwchoi00@gmail.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Ajay Kumar <ajaykumar.rs@samsung.com>,
        Pankaj Dubey <pankaj.dubey@samsung.com>,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Arnd Bergmann <arnd@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>
Date:   Thu, 12 Jan 2023 12:38:36 -0800
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Arnd Bergmann (2023-01-05 06:12:13)
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> With the s3c24xx clk driver gone, the portions of the pll driver
> for it can also be removed.
>=20
> Suggested-by: Chanwoo Choi <cwchoi00@gmail.com>
> Cc: Chanwoo Choi <cwchoi00@gmail.com>
> Link: https://lore.kernel.org/linux-arm-kernel/0e0eff12-d8ea-72e9-d135-42=
59dda9a750@gmail.com/
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
