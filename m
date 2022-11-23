Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8A1634DC7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 03:23:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235485AbiKWCXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 21:23:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235505AbiKWCWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 21:22:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37ECE9A27D;
        Tue, 22 Nov 2022 18:22:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC1F0619F3;
        Wed, 23 Nov 2022 02:22:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28C30C433C1;
        Wed, 23 Nov 2022 02:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669170171;
        bh=zGv6AraZC7adGE2mTHkUpnNRAtW0gGDS836wAIKnlFg=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=D4DpA6XN351UiIDYkp3Q0TB8MEWoPr2vAl4wSNd1GQmLi4DwbSLW1dxYBOJcNy1MI
         bApbIdnQHAe5dlRpQSkXeNyE+ODi5oQdmn8SXD9yxV+wZgsaVV0km7e7zpH5N0zYd1
         5fYHs1GlpWNpRmXupza3DjRrKQSWB6MCdY+ebNmIlSgviDH6xEwzMLFP51AAbqVlGl
         gITFmc7/e1mxeMJGdVgmKj76xB7sXa95/x/mE2p6eBhFpvTabfDs+0HszyeeXrEO+c
         T5UYtIku44sbUz8kazMZsS5UEpGwMnfE7M1uXqiLAMHTx1IHh6dDW8/fkDsXr6S0fe
         fvei4x03bxMnQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20221122130732.48537-3-andriy.shevchenko@linux.intel.com>
References: <20221122130732.48537-1-andriy.shevchenko@linux.intel.com> <20221122130732.48537-3-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 3/3] clk: fractional-divider: Regroup inclusions
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 22 Nov 2022 18:22:47 -0800
User-Agent: alot/0.10
Message-Id: <20221123022251.28C30C433C1@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Andy Shevchenko (2022-11-22 05:07:32)
> For the better maintenance regroup inclusions as follows:
> - split CCF related headers in its own group
> - order groups from generic to particular
> - sort each group alphabetically
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---

Applied to clk-next
