Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6C861E206
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 13:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbiKFMN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 07:13:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbiKFMNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 07:13:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60A726E;
        Sun,  6 Nov 2022 04:13:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E57760C54;
        Sun,  6 Nov 2022 12:13:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC207C433C1;
        Sun,  6 Nov 2022 12:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667736800;
        bh=n7I0dfh4J22AKYzyGTJXvVtld9av1k13Mzj9MWHRvtw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HxeB+8akcnzj8crEMbCHkEU2HpNJkll3UynQkNIXLbk/dRWogZZOSjGrLDB9rYBwz
         E1tsW1FkeuTrRYVUj18u4C1NZ7tvRjHXWZ9X8Cvyvzr/lOgh6xqSZShydv9jKRI8/F
         K3fpUpCNpiY6QfzfwLFl+HS/wMpN09nmfW1t3EJsWieqy9dnKT46M7yShWJsXMogi5
         uwfmt/fjdA4DVZFjuWmZmRd+5i/HXrl9RzQHYf/qr9vAsvoCVPpyRnKpgifP8JV2ES
         TAfrZJdxkxVPYLU2uHeYWnwk3axWKpAEBUkSzwRHqz3gHUnIfs4CFqgY4YS/f6Ub35
         aa3tr9aEEoXoQ==
Date:   Sun, 6 Nov 2022 12:13:10 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Luca Weiss <luca@z3ntu.xyz>, linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        afd@ti.com, Lars-Peter Clausen <lars@metafoo.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio/adc: qcom,spmi-iadc: use double
 compatibles
Message-ID: <20221106121310.3ad643be@jic23-huawei>
In-Reply-To: <20221102163136.GA4004075-robh@kernel.org>
References: <20221031182456.952648-1-luca@z3ntu.xyz>
        <20221102163136.GA4004075-robh@kernel.org>
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

On Wed, 2 Nov 2022 11:31:36 -0500
Rob Herring <robh@kernel.org> wrote:

> On Mon, Oct 31, 2022 at 07:24:54PM +0100, Luca Weiss wrote:
> > As in other bindings, let's use specific compatibles together with the
> > fallback compatible. Adjust the bindings for it.  
> 
> You should state users are already doing this.
> 
I can fix that up whilst applying.  However it raises the question:
Should I treat this as a fix, or a tidy up (that can wait for next merge window)?

I'm also fine with this going with the other patch in the series (that lore
found for me as it didn't go to linux-iio) if that makes more sense.

If that happens

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Jonathan

> > 
> > Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> > ---
> > Changes in v2:
> > * New patch
> > 
> >  .../devicetree/bindings/iio/adc/qcom,spmi-iadc.yaml        | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)  
> 
> Acked-by: Rob Herring <robh@kernel.org>

