Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69CF562F55D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 13:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235142AbiKRMw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 07:52:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiKRMwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 07:52:54 -0500
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6F37A1AF09;
        Fri, 18 Nov 2022 04:52:51 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id C0373807E;
        Fri, 18 Nov 2022 12:42:44 +0000 (UTC)
Date:   Fri, 18 Nov 2022 14:52:49 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Maxim Korotkov <korotkov.maxim.s@gmail.com>
Cc:     Haojian Zhuang <haojian.zhuang@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: Re: [PATCH] pinctrl: single: fix potential NULL dereference
Message-ID: <Y3eAIb7x6de9Bigy@atomide.com>
References: <20221118104332.943-1-korotkov.maxim.s@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221118104332.943-1-korotkov.maxim.s@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Maxim Korotkov <korotkov.maxim.s@gmail.com> [221118 10:33]:
> Added checking of pointer "function" in pcs_set_mux().
> pinmux_generic_get_function() can return NULL and the pointer
> "function" was dereferenced without checking against NULL.

Reviewed-by: Tony Lindgren <tony@atomide.com>
