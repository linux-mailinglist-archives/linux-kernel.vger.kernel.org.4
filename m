Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C84626A863B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 17:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbjCBQWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 11:22:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjCBQWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 11:22:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A267B55057;
        Thu,  2 Mar 2023 08:22:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4EEA5B81219;
        Thu,  2 Mar 2023 16:22:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6C74C4339C;
        Thu,  2 Mar 2023 16:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677774162;
        bh=8RXUV8bd1LKlHKCGBBvoZ3gMwk6ETdCYY1KHqKNMpKk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K8aKIlEZp/WmC3zFv+2wqFi0PHKtUsQ4ZZT/gmQY260fDwGApk9Lvkl2D03YVyidh
         T7s6RqcWFpX/N+f0w8SOfx1JQtpfBHSJvykzhqDHFbXniVl+7F6otDdELNN9twXnsC
         5iBSiiQglgd/OyHmorZR+Yfx2nmTlIZneZqU4JmbGzbvt9p5uoEcPSbrclarVwqL/D
         B7XmbqH7uDTMbXsPNmy97MifstVb1f1bRuU8ROiDnlIOiZq8gr88izKt4Q6ZEDcHsh
         WKwFDSsmvuksE0f/dSWH4PnnTa5+FIE+r3Yb5cphdyc1Ln9kqKvC1Y9QvwQHznXF61
         BKij30H12FbUA==
Date:   Thu, 2 Mar 2023 16:22:35 +0000
From:   Lee Jones <lee@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        shengfei Xu <xsf@rock-chips.com>
Subject: Re: [PATCHv6 09/11] pinctrl: rk805: add rk806 pinctrl support
Message-ID: <ZADNS9dqqbBE9Ohb@google.com>
References: <20230127181244.160887-1-sebastian.reichel@collabora.com>
 <20230127181244.160887-10-sebastian.reichel@collabora.com>
 <CACRpkdbQfaCX=ZbFQh3p_T3biWEex-QZofXTrbVKd5hYOzMAug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdbQfaCX=ZbFQh3p_T3biWEex-QZofXTrbVKd5hYOzMAug@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Jan 2023, Linus Walleij wrote:

> On Fri, Jan 27, 2023 at 7:13 PM Sebastian Reichel
> <sebastian.reichel@collabora.com> wrote:
> 
> > Add support for rk806 dvs pinctrl to the existing rk805
> > driver.
> >
> > This has been implemented using shengfei Xu's rk806
> > specific driver from the vendor tree as reference.
> >
> > Co-Developed-by: shengfei Xu <xsf@rock-chips.com>
> > Signed-off-by: shengfei Xu <xsf@rock-chips.com>
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> 
> Is this something I can just apply? I haven't had Heiko's review
> on it but it looks innocent enough.

Ack please. :)

-- 
Lee Jones [李琼斯]
