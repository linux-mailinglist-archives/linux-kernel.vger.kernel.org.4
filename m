Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3991664E9CA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 11:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbiLPKxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 05:53:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiLPKxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 05:53:30 -0500
Received: from relay04.th.seeweb.it (relay04.th.seeweb.it [5.144.164.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EFE82F643
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 02:53:27 -0800 (PST)
Received: from SoMainline.org (94-209-172-39.cable.dynamic.v4.ziggo.nl [94.209.172.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id EAF3D1F9B2;
        Fri, 16 Dec 2022 11:53:22 +0100 (CET)
Date:   Fri, 16 Dec 2022 11:53:21 +0100
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
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
Message-ID: <20221216105321.bxol64or5j4jeynh@SoMainline.org>
Mail-Followup-To: Marijn Suijten <marijn.suijten@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
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
 <20221214204933.eo6sxodlnmcisc47@SoMainline.org>
 <01f7ef3c-910e-43fc-5cbf-c4caf223dc7c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01f7ef3c-910e-43fc-5cbf-c4caf223dc7c@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-12-16 11:44:34, Krzysztof Kozlowski wrote:
> On 14/12/2022 21:49, Marijn Suijten wrote:
> > On 2022-12-11 14:15:26, Jonathan Cameron wrote:
> >> On Sat, 10 Dec 2022 17:54:34 +0100
> >> Marijn Suijten <marijn.suijten@somainline.org> wrote:
> >>
> >>> On 2022-12-10 12:02:03, Krzysztof Kozlowski wrote:
> >>>> On 09/12/2022 22:53, Marijn Suijten wrote:  
> >>>>> As discussed in [1] the DT should use labels to describe ADC channels,
> >>>>> with generic node names, since the IIO drivers now moved to the fwnode
> >>>>> API where node names include the `@xx` address suffix.
> >>>>>
> >>>>> Especially for the ADC5 driver that uses extend_name - which cannot be
> >>>>> removed for compatibility reasons - this results in sysfs files with the
> >>>>> @xx name that wasn't previously present, and leads to an unpleasant
> >>>>> file-browsing experience.
> >>>>>
> >>>>> Also remove all the unused channel labels in pm660.dtsi.
> >>>>>
> >>>>> [1]: https://lore.kernel.org/linux-arm-msm/20221106193018.270106-1-marijn.suijten@somainline.org/T/#u
> >>>>>
> >>>>> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>  
> >>>>
> >>>> The talk was in context of bindings, not about changing all existing
> >>>> users thus affecting DTS.  
> >>>
> >>> And as a consequence, DTS.  The already-merged transition from OF to
> >>> fwnode resulted in `@xx` to be included in the ADC channel name - and in
> >>> the case of ADC5 even in sysfs filenames - so this seems like a
> >>> necessary change to make.
> >>
> >> Gah. We missed that at the time.  Arguably we should first fix that
> >> particular issue as we will have lots of old DT out there.
> >> (add a bit of code to strip the @xxx bit from that particular usecase).
> >> It gets tricky because now we might have code relying on the new
> >> broken behavior.
> > 
> > Before rushing to fix that, my idea was to simply only read DT labels in
> > the driver, and otherwise fall back to the hardcoded names inside that
> > IIO driver (again: ADC5 defines friendly names in the driver, but
> > doesn't ever reference them besides a worthless non-NULL check).
> > 
> >>> At the very least I would have changed the bindings submitted or
> >>> co-authored /by myself/ since I initially decided to rely on this (now
> >>> obviously) wrong behaviour, and should have used labels from the get go.
> >>>
> >>>> What's more, to me "skin-temp-thermistor" is
> >>>> quite generic name, maybe "thermistor" would be more and reflects the
> >>>> purpose of the node, so it was more or less fine.  
> >>>
> >>> Are you suggesting to not use "adc-chan", but "thermistor" as node name
> >>> (and still use skin_temp as label)?  Or to keep the fully-written-out
> >>> "thermistor" word in the label?
> >>>
> >>>> Anyway I am against such changes without expressing it in the bindings.  
> >>>
> >>> As expressed in [1] I suggested and am all for locking this change in
> >>> via bindings, and you are right to expect that to have gone paired with
> >>> this patch.
> >>>
> >>> I'll submit that as the leading patch to this in v2, with the wildcard
> >>> pattern changed to adc-chan (or something else pending the discussion
> >>> above), and should I then also require the label property via `label:
> >>> true`?
> >>>
> >>> [1]: https://lore.kernel.org/linux-arm-msm/20221208101232.536i3cmjf4uk2z52@SoMainline.org/
> >>
> >> So the 'fun' here is what to do with old DTS as we need to support that
> >> even if we update the binding docs and all in kernel users.
> > 
> > Personally I have never cared about backwards compat as all my devices
> > rely on the DT and drivers to be brought up in tandem, but yes that is a
> > problem for others...
> 
> Yeah, but we do not accept patches with each other person point of view
> of ABI. ABI rules are generic, otherwise it would not be ABI, right?

Hence I am not outright rejecting the proposal to maintain ABI
compatibility.

However I won't be the one reverting the fwnode conversion or writing
the code to strip the `@xx` suffix.  We're already on a tangent of a
tangent, with my original goal to add the missing label names to the
VADC driver.

> > 
> >> Probably right option in driver is:
> >> a) Use label if present
> >> b) Use node name if it's not adc-chan but strip the @xxx off it.
> > 
> > Perhaps we can skip this entirely: as shown by this patch the use of
> > node names instead of labels is limited to "newer" devices and SoCs,
> > given their "active" development leads to the assumption they must also
> 
> Only SM8550, SC8280xp and maybe SM8450 qualify to such "active"
> development platforms.

I guess we'll have to agree to disagree here.  Many more SoCs are still
in swing or so incomplete that it hardly makes any sense to not update
/both/ regularly.

That's not a valid argument to break ABI though, so we'll leave it at
that.

> > flash their kernel and DTB updates in tandem? 
> 
> No, DTS is used outside in other projects and out of tree kernels. Just
> because you use them together does not change the requirements of DTS
> and kernel of not breaking other users, without clear, justified reason.

That's known, but inconvenient nevertheless given the rate at which both
"evolve".

 - Marijn
