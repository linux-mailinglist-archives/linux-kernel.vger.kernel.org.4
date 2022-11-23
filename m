Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D32DD636B6C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 21:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237613AbiKWUmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 15:42:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239467AbiKWUls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 15:41:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB5F3FB89;
        Wed, 23 Nov 2022 12:40:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7CD6461EE0;
        Wed, 23 Nov 2022 20:40:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFF2BC433C1;
        Wed, 23 Nov 2022 20:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669236045;
        bh=Yp9Bb9HKkMQujnOoIHYXW9MwZHd9AcXAOCWV4wdNkKg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=I+pV7Sq35DijtqEPr3f3H9wlRaRHxIJK/BlwelXX8Ku42XwU81y68YTy4dRWjswVh
         mWI37xjp/xaEJMNhIU9YRo+RwWI6CPN1z2x6Pmgc2me8d6BJOEQdClP63IsBmQKHEr
         xfWi4Zc7YHFcWeG8epq8gBFMDtc93f8JTqG6EiJShX0KC6INMZkYIyoKRPwl/9Qz+Q
         BOoE+DbctWhYtdXtB4U8eXGPfmNLd7Wbngo69rv/DZEP8VYFtxMu2zGOaseTsxXH4D
         /Y5c9hKklw9A7q9i1FvoglqTzRbyLsEFjKPtky21O22qDWqX7YxEixatab4l4PY5Fy
         0/mz1guBEqkRA==
Date:   Wed, 23 Nov 2022 20:53:18 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        afd@ti.com, Lars-Peter Clausen <lars@metafoo.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio/adc: qcom,spmi-iadc: use double
 compatibles
Message-ID: <20221123205318.5afba8a3@jic23-huawei>
In-Reply-To: <2259963.ElGaqSPkdT@g550jk>
References: <20221031182456.952648-1-luca@z3ntu.xyz>
        <20221102163136.GA4004075-robh@kernel.org>
        <20221106121310.3ad643be@jic23-huawei>
        <2259963.ElGaqSPkdT@g550jk>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

On Fri, 18 Nov 2022 18:10:17 +0100
Luca Weiss <luca@z3ntu.xyz> wrote:

> Hi Jonathan,
> 
> On Sonntag, 6. November 2022 13:13:10 CET Jonathan Cameron wrote:
> > On Wed, 2 Nov 2022 11:31:36 -0500
> > 
> > Rob Herring <robh@kernel.org> wrote:  
> > > On Mon, Oct 31, 2022 at 07:24:54PM +0100, Luca Weiss wrote:  
> > > > As in other bindings, let's use specific compatibles together with the
> > > > fallback compatible. Adjust the bindings for it.  
> > > 
> > > You should state users are already doing this.  
> > 
> > I can fix that up whilst applying.  However it raises the question:
> > Should I treat this as a fix, or a tidy up (that can wait for next merge
> > window)?
> > 
> > I'm also fine with this going with the other patch in the series (that lore
> > found for me as it didn't go to linux-iio) if that makes more sense.
> >   
> 
> Sorry for the delay in answering.
> The dts patch (2/2) has already been picked up through qcom tree, so I think 
> you can apply this one to your tree.
> It's definitely not urgent, so next merge window would be perfect.

Applied
> 
> Regards
> Luca
> 
> > If that happens
> > 
> > Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Jonathan
> >   
> > > > Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> > > > ---
> > > > Changes in v2:
> > > > * New patch
> > > > 
> > > >  .../devicetree/bindings/iio/adc/qcom,spmi-iadc.yaml        | 7 +++++--
> > > >  1 file changed, 5 insertions(+), 2 deletions(-)  
> > > 
> > > Acked-by: Rob Herring <robh@kernel.org>  
> 
> 
> 
> 

