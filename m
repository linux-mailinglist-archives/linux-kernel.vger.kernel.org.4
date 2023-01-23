Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5C7A67794A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 11:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231844AbjAWKgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 05:36:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbjAWKgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 05:36:15 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B1B17176;
        Mon, 23 Jan 2023 02:36:11 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4P0mck3ssfz6J7f6;
        Mon, 23 Jan 2023 18:32:06 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 23 Jan
 2023 10:36:08 +0000
Date:   Mon, 23 Jan 2023 10:36:07 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Marijn Suijten <marijn.suijten@somainline.org>
CC:     Jonathan Cameron <jic23@kernel.org>, <phone-devel@vger.kernel.org>,
        <~postmarketos/upstreaming@lists.sr.ht>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        <iio@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Manivannan Sadhasivam" <mani@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: Require generic adc-chan
 name for channel nodes
Message-ID: <20230123103607.00001fcd@Huawei.com>
In-Reply-To: <20230122233741.7jn2nzghfvhgoemr@SoMainline.org>
References: <20230119212632.185881-1-marijn.suijten@somainline.org>
        <20230119212632.185881-2-marijn.suijten@somainline.org>
        <20230121170825.0d284151@jic23-huawei>
        <20230122233741.7jn2nzghfvhgoemr@SoMainline.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
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

On Mon, 23 Jan 2023 00:37:41 +0100
Marijn Suijten <marijn.suijten@somainline.org> wrote:

> On 2023-01-21 17:08:25, Jonathan Cameron wrote:
> > On Thu, 19 Jan 2023 22:26:31 +0100
> > Marijn Suijten <marijn.suijten@somainline.org> wrote:
> >   
> > > As discussed in [1] it is more convenient to use a generic adc-chan node
> > > name for ADC channels while storing a friendly - board-specific instead
> > > of PMIC-specific - name in the label, if/when desired to overwrite the
> > > channel description already contained (but previously unused) in the
> > > driver [2].
> > > 
> > > Replace the .* name pattern with the adc-chan literal, but leave the
> > > label property optional for bindings to choose to fall back a channel
> > > label hardcoded in the driver [2] instead.
> > > 
> > > [1]: https://lore.kernel.org/linux-arm-msm/20221106193018.270106-1-marijn.suijten@somainline.org/T/#u
> > > [2]: https://lore.kernel.org/linux-arm-msm/20230116220909.196926-4-marijn.suijten@somainline.org/
> > > 
> > > Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>  
> > Other than the use in the tm5 thermal example that Rob's bot found, this looks
> > good to me.  
> 
> Yep, shouldn't have ran dt_binding_check and dtbs_check with
> DT_SCHEMA_FILES=just/the/one/edited/here.
> 
> > I think ideal would be to fix that in a precursor patch then
> > do this one.  
> 
> Can't that be part of the current one?  At least the change requested by
> dt-bindings here is backwards-compatible; the adc-chan@xx format with
> optional label property was already allowed.

Sure you can merge it in, or do it as a precursor. I'd split it though
purely as it can be picked up by a different maintainer if that makes
sense (at cost of some errors as things filter through the various
trees).

> 
> > Note that the existing two patches should be in the other order
> > 1. Update the dtsi
> > 2. Tighten the bounds to check they are right.  
> 
> Hmm, I'm never sure what goes first: drivers, bindings, or DT
> (considering there's an ABI it shouldn't matter whether drivers or DT
> go first, leaving just dt-bindings which could be used to TDD the DT...
> or check adjustment after the fact).  Is this relationship - and the
> order following from it - documented somewhere?

In this particular case we in theory want bisectability.  As you note
the updated tighter naming is already allowed, so we can make that change
first.

Normally we are adding new bindings and it doesn't matter on order as
we just have an undocumented binding if the driver goes first.

As noted it all become irrelevant when things go through different
trees anyway!

J
> 
> > Doesn't matter much though as the two patches will probably go through
> > different trees.  
> 
> Should be right, indeed.
> 
> - Marijn

