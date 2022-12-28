Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F35F3658623
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 19:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbiL1S5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 13:57:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbiL1S5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 13:57:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3FD17074;
        Wed, 28 Dec 2022 10:57:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 18357615A0;
        Wed, 28 Dec 2022 18:57:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97A5FC433EF;
        Wed, 28 Dec 2022 18:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672253823;
        bh=DREtdnJeXc6R6wIE9paEufR2i5KPgK7BYcKbJMgBpjY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a37xw12AJT4hBNwCimK7qCcBD2OWoHaTYP20D64esILnl3s8fJc1j91Z7WAjlEcC3
         sLFOhBkbqhWoRlKw7uYnQm3L3E9it26gr8K+PTsqIeGEYKPxq77rkEeqi0vuAYrfVJ
         fwHp2PTSfOSIxN9daAOWwIZ8uv0FDy43Q5tvA2L6u97QckqAfETGYbHg0bm2Tbvam8
         AtMJhthvLa/6Kf2t3Mfz0uWepaACvRI77BfsrWPlT7Zgn+FLdz9F6CbiBQwNWATl5f
         8OgCUybWq2k1cxZG4RD6R2DwCTPZDB7mbaq14WoMRB58lMl3zi6EwJMItrUS+tr+jb
         xFo7DhXfC3/PQ==
Date:   Wed, 28 Dec 2022 12:57:00 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Georgi Djakov <djakov@kernel.org>, Abel Vesa <abel.vesa@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v5 1/2] dt-bindings: interconnect: Add Qualcomm SM8550
Message-ID: <20221228185700.4tyziwqiiopafstl@builder.lan>
References: <20221202232054.2666830-1-abel.vesa@linaro.org>
 <20221202232054.2666830-2-abel.vesa@linaro.org>
 <20221205221425.c6eiserur27clirp@builder.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221205221425.c6eiserur27clirp@builder.lan>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2022 at 04:14:25PM -0600, Bjorn Andersson wrote:
> On Sat, Dec 03, 2022 at 01:20:53AM +0200, Abel Vesa wrote:
> > The Qualcomm SM8550 SoC has several bus fabrics that could be
> > controlled and tuned dynamically according to the bandwidth demand.
> > 
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> @Georgi, would you mind picking this patch on its own, create a git tag
> and share that tag with me (and then merge the tag into your tree...),
> so that I can merge the dts patches ontop?
> 

dt-bindings/clock/qcom,sm8550-gcc.h has now made it into v6.2-rc1, so
you should be able to merge this now,Georgi.

In order for me to pick the dts patches I still would need a immutable
branch/tag.

Thanks,
Bjorn
