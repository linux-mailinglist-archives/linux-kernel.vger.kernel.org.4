Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01058648FD0
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 17:31:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiLJQbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 11:31:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiLJQb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 11:31:28 -0500
Received: from relay04.th.seeweb.it (relay04.th.seeweb.it [IPv6:2001:4b7a:2000:18::165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B0F1056A
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 08:31:26 -0800 (PST)
Received: from SoMainline.org (94-209-172-39.cable.dynamic.v4.ziggo.nl [94.209.172.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id A70201F892;
        Sat, 10 Dec 2022 17:31:22 +0100 (CET)
Date:   Sat, 10 Dec 2022 17:31:21 +0100
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Luca Weiss <luca@z3ntu.xyz>, linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v3 2/2] arm64: dts: qcom: Add configuration for PMI8950
 peripheral
Message-ID: <20221210163121.woacrjuicb3vuzcn@SoMainline.org>
Mail-Followup-To: Marijn Suijten <marijn.suijten@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Luca Weiss <luca@z3ntu.xyz>, linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>
References: <20221101161801.1058969-1-luca@z3ntu.xyz>
 <36eb03e8-aace-f7ce-edc8-53715021c0ea@linaro.org>
 <20221208112055.m7sqg3ysxzskqjp4@SoMainline.org>
 <5740737.DvuYhMxLoT@g550jk>
 <20221209203851.sy37qqzczoaruuyb@SoMainline.org>
 <4846bb5f-79a9-e199-6a1c-5021e975e7ee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4846bb5f-79a9-e199-6a1c-5021e975e7ee@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-12-10 11:58:24, Krzysztof Kozlowski wrote:
> On 09/12/2022 21:38, Marijn Suijten wrote:
> > On 2022-12-09 17:54:50, Luca Weiss wrote:
> >> On Donnerstag, 8. Dezember 2022 12:20:55 CET Marijn Suijten wrote:
> >>> On 2022-12-08 11:23:17, Krzysztof Kozlowski wrote:
> >>>> On 08/12/2022 11:12, Marijn Suijten wrote:
> >>>>> On 2022-12-04 17:19:05, Luca Weiss wrote:
> >>>>>> On Freitag, 2. Dezember 2022 10:36:58 CET Marijn Suijten wrote:
> >>>>>> [..]
> >>>>>>
> >>>>>> So the way this patch does it is good or does it need changes?
> >>>>>
> >>>>> Except the typo(s?) pointed out in my first reply, this is good to go.
> >>>>>
> >>>>> If we stick with generic adc-chan node names that should be documented
> >>>>> in the bindings IMO, as it is currently only captured implicitly in the
> >>>>> examples.  Krzysztof, what is your thought on this?
> >>>>
> >>>> If I understand correctly, the outcome of other discussion [1] was to
> >>>> use labels and generic node names.
> >>>
> >>> The outcome was to use labels in the driver and disregard node names as
> >>> the new fwnode API clobbers those names by including the @xx register
> >>> bit.
> >>>
> >>> (I'll follow up with Jonathan whether or not to remove the current
> >>> fallback to node names, as [1] ended up discussing many different issues
> >>> and nits)
> >>>
> >>>> In such case the patch was correct
> >>>> (except other comments).
> >>>
> >>> As a consequence it _doesn't matter_ how nodes are named, and we _can_
> >>> use generic node names.  My question for you is whether we should, and
> >>> if we should lock that in via dt-bindings to guide everyone towards
> >>> using labels (which i did _not_ do in the recently-landed PM8950 and
> >>> PM6125, but will send followup for).
> >>
> >> FYI the patch has been merged already and is now in linux-next
> >> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/arch/arm64/boot/dts/qcom/pmi8950.dtsi?id=0d97fdf380b478c358c94f50f1b942e87f407b9b
> >>
> >> If you have any changes that need to be done please send a follow-up patch.
> > 
> > Unfortunately saw that today as well, well after sending this reply.  I
> > would've loved to correct the pmi8950_gpio label _gpios before someone
> 
> I don't understand what is there to correct. The "pmi8950_gpio" is a
> correct label. There is no single rule saying label should have "s" at
> the end. The only rules are: using underscores and having similar naming
> (e.g. mdss_ for all display labels).

If we were able to have rules for labels, would I then be allowed to
"correct" this?  The inconsistency between DTs is /super/ annoying (and
it looks wrong to have a singular _gpio named thing contain /multiple
gpios/), but just because we can't express this in dt-bindings (or so I
think) we shouldn't change it?

- Marijn
