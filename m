Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65A345EEA7C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 02:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbiI2ASU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 20:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiI2ASR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 20:18:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 128A611A6B0;
        Wed, 28 Sep 2022 17:18:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C73C6149D;
        Thu, 29 Sep 2022 00:18:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2F72C433B5;
        Thu, 29 Sep 2022 00:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664410695;
        bh=dMb5j3HoumTKUplDjSt7FG9Gtjknp0T8dUlhniqfEhY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=KL9/gxHW4uTlCkcYo9PJHQep6FvZ0AsxTV1u5u9N6bm3Xnizni+CYSFgfDetUMrgU
         BzhlCTYAKmemM2vm7nynIPP6i9CR/oAPm8GVH3bGduEs0ktNNwvzS/ULveGlhhfv7C
         ChnOrhPF608fKbItjyyIlevyX/xK6bvVyo9rwQ4EUulS/JVcMDcIimJsSw8hYNGFgg
         aTpDaHoY64ymLdXGCboPVONH/AcJlN3cjX4u3zO8hl07O2nQHEjl0+GugWcu18yiXL
         XlLfn/t0t+aIxClUAxok9nfX6+xsusFIPEskoQDCaXHuPQmKCbMmTR1ypQ0O/o9dxL
         8evkpFdpLFzNw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <73cdb7cb3919b29a41a52da4904b1273bd81c7fe.1663827071.git.rtanwar@maxlinear.com>
References: <cover.1663827071.git.rtanwar@maxlinear.com> <73cdb7cb3919b29a41a52da4904b1273bd81c7fe.1663827071.git.rtanwar@maxlinear.com>
Subject: Re: [PATCH RESEND v2 5/5] clk: mxl: Add a missing flag to allow parent clock rate change
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-lgm-soc@maxlinear.com,
        Rahul Tanwar <rtanwar@maxlinear.com>
To:     Rahul Tanwar <rtanwar@maxlinear.com>, linux-clk@vger.kernel.org,
        mturquette@baylibre.com
Date:   Wed, 28 Sep 2022 17:18:12 -0700
User-Agent: alot/0.10
Message-Id: <20220929001815.D2F72C433B5@smtp.kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rahul Tanwar (2022-09-21 23:24:28)
> One of the clock entry "dcl" clk's rate can only be changed by
> changing its parent's clock rate. But it was missing to have
> CLK_SET_RATE_PARENT flag as enabled.
>=20
> Add/enable CLK_SET_RATE_PARENT flag for dcl clk in order to
> allow its clk rate to be changed via its parent's clk.
>=20
> Signed-off-by: Rahul Tanwar <rtanwar@maxlinear.com>
> ---

Any Fixes tag?
