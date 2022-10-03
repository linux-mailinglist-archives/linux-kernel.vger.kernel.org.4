Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38BFA5F284F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 07:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiJCF51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 01:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiJCF5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 01:57:25 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED443499F;
        Sun,  2 Oct 2022 22:57:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5AFFBCE0AC6;
        Mon,  3 Oct 2022 05:57:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCE41C433D6;
        Mon,  3 Oct 2022 05:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664776639;
        bh=DkLwAywA2rWJ7v4sNijkAd67LyPIxqvzoVbJZbXrNa8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gRd5IdCxnBL6sGiB+FZ9y1Lmj1QCHD+Er48KZ81+zjvg9BiAzwLfCb3YqaknekeA2
         7d5iUfRazZteFl971nZlYKK01Rk7rgWH3iCHhPxZpWfJpcmxSivjj1QcxvPPoSJ3Rf
         sUIXvf6y6NtrwsH+87i1cUNaYLEkA8UkTA20eZ6o2wRDWyympwW6aoz5kbybMkIO6o
         aOlaxKAATzd3CrsF8ugGYbqQf3B1p0gD/LLN3SNwSUcvuRfID7ULRu50GXFjOqQjxI
         fafNwXVjpvZq+cOZw8XsqJimwHi+GxWiyRSg+UyNgs2PwUvaf/PsSk+QGzc3AKey6g
         C7tBaTFmX50qA==
Date:   Mon, 3 Oct 2022 11:27:15 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 0/2] spmi: pmic-arb: Add support for PMIC v7
Message-ID: <Yzp5u7GgT+bDI4RG@matsya>
References: <20220914165212.3705892-1-vkoul@kernel.org>
 <YysqiefYFYC13Ykm@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YysqiefYFYC13Ykm@matsya>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-09-22, 20:45, Vinod Koul wrote:
> On 14-09-22, 22:22, Vinod Koul wrote:
> > Hello,
> > 
> > The is version 5 of support for PMIC v7. I have added a new property
> > qcom,bus-id for supporting v7 and then add driver changes for v7
> 
> Steve,
> 
> Can you please get this in for v6.1 ?

I dont know what I can do now to get this patch in... looks like 6.1 is
missed too!

> 
> > 
> > Changes since v4:
> >  - Fix David name and email
> >  - remove trailing line in binding
> > 
> > Changes since v3:
> >  - rebase on spmi/next
> > 
> > David Collins (1):
> >   spmi: pmic-arb: Add support for PMIC v7
> > 
> > Vinod Koul (1):
> >   dt-bindings: spmi: Add qcom,bus-id
> > 
> >  .../bindings/spmi/qcom,spmi-pmic-arb.yaml     |  10 +
> >  drivers/spmi/spmi-pmic-arb.c                  | 242 ++++++++++++++++--
> >  2 files changed, 231 insertions(+), 21 deletions(-)
> > 
> > 
> > base-commit: 18c42f8d23426d3f4048df89523aa47203c3493a
> > -- 
> > 2.37.3
> 
> -- 
> ~Vinod

-- 
~Vinod
