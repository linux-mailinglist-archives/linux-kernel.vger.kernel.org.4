Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D778F644AF0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 19:14:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiLFSOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 13:14:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiLFSOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 13:14:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD51E654C;
        Tue,  6 Dec 2022 10:13:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58A16617BF;
        Tue,  6 Dec 2022 18:13:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1197C433C1;
        Tue,  6 Dec 2022 18:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670350438;
        bh=gaLWT87ue6l/V9JSmDr9yvVtnAAJOeuZ4HFvZ8zHjLA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=agGrinilUI0prtyb6dl3sE+EtoCr7VQ5OiQ5zz0UmZQHfINYA9Xx9a05wJ4ZT52k4
         dyckAPPCkytKOGbKPgykSeDC66JeLqDNZsDSNYMLEQYDbTD12yLbGzaELZrYG/bm53
         zg9jw5t2Uxq8Grb4EWPYSHQyZszKZceKilXRorONdqOhAE+rKqJ/2ggmKdbWcVU7cK
         63+qHaz4uK/N4cmlYTYKP2JTq/dJ9xEtILSm6gm2sYdx65QMHTZslYElFtOZ9HWB6s
         H6A06Mneb2OhSFU4BkRAKoLvr3xHmHnRdzdR5OYOswkgoSa8sEDFileVuvUSYsfhiX
         rRlV6B8m1MufQ==
Date:   Tue, 6 Dec 2022 12:13:55 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: adc: qcom,spmi-vadc: fix PM8350 define
Message-ID: <20221206181355.qhbchi2d2gvaroln@builder.lan>
References: <20221117121307.264550-1-krzysztof.kozlowski@linaro.org>
 <20221117122256.GG93179@thinkpad>
 <a3da2ab9-ad36-2283-0659-ad8ebf877e17@linaro.org>
 <20221117155658.00005d08@Huawei.com>
 <9ddf7e56-f396-5720-9960-e3ef4aa9a204@linaro.org>
 <20221117165806.00007f55@huawei.com>
 <CAL_JsqJ980WdxiUzUSp+p9qTA_BA-n0e_+5qp9Kbw9==MoQpXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqJ980WdxiUzUSp+p9qTA_BA-n0e_+5qp9Kbw9==MoQpXw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2022 at 05:36:12PM -0600, Rob Herring wrote:
> On Thu, Nov 17, 2022 at 10:58 AM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > On Thu, 17 Nov 2022 17:21:25 +0100
> > Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> >
> > > On 17/11/2022 16:56, Jonathan Cameron wrote:
> > > > On Thu, 17 Nov 2022 13:28:33 +0100
> > > > Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> > > >
> > > >> On 17/11/2022 13:22, Manivannan Sadhasivam wrote:
> > > >>> On Thu, Nov 17, 2022 at 01:13:07PM +0100, Krzysztof Kozlowski wrote:
> > > >>>> The defines from include/dt-bindings/iio/qcom,spmi-adc7-pm8350.h were
> > > >>>> changed to take sid argument:
> > > >>>>
> > > >>>>   Error: Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.example.dts:99.28-29 syntax error
> > > >>>>
> > > >>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > > >>>
> > > >>> Looks like I didn't rebase on top of Bjorn's for-next for my series, so didn't
> > > >>> see this example.
> > > >>>
> > > >>> Thanks for fixing!
> > > >>>
> > > >>> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > >>>
> > > >>
> > > >> This should not go via Bjorn's tree without IIO ack and
> > > >> Jonathan/Lars-Peter/IIO lists were not in CC.
> > > >>
> > > > Thanks for the heads up.
> > > >
> > > > Not sure I'd have registered there would have been a problem here even
> > > > if I had seen original patch.  Anyhow, I assume Bjorn will pick this up
> > > > and all will be well again.
> > > >
> > > > Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > >
> > > I am afraid it cannot go via Bjorn's tree, because this depends on a
> > > change in your tree:
> > > https://lore.kernel.org/all/20221027143411.277980-2-krzysztof.kozlowski@linaro.org/
> > >
> > > Can you pick it up instead? This is the only way to fix the linux-next,
> > > although your tree will have a dt_binding_check error.
> > >
> > > Other way is to have cross-tree merge, but the commit to bindings
> > > headers ended up in DTS patch, so it cannot be shared with driver tree.
> >
> > Ah. I've sent Greg a pull reuqest including that patch, so this is going to get
> > worse and the linux-next intermediate builds are going to fail which is never good.
> >
> > Best bet at this point may be for Bjorn to also take the dependency
> > you list above and the fix.
> >
> > Git will happily unwind the same patch turning up in two trees and
> > that way he'll have everything and the IIO tree  + char-misc will
> > be fine on their own as well.
> >
> > That work for everyone?
> 
> linux-next is failing still. Is someone going to sort this out?
> 

I've picked up the dependency followed by Krzysztof's patch, and
notified Stephen about the expected merge conflict between our trees.

The result do pass dt_binding_check of this binding.

Regards,
Bjorn
