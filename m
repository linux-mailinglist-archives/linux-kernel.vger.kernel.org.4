Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77DB167D369
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 18:41:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbjAZRl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 12:41:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjAZRlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 12:41:24 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAFBA6BBEA;
        Thu, 26 Jan 2023 09:41:23 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4P2nzk5c0Dz6J9b8;
        Fri, 27 Jan 2023 01:40:34 +0800 (CST)
Received: from localhost (10.81.202.191) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 26 Jan
 2023 17:41:20 +0000
Date:   Thu, 26 Jan 2023 17:41:19 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Markuss Broks <markuss.broks@gmail.com>
CC:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: light: Add support for AMS TCS3490 light
 sensor
Message-ID: <20230126174119.000056da@Huawei.com>
In-Reply-To: <a782a0d9-c47e-4328-774f-6bef78161d81@gmail.com>
References: <20230123231028.26073-1-markuss.broks@gmail.com>
        <20230123231028.26073-3-markuss.broks@gmail.com>
        <Y8+xamtH/U4vK75e@smile.fi.intel.com>
        <a782a0d9-c47e-4328-774f-6bef78161d81@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.202.191]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Jan 2023 17:54:56 +0200
Markuss Broks <markuss.broks@gmail.com> wrote:

> Hi Andy,
> 
> On 1/24/23 12:22, Andy Shevchenko wrote:
> > On Tue, Jan 24, 2023 at 01:10:25AM +0200, Markuss Broks wrote:  
> >> Add a driver for AMS TCS3490 Color Light-to-Digital Converter. This
> >> device provides color and IR (red, green, blue, clear and IR) light
> >> sensing. The color sensing can be used for light source detection and
> >> color temperature measurements.  
> > ...
> >  
> >> +AMS TCS3490 DRIVER
> >> +M:	Markuss Broks <markuss.broks@gmail.com>
> >> +L:	linux-iio@vger.kernel.org
> >> +S:	Maintained
> >> +F:	Documentation/devicetree/bindings/iio/light/ams,tcs3490.yaml  
> > Shouldn't actually be added with the schema patch?
> >  
> >> +F:	drivers/iio/light/tcs3490.c  
> > I dunno what's the rules but it feels a bit inconsistent in case the schema
> > will leave while driver got, for example, rewritten (as brand new) and reverted
> > (as old one). In such (quite unlikely) circumstances we may end up with the
> > dangling file.
> >
> > Rob, Krzysztof, Jonathan, what is yours take from this?

Ideal is update the file listing as files are added, but I rarely care
enough to fix it up or complain as the patches almost always go
together.
