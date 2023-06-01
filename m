Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E18907193FD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 09:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbjFAHRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 03:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjFAHRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 03:17:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E48F129;
        Thu,  1 Jun 2023 00:17:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C6F6B641CE;
        Thu,  1 Jun 2023 07:17:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6881BC433EF;
        Thu,  1 Jun 2023 07:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685603828;
        bh=lFxVqHllcG3lgD1iV1Z0FPSYL2IAzqEz/TFrgzuj/GE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JwRgk1d9gEBP9CbER7TDB8+paz2PnwQBNBP1/61cr1B4pNsTwx4mxnaMinxnzfHJf
         OJX1ngqsE9Y+K/bZp/suNhK55GaKN4HkF55QZCrTyYC1tRvDkmXpDaXWg4Rc9B7J/8
         h19sUk8AUsHX3Rpd/VBc2voLbUvT5g8sDi9+KF1Gk4d0fZX86YP3DvC0yqrkaR9WeR
         z+7YQ3hHPjjEUFs70kgeuE8qHSWscE+PfUl3vtcKzrywjv1tPK0UOWigy9jfQoV/C/
         5bemy6mv3f3kC6gYvdAkNsaQt30wC9dyfIlrZcqddlDKjPwJt+ZBFTS+JHdz7DNvJq
         9/scfj3CQb6NA==
Date:   Thu, 1 Jun 2023 12:47:03 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 07/15] arm64: dts: qcom: sc8180x: Add interconnects
 and lmh
Message-ID: <ZHhF7zbPYyqdfURV@matsya>
References: <20230530162454.51708-1-vkoul@kernel.org>
 <20230530162454.51708-8-vkoul@kernel.org>
 <7d4089df-e572-4d3b-6fb7-061d69479dce@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d4089df-e572-4d3b-6fb7-061d69479dce@linaro.org>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31-05-23, 10:26, Krzysztof Kozlowski wrote:
> On 30/05/2023 18:24, Vinod Koul wrote:
> > This add interconnect nodes and add LMH to sc8180x SoC dtsi
> > 
> > Co-developed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > ---
> 
> I don't understand why this was split. We talked on IRC many times on
> this - artificial splits are not "release early, release often". Your
> previous patchset was correct in that approach, but why this is separate
> patch?

Coz the patch was big to review. This is usual Linux approach to break a
change into smaller chunks for review!

-- 
~Vinod
