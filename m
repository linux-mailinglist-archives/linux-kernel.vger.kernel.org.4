Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7410761527D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 20:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbiKAToT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 15:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiKAToP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 15:44:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7849F11C05;
        Tue,  1 Nov 2022 12:44:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 332FDB81F0E;
        Tue,  1 Nov 2022 19:44:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAFB4C433D6;
        Tue,  1 Nov 2022 19:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667331851;
        bh=DoZu+AdSzcBGy+/tgbWd1ZGVY4aJ0Ll1DRtpT/Artho=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=MrKHKa0Y1aBa809oO+5nloeWVDJpU2h8CjnPGlQqAg5OOD2mjm5AGianEcwNTlnOt
         rFHLK4/DgDhYDT3XTmBHOSx75zzqz9o4FNHeutCgXa7SOlSNo2nnS1rEZPPMiGyYf3
         9tZm6Them2581uR6QMFGE64FylK0uWgawseHO220FENUParVgB/6SqIfprIuQITvRx
         Grjb1W6spSlm4SQumL3DXmXAxjtOBmcBYa9WG6Lvn1/IjJyyLjkVM/0/XQWiDhFH6t
         +5V3gMBm7R2qxa4M4Ui3oKmYvUr+5cT7ICZclSXYvUthgpEd2OtKRqvO4n4uu8JWJJ
         ER/B6Jfy3i9Tg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20221031183930.1338009-2-lis8215@gmail.com>
References: <20221031183930.1338009-1-lis8215@gmail.com> <20221031183930.1338009-2-lis8215@gmail.com>
Subject: Re: [PATCH v7 1/1] clk: Add Ingenic JZ4755 CGU driver
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Siarhei Volkau <lis8215@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-clk@vger.kernel.org
To:     Siarhei Volkau <lis8215@gmail.com>
Date:   Tue, 01 Nov 2022 12:44:09 -0700
User-Agent: alot/0.10
Message-Id: <20221101194411.CAFB4C433D6@smtp.kernel.org>
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Siarhei Volkau (2022-10-31 11:39:29)
> Add support for the clocks provided by the CGU in the Ingenic JZ4755
> SoC.
>=20
> Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
> ---

Applied to clk-next
