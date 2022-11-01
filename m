Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B610615282
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 20:44:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbiKAToy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 15:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiKATow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 15:44:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714F012770;
        Tue,  1 Nov 2022 12:44:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D95F61715;
        Tue,  1 Nov 2022 19:44:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 648B3C433D6;
        Tue,  1 Nov 2022 19:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667331891;
        bh=//K4QNbzYFOWo+QH+GbBMQaZSa7pLigyVZveW13UDss=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=h5CVyHDxIu+wbsgX7z2Se8He7WoX56gqzFkhqJkwj41lORQNNMOfDuXiCuAcOUPl8
         2MGG1srv+1vuAO4AuSpeWJHAS6HrfUo7Uq/C6gr0CEph/LXhGwRy7Dtz2U/IK4AaQY
         Mabd+8rQ9hvv8tw43+VWy42C6kCTYOuA76EI8Z4HLgQXLmAX3FwMhi5U6jDh/cYUEg
         4M7R0vA3swejR+0yWA1BzuoWxWBibPBHLF0AmxkE0NDvRPlpII6vsyZ1lja1x8lE+y
         R3XEOhmMOod8/tJQtbNwjeVUsgQnWsm56toOFuOw9uoozmVFWno2EYO4Z9KDVoIV5M
         V9Hbfr+JymGvQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20221031220751.158341-1-j.neuschaefer@gmx.net>
References: <20221031220751.158341-1-j.neuschaefer@gmx.net>
Subject: Re: [PATCH] clk: samsung: Fix reference to CLK_OF_DECLARE in comment
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Jonathan =?utf-8?q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
To:     Jonathan =?utf-8?q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-clk@vger.kernel.org
Date:   Tue, 01 Nov 2022 12:44:49 -0700
User-Agent: alot/0.10
Message-Id: <20221101194451.648B3C433D6@smtp.kernel.org>
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jonathan Neusch=C3=A4fer (2022-10-31 15:07:51)
> It was misspelled as OF_CLK_DECLARE. Fix it.
>=20
> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> ---

Applied to clk-next
