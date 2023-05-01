Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B30316F39F4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 23:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbjEAV4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 17:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232101AbjEAV4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 17:56:12 -0400
Received: from m-r2.th.seeweb.it (m-r2.th.seeweb.it [5.144.164.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F1C26AA
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 14:56:09 -0700 (PDT)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id B492140DE9;
        Mon,  1 May 2023 23:56:06 +0200 (CEST)
Date:   Mon, 1 May 2023 23:56:04 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v4 5/5] dt-bindings: iio: adc: Require generic `channel`
 name for channel nodes
Message-ID: <qqfqnj5cta5j6dpv2mli2dt6wdjghxt23u5ivvadhltxh6vd2d@lka4jue7blne>
Mail-Followup-To: Marijn Suijten <marijn.suijten@somainline.org>, 
        Jonathan Cameron <jic23@kernel.org>, phone-devel@vger.kernel.org, 
        ~postmarketos/upstreaming@lists.sr.ht, 
        AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
        Martin Botka <martin.botka@somainline.org>, Jami Kettunen <jami.kettunen@somainline.org>, 
        Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>, 
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Andy Gross <agross@kernel.org>, 
        Bjorn Andersson <andersson@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
        linux-arm-msm@vger.kernel.org
References: <20230410202917.247666-1-marijn.suijten@somainline.org>
 <20230410202917.247666-6-marijn.suijten@somainline.org>
 <20230412212756.0b4b69f3@jic23-huawei>
 <c653un4emxud34gpo5np7jtnhsym5thpivjwcgpm2vsft2q2qj@s66thxonibjc>
 <20230415174943.2b731203@jic23-huawei>
 <20230501171838.461501b1@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230501171838.461501b1@jic23-huawei>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-01 17:18:38, Jonathan Cameron wrote:
<snip>
> > > > Otherwise we can do (a) early in next cycle.  Feel free to poke me if we are doing (b)
> > > > and I seem to have forgotten to pick up this patch!    
> > > 
> > > Thanks!  I hope we don't get many conflicts (+ new bindings adhering to
> > > the old(er) formats) otherwise I'll resend if we do (a).  Around what
> > > time would be good, rc2?  
> > 
> > Sure. If rebase is needed send a v5 with that done.  If not, a simple
> > reminder reply to this thread will probably work.
> 
> I've started queuing stuff for the next cycle as the relevant pull requests
> are for the IIO tree for this cycle were picked up a few days ago.
> 
> Hence, applied to the togreg branch of iio.git and pushed out as testing for 0-day
> to take a quick look at it.

Thanks, running with:

    make VALIDATE_DT=1 ARCH=arm64 dt_binding_checka dtbs_check \
        DT_SCHEMA_FILES="Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml"

And similar for ARCH=arm on -next-20230428 shows that there is no new
use of the old (arbitrary) node name format, so no v5 should be
necessary (unless those patches also land at the same time...).

Such a resend would only affect patch 1/5 and 3/5 though, which rewrite
the actual DTS node names.

- Marijn
