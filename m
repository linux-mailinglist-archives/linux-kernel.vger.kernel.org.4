Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F062E692BD5
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 01:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjBKAPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 19:15:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjBKAPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 19:15:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A680882190;
        Fri, 10 Feb 2023 16:15:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F92861EC3;
        Sat, 11 Feb 2023 00:15:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92FB7C433D2;
        Sat, 11 Feb 2023 00:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676074500;
        bh=3Gu16sVpeG91r2zL5sJBxTx6RouftcrivaZx9fWn6MM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=PEgy2c3f444YbEc7JeGNKRiplYtKiEeaWczWaOjJgiseSWGe/4gz6+rup4mZ6eKjv
         k7KbeUVlxY+ex32xFFetO0VfF00pz7mM34K6RKNgNdpWHZST3NB2x/K0mwvf968chn
         pNoKRPJdEW7hDk+4bwIOYmB1LOjZE4IWJbyk6Iq8IVnydE/y2iwtjK2+GJc8cCmxXd
         vuvX1V2GF+JYKdDMe5zjS5y+lD3DHqGC3ZVvbjISzZSVoqoFPOSq3FgnkhZoIcNsTG
         t+sQQtMW2HK5QeQqORWwvV74BuRde+jI+j15KyGhJQGlryyisBZPHO960vf1mPCPrE
         HX51laDojwxxQ==
Message-ID: <2b64e860005caf58b238582362c30b46.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230201091300.3201-1-cixi.geng@linux.dev>
References: <20230201091300.3201-1-cixi.geng@linux.dev>
Subject: Re: [PATCH] clk: sprd: Add dependency for SPRD_UMS512_CLK
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        cixi.geng1@unisoc.com
To:     Cixi Geng <cixi.geng@linux.dev>, baolin.wang@linux.alibaba.com,
        mturquette@baylibre.com, orsonzhai@gmail.com, zhang.lyra@gmail.com
Date:   Fri, 10 Feb 2023 16:14:58 -0800
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Cixi Geng (2023-02-01 01:13:00)
> From: Cixi Geng <cixi.geng1@unisoc.com>
>=20
> Add depends on and default for ums512 clk config.
>=20
> Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
> ---

Applied to clk-next

The ARM64 dependency is redundant though so maybe you should remove that
too in another patch.
