Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCB2262FB43
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 18:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241679AbiKRRLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 12:11:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242547AbiKRRKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 12:10:55 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3848CF10;
        Fri, 18 Nov 2022 09:10:50 -0800 (PST)
Received: from g550jk.localnet (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 28FBBCAE34;
        Fri, 18 Nov 2022 17:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1668791418; bh=H8LeYLsrrHDcYvO2z/fKun56/ndn3rLQwgBtKmM3hk4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Iv5ai0HwlG35CGMM4PW5M2jRZV1kAEqDIllnhNwaMzZaJKI/p+rwhNLl9J64DWWGS
         TmBkUj14j7NwEHt7Dud75+EW+Yl0g8Bki08N5UjlZDa5L8WBkSVS+mr1NZfZqrE/5O
         FgTYpnHVEAGjTZ8RltkPdnYvrnnDo9CEv1pTZvjI=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     Rob Herring <robh@kernel.org>, Jonathan Cameron <jic23@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        afd@ti.com, Lars-Peter Clausen <lars@metafoo.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio/adc: qcom,spmi-iadc: use double compatibles
Date:   Fri, 18 Nov 2022 18:10:17 +0100
Message-ID: <2259963.ElGaqSPkdT@g550jk>
In-Reply-To: <20221106121310.3ad643be@jic23-huawei>
References: <20221031182456.952648-1-luca@z3ntu.xyz> <20221102163136.GA4004075-robh@kernel.org> <20221106121310.3ad643be@jic23-huawei>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

On Sonntag, 6. November 2022 13:13:10 CET Jonathan Cameron wrote:
> On Wed, 2 Nov 2022 11:31:36 -0500
> 
> Rob Herring <robh@kernel.org> wrote:
> > On Mon, Oct 31, 2022 at 07:24:54PM +0100, Luca Weiss wrote:
> > > As in other bindings, let's use specific compatibles together with the
> > > fallback compatible. Adjust the bindings for it.
> > 
> > You should state users are already doing this.
> 
> I can fix that up whilst applying.  However it raises the question:
> Should I treat this as a fix, or a tidy up (that can wait for next merge
> window)?
> 
> I'm also fine with this going with the other patch in the series (that lore
> found for me as it didn't go to linux-iio) if that makes more sense.
> 

Sorry for the delay in answering.
The dts patch (2/2) has already been picked up through qcom tree, so I think 
you can apply this one to your tree.
It's definitely not urgent, so next merge window would be perfect.

Regards
Luca

> If that happens
> 
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Jonathan
> 
> > > Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> > > ---
> > > Changes in v2:
> > > * New patch
> > > 
> > >  .../devicetree/bindings/iio/adc/qcom,spmi-iadc.yaml        | 7 +++++--
> > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > 
> > Acked-by: Rob Herring <robh@kernel.org>




