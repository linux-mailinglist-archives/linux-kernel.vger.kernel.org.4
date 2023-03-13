Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 032636B712C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 09:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjCMI3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 04:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjCMI3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 04:29:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C9C427484;
        Mon, 13 Mar 2023 01:29:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 398FA6112A;
        Mon, 13 Mar 2023 08:29:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 199FDC433D2;
        Mon, 13 Mar 2023 08:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678696168;
        bh=7yIJHlo0hvQclG6eewScTQKZFwheqW4gP3Ye2BzBB9w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d1a0se5kj3K8HE3hJnyb0y4qW0jfgp4pRCSKMxJvQU5L3dFHFGztnLBy0Qnp8277l
         bS8lS4T9+WMTrJHtXeDLJ83/Ki0CftN7c/jsym3Lomg9SqY7Vn6AcfbRlLFdgLeOch
         Ru10NhLSN+Dtkk9RWYH01+3YmNfdKpS2W0R07HQGME9U0HZGxteweF0Pi7MKrh6YQy
         G7NKe2Bkgub5sw8z6yaBtrZbIOBvBq6/bMWhFhtrjWCwirnxuVmiRoBdRf2KcQT89r
         kWZV7pYHELlt6BiRakW2n/YS+AzeWL6DsAxXa357vL5GjxiNEcXwdk/lvhBBzBBdMB
         TW0YCpurXMhJw==
Date:   Mon, 13 Mar 2023 16:29:21 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/6] ARM: dts: imx6dl-yapp4: Use reset-gpios property name
Message-ID: <20230313082921.GP143566@dragon>
References: <20230210154855.3086900-1-michal.vokac@ysoft.com>
 <20230210154855.3086900-4-michal.vokac@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230210154855.3086900-4-michal.vokac@ysoft.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2023 at 04:48:52PM +0100, Michal Vokáč wrote:
> Use the gpios instead of gpio suffix that is mandated by the binding.
> This dtbs_check warning is fixed now:
> 
>   touchscreen@5c: Unevaluated properties are not allowed ('reset-gpio' was unexpected)
> 
> The reset signal worked correctly as both the "gpio" and "gpios" suffixes
> are actually allowed by the gpiolib.
> 
> Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>

Applied, thanks!
