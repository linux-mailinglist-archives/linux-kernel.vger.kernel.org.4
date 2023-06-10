Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B740872AD37
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 18:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjFJQVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 12:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjFJQVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 12:21:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26F230E4;
        Sat, 10 Jun 2023 09:21:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5BC6261135;
        Sat, 10 Jun 2023 16:21:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0647CC433EF;
        Sat, 10 Jun 2023 16:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686414064;
        bh=XPRPDFAeHAguOSutCbcgO+ZpDKUbl65niaxafIt4aZI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dQYQeo4Cr/Pp4nZwrYcbytNKhZr/RHBFiMVZfNJEwuaJfPqkf4LxyDPlitZV4+3ya
         4yhlZyJZ0DTB48UuX4WLfonKOrzdFHkN3z3evXMESpSzUBrnzKy6ZeeETN8hSmkTNn
         LrzBc+wo34pHQ51j/WPVseIh4gtmKaF9Gvj9GBCFrx/3o7EJ6zkfxOaee2itTis+FT
         tE14fUY3zENd/wWb5M7OwLQoz1mbAwsoKGGGw9s8k3bBqB08+mVjsZa+9k455sOdg1
         Uwj4F7CjUpzZCp1obqnYCPTUHvsnfcY8a2kA2AltQgHy5fTZJoas9Oveknx08aEJLh
         V98h9BYD+1IhQ==
Date:   Sat, 10 Jun 2023 09:24:32 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 07/15] arm64: dts: qcom: sc8180x: Add interconnects
 and lmh
Message-ID: <20230610162432.mskkurycytjzt63z@ripper>
References: <20230530162454.51708-1-vkoul@kernel.org>
 <20230530162454.51708-8-vkoul@kernel.org>
 <7d4089df-e572-4d3b-6fb7-061d69479dce@linaro.org>
 <ZHhF7zbPYyqdfURV@matsya>
 <20230601132717.yslaigqg4lprkniv@ripper>
 <3613f6ed-f8ad-a62c-6c0d-932bca7956dd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3613f6ed-f8ad-a62c-6c0d-932bca7956dd@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2023 at 05:27:21PM +0200, Krzysztof Kozlowski wrote:
> On 01/06/2023 15:27, Bjorn Andersson wrote:
> > On Thu, Jun 01, 2023 at 12:47:03PM +0530, Vinod Koul wrote:
> >> On 31-05-23, 10:26, Krzysztof Kozlowski wrote:
> >>> On 30/05/2023 18:24, Vinod Koul wrote:
> >>>> This add interconnect nodes and add LMH to sc8180x SoC dtsi
> >>>>
> >>>> Co-developed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> >>>> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> >>>> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> >>>> ---
> >>>
> >>> I don't understand why this was split. We talked on IRC many times on
> >>> this - artificial splits are not "release early, release often". Your
> >>> previous patchset was correct in that approach, but why this is separate
> >>> patch?
> >>
> >> Coz the patch was big to review. This is usual Linux approach to break a
> >> change into smaller chunks for review!
> >>
> > 
> > We break patches into small, logical units so that it's easy to follow
> > the thought through each step in the process of introducing a change.
> 
> For example splitting interconnects which are essential part of several
> IP blocks is not making it easy. One patch introduces incomplete block
> which is then fixed (completed) in next patch.
> 
> > 
> > This is not the same thing as splitting one logical change into multiple
> > smaller patches to keep the line count of each patch down. This just
> > forces the reviewer to jump between emails to get the full picture of
> > the logical change.
> 
> Reviewer has to jump here to see full picture of UART or some other IP
> block.
> 

Sorry if it wasn't clear, I'm trying to make the same argument as you,
Krzysztof.


The way to split such series would be to introduce some minimal bootable
board, and then extend that in a bisectable fashion. But given that both
contributor and maintainer primarily care about the whole set at this
stage, I'd generally prefer longer patches.

Regards,
Bjorn
