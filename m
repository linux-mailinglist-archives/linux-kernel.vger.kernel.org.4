Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4546B24B8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 13:58:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbjCIM6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 07:58:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbjCIM5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 07:57:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC70F20B5;
        Thu,  9 Mar 2023 04:57:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B88661B36;
        Thu,  9 Mar 2023 12:57:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4162DC4339B;
        Thu,  9 Mar 2023 12:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678366625;
        bh=i/LtRm/+xPkilVIoFGYctjNW3aIYZcWrBFVjrm/3Rys=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2KaFLNAU22iAs42w6sbVTsr7raogabjjVshv7oTwh1s6J1pCAgQC3dsq6SXOIFlA6
         C4Cerr1HM4mdsVRz/ywG8WGRQweuPDuGDkVLoGARFMcsfDPR3s5CrQB0BEfcSCxv2U
         8bmG3LynVpgcCVuhLLExkXqoCblYabkNuiNXR3SU=
Date:   Thu, 9 Mar 2023 13:57:02 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Svyatoslav Ryhel <clamor95@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/4] Update APDS990x ALS to support IIO
Message-ID: <ZAnXnndzfb4puX3H@kroah.com>
References: <20230308090219.12710-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230308090219.12710-1-clamor95@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2023 at 11:02:15AM +0200, Svyatoslav Ryhel wrote:
> Add apds990x binding scheme, convert it to get basic data from
> dts and use common IIO API. Since it works with IIO now, move from
> /misc to /iio.
> 
> Svyatoslav Ryhel (4):
>   dt-bindings: iio: light: add apds990x binding
>   misc: adps990x: convert to OF
>   misc: apds990x: convert to IIO
>   iio: light: move apds990x into proper place
> 
>  .../bindings/iio/light/avago,apds990x.yaml    |  76 ++
>  drivers/iio/light/Kconfig                     |  10 +
>  drivers/iio/light/Makefile                    |   1 +
>  drivers/{misc => iio/light}/apds990x.c        | 802 +++++++++---------
>  drivers/misc/Kconfig                          |  10 -
>  drivers/misc/Makefile                         |   1 -
>  6 files changed, 509 insertions(+), 391 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/avago,apds990x.yaml
>  rename drivers/{misc => iio/light}/apds990x.c (67%)
> 

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
