Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6755B461D
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 13:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbiIJLqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 07:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiIJLq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 07:46:28 -0400
Received: from soltyk.jannau.net (soltyk.jannau.net [144.76.91.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A8811172;
        Sat, 10 Sep 2022 04:46:27 -0700 (PDT)
Received: by soltyk.jannau.net (Postfix, from userid 1000)
        id 781C126F009; Sat, 10 Sep 2022 13:46:26 +0200 (CEST)
Date:   Sat, 10 Sep 2022 13:46:26 +0200
From:   Janne Grunau <j@jannau.net>
To:     asahi@lists.linux.dev
Cc:     Mark Kettenis <kettenis@openbsd.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Hector Martin <marcan@marcan.st>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sven Peter <sven@svenpeter.dev>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 08/10] arm64: dts: apple: Add J375 devicetrees
Message-ID: <20220910114626.GE4024@jannau.net>
References: <20220909135103.98179-1-j@jannau.net>
 <20220909135103.98179-9-j@jannau.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909135103.98179-9-j@jannau.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-09-09 15:51:01 +0200, Janne Grunau wrote:
> These are the Mac Studio devices with M1 Max (t6001) and
> M1 Ultra (t6002).
> 
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
> 
>  arch/arm64/boot/dts/apple/Makefile        |   2 +
>  arch/arm64/boot/dts/apple/t6001-j375c.dts |  18 ++++
>  arch/arm64/boot/dts/apple/t6002-j375d.dts |  50 ++++++++++
>  arch/arm64/boot/dts/apple/t600x-j375.dtsi | 115 ++++++++++++++++++++++
>  4 files changed, 185 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/apple/t6001-j375c.dts
>  create mode 100644 arch/arm64/boot/dts/apple/t6002-j375d.dts
>  create mode 100644 arch/arm64/boot/dts/apple/t600x-j375.dtsi

...

> diff --git a/arch/arm64/boot/dts/apple/t600x-j375.dtsi b/arch/arm64/boot/dts/apple/t600x-j375.dtsi
> new file mode 100644
> index 000000000000..c5444cb34389
> --- /dev/null
> +++ b/arch/arm64/boot/dts/apple/t600x-j375.dtsi
> @@ -0,0 +1,115 @@
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
> +/*
> + * Mac Studio (2022)
> + *
> + * This file contains the parts common to J375 devices with both t6001 and t6002.
> + *
> + * target-type: J375c / J375d
> + *
> + * Copyright The Asahi Linux Contributors
> + */
> +
> +/dts-v1/;

This stray "/dts-v1/;" has been removed locally from the .dtsi file, 
fixing a build error.

Janne
