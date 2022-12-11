Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6849B649498
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 15:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbiLKOCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 09:02:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLKOCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 09:02:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A28DF6B;
        Sun, 11 Dec 2022 06:02:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B8DBC60DC9;
        Sun, 11 Dec 2022 14:02:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45C67C433F0;
        Sun, 11 Dec 2022 14:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670767354;
        bh=qbLdcwHUSakHdBthMKlWZnGRsrtDuG/VUTavNAVkCbU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=S/AP9d93h1gVNufHPENhK8MQiLLfvo81gOZUBHnabPS/zwKMbxLoZkAG1ytQkaJXa
         oSh/GvVIs/U94x9gd95SSS6G21HqazC+AMporVhhEaHZ8EnM4m+KjHgHKRey7E9bu6
         rbqFWrTgny0leNUkgARaE54PTyj/UzcyG1y+1OSJakjHXbiwQkIuaZoyktu3k4iJbP
         6CkShtbVoZj6z6tsgG8gA7UqRSEPf2YcQjnDLIvWgFBDSMSACUW5Mn9aDCmJ17vg0Z
         08HeScdMr06j99op26cW7iQfijNXyYId/Mx+J2nQmEaZkANQGDn3+ryT7ulNb0TVOt
         Y6du7WsIdvy9g==
Date:   Sun, 11 Dec 2022 14:15:26 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marijn Suijten <marijn.suijten@somainline.org>
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
Subject: Re: [RFC PATCH] arm64: dts: qcom: Use labels with generic node
 names for ADC channels
Message-ID: <20221211141526.463f43e6@jic23-huawei>
In-Reply-To: <20221210165434.3hhen5mgtvflghks@SoMainline.org>
References: <20221209215308.1781047-1-marijn.suijten@somainline.org>
        <3d5b29f3-8d8d-93a7-a485-5261e2d8891d@linaro.org>
        <20221210165434.3hhen5mgtvflghks@SoMainline.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Dec 2022 17:54:34 +0100
Marijn Suijten <marijn.suijten@somainline.org> wrote:

> On 2022-12-10 12:02:03, Krzysztof Kozlowski wrote:
> > On 09/12/2022 22:53, Marijn Suijten wrote:  
> > > As discussed in [1] the DT should use labels to describe ADC channels,
> > > with generic node names, since the IIO drivers now moved to the fwnode
> > > API where node names include the `@xx` address suffix.
> > > 
> > > Especially for the ADC5 driver that uses extend_name - which cannot be
> > > removed for compatibility reasons - this results in sysfs files with the
> > > @xx name that wasn't previously present, and leads to an unpleasant
> > > file-browsing experience.
> > > 
> > > Also remove all the unused channel labels in pm660.dtsi.
> > > 
> > > [1]: https://lore.kernel.org/linux-arm-msm/20221106193018.270106-1-marijn.suijten@somainline.org/T/#u
> > > 
> > > Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>  
> > 
> > The talk was in context of bindings, not about changing all existing
> > users thus affecting DTS.  
> 
> And as a consequence, DTS.  The already-merged transition from OF to
> fwnode resulted in `@xx` to be included in the ADC channel name - and in
> the case of ADC5 even in sysfs filenames - so this seems like a
> necessary change to make.

Gah. We missed that at the time.  Arguably we should first fix that
particular issue as we will have lots of old DT out there.
(add a bit of code to strip the @xxx bit from that particular usecase).
It gets tricky because now we might have code relying on the new
broken behavior.

> 
> At the very least I would have changed the bindings submitted or
> co-authored /by myself/ since I initially decided to rely on this (now
> obviously) wrong behaviour, and should have used labels from the get go.
> 
> > What's more, to me "skin-temp-thermistor" is
> > quite generic name, maybe "thermistor" would be more and reflects the
> > purpose of the node, so it was more or less fine.  
> 
> Are you suggesting to not use "adc-chan", but "thermistor" as node name
> (and still use skin_temp as label)?  Or to keep the fully-written-out
> "thermistor" word in the label?
> 
> > Anyway I am against such changes without expressing it in the bindings.  
> 
> As expressed in [1] I suggested and am all for locking this change in
> via bindings, and you are right to expect that to have gone paired with
> this patch.
> 
> I'll submit that as the leading patch to this in v2, with the wildcard
> pattern changed to adc-chan (or something else pending the discussion
> above), and should I then also require the label property via `label:
> true`?
> 
> [1]: https://lore.kernel.org/linux-arm-msm/20221208101232.536i3cmjf4uk2z52@SoMainline.org/

So the 'fun' here is what to do with old DTS as we need to support that
even if we update the binding docs and all in kernel users.

Probably right option in driver is:
a) Use label if present
b) Use node name if it's not adc-chan but strip the @xxx off it.
c) return an error.

p.s. Please add iio@vger.kernel.org to future versions of this. If nothing
else I tend to lose direct emails about IIO stuff as they aren't in the
relevant patchwork instance.

> 
> - Marijn

