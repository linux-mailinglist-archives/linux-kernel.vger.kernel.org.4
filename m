Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D17634DC5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 03:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235500AbiKWCWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 21:22:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235494AbiKWCWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 21:22:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B2511464;
        Tue, 22 Nov 2022 18:22:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6AFC7619F3;
        Wed, 23 Nov 2022 02:22:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0851C433C1;
        Wed, 23 Nov 2022 02:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669170153;
        bh=G8ldD5XLNgFkctdiUvzV7hGQ8thaimppY8W3c2//TmE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=fmexUNdzDfqgfx1vJ/IpfDup6gOUkmLdk71MuJHe5DYvgy7GKcYVaD/fw97jVW52g
         OsARX/e2VtQTgajMIdM/bdmTp7MQLu5xJefBaQYvDAUJ82o8aSa0EujbCmZl2Bxz/x
         cn77XdlxDOB81rspvlNxMCRlkTRAKWSYMQUR9NUpPWHxq2EqjApuOVMYALIWEtYQ4i
         irm384WQ9VXT2Qrfo9hwAWZTiobn9xterynwA7RSc0qrtw0pVu/23mkwrfM8nb1x7Q
         dPc9TXXfKfgA7lnRPhYCLKH3cGTOXUHQ6+6mRKW9Py29p87riIkEgFnZHUC0tSCCCs
         PgJkLc18qVsNA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20221122130732.48537-2-andriy.shevchenko@linux.intel.com>
References: <20221122130732.48537-1-andriy.shevchenko@linux.intel.com> <20221122130732.48537-2-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 2/3] clk: fractional-divider: Show numerator and denominator in debugfs
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 22 Nov 2022 18:22:30 -0800
User-Agent: alot/0.10
Message-Id: <20221123022233.C0851C433C1@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Andy Shevchenko (2022-11-22 05:07:31)
> It's very useful to see what are the values of the fractional divider.
> For that, add respective debugfs files.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---

Applied to clk-next
