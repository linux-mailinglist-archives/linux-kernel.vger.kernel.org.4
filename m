Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D40FD601C70
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 00:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbiJQWam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 18:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbiJQWaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 18:30:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586A08263C;
        Mon, 17 Oct 2022 15:30:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0B815B81B37;
        Mon, 17 Oct 2022 22:29:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D71DC433C1;
        Mon, 17 Oct 2022 22:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666045741;
        bh=a0hL4DAeU1uv9+yPBashvADErL0rcOpOfClpiG5iyJU=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=fR2jHtQzIpr4Uo8B1sFIglt9bmHNiGUckCOd6dd2HFnOva6qD1cyvEMzH3KVcotJ1
         B2NzcG+z7iElo1R0kLDYU7ptO3GuqL3KuRPvmgLaW3kPPvErBcPT74/C9t7tWqGkjt
         kmRslexsGUxhPasjAduMYPG3yrnOnyoz2FPQDvwD2zAyfgO2Iinnm2jljKAytSPjza
         mcHjPsSLTaMEPHNTb039+Dh6jYL8a3QJ5vT6wPPf9bsKUD9fdjo4J3D2aB3khe4Fel
         5/veLdB+RmvJ/7V3aZPAUTp8TUfkKH6lYg5Uikdq0/KVjNIv+42UaSlXlIOCo9Z7RR
         Zp99bDMLAGhXQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <bdc9c89317b5d338a6c4f1d49386b696e947a672.1665642720.git.rtanwar@maxlinear.com>
References: <cover.1665642720.git.rtanwar@maxlinear.com> <bdc9c89317b5d338a6c4f1d49386b696e947a672.1665642720.git.rtanwar@maxlinear.com>
Subject: Re: [PATCH v4 3/4] clk: mxl: Add option to override gate clks
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-lgm-soc@maxlinear.com,
        Rahul Tanwar <rtanwar@maxlinear.com>
To:     Rahul Tanwar <rtanwar@maxlinear.com>, linux-clk@vger.kernel.org,
        mturquette@baylibre.com, yzhu@maxlinear.com
Date:   Mon, 17 Oct 2022 15:28:59 -0700
User-Agent: alot/0.10
Message-Id: <20221017222901.9D71DC433C1@smtp.kernel.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rahul Tanwar (2022-10-12 23:48:32)
> In MxL's LGM SoC, gate clocks can be controlled either from CGU clk driver
> i.e. this driver or directly from power management driver/daemon. It is
> dependent on the power policy/profile requirements of the end product.
>=20
> To support such use cases, provide option to override gate clks enable/di=
sable
> by adding a flag GATE_CLK_HW which controls if these gate clks are contro=
lled
> by HW i.e. this driver or overridden in order to allow it to be controlled
> by power profiles instead.
>=20
> Reviewed-by: Yi xin Zhu <yzhu@maxlinear.com>
> Signed-off-by: Rahul Tanwar <rtanwar@maxlinear.com>
> ---

Applied to clk-next
