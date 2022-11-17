Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3180062E25F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 17:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239988AbiKQQ6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 11:58:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240024AbiKQQ6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 11:58:13 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3DDA70A1D;
        Thu, 17 Nov 2022 08:58:09 -0800 (PST)
Received: from frapeml100002.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NCmJD4l0cz683hj;
        Fri, 18 Nov 2022 00:55:40 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 frapeml100002.china.huawei.com (7.182.85.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 17 Nov 2022 17:58:07 +0100
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 17 Nov
 2022 16:58:07 +0000
Date:   Thu, 17 Nov 2022 16:58:06 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: iio: adc: qcom,spmi-vadc: fix PM8350
 define
Message-ID: <20221117165806.00007f55@huawei.com>
In-Reply-To: <9ddf7e56-f396-5720-9960-e3ef4aa9a204@linaro.org>
References: <20221117121307.264550-1-krzysztof.kozlowski@linaro.org>
        <20221117122256.GG93179@thinkpad>
        <a3da2ab9-ad36-2283-0659-ad8ebf877e17@linaro.org>
        <20221117155658.00005d08@Huawei.com>
        <9ddf7e56-f396-5720-9960-e3ef4aa9a204@linaro.org>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
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

On Thu, 17 Nov 2022 17:21:25 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 17/11/2022 16:56, Jonathan Cameron wrote:
> > On Thu, 17 Nov 2022 13:28:33 +0100
> > Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> >   
> >> On 17/11/2022 13:22, Manivannan Sadhasivam wrote:  
> >>> On Thu, Nov 17, 2022 at 01:13:07PM +0100, Krzysztof Kozlowski wrote:    
> >>>> The defines from include/dt-bindings/iio/qcom,spmi-adc7-pm8350.h were
> >>>> changed to take sid argument:
> >>>>
> >>>>   Error: Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.example.dts:99.28-29 syntax error
> >>>>
> >>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>    
> >>>
> >>> Looks like I didn't rebase on top of Bjorn's for-next for my series, so didn't
> >>> see this example.
> >>>
> >>> Thanks for fixing!
> >>>
> >>> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> >>>     
> >>
> >> This should not go via Bjorn's tree without IIO ack and
> >> Jonathan/Lars-Peter/IIO lists were not in CC.
> >>  
> > Thanks for the heads up. 
> > 
> > Not sure I'd have registered there would have been a problem here even
> > if I had seen original patch.  Anyhow, I assume Bjorn will pick this up
> > and all will be well again.
> > 
> > Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>  
> 
> I am afraid it cannot go via Bjorn's tree, because this depends on a
> change in your tree:
> https://lore.kernel.org/all/20221027143411.277980-2-krzysztof.kozlowski@linaro.org/
> 
> Can you pick it up instead? This is the only way to fix the linux-next,
> although your tree will have a dt_binding_check error.
> 
> Other way is to have cross-tree merge, but the commit to bindings
> headers ended up in DTS patch, so it cannot be shared with driver tree.

Ah. I've sent Greg a pull reuqest including that patch, so this is going to get
worse and the linux-next intermediate builds are going to fail which is never good.

Best bet at this point may be for Bjorn to also take the dependency 
you list above and the fix.

Git will happily unwind the same patch turning up in two trees and
that way he'll have everything and the IIO tree  + char-misc will
be fine on their own as well.

That work for everyone?

Jonathan



> 
> Best regards,
> Krzysztof
> 

