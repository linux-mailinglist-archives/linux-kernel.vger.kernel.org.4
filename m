Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 261F4744D4C
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 12:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjGBKeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 06:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjGBKeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 06:34:19 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D70A7135;
        Sun,  2 Jul 2023 03:34:18 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Qv53V1fv4z6J6n8;
        Sun,  2 Jul 2023 18:32:38 +0800 (CST)
Received: from localhost (10.48.51.211) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sun, 2 Jul
 2023 11:34:13 +0100
Date:   Sun, 2 Jul 2023 18:34:09 +0800
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Waqar Hameed <waqar.hameed@axis.com>
CC:     Jonathan Cameron <jic23@kernel.org>, <devicetree@vger.kernel.org>,
        "Conor Dooley" <conor+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, <kernel@axis.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <kernel@lists.axis.com>
Subject: Re: [PATCH 1/2] dt-bindings: iio: proximity: Add bindings for
 Murata IRS-D200
Message-ID: <20230702183409.0000021f@Huawei.com>
In-Reply-To: <pndwmzz1yqu.fsf@axis.com>
References: <cover.1686926857.git.waqarh@axis.com>
        <9487391b0565434761055b39ba04900bd839580a.1686926857.git.waqarh@axis.com>
        <20230617135532.328dc3c8@jic23-huawei>
        <pndwmzz1yqu.fsf@axis.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.51.211]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Jun 2023 12:41:06 +0200
Waqar Hameed <waqar.hameed@axis.com> wrote:

> On Sat, Jun 17, 2023 at 13:55 +0100 Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > On Fri, 16 Jun 2023 17:10:42 +0200
> > Waqar Hameed <waqar.hameed@axis.com> wrote:
> >  
> >> Murata IRS-D200 is a PIR sensor for human detection. It uses the I2C bus
> >> for communication with interrupt support. Add devicetree bindings
> >> requiring the compatible string, I2C slave address (reg) and interrupts.
> >> 
> >> Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>  
> >
> > This device will have some power supplies, so I'd expect those to be both
> > listed and marked as required (maybe some are optional?)  
> 
> Right, will add that here (and call `devm_regulator_get_enable()` in
> driver's probe).
> 
> [...]
> 
> >> +required:
> >> +  - compatible
> >> +  - reg
> >> +  - interrupts  
> >
> > If it is possible to remove interrupts from requires  - and hence have
> > at least a partly functional driver doing basic reading of the sensor
> > then that is usually a good idea.   Far too many board designers seem
> > to decide that they don't need to wire up interrupt liness
> > If it's really hard then don't worry too much.  
> 
> I see. It would be possible, but would also require some work. Let's
> leave it for now then?

Sure - as long as you review the patches when they come in :)

Jonathan
