Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6086BD762
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 18:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjCPRpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 13:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjCPRom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 13:44:42 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDFFFDF720;
        Thu, 16 Mar 2023 10:44:32 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PcvkX1V3Rz6J7h1;
        Fri, 17 Mar 2023 01:43:32 +0800 (CST)
Received: from localhost (10.48.145.133) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 16 Mar
 2023 17:44:29 +0000
Date:   Thu, 16 Mar 2023 17:44:28 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Marijn Suijten <marijn.suijten@somainline.org>
CC:     Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
        <phone-devel@vger.kernel.org>,
        <~postmarketos/upstreaming@lists.sr.ht>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        <iio@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] dt-bindings: thermal: qcom-spmi-adc-tm5: Use
 generic ADC node name
Message-ID: <20230316174428.00003c4c@Huawei.com>
In-Reply-To: <20230316124307.pzuvbacsmjdootfx@SoMainline.org>
References: <20230201204447.542385-1-marijn.suijten@somainline.org>
        <20230201204447.542385-3-marijn.suijten@somainline.org>
        <20230203212501.GA908601-robh@kernel.org>
        <20230205150645.549ff062@jic23-huawei>
        <20230316124307.pzuvbacsmjdootfx@SoMainline.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.145.133]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
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

On Thu, 16 Mar 2023 13:43:07 +0100
Marijn Suijten <marijn.suijten@somainline.org> wrote:

> On 2023-02-05 15:06:45, Jonathan Cameron wrote:
> > On Fri, 3 Feb 2023 15:25:01 -0600
> > Rob Herring <robh@kernel.org> wrote:
> >   
> > > On Wed, Feb 01, 2023 at 09:44:46PM +0100, Marijn Suijten wrote:  
> > > > Update the example to reflect a future requirement for the generic
> > > > adc-chan node name on ADC channel nodes, while conveying the board name
> > > > of the channel in a label instead.    
> > > 
> > > I don't think we've defined 'adc-chan' as THE generic name. Looks like 
> > > we have:
> > > 
> > > adc-chan
> > > adc-channel
> > > channel
> > > 
> > > 'channel' is the most common (except for QCom).  
> > Good spot.
> > 
> > We also have that defined as the channel name in 
> > bindings/iio/adc.yaml  
> 
> Good point, let's match adc.yaml and use 'channel' instead.  I'll
> respin this series with thas, as well as rebasing on -next to solve
> conflicts with 8013295662f5 ("arm64: dts: qcom: sc8280xp: Add label
> property to vadc channel nodes"): supposedly that DT originally relied
> on the `@XX` suffix bug :)
> 
> > Now this particular binding doesn't use anything from that
> > generic binding (other than trivial use of reg) but better to be
> > consistent with it than not!  
> 
> Should it inherit the common binding, or was it omitted for a reason?

Harmless but little point as far as I can see given we don't happen
to have any of the generic elements defined in the generic channel
binding.

Jonathan

> 
> - Marijn
> 

