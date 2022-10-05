Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A88695F5CFE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 01:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbiJEXCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 19:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiJEXCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 19:02:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4062B85599;
        Wed,  5 Oct 2022 16:02:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BCC2B617E6;
        Wed,  5 Oct 2022 23:02:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A24CC433C1;
        Wed,  5 Oct 2022 23:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665010934;
        bh=zAhxaN/puxBBRzAqxbPmu5dfVHwdi+dZAefdvkKN7EI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=ZRVK958HBYz3PlbIuewp5kZqsw9ZAd0FiWzvErQEroEGmw8IDCuvbOj5QCyWYsLmn
         LfPbroyjDV0IYRhKwu/5OufzqLKnV9uaNhVrnxJKXPf6tuKzex8qhK388a1hB9SeX5
         IK9m77XiZmnNkx6/yuB0IhxSKbm2Cg5eEKKxLCD/3I0TvLrqhVVisY6QvsuKc8Z1t/
         AFulzW2coShpbYD/M/S30dOup0HZHIcEUzX5gGZmFzuTTXyK71rUvD0SL4rtLN3EGL
         k5ZoElPNqllKRufZ0Y/bBAkZ2R8l0l6SH7fwR/8hDaIVldcFWITrRoRLXBsSmHDt2/
         F29IOGtX7W9Jw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20221005085305.42075-2-romain.perier@gmail.com>
References: <20221005085305.42075-1-romain.perier@gmail.com> <20221005085305.42075-2-romain.perier@gmail.com>
Subject: Re: [PATCH RESEND v6 1/1] clk: mstar: msc313 cpupll clk driver
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Willy Tarreau <w@1wt.eu>
To:     Daniel Palmer <daniel@0x0f.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Romain Perier <romain.perier@gmail.com>,
        linux-clk@vger.kernel.org
Date:   Wed, 05 Oct 2022 16:02:12 -0700
User-Agent: alot/0.10
Message-Id: <20221005230214.1A24CC433C1@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Romain Perier (2022-10-05 01:53:05)
> From: Daniel Palmer <daniel@0x0f.com>
>=20
> Add a driver for the CPU pll/ARM pll/MIPS pll that is present
> in MStar SoCs.
>=20
> Currently there is no documentation for this block so it's possible
> this driver isn't entirely correct.
>=20
> Only tested on the version of this IP in the MStar/SigmaStar
> ARMv7 SoCs.
>=20
> Signed-off-by: Daniel Palmer <daniel@0x0f.com>
> Co-developed-by: Willy Tarreau <w@1wt.eu>
> Signed-off-by: Willy Tarreau <w@1wt.eu>

Missing Signed-off-by Romain.
