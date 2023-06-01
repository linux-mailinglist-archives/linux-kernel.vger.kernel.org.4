Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBD9719D84
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 15:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233624AbjFANXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 09:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233657AbjFANXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 09:23:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C883E196;
        Thu,  1 Jun 2023 06:23:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D1296446A;
        Thu,  1 Jun 2023 13:23:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19ACAC433EF;
        Thu,  1 Jun 2023 13:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685625817;
        bh=2Nu2ylXt9pKJIwKd04EwnfYt1AUPOoKUZUCSAoCM0V0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UPS3vEaxeyZvUegv+jMspVrWrIp/uYyoer+SfWAu4tKc2dW6JIWwVXBfAIcqGToag
         gskqVPR5CkyxvLlVm2KHxNEbwb0hQskXdu1xYNzTTmAEsUXdYmIprU3nMIPunp4wPk
         IZ0KAErfLBp5zOyrB7CSBqxI87Fc5M2BkSCFhxbX1REJEHXEYjss1jBPg/kpcqQm4r
         v4Y9jvZXvw9hamv6WzeejPWrpktK9cK7E+n0m3FSNKZfbqrNwHExF8dCzZ6m31LizY
         kcbq8HanmrO1jbVGbtP/TZndDlRC9b8Seq5vpFMMCTJWTI6H3MuYcIRmXk/kUZ74Qq
         KFNpT0G5O0WNQ==
Date:   Thu, 1 Jun 2023 06:27:17 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 07/15] arm64: dts: qcom: sc8180x: Add interconnects
 and lmh
Message-ID: <20230601132717.yslaigqg4lprkniv@ripper>
References: <20230530162454.51708-1-vkoul@kernel.org>
 <20230530162454.51708-8-vkoul@kernel.org>
 <7d4089df-e572-4d3b-6fb7-061d69479dce@linaro.org>
 <ZHhF7zbPYyqdfURV@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZHhF7zbPYyqdfURV@matsya>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2023 at 12:47:03PM +0530, Vinod Koul wrote:
> On 31-05-23, 10:26, Krzysztof Kozlowski wrote:
> > On 30/05/2023 18:24, Vinod Koul wrote:
> > > This add interconnect nodes and add LMH to sc8180x SoC dtsi
> > > 
> > > Co-developed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > > ---
> > 
> > I don't understand why this was split. We talked on IRC many times on
> > this - artificial splits are not "release early, release often". Your
> > previous patchset was correct in that approach, but why this is separate
> > patch?
> 
> Coz the patch was big to review. This is usual Linux approach to break a
> change into smaller chunks for review!
> 

We break patches into small, logical units so that it's easy to follow
the thought through each step in the process of introducing a change.

This is not the same thing as splitting one logical change into multiple
smaller patches to keep the line count of each patch down. This just
forces the reviewer to jump between emails to get the full picture of
the logical change.

And it's not until patch 14 that any of this content is introduced to
the build system, so it's not split to ensure bisectability etc.


I'd be perfectly happy to have received the dts changes as 3-4 patches.

Regards,
Bjorn
