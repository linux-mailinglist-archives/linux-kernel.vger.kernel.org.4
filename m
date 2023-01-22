Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6AAB67737B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 00:37:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjAVXhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 18:37:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjAVXhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 18:37:47 -0500
Received: from relay03.th.seeweb.it (relay03.th.seeweb.it [IPv6:2001:4b7a:2000:18::164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B2228A59;
        Sun, 22 Jan 2023 15:37:45 -0800 (PST)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 0B73F1F54F;
        Mon, 23 Jan 2023 00:37:42 +0100 (CET)
Date:   Mon, 23 Jan 2023 00:37:41 +0100
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: Require generic adc-chan
 name for channel nodes
Message-ID: <20230122233741.7jn2nzghfvhgoemr@SoMainline.org>
Mail-Followup-To: Marijn Suijten <marijn.suijten@somainline.org>,
        Jonathan Cameron <jic23@kernel.org>, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>, iio@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20230119212632.185881-1-marijn.suijten@somainline.org>
 <20230119212632.185881-2-marijn.suijten@somainline.org>
 <20230121170825.0d284151@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230121170825.0d284151@jic23-huawei>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-01-21 17:08:25, Jonathan Cameron wrote:
> On Thu, 19 Jan 2023 22:26:31 +0100
> Marijn Suijten <marijn.suijten@somainline.org> wrote:
> 
> > As discussed in [1] it is more convenient to use a generic adc-chan node
> > name for ADC channels while storing a friendly - board-specific instead
> > of PMIC-specific - name in the label, if/when desired to overwrite the
> > channel description already contained (but previously unused) in the
> > driver [2].
> > 
> > Replace the .* name pattern with the adc-chan literal, but leave the
> > label property optional for bindings to choose to fall back a channel
> > label hardcoded in the driver [2] instead.
> > 
> > [1]: https://lore.kernel.org/linux-arm-msm/20221106193018.270106-1-marijn.suijten@somainline.org/T/#u
> > [2]: https://lore.kernel.org/linux-arm-msm/20230116220909.196926-4-marijn.suijten@somainline.org/
> > 
> > Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> Other than the use in the tm5 thermal example that Rob's bot found, this looks
> good to me.

Yep, shouldn't have ran dt_binding_check and dtbs_check with
DT_SCHEMA_FILES=just/the/one/edited/here.

> I think ideal would be to fix that in a precursor patch then
> do this one.

Can't that be part of the current one?  At least the change requested by
dt-bindings here is backwards-compatible; the adc-chan@xx format with
optional label property was already allowed.

> Note that the existing two patches should be in the other order
> 1. Update the dtsi
> 2. Tighten the bounds to check they are right.

Hmm, I'm never sure what goes first: drivers, bindings, or DT
(considering there's an ABI it shouldn't matter whether drivers or DT
go first, leaving just dt-bindings which could be used to TDD the DT...
or check adjustment after the fact).  Is this relationship - and the
order following from it - documented somewhere?

> Doesn't matter much though as the two patches will probably go through
> different trees.

Should be right, indeed.

- Marijn
