Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67442728C74
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 02:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236809AbjFIAax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 20:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjFIAav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 20:30:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B2FB1BE8;
        Thu,  8 Jun 2023 17:30:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 273A365253;
        Fri,  9 Jun 2023 00:30:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 719E2C433EF;
        Fri,  9 Jun 2023 00:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686270649;
        bh=ZVa287C0oWjuND1JLpn/ix4C5uNAJ2w+6kuC46VG9vE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=s/g+io50EQvASbCX7TDs+IUF4y6VXjtJHYVn/8aEdDoARJKSHAeCx3K3xmVKS7mcJ
         GwX3a+feCVTiOWjztM8Z3xA2B3Osv16VE/CJTEr/RxDVB3MFS1lEKMKBb6JRbEKr82
         E30+ILMtwgnYYmwRCUIOBvirg0tRtRTz8JOYEou4KxwaDI9Epgxd+P7uW2EfBcB0ZI
         Wqeq/XzFzahMjAeENB4NoivimmUcpWhWGWV1qpbYg/7XkSJ4mGqxyKOnCjPheEC9Im
         QYZikyivbGxWgz7fj3JktOguTT/fCQZ/bL0ZGhK6Q9tbGMhFbJF8m6vIIvGWehlfQ/
         ANG5h9qBuajlA==
Message-ID: <2e4a08941bf46408eaef415a1f0e6c32.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230601095512.18029-1-zhangqing@rock-chips.com>
References: <20230601095512.18029-1-zhangqing@rock-chips.com>
Subject: Re: [PATCH v1] clk: clk-fractional-divider: Export clk_fractional_divider_general_approximation API
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        huangtao@rock-chips.com
To:     heiko@sntech.de, kever.yang@rock-chips.com,
        mturquette@baylibre.com, zhangqing@rock-chips.com
Date:   Thu, 08 Jun 2023 17:30:47 -0700
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

Quoting Elaine Zhang (2023-06-01 02:55:12)
> This is used by the Rockchip clk driver, export it to allow that
> driver to be compiled as a module.

Sounds fine when CONFIG_COMMON_CLK_ROCKCHIP is tristate.
