Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 468746D532D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 23:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233598AbjDCVLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 17:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232805AbjDCVLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 17:11:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189D549CD;
        Mon,  3 Apr 2023 14:11:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 81C3C61E21;
        Mon,  3 Apr 2023 21:11:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D797DC433EF;
        Mon,  3 Apr 2023 21:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680556276;
        bh=3hxbwLfIPBSErZH0ZG4KR9ETcZ0/kYnkHQG9lfQbWlE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=m5M/pTq++F1ExgqRnygB2EGIaIg67uk+aaQxJRIbyxbDHnIkK2GC7r57PIcmmzo0g
         Ba2ddfaBEb9WwjXQUnh/Xohe15O6d/Eo0iniBHC4kejB9dCLcAVBe43rVXHIT4TFOQ
         mo5EUQf9egMSOC3mdC8k+rveF8QAilZVbHWEKyPqX4nR0hvDpRT0MMmfxjG/dcQlGm
         9hUeTMCOLuTZIn7EuBJOBPj9IndtiAheTkN3iL72ZLzkI9M+jTitWS54YbU+Er336O
         r2zeYRXiTC/xcMOAlwlBRCJIj5lttacpeUbFUQy+qVtm6RHErQXZZbNXOGpVJv5hCz
         yECGqPHkv8rOw==
Message-ID: <d93bd6ff1ce2401fd9a33c6a3ed065d2.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <e08a470fbd6151ebd83a548714c08807a80a8ad0.1680364296.git.christophe.jaillet@wanadoo.fr>
References: <e08a470fbd6151ebd83a548714c08807a80a8ad0.1680364296.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] clk: stm32h7: Remove an unused field in struct stm32_fractional_divider
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-clk@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
To:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>
Date:   Mon, 03 Apr 2023 14:11:14 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Christophe JAILLET (2023-04-01 08:52:12)
> 'mmask' has never been used in this driver.
> Remove it.
>=20
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---

Applied to clk-next
