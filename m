Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2A1A6BDD12
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 00:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbjCPXlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 19:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbjCPXlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 19:41:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D241CB5FC6;
        Thu, 16 Mar 2023 16:40:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A891C62157;
        Thu, 16 Mar 2023 23:40:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE657C433D2;
        Thu, 16 Mar 2023 23:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679010005;
        bh=gaEWoGVbQdo400PIFpa/a6tdIPaKV1l5ImBHIuKTljo=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Pv33oHq3ImBnH1f8q15CUQrKnwcdJ4kjX2LIXaSoD6UEyCzkB5T9umM2UKc6tJQZq
         29+s0rLDZSI7T05NAvN1UOMJT7jgJDwl55tL683bXQ5PnggSSziJBfi+MiETBmN79C
         MEK2QAZKtHh9bnqap5c63408Xp5svF4jiow57od+GMOWzUbQOsNNriY5UrFOm0iL85
         cbXnIYD+1ZJUn1LDfa4p2vL6DvioauzQeThO27j/n3BAwksi0Nf4Ctb5j2vGsOn5YE
         jSxmotWWQqRKHP9O0Q9I3XqFPRw2XOuNUIlRWP0jfr1aC5NgScHzMvIf/XKNgpKgPA
         F+ay3O4Rm3P8Q==
Message-ID: <182bd2465ee74ccc739b82c6ebd49cf8.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230316023624.758204-1-chunyan.zhang@unisoc.com>
References: <20230316023624.758204-1-chunyan.zhang@unisoc.com>
Subject: Re: [PATCH V2] clk: sprd: set max_register according to mapping range
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
To:     Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Michael Turquette <mturquette@baylibre.com>
Date:   Thu, 16 Mar 2023 16:40:02 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chunyan Zhang (2023-03-15 19:36:24)
> In sprd clock driver, regmap_config.max_register was set to a fixed value
> which is likely larger than the address range configured in device tree,
> when reading registers through debugfs it would cause access violation.
>=20
> Fixes: d41f59fd92f2 (clk: sprd: Add common infrastructure)
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> ---

Applied to clk-fixes
