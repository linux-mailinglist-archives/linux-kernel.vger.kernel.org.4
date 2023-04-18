Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3AD26E55DD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 02:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjDRAaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 20:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjDRAaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 20:30:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F243F1733;
        Mon, 17 Apr 2023 17:30:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D52662B14;
        Tue, 18 Apr 2023 00:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB852C433D2;
        Tue, 18 Apr 2023 00:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681777820;
        bh=ZmFwJ7m5ZLxH+t58ZzfiJLOLdybzzWisxpx1qHDzVPU=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=qksOjS7UehQHQU48wzAd/nTyFi31TTsNEgEIWIKQGpsxL2pE8hf/dsvnj0/Jcqjp8
         Vfineigagj/H2n+uleVsWnN8FPBxtpzGdFGz8Em4SnTJBpcV9yIcBDUNwuemcDSCYd
         2WykdHQLpI2Mg02n8TPm5sysYZ0e9bGHJyUSb25fdoBg9DmXPRIeQrps4ULCRzTydQ
         lceiWuzffBWt2lyYjxWIgIvUGL5Odt7WXCUv/soBT/6/CEmA5xGZzpXp6qRWC+WlIE
         bx0RXZoxQeRvjv2Pq7g6bm1tn5cosbH1GUgPzNqjUrUvoDGhQD+93ld7ltPUX9e9VO
         Yfln7MbSen6Uw==
Message-ID: <866ffea2459ba57328afa800a30421b4.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <2aa668e3-d065-7376-5d41-ef855afa8518@starfivetech.com>
References: <20230413205528.4044216-1-sboyd@kernel.org> <b41d8cf4-70aa-3b64-5254-46d92a188f63@starfivetech.com> <2aa668e3-d065-7376-5d41-ef855afa8518@starfivetech.com>
Subject: Re: [PATCH] clk: starfive: Avoid casting iomem pointers
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        patches@lists.linux.dev, Tommaso Merciai <tomm.merciai@gmail.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Conor Dooley <conor.dooley@microchip.com>
To:     Hal Feng <hal.feng@starfivetech.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Xingyu Wu <xingyu.wu@starfivetech.com>
Date:   Mon, 17 Apr 2023 17:30:18 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Hal Feng (2023-04-14 16:31:45)
>=20
> Thanks for your fix to my previous patches, and I have tested this patch
> on VisionFive 2 board. As Xingyu said above, I think dev_set_drvdata()
> should also be dropped in clk-starfive-jh7110-sys.c and
> clk-starfive-jh7110-aon.c.
>=20

Sure. I see you sent the patch. Thanks.
