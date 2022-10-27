Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8598610639
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 01:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235808AbiJ0XL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 19:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234642AbiJ0XLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 19:11:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB469E2E9;
        Thu, 27 Oct 2022 16:11:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC1B262592;
        Thu, 27 Oct 2022 23:11:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01DC3C43470;
        Thu, 27 Oct 2022 23:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666912311;
        bh=qE45ZMWm8NxAU1S6nLPvp8ebvWjS46uVJ8CHgzGsuLg=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Z4Gp+cu58RClezCBZ3x4FDdDHhjLaFHkek7L0h/0sTIxff3wTI62VXliZfQGTZL5b
         9xToKjJCQgXPQ8azks3BPioc/fPOwE5TRE5ueIc9O/aHdYcRtFlu9djuuTppx0Uy0/
         xwUOBzGyW0NwatSpUXjMGFAgIcJIODHEavNnp0n3ECE+c+izEEgwgLPkhJH6pUyuJK
         fP+6mHm6Yqhf3zgOYDeLS8iv0UgY8oRi85IZzFoeHScTpQRQIXUDIb1gERCrmySz8u
         4DCnx1rDJPhW4sh8YPJMQnj8Zeeuy86BjHt09Mq+qulwNjn4+4mdrSIy0aXMTq/s6G
         UKSkUEcDNJnZQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20221021203329.4143397-11-arnd@kernel.org>
References: <20221021202254.4142411-1-arnd@kernel.org> <20221021203329.4143397-11-arnd@kernel.org>
Subject: Re: [PATCH 11/21] clk: remove s3c24xx driver
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>,
        Simtec Linux Team <linux@simtec.co.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org
To:     Arnd Bergmann <arnd@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Date:   Thu, 27 Oct 2022 16:11:48 -0700
User-Agent: alot/0.10
Message-Id: <20221027231151.01DC3C43470@smtp.kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Arnd Bergmann (2022-10-21 13:27:44)
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> The s3c24xx platform is gone, so the clk driver can be removed as
> well.
>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
