Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C00DC6DDC62
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 15:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbjDKNkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 09:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbjDKNkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 09:40:45 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49DC05244;
        Tue, 11 Apr 2023 06:40:37 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Pwn1C1jJtz67gjn;
        Tue, 11 Apr 2023 21:36:15 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 11 Apr
 2023 14:40:33 +0100
Date:   Tue, 11 Apr 2023 14:40:31 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>
Subject: Re: [RFC PATCH 0/2] Support for Avago APDS9306 Ambient Light Sensor
Message-ID: <20230411144031.000077c7@Huawei.com>
In-Reply-To: <20230411011203.5013-1-subhajit.ghosh@tweaklogic.com>
References: <20230411011203.5013-1-subhajit.ghosh@tweaklogic.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Apr 2023 09:12:01 +0800
Subhajit Ghosh <subhajit.ghosh@tweaklogic.com> wrote:

> This series adds support for Avago (Broadcom) APDS9306 Ambient Light
> Sensor.
> 
> Datasheet: https://docs.broadcom.com/doc/AV02-4755EN
> 
> Following features are supported:
> - I2C interface
> - 2 channels - als and clear
> - Up to 20 bit resolution
> - 20 bit data register for each channel
> - Common Configurable items for both channels
>     - Integration Time
>     - Measurement Frequency
>     - Scale
> - High and Low threshold interrupts for each channel
> 
> - Selection of interrupt channel - als or clear
> - Selection of interrupt mode - threshold or adaptive
> - Level selection for adaptive threshold interrupts
> - Persistence (Period) level selection for interrupts
> 
> Signed-off-by: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
Hi Subhajit,

No need to sign off a cover letter.  The content isn't captured in the
git tree anyway.

For an RFC, I'd expect to see a clear statement in the cover letter of
why it is an RFC rather than a formal patch submission.  What specifically
are you looking for comments on?

Point us in the right direction and we might answer the questions quicker.

Thanks,

Jonathan

> 
> Subhajit Ghosh (2):
>   dt-bindings: Document APDS9306 Light Sensor bindings
>   iio: light: Add support for APDS9306 Light Sensor
> 
>  .../bindings/iio/light/avago,apds9306.yaml    |   47 +
>  drivers/iio/light/Kconfig                     |   11 +
>  drivers/iio/light/Makefile                    |    1 +
>  drivers/iio/light/apds9306.c                  | 1146 +++++++++++++++++
>  4 files changed, 1205 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/avago,apds9306.yaml
>  create mode 100644 drivers/iio/light/apds9306.c
> 
> 
> base-commit: 0d3eb744aed40ffce820cded61d7eac515199165

