Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A917E648FDF
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 18:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbiLJRFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 12:05:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiLJRFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 12:05:36 -0500
Received: from m-r1.th.seeweb.it (m-r1.th.seeweb.it [IPv6:2001:4b7a:2000:18::170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F7B15A1B;
        Sat, 10 Dec 2022 09:05:34 -0800 (PST)
Received: from SoMainline.org (94-209-172-39.cable.dynamic.v4.ziggo.nl [94.209.172.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id DDAFD1F887;
        Sat, 10 Dec 2022 18:05:32 +0100 (CET)
Date:   Sat, 10 Dec 2022 18:05:31 +0100
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Luca Weiss <luca@z3ntu.xyz>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] arm64: dts: qcom: Use plural _gpios node label for
 PMIC gpios
Message-ID: <20221210170531.pxoux2kje4vgor5y@SoMainline.org>
Mail-Followup-To: Marijn Suijten <marijn.suijten@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Luca Weiss <luca@z3ntu.xyz>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221209220450.1793421-1-marijn.suijten@somainline.org>
 <714ac62a-7bab-e16e-e3b6-bdd86e422699@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <714ac62a-7bab-e16e-e3b6-bdd86e422699@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-12-10 11:50:51, Krzysztof Kozlowski wrote:
> On 09/12/2022 23:04, Marijn Suijten wrote:
> > The gpio node in PMIC dts'es define access to multiple GPIOs.  Most Qcom
> > PMICs were already using the plural _gpios label to point to this node,
> > but a few PMICs were left behind including the recently-pulled
> > pm(i)8950.
> > 
> > Rename it from *_gpio to *_gpios for pm6125, pm6150(l), pm8005,
> > pm(i)8950, and pm(i)8998.
> > 
> > Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> > 
> > ---
> > 
> > This was brought up for discussion in [1] but hasn't seen any relevant
> > reply, unfortunately.
> 
> This is just a label, it does not matter. Why changing all exisitng
> files? I don't think it was a part of previous discussions...

I would've let it slide if it was corrected in the patch that was
reviewed, but since that didn't happen it wouldn't make sense to only
correct pmi8950 (and the other bindings submitted or co-authored by
myself, such as pm6125 and pm8950) for "consistency" - that wouldn't be
consistent at all.

To me (and supposedly, to other as well) it does matter.  People keep
copy-pasting these to to add a newer PMIC and sooner rather than later
we'll end up with both conventions.

Regardless, labels are already a mess all over the place, and unless we
can steer them with bindings or written conventions we're unlikely to
ever clean that up.

> To me it is unneeded churn.

Just like -state and -pins suffix, sometimes even the unnecessary
-pins-pins suffix?  To me that is the same kind of churn, and *it is
needed* to keep the bindings somewhat clean, consistent and digestible.
In this specific case it's not even that many changes, IMO.

That being said my limited hobby time is probably too valuable to be
spent on binding cleanup rather than fixes and feature enablement
elsewhere in the kernel.

- Marijn
