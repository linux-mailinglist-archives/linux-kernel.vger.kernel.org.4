Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2775B658E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 04:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbiIMCYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 22:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbiIMCYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 22:24:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E85DD0;
        Mon, 12 Sep 2022 19:24:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A42B612CE;
        Tue, 13 Sep 2022 02:24:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 048A5C43470;
        Tue, 13 Sep 2022 02:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663035876;
        bh=tSUVqagejTTQFNc/fHvohjFQ0Cm3n0W/NExp2yGcDww=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S5w/NYuCcBv2d+rjsBCaNInfLCTXWlRFjCOt3I3d+kNlxIIQvfLOoZaMR4sGl8lKI
         d9OhG/MQ5kath2p3D7Vf7jJabn5VJZZFKxkuVJHLen5jpdl2UP/xA5ETw3tb+VDUFE
         PnZI7iG2RwqebAlPmJKN5nDxm4vKpDTqGjPXeStZ1+YdkCzB5DKyQq3YqQEq51V9Uc
         Cszbms6MYE3jJiJNoP9PS4P4DIYaKXtukSeLDh0lGLowoC4L6skNhkFjL5YuuSYR1L
         bb5G8RX9xWCLtT9N6j8hflutgFQ6HfSLp/a/b1JXezQxV6pr9WxFBI+a98Cf0DXAIQ
         GFtSHjyGdGZCg==
Date:   Tue, 13 Sep 2022 10:24:30 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 1/5] arm64: dts: imx8mp-venice-gw74xx: fix CAN STBY
 polarity
Message-ID: <20220913022430.GG1728671@dragon>
References: <20220912180836.773729-1-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220912180836.773729-1-tharvey@gateworks.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2022 at 11:08:32AM -0700, Tim Harvey wrote:
> The CAN STBY poarlity is active-low. Specify it as such by removing the
> 'enable-active-high' property and updating the gpio property.
> 
> Fixes: 7899eb6cb15d ("arm64: dts: imx: Add i.MX8M Plus Gateworks gw7400 dts support")
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Applied all, thanks!
