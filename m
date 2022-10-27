Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA5060ED45
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 03:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233705AbiJ0BKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 21:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233408AbiJ0BKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 21:10:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3682448CA7;
        Wed, 26 Oct 2022 18:10:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D056E620F7;
        Thu, 27 Oct 2022 01:10:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EB36C433D6;
        Thu, 27 Oct 2022 01:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666833040;
        bh=ghOLsfeg088IxK/V/Su106MptF1U9muSHmHSXehujlY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=nr7UI14nYlfto8g00xP8SwjpFKKwMqUaHNCyI1lIccnfmFmOTC005HBqZJQpl3d/S
         q3FZdEjTWADu20o8sbTJ+s9fKQutkBTgOH9yL9kdKOzr4FVNkKE3fmafv03p5SCHJK
         CKaxUDyo/xRaAv7huLRsaR2KOWTEg4oeUkW+ZrJYCxl3xqowdZUf3u+CzIjorrguox
         iwC7bq9k1SZa+f3GFVvGNqOXYb7B58pyB7QMphNIk23W0duQJlHjcJTyf9t7TjWSsk
         F6jBCY25JCP3RfQ5D3P9rHecXbS2+JKCSOXlAAleOIa2jf63JJf258odcslV5AlOr0
         ZvmChasoGDlyQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20221019152947.3857217-5-arnd@kernel.org>
References: <20221019152947.3857217-1-arnd@kernel.org> <20221019152947.3857217-5-arnd@kernel.org>
Subject: Re: [PATCH 04/14] clk: remove davinci dm3xx drivers
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-clk@vger.kernel.org
To:     Arnd Bergmann <arnd@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        David Lechner <david@lechnology.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Sekhar Nori <nsekhar@ti.com>,
        linux-arm-kernel@lists.infradead.org
Date:   Wed, 26 Oct 2022 18:10:38 -0700
User-Agent: alot/0.10
Message-Id: <20221027011040.2EB36C433D6@smtp.kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Arnd Bergmann (2022-10-19 08:29:30)
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> The davinci dm3xx machines are all removed, so the clk driver
> is no longer needed. The da8xx platforms are now using DT
> exclusively, so those drivers remain untouched.
>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
