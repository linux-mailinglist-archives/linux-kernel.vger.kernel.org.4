Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 499A1730C1D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 02:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237390AbjFOAVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 20:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237476AbjFOAVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 20:21:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3780B2D57;
        Wed, 14 Jun 2023 17:20:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 81BB96153D;
        Thu, 15 Jun 2023 00:20:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D401EC433C8;
        Thu, 15 Jun 2023 00:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686788425;
        bh=ozv6giPzGRmfPQuuB5WiAMIv+WoZnlC14A7qr+rfDI0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=fNvwp91OD4u/aRRucVtnnzbLVjb8nGkhseyxYbrgGkqYJU1kUsrMKzJ+yWd/tTwdc
         21uNiFAu6SEuJlQa6yFHT0JrOuy9te6VMWT0TwPsZ6ecCUXUOiVlPaEtx1t00KrEHr
         tfltbesbpdcqI1ecgpPexmoSTZ1B0h+tiw0GteXedDxoFxATBt57StUL6c+knzyeXA
         0jTPlQq0VloUkgH20At8N++y8FKGn46XPWH6lFzTxb2/cYEUZlva5uaOh33tjAwN3L
         Tgkn9JASl5Xgj1BIDvNeqoX9omDBw0fHjFWVc4mJoR8IEh5/+8dJcaPw0hJd6oGLtU
         6r6L/AJRq4pDg==
Message-ID: <3d583029c237b29deb49159a1a64d04f.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230428070005.41192-1-yang.lee@linux.alibaba.com>
References: <20230428070005.41192-1-yang.lee@linux.alibaba.com>
Subject: Re: [PATCH -next] clk: sifive: Use devm_platform_ioremap_resource()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        linux-clk@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>
To:     Yang Li <yang.lee@linux.alibaba.com>, mturquette@baylibre.com
Date:   Wed, 14 Jun 2023 17:20:23 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Yang Li (2023-04-28 00:00:05)
> Convert platform_get_resource(),devm_ioremap_resource() to a single
> call to devm_platform_ioremap_resource(), as this is exactly what this
> function does.
>=20
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---

Applied to clk-next
