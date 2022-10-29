Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BDBF612263
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 13:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbiJ2L25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 07:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiJ2L2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 07:28:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D6268893;
        Sat, 29 Oct 2022 04:28:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C203F60C85;
        Sat, 29 Oct 2022 11:28:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE4D5C433D6;
        Sat, 29 Oct 2022 11:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667042934;
        bh=DFj2qb6zfl0yMBOm4TqcZAJBhm4CB+DeYfezVBfdnU8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=of3d9sAmohCh+nH4/qjgKWHYrQ37o5CeBo9C+wbQSyeJ0mDrkV71fWkh0vWX4HJVO
         34ZMrVZUuDNJ3kYtyNaRz4wz3MxODynwZVCBzQsXYZh1ZJ2UYaFtVc/V2SXmkqXVxn
         VQTs339IH5Vax0uWvB1tD+IuFSaiahRPtb2IeTfLM9gmd28PfPAik1EJ+FmSgCz+UO
         PDiHXHmgL/bdxL95n4Sz5iWtccjWRq8pOJ52lJBfioRomk4pRlVIErKAtq7kt6tPme
         ch3vm9zQokKeMUYD9Mjux8OtV+mN28gRI5lIIyKfrTMy9UgiRXFY64VIolKHe9L4oL
         s3ljGRbcP/2LA==
Date:   Sat, 29 Oct 2022 12:40:48 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mitja Spes <mitja@lxnav.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Lee Jones <lee.jones@linaro.org>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>,
        Tomasz Duszynski <tduszyns@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] ms5611 sensor value bug fix; dt-binding fix
Message-ID: <20221029124048.372aed3b@jic23-huawei>
In-Reply-To: <20221021135827.1444793-1-mitja@lxnav.com>
References: <20221021135827.1444793-1-mitja@lxnav.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Oct 2022 15:58:19 +0200
Mitja Spes <mitja@lxnav.com> wrote:

> Subject: [PATCH 0/3] ms5611 sensor value bug fix; dt-binding fix
> 
> The first patch fixes a bug in ms5611 iio driver where PROM value
> compensation table was overwritten by the last initialized sensor.
> This in turn produced wrong values when multiple sensors were used.
> 
> Second patch removes the hardcoded SPI frequency and uses the setting
> from dt-bindings.
> 
> Third patch outlines the change from the second patch in the bindings
> example.

1+2 applied to the fixes-togreg branch of iio.git and marked for
stable.

Thanks,

Jonathan

> 
> v2:
> 
> [PATCH 1-2]
> * no change
> 
> [PATCH 3]
> * corrected patch subject
> 
> Mitja Spes (3):
>   iio: pressure: ms5611: fixed value compensation bug
>   iio: pressure: ms5611: changed hardcoded SPI speed to value limited
>   dt-bindings: iio: pressure: meas,ms5611: add max SPI frequency to the
>     example
> 
>  .../bindings/iio/pressure/meas,ms5611.yaml    |  1 +
>  drivers/iio/pressure/ms5611.h                 | 12 ++---
>  drivers/iio/pressure/ms5611_core.c            | 51 ++++++++++---------
>  drivers/iio/pressure/ms5611_spi.c             |  2 +-
>  4 files changed, 33 insertions(+), 33 deletions(-)
> 

