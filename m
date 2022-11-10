Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6FB623C84
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 08:18:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232259AbiKJHSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 02:18:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbiKJHSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 02:18:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377032A251;
        Wed,  9 Nov 2022 23:18:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D0E9DB820DF;
        Thu, 10 Nov 2022 07:18:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B128C433D6;
        Thu, 10 Nov 2022 07:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668064716;
        bh=+mje26SHntEM/1VqQyYcgj+5RQdpwiHgDT41ahrofKY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HNEAJWM1/6DAN46RYDPjAlRcfr4IawN1EUhI7ZTCAIus5sylAbiqkD8bs1/RwTXiW
         pQCct+YWDPkXpTljyP2MRAs7HbJgAeoEEE484tzuR/Kc0IvPF9FJcBhmBRCEnlUkJJ
         02/ET2RJOe7KxdpDM/EUzykIq4Goc4LgDnDmhe+75iXWe7ntkIU8Yw26v3q3R0VbCR
         RP3HI8X4tmrGCQUE6Mu+zohmZAiP9AJTzDQM0VZ/NfJT3neuQ2iDenlPQCWt62kNtu
         xH1bxMqw5M6qnJ+9/njqHa7UvwwJa614Hu7H+lDaptOX2RXGpNRfezqTx5rC9vMI0a
         xUUUbr0jfGEkQ==
Date:   Thu, 10 Nov 2022 15:18:28 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Alistair Francis <alistair@alistair23.me>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linus.walleij@linaro.org,
        robh+dt@kernel.org, dmitry.torokhov@gmail.com, rydberg@bitmath.org,
        alistair23@gmail.com, s.hauer@pengutronix.de, andreas@kemnade.info
Subject: Re: [PATCH v10 3/4] ARM: imx_v6_v7_defconfig: Enable the cyttsp5
 touchscreen
Message-ID: <20221110071828.GD125525@dragon>
References: <20221026114908.191472-1-alistair@alistair23.me>
 <20221026114908.191472-4-alistair@alistair23.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221026114908.191472-4-alistair@alistair23.me>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 26, 2022 at 09:49:07PM +1000, Alistair Francis wrote:
> The imx6/7 based devices Remarkable 2, Kobo Clara HD, Kobo Libra H2O,
> Tolino Shine 3, Tolino Vision 5 all contain a Cypress TT2100
> touchscreen so enable the corresponding driver.
> 
> Signed-off-by: Alistair Francis <alistair@alistair23.me>

Applied, thanks!
