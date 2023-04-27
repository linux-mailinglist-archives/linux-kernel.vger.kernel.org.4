Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37E446F0A8F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 19:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243457AbjD0ROY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 13:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239857AbjD0ROV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 13:14:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3EE91990;
        Thu, 27 Apr 2023 10:14:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C81E63BB9;
        Thu, 27 Apr 2023 17:14:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BD2BC4339B;
        Thu, 27 Apr 2023 17:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682615659;
        bh=VxbpbS/ZvGtLooC7WKWDiaWh8HMGWlf144SHZLQ/yDo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n2EREdRnxzcw+CBcKzhsANF86pi/exGxJERUK0HG9s4/f2YDweC0DyA7rkG6MnzVj
         cHcjIgzU6D7hZ9h0lLe7OaKdmvu9a8fkY/eMgPepntaVjw0pA29LAFd/tz6S6ydUnK
         Vh1Qdg2dBHj6N9udyq2vEFawQCU3nVnp/J+PkX/3HPV+EsK+sXkxIPkkbW/xK2B10J
         UdiZKfKcGI0uchgQ5WbmsHvDMXA1/2alRSxoo7uxiTW9VI2UHbVd/vYrBVThC1xaTI
         pVGT/+ULJJNXlFKc8ogp3yd0ngwn4VtqHtWF0FJu+KPkg8yrJIo5WY0qoHX2LTUg9N
         hgZbO94gDhfkg==
Date:   Thu, 27 Apr 2023 18:14:14 +0100
From:   Lee Jones <lee@kernel.org>
To:     "larry.lai" <larry.lai@yunjingtech.com>
Cc:     andriy.shevchenko@linux.intel.com, linus.walleij@linaro.org,
        pavel@ucw.cz, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-leds@vger.kernel.org,
        GaryWang@aaeon.com.tw, musa.lin@yunjingtech.com,
        jack.chang@yunjingtech.com, noah.hung@yunjingtech.com,
        michael.wang@yunjingtech.com, Javier Arteaga <javier@emutex.com>,
        Nicola Lunghi <nicola.lunghi@emutex.com>
Subject: Re: [RFC RESEND 1/3] mfd: Add support for UP board CPLD/FPGA
Message-ID: <20230427171414.GE620451@google.com>
References: <20230425152135.30745-1-larry.lai@yunjingtech.com>
 <20230425152135.30745-2-larry.lai@yunjingtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230425152135.30745-2-larry.lai@yunjingtech.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Apr 2023, larry.lai wrote:

> The UP Squared board <http://www.upboard.com> implements certain
> features (pin control, onboard LEDs or CEC) through an on-board CPLD/FPGA.
> 
> This mfd driver implements the line protocol to read and write registers
> from the FPGA through regmap. The register address map is also included.
> 
> The UP Boards provide a few I/O pin headers (for both GPIO and
> functions), including a 40-pin Raspberry Pi compatible header.
> 
> This patch implements support for the FPGA-based pin controller that
> manages direction and enable state for those header pins.
> 
> Partial support UP boards:
> * UP core + CREX
> * UP core + CRST02
> 
> Signed-off-by: Javier Arteaga <javier@emutex.com>
> [merge various fixes]
> Signed-off-by: Nicola Lunghi <nicola.lunghi@emutex.com>

> Reviewed-by: Lee Jones <lee@kernel.org>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Wait, what?!

When did Andy or I provide you with Reviewed-by tags?

You must to apply any tag that isn't explicitly provided to you.

> Signed-off-by: larry.lai <larry.lai@yunjingtech.com>
> ---
> RFC 2022/11/23 -> RFC 2023/04/25
> (1) Refer 2022/12/08 Andy Shevchenko review, cleaned up coding style
> and addressed review comments.
> PATCH V3 -> RFC 2022/11/23:
> (1) Refer 2022/11/16 Lee Jones review, cleaned up coding style and
> addressed review comments.
> (2) Description on the UP Boards FPGA register read/write protocols
> PATCH V2 -> V3:
> (1) fixed kernel test robot compiler warning
> PATCH V1 -> V2:
> (1) Synchronizing upboard github to rc2
> (2) Refer 2022/10/31 Lee Jones review, fixed some of the issues.
> ---
> ---
>  drivers/mfd/Kconfig              |  12 +
>  drivers/mfd/Makefile             |   1 +
>  drivers/mfd/upboard-fpga.c       | 527 +++++++++++++++++++++++++++++++
>  include/linux/mfd/upboard-fpga.h |  61 ++++
>  4 files changed, 601 insertions(+)
>  create mode 100644 drivers/mfd/upboard-fpga.c
>  create mode 100644 include/linux/mfd/upboard-fpga.h

I'm not even going to try and review this (again).

Looking at the subject line, this is patch is masquerading as a RESEND
of an unreviewed v1.  However, at best this is a RESEND of a reviewed
(which was ignored) v3, perhaps even just a straight v4.

Either way, it appears as though the review comments you received in v3
were ignored.  Please go back and fix those before submitting v5,
thanks.

-- 
Lee Jones [李琼斯]
