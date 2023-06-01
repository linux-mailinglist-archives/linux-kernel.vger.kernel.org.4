Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C238371944F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 09:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232008AbjFAHbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 03:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232006AbjFAHa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 03:30:59 -0400
Received: from the.earth.li (the.earth.li [IPv6:2a00:1098:86:4d:c0ff:ee:15:900d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3130134;
        Thu,  1 Jun 2023 00:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
        s=the; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=5R1BHC0gXtbz/0Z2uW7Pc5h9Efmbp8Ceo5/wsspQkEM=; b=NwaiNQQaonrok2bcrK9PdEqsDW
        ki1pWFn/jaST9w8KfVTlfJNmvoheojlmbgcfnkOhU5SzZ7VFpfQMTvxzMkTdDDX/T0b3O0/yB6jCl
        WivI0/XnMx/74gFgrtZDK4aiqYDx9HQC+XRYzS9BHRBXj+oH76975bI6BYFxNaYl6AJLkY9W4EBMI
        N6VL7gpwRbiiDnTEDm+/7LI28q11+2sfdQ036PlL/KbafJ0xbLiapaVK3HrvRTryuDk/jHPyiU0M+
        oOYBAKsAhBXAAqEybqnPRbge/G9Rg/0jAFo4ZWoiRbQMpNQXtfP29Z0bGDGGRPpWJGI6C37EUqJyN
        F0D5ci8g==;
Received: from noodles by the.earth.li with local (Exim 4.94.2)
        (envelope-from <noodles@earth.li>)
        id 1q4clZ-00FO5U-6b; Thu, 01 Jun 2023 08:30:37 +0100
Date:   Thu, 1 Jun 2023 08:30:37 +0100
From:   Jonathan McDowell <noodles@earth.li>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2 2/5] pinctrl: axp209: Add support for GPIO3 on the
 AXP209
Message-ID: <ZHhJHQl+/oVeLOOO@earth.li>
References: <cover.1681580558.git.noodles@earth.li>
 <cover.1683719613.git.noodles@earth.li>
 <f9b643ff0d0ed770f5a841111f213f8481dc920f.1683719613.git.noodles@earth.li>
 <CACRpkdb-wp2631KphG+iwnVaYk0Sm9JCLpoz1DuSQd4jXvEdAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdb-wp2631KphG+iwnVaYk0Sm9JCLpoz1DuSQd4jXvEdAg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2023 at 11:51:46AM +0200, Linus Walleij wrote:
> On Wed, May 10, 2023 at 2:01 PM Jonathan McDowell <noodles@earth.li> wrote:
> > The AXP209 device has a 4th GPIO which has a slightly different register
> > setup, where the control + status bits are held in a single register
> > rather than sharing AXP20X_GPIO20_SS with GPIOs 0-2.
> >
> > Signed-off-by: Jonathan McDowell <noodles@earth.li>
> 
> This patch 2/5 applied to the pinctrl tree.
> 
> I just assume it is fine to apply this one patch, Bartosz already
> applied the binding patch.
> 
> Tell me if this works.

Everything else seems to have been picked up, so that works for me.


J.

-- 
Revd Jonathan McDowell, ULC | Even the Evening Herald slags me off.
