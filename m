Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F32AA5EDDDB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 15:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234096AbiI1NjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 09:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234151AbiI1Nin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 09:38:43 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2FAA4B2E;
        Wed, 28 Sep 2022 06:38:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id F4118CE1E77;
        Wed, 28 Sep 2022 13:38:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB624C433C1;
        Wed, 28 Sep 2022 13:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664372296;
        bh=QcHofT14wPhfiRplf578gZRladg0Y1dvJweE2jk5O2E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JMs0EWanBHAivoc1Ta4sas9yD206ne6HPGvj3K/qgrt2FmiJ9pReyVHPhHsqzrqEU
         kjoeACatCRQ15WFt5fUXfrG0synhOLkv2xC0qyCYDfnFlV6bWdWSuxPkGci7burnfO
         BBFLbhzkouhSqELfxqB1no/d2WVMwPL8qMjq54+IrV1WvQIHWXVYJoGndKHQc1fAYU
         RBMV8psyh59D/ZRx+MuKnPFxdUAAZjlSPZuG3eDb42nh6jQtmmPksq2sCAzP2QGC2q
         ESMM0j53CnOle0TZeUZ0C7U1yfIbAHYPqjDirRLNaXHWPOrSFSNgPr7lYDPKQ6vXIi
         VIB2ff0r+VWZg==
Date:   Wed, 28 Sep 2022 14:38:09 +0100
From:   Lee Jones <lee@kernel.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCHv3 01/14] mfd: rk808: convert to device managed resources
Message-ID: <YzROQZ2L1G1ax5Is@google.com>
References: <20220909175522.179175-1-sebastian.reichel@collabora.com>
 <20220909175522.179175-2-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220909175522.179175-2-sebastian.reichel@collabora.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 09 Sep 2022, Sebastian Reichel wrote:

> Fully convert the driver to device managed resources.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  drivers/mfd/rk808.c | 66 +++++++++++++++------------------------------
>  1 file changed, 22 insertions(+), 44 deletions(-)

For my own reference (apply this as-is to your sign-off block):

  Acked-for-MFD-by: Lee Jones <lee@kernel.org>

-- 
Lee Jones [李琼斯]
