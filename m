Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F0964399D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 00:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233178AbiLEXhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 18:37:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232825AbiLEXgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 18:36:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2699A1FFA1;
        Mon,  5 Dec 2022 15:36:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 471C7B815BD;
        Mon,  5 Dec 2022 23:36:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5042C433D6;
        Mon,  5 Dec 2022 23:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670283385;
        bh=HmzCjfAOF4UyYdOVbdTC1bINOmWkHWowuczF6T9yrCo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KAVNMilO9ElFYsCYk+f6sXJeBj3cqfDZZnWVz5y9TC8O8dp5L8y+M+vctPM6oQrkk
         SryXr+iJKEjmF1uISoGHeOP9WgX8dBRvflov8duvWJDLyKec3hSd6MAmRDymTTMCRL
         5RXEfls4gS1unqyR1QpBB5Ta/HrVRVFFxs0P0qDMmqAEXAKnZkaK4kH8miu56v1gGT
         dZXCAZP8vTcDHfoNocPbp+sUafMRTd3US8iIf/7Jha6fCelImKXoboSIXsFFUHdRgc
         VBo36gS03LeDEJOhHG+vzaKqpWp6Lr5mhd+LcfYr68SuDootsPYl5HcWJactq2okjo
         dRui1sXuj766w==
Received: by mail-vk1-f170.google.com with SMTP id o5so3760787vkn.7;
        Mon, 05 Dec 2022 15:36:25 -0800 (PST)
X-Gm-Message-State: ANoB5pm8YG4lWi20a4s+ZSvWHd1VkLuWyBz0sHEy+1wr0TWFsdqMou3i
        BWIJpQVU3HKIcjNlcPySKHQ6kyL0mkoNRFMPbA==
X-Google-Smtp-Source: AA0mqf45vIAxbqhtzcJrgQ9/zSu41J+UkpRu+Qvmux7lBoo2dhfhQAUIqUVwT2CGZiLqMQzjmDl3xNRIfH6P4NW2gmU=
X-Received: by 2002:a1f:9110:0:b0:3bc:fc56:597 with SMTP id
 t16-20020a1f9110000000b003bcfc560597mr16411535vkd.14.1670283384892; Mon, 05
 Dec 2022 15:36:24 -0800 (PST)
MIME-Version: 1.0
References: <20221117121307.264550-1-krzysztof.kozlowski@linaro.org>
 <20221117122256.GG93179@thinkpad> <a3da2ab9-ad36-2283-0659-ad8ebf877e17@linaro.org>
 <20221117155658.00005d08@Huawei.com> <9ddf7e56-f396-5720-9960-e3ef4aa9a204@linaro.org>
 <20221117165806.00007f55@huawei.com>
In-Reply-To: <20221117165806.00007f55@huawei.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 5 Dec 2022 17:36:12 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ980WdxiUzUSp+p9qTA_BA-n0e_+5qp9Kbw9==MoQpXw@mail.gmail.com>
Message-ID: <CAL_JsqJ980WdxiUzUSp+p9qTA_BA-n0e_+5qp9Kbw9==MoQpXw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: iio: adc: qcom,spmi-vadc: fix PM8350 define
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 10:58 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Thu, 17 Nov 2022 17:21:25 +0100
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
>
> > On 17/11/2022 16:56, Jonathan Cameron wrote:
> > > On Thu, 17 Nov 2022 13:28:33 +0100
> > > Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> > >
> > >> On 17/11/2022 13:22, Manivannan Sadhasivam wrote:
> > >>> On Thu, Nov 17, 2022 at 01:13:07PM +0100, Krzysztof Kozlowski wrote:
> > >>>> The defines from include/dt-bindings/iio/qcom,spmi-adc7-pm8350.h were
> > >>>> changed to take sid argument:
> > >>>>
> > >>>>   Error: Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.example.dts:99.28-29 syntax error
> > >>>>
> > >>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > >>>
> > >>> Looks like I didn't rebase on top of Bjorn's for-next for my series, so didn't
> > >>> see this example.
> > >>>
> > >>> Thanks for fixing!
> > >>>
> > >>> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > >>>
> > >>
> > >> This should not go via Bjorn's tree without IIO ack and
> > >> Jonathan/Lars-Peter/IIO lists were not in CC.
> > >>
> > > Thanks for the heads up.
> > >
> > > Not sure I'd have registered there would have been a problem here even
> > > if I had seen original patch.  Anyhow, I assume Bjorn will pick this up
> > > and all will be well again.
> > >
> > > Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > I am afraid it cannot go via Bjorn's tree, because this depends on a
> > change in your tree:
> > https://lore.kernel.org/all/20221027143411.277980-2-krzysztof.kozlowski@linaro.org/
> >
> > Can you pick it up instead? This is the only way to fix the linux-next,
> > although your tree will have a dt_binding_check error.
> >
> > Other way is to have cross-tree merge, but the commit to bindings
> > headers ended up in DTS patch, so it cannot be shared with driver tree.
>
> Ah. I've sent Greg a pull reuqest including that patch, so this is going to get
> worse and the linux-next intermediate builds are going to fail which is never good.
>
> Best bet at this point may be for Bjorn to also take the dependency
> you list above and the fix.
>
> Git will happily unwind the same patch turning up in two trees and
> that way he'll have everything and the IIO tree  + char-misc will
> be fine on their own as well.
>
> That work for everyone?

linux-next is failing still. Is someone going to sort this out?

Rob
