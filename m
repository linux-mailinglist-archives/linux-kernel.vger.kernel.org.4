Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF960636B6D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 21:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238488AbiKWUmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 15:42:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239053AbiKWUmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 15:42:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C491F14085;
        Wed, 23 Nov 2022 12:42:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6F32EB81F03;
        Wed, 23 Nov 2022 20:42:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 868BDC433D6;
        Wed, 23 Nov 2022 20:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669236160;
        bh=ujHw+aEUaI4XEXzsza7m4fXJuhYYTP3KGc3pezOt4Lk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jjkc+E6u03YiMaWa9vMg2/eu7K42pLsepaYdDYazo9KpOFLTpcU+ecS+d4ldCWoMN
         /Rlvrbx2TRDlF5v1x3GfzDAgyQzBV+w1855yhwf4JfWswZoIE4LuDZ0c40H95hRvAX
         7Gbd9ql864Okc574/FZANW5SHPrsTIx4nJ7mVv46NuC6cI0PFfFlddR3Hb3jQPJOJp
         gCLW0sdWhvoHgr3N6TFtKYtrljT2kM2TFq5bW0gdsz6xnxb2u5+YZqArtdJGeMSj5F
         rIgi1Opi77XwvYHeOZu18Hiv0XsiPPzhorVlQ9wdx4IUoBO9L7U6YZdjPzfs6yl2yz
         kjHgXB9Oin6lw==
Date:   Wed, 23 Nov 2022 20:55:12 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 0/3] iio: addac: ad74413r: add spi device id table,
 support reset gpio
Message-ID: <20221123205512.5db9bc08@jic23-huawei>
In-Reply-To: <20221115095517.1008632-1-linux@rasmusvillemoes.dk>
References: <20221111143921.742194-1-linux@rasmusvillemoes.dk>
        <20221115095517.1008632-1-linux@rasmusvillemoes.dk>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

On Tue, 15 Nov 2022 10:55:14 +0100
Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:

> Fix a run-time warning from the SPI core by providing a spi_device_id
> table, and add binding and driver support for a reset gpio.
> 
> v2:
> - drop the two patches related to refin-supply
> - fall back to getting device data from the spi_device_id entry
> - update the example in the binding with a reset-gpios entry
> - fix a style nit

Series applied to the togreg branch of iio.git.  They might get one
day soaking as testing before I push them out to get some linux-next
coverage or I might skip that bit.

Thanks,

Jonathan

> 
> Rasmus Villemoes (3):
>   iio: addac: ad74413r: add spi_device_id table
>   dt-bindings: iio: ad74413r: add optional reset-gpios
>   iio: addac: ad74413r: add support for reset-gpio
> 
>  .../bindings/iio/addac/adi,ad74413r.yaml      |  4 +++
>  drivers/iio/addac/ad74413r.c                  | 29 +++++++++++++++++++
>  2 files changed, 33 insertions(+)
> 

