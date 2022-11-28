Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4C0563A57C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 10:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbiK1J4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 04:56:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiK1J4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 04:56:11 -0500
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F9619297;
        Mon, 28 Nov 2022 01:56:08 -0800 (PST)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id DFB422006;
        Mon, 28 Nov 2022 10:56:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1669629366;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q6/UvepOOYPsvbSImDw9v/sYqkOjQsUVqAxKEdeyGck=;
        b=1n+dwQGnfZDPS4xivA1Tzub14oqg5WEWQdx1vUfOZfjamggMGF1WEBquaHdwYGEGBxJRFi
        gMlAmgVHZGgEfaVZy4/0T1CXd99Ozd0QmwKNeag8VKQUK3BFWLSNjtI6EPbSa+pJtxwZU3
        2QXpDFv9sMaxotsi6591RrsJfCa2OobwYU/HiOJ4FbAZ6TpiFq483BVhsTzKJwpyLhWf5E
        1WZ0XUNkRP2x6cXjn5xSxxGD90vri68JsxcjgBYQoLbykeuSLDJoA8RSvd/FtOG15OipT5
        6xMRb5TdonSwjwVXjoZyZPYdNOfnRfa6N5Ylko3atYyrPHccMkH3+qmBYyrr+w==
MIME-Version: 1.0
Date:   Mon, 28 Nov 2022 10:56:06 +0100
From:   Michael Walle <michael@walle.cc>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     William Breathitt Gray <william.gray@linaro.org>,
        linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org
Subject: Re: [PATCH v3 3/9] gpio: 104-dio-48e: Migrate to the regmap-irq API
In-Reply-To: <Y4SCZKr3uEXTQmHZ@smile.fi.intel.com>
References: <cover.1669100542.git.william.gray@linaro.org>
 <80fc819bcafe9697b6e02c0750d3cf0ea4ec9e1b.1669100542.git.william.gray@linaro.org>
 <Y3414YhVjqKakddV@smile.fi.intel.com> <Y3ykg1Vc96Px6ovg@fedora>
 <3a23df35a35cdba19eeb10c75b5bca97@walle.cc>
 <Y4SCZKr3uEXTQmHZ@smile.fi.intel.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <74fb9467d82cc55e74468459984e9090@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2022-11-28 10:41, schrieb Andy Shevchenko:
> Of course there are drivers that are using it and it's not in
> their ->probe():s

I was speaking of gpio drivers which use the regmap-irq stuff. I
couldn't find any which are using {devm_,}regmap_add_irq_chip*()
and gpiochip.init_hw().

-michael
