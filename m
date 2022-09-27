Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 015405EB86A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 05:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbiI0DNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 23:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbiI0DMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 23:12:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4E421E1E;
        Mon, 26 Sep 2022 20:09:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9495CB80DAB;
        Tue, 27 Sep 2022 03:09:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 641CFC433C1;
        Tue, 27 Sep 2022 03:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664248189;
        bh=5alXme/iG0Q2Mzk003ElCEPHonmuGvo4KYhWd730jdo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jr+IfCGayJhZN8Z1h6NUhmMgQmfHRkh5g+DrWrQlpiCCbIH8QIA7JEA47F/W6H+1O
         FbeQ2/0FFmYP521UZkMjia47O2zA5fWd+rD8vrgGl+GH9lffjFj5HOITfhrlv5KWEn
         vvKbpVev42H8RmuGATB2JOmSIoB+deFWHSkrx20wuIcYawRVDksgusCN996VNA2nPa
         pNAVnMWvW8/UFgurZkolLIEL9XG7vVhH4g3jUJhhATh87QuX7qEITo00cNyHq4PeMW
         kIVsTDj5/sCdmb0aBRy0qPSdEauJuUl10zuGh7MNVEhiqIPXb6dzOzEabo+9xqdOZs
         J8QJ4m8P1iwvw==
Date:   Mon, 26 Sep 2022 22:09:46 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Adam Skladowski <a39.skl@gmail.com>, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: clock: add QCOM SM6115 display clock
 bindings
Message-ID: <20220927030946.5acxedwvut6ifdmx@builder.lan>
References: <20220911164635.182973-1-a39.skl@gmail.com>
 <20220911164635.182973-2-a39.skl@gmail.com>
 <20220913152620.GA3762864-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220913152620.GA3762864-robh@kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2022 at 10:26:20AM -0500, Rob Herring wrote:
> On Sun, Sep 11, 2022 at 06:46:18PM +0200, Adam Skladowski wrote:
> > Add device tree bindings for display clock controller for
> > Qualcomm Technology Inc's SM6115 SoC.
> > 
> > Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
> > ---
> >  .../bindings/clock/qcom,sm6115-dispcc.yaml    | 70 +++++++++++++++++++
> >  .../dt-bindings/clock/qcom,sm6115-dispcc.h    | 36 ++++++++++
> >  2 files changed, 106 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm6115-dispcc.yaml
> >  create mode 100644 include/dt-bindings/clock/qcom,sm6115-dispcc.h
> > 
> > diff --git a/Documentation/devicetree/bindings/clock/qcom,sm6115-dispcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm6115-dispcc.yaml
> > new file mode 100644
> > index 000000000000..a6bf363b5015
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/qcom,sm6115-dispcc.yaml
> > @@ -0,0 +1,70 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/clock/qcom,sm6115-dispcc.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Qualcomm Display Clock Controller Binding for SM6115
> 
> s/Binding //
> 
> > +
> > +maintainers:
> > +  - Bjorn Andersson <andersson@kernel.org>
> > +
> > +description: |
> 
> Don't need '|' when no formatting to preserve.
> 

This follows the other dispcc bindings, where I think the intention is
to keep the formatting over "See also". In contrast to the other dispcc
bindings the "See also" has a ':' at the end in this proposal...

> With those fixes,
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

I took the liberty of fixing up the description to align with the others
and applied this, with your R-b.

Regards,
Bjorn
