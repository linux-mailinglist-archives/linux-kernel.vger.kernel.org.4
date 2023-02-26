Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01C016A2FD1
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 14:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjBZN1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 08:27:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjBZN1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 08:27:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B5B9DBF4;
        Sun, 26 Feb 2023 05:27:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD73F60C16;
        Sun, 26 Feb 2023 13:27:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D1AAC433D2;
        Sun, 26 Feb 2023 13:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677418057;
        bh=Ae0Hdg9ZWuA1sN5X/2SiqkpL5F27wBz4IFOo78e6q/I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Bhk5EhdCPDXdGrxCWopceEu985Ks4pIxX9S0VCLVlOfCOEUDuTLYuKH0bO0Y6vtgY
         c6q2GLJ4dToKJK3gPVUw0I5il4V8YhRbfpX7IvQq9vs4nYxAJOK2VmFUMxQIM3HElU
         y9ost3sJdixZHUBqwzSTeCQuCzdnQcvhHzY9atg9hSaNeFjZyAD82/4nkflfAjIHlc
         Rx7mPc14afMCa3XWifr2ZjQcxTbAHCbbCNuK9T6yPp1kHIj6dlNz743X9E05VQaTP7
         9mixcaDOAQY0GZgNi/vrZ57q4EerzViVFs2tf1D2ntt3nTGvIEgcKZKLNd5penYi2T
         AQW5W+X+5BmNQ==
Date:   Sun, 26 Feb 2023 13:42:00 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Liam Beguin <liambeguin@gmail.com>,
        Peter Rosin <peda@axentia.se>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 6/6] MAINTAINERS: Add ROHM BU27034
Message-ID: <20230226134200.423649e1@jic23-huawei>
In-Reply-To: <8dbdf68749389605cc4dff396ddd66d27fdb2a0d.1677080089.git.mazziesaccount@gmail.com>
References: <cover.1677080089.git.mazziesaccount@gmail.com>
        <8dbdf68749389605cc4dff396ddd66d27fdb2a0d.1677080089.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Feb 2023 18:16:18 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> Add myself as a maintainer for ROHM BU27034 ALS driver.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> ---
>  MAINTAINERS | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 43f5a024daa2..8d31ef852372 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18090,6 +18090,11 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/iio/light/bh1750.yaml
>  F:	drivers/iio/light/bh1750.c
>  
> +ROHM BU27034 AMBIENT LIGHT SENSOR DRIVER
> +M:	Matti Vaittinen <mazziesaccount@gmail.com>
Whilst the wild cards stuff for IIO should also catch this, it's (fairly)
conventional to still add the list entry to make it easy for
people reading the file directly.

We are a bit inconsistent on it though.

> +S:	Supported
> +F:	drivers/iio/light/rohm-bu27034.c
> +
>  ROHM MULTIFUNCTION BD9571MWV-M PMIC DEVICE DRIVERS
>  M:	Marek Vasut <marek.vasut+renesas@gmail.com>
>  L:	linux-kernel@vger.kernel.org

