Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EFBD648986
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 21:25:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiLIUZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 15:25:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiLIUZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 15:25:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55DD1649D;
        Fri,  9 Dec 2022 12:25:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 367BD622FA;
        Fri,  9 Dec 2022 20:25:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A4F0C433D2;
        Fri,  9 Dec 2022 20:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670617510;
        bh=9p6P37PolWmqYhi8ppeONKqBme0cH8lJOdEoUbGKtfc=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=uhXo8zL+Xjj/VK820NF5RzCbZBFpOIiP6A70bHhSW8DKfe/IAg//aPWVmiqMzkBOH
         tsI5RYef4gtHDjs2jzTimtQsTcfmB3hbAebuD5kzwbMvWwW2SlkaHW+01KYJ1sOkgR
         puA3BpZsyg+/FaUWs8FtGkQZBwczgSPJ8sevCX65GwQ/96o7VG0qvjB55x0x5A8HZF
         8oLN34t1LvUUzGwBwvIoQFmU0OvsAmJ/J8fVzCvkCxgyGFdc38gIJ4/LOF3cZCwaG+
         UqzPVl6HISkqmd9M10TpzF3cZvTNn3DtQPWgspMmGMjDg5Oow5KZOg6flkN8/+0VOP
         8eWG1T+0tbUNA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <202211220948416946619@zte.com.cn>
References: <202211220948416946619@zte.com.cn>
Subject: Re: [PATCH] clk: use devm_platform_get_and_ioremap_resource()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     mturquette@baylibre.com, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        chi.minghao@zte.com.cn
To:     mani@kernel.org, ye.xingchen@zte.com.cn
Date:   Fri, 09 Dec 2022 12:25:08 -0800
User-Agent: alot/0.10
Message-Id: <20221209202510.7A4F0C433D2@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting ye.xingchen@zte.com.cn (2022-11-21 17:48:41)
> From: Minghao Chi <chi.minghao@zte.com.cn>
>=20
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
>=20
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>

Please fix the subject.

 $ git log --oneline -2 -- drivers/clk/clk-bm1880.c
 c861c1be3897 clk: bm1880: remove kfrees on static allocations
 59ef4da4e408 clk: bm1800: Remove set but not used variable 'fref'

And then get Mani to ack it.
