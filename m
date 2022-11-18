Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBA0562EF04
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 09:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241082AbiKRIP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 03:15:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiKRIPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 03:15:24 -0500
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D7AD113DDA;
        Fri, 18 Nov 2022 00:15:23 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id A89C0807E;
        Fri, 18 Nov 2022 08:05:17 +0000 (UTC)
Date:   Fri, 18 Nov 2022 10:15:21 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Maxim Korotkov <korotkov.maxim.s@gmail.com>
Cc:     Haojian Zhuang <haojian.zhuang@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Manjunathappa, Prakash" <prakash.pm@ti.com>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: Re: [PATCH] pinctrl: single: Fix potential division by zero
Message-ID: <Y3c/GSZEW60ZgSkM@atomide.com>
References: <20221117123034.27383-1-korotkov.maxim.s@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117123034.27383-1-korotkov.maxim.s@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Maxim Korotkov <korotkov.maxim.s@gmail.com> [221117 12:22]:
> There is a possibility of dividing by zero due to the pcs->bits_per_pin
> if pcs->fmask() also has a value of zero and called fls
> from asm-generic/bitops/builtin-fls.h or arch/x86/include/asm/bitops.h.
> The function pcs_probe() has the branch that assigned to fmask 0 before
> pcs_allocate_pin_table() was called

Reviewed-by: Tony Lindgren <tony@atomide.com>
