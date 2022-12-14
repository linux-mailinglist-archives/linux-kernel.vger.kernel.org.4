Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE20E64D178
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 21:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiLNUtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 15:49:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiLNUth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 15:49:37 -0500
Received: from relay06.th.seeweb.it (relay06.th.seeweb.it [5.144.164.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B93D1C132
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 12:49:36 -0800 (PST)
Received: from SoMainline.org (94-209-172-39.cable.dynamic.v4.ziggo.nl [94.209.172.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 436963F336;
        Wed, 14 Dec 2022 21:49:34 +0100 (CET)
Date:   Wed, 14 Dec 2022 21:49:33 +0100
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] arm64: dts: qcom: Use labels with generic node names
 for ADC channels
Message-ID: <20221214204933.eo6sxodlnmcisc47@SoMainline.org>
Mail-Followup-To: Marijn Suijten <marijn.suijten@somainline.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221209215308.1781047-1-marijn.suijten@somainline.org>
 <3d5b29f3-8d8d-93a7-a485-5261e2d8891d@linaro.org>
 <20221210165434.3hhen5mgtvflghks@SoMainline.org>
 <20221211141526.463f43e6@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221211141526.463f43e6@jic23-huawei>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-12-11 14:15:26, Jonathan Cameron wrote:
> On Sat, 10 Dec 2022 17:54:34 +0100
> Marijn Suijten <marijn.suijten@somainline.org> wrote:
> 
> > On 2022-12-10 12:02:03, Krzysztof Kozlowski wrote:
> > > On 09/12/2022 22:53, Marijn Suijten wrote:  
> > > > As discussed in [1] the DT should use labels to describe ADC channels,
> > > > with generic node names, since the IIO drivers now moved to the fwnode
> > > > API where node names include the `@xx` address suffix.
> > > > 
> > > > Especially for the ADC5 driver that uses extend_name - which cannot be
> > > > removed for compatibility reasons - this results in sysfs files with the
> > > > @xx name that wasn't previously present, and leads to an unpleasant
> > > > file-browsing experience.
> > > > 
> > > > Also remove all the unused channel labels in pm660.dtsi.
> > > > 
> > > > [1]: https://lore.kernel.org/linux-arm-msm/20221106193018.270106-1-marijn.suijten@somainline.org/T/#u
> > > > 
> > > > Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>  
> > > 
> > > The talk was in context of bindings, not about changing all existing
> > > users thus affecting DTS.  
> > 
> > And as a consequence, DTS.  The already-merged transition from OF to
> > fwnode resulted in `@xx` to be included in the ADC channel name - and in
> > the case of ADC5 even in sysfs filenames - so this seems like a
> > necessary change to make.
> 
> Gah. We missed that at the time.  Arguably we should first fix that
> particular issue as we will have lots of old DT out there.
> (add a bit of code to strip the @xxx bit from that particular usecase).
> It gets tricky because now we might have code relying on the new
> broken behavior.

Before rushing to fix that, my idea was to simply only read DT labels in
the driver, and otherwise fall back to the hardcoded names inside that
IIO driver (again: ADC5 defines friendly names in the driver, but
doesn't ever reference them besides a worthless non-NULL check).

> > At the very least I would have changed the bindings submitted or
> > co-authored /by myself/ since I initially decided to rely on this (now
> > obviously) wrong behaviour, and should have used labels from the get go.
> > 
> > > What's more, to me "skin-temp-thermistor" is
> > > quite generic name, maybe "thermistor" would be more and reflects the
> > > purpose of the node, so it was more or less fine.  
> > 
> > Are you suggesting to not use "adc-chan", but "thermistor" as node name
> > (and still use skin_temp as label)?  Or to keep the fully-written-out
> > "thermistor" word in the label?
> > 
> > > Anyway I am against such changes without expressing it in the bindings.  
> > 
> > As expressed in [1] I suggested and am all for locking this change in
> > via bindings, and you are right to expect that to have gone paired with
> > this patch.
> > 
> > I'll submit that as the leading patch to this in v2, with the wildcard
> > pattern changed to adc-chan (or something else pending the discussion
> > above), and should I then also require the label property via `label:
> > true`?
> > 
> > [1]: https://lore.kernel.org/linux-arm-msm/20221208101232.536i3cmjf4uk2z52@SoMainline.org/
> 
> So the 'fun' here is what to do with old DTS as we need to support that
> even if we update the binding docs and all in kernel users.

Personally I have never cared about backwards compat as all my devices
rely on the DT and drivers to be brought up in tandem, but yes that is a
problem for others...

> Probably right option in driver is:
> a) Use label if present
> b) Use node name if it's not adc-chan but strip the @xxx off it.

Perhaps we can skip this entirely: as shown by this patch the use of
node names instead of labels is limited to "newer" devices and SoCs,
given their "active" development leads to the assumption they must also
flash their kernel and DTB updates in tandem?  Unless I missed a whole
bunch of nodes.

> c) return an error.

Again, we could also fall back to the names coded in the driver.  They
exist for ADC5, for VADC they're preprocessor-stringified definitions,
and should be made less shouty first IMO.

> p.s. Please add iio@vger.kernel.org to future versions of this. If nothing
> else I tend to lose direct emails about IIO stuff as they aren't in the
> relevant patchwork instance.

Ack, blindly used get_maintained without realizing this!

Apologies for not having replied to our initial discussion yet; it
spiraled out of control in terms of size.  I'll see if I can clarify
some of the points in hopes of bringing this forward too.

- Marijn
