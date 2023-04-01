Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58F5A6D32F3
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 19:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjDARnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 13:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjDARnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 13:43:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC3CB756;
        Sat,  1 Apr 2023 10:43:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B7B63B80D3F;
        Sat,  1 Apr 2023 17:43:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E5E6C433EF;
        Sat,  1 Apr 2023 17:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680371023;
        bh=WfC/iX0dEb4xGbqcFGvTTanaYnEtENKY3q2ER9Z5Bww=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=r9hjNriWYxS8YrR+N1Rw/vbG1WQEXLMu4Vbw29KsUQehBiujZ2DCjohci0vf/Ls5U
         s+v8kPZXp/rAPybtaCAFunqeEnbx+x39EU3lPGoYpDzu9azCGHb38Pg9eVArv1ogn4
         dY4VCQRNt8qqY/6MVE/D1T/uBGt+mqFFwYunoIwJxwxedRPbiIjZy3A8jt2azL3gTt
         iPh5WRfJDa0KHxFih4VU1W1ClsRD7sd1eSrX76KfKeEWlQBvI/n5nzpPTKZENO4BOB
         B8qfijv78akMRC4huy2GAY1WhjRkr11dt5bbN+MPpgvvjoKsMALNzANygMYTByOhTI
         aubkU8m03Gdew==
Date:   Sat, 1 Apr 2023 18:58:52 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v7 2/5] MAINTAINERS: Add IIO gain-time-scale helpers
Message-ID: <20230401185852.4290b50c@jic23-huawei>
In-Reply-To: <d46414eabe8dd4cd3edb15f859f3b93cd406d9aa.1680263956.git.mazziesaccount@gmail.com>
References: <cover.1680263956.git.mazziesaccount@gmail.com>
        <d46414eabe8dd4cd3edb15f859f3b93cd406d9aa.1680263956.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Mar 2023 15:41:06 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> Add myself as a maintainer for IIO light sensor helpers (helpers for
> maintaining the scale while adjusting intergration time or gain) and
> related Kunit tests.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> ---
> RFCv1 =>
> - No changes
> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ec57c42ed544..6ec9326f4ce9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9938,6 +9938,14 @@ F:	Documentation/ABI/testing/sysfs-bus-iio-adc-envelope-detector
>  F:	Documentation/devicetree/bindings/iio/adc/envelope-detector.yaml
>  F:	drivers/iio/adc/envelope-detector.c
>  
> +IIO LIGHT SENSOR GAIN-TIME-SCALE HELPERS
> +M:	Matti Vaittinen <mazziesaccount@gmail.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Maintained
> +F:	drivers/iio/light/gain-time-scale-helper.c
> +F:	drivers/iio/light/gain-time-scale-helper.h
> +F:	drivers/iio/test/iio-test-gts.c

Not yet.  If that's all that comes up I'll drop that line whilst
applying.

> +
>  IIO MULTIPLEXER
>  M:	Peter Rosin <peda@axentia.se>
>  L:	linux-iio@vger.kernel.org

