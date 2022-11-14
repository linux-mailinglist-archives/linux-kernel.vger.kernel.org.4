Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4566462850E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 17:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237186AbiKNQWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 11:22:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237472AbiKNQWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 11:22:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C3F2FC07;
        Mon, 14 Nov 2022 08:22:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 398C0612BE;
        Mon, 14 Nov 2022 16:22:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84DBAC433D7;
        Mon, 14 Nov 2022 16:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668442944;
        bh=1qhbjtrf4OBeymlcd5IJ17ytL34jXMNYYy2ti/5wf+8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WdZE0bgMsqEaxuR8BIVcBnFO5zLpsGWoIXXW/zhOzAXRvB+DMNeSsElwiNjTSLVkX
         MMQipvVKqO0F43RZCVFC9+Gc63TaDYzRUjuKMKd4p7+LnTPFVMsGfPqkgrHNfOQ4n6
         +R8fggl04sAK1uWDIfwvNMmOKpITUZREPUfWb5MnfeXjYI4/8JgFH8x87ceYVRThqR
         60CZYene5AsbkxfhAFhuOuUdLfwNkXZUfo6eU5PVMh01sIpyTqBaXZab7N0bFgw4JJ
         6gXqdZPDgJd1VLMGxJzOu7X1jTpD/8KyJrxfiRSyyYbZ/Gy5QnbcTQU/zz2j313h8k
         3J9e3QH9vCpsQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oucDX-0004vF-Tb; Mon, 14 Nov 2022 17:21:52 +0100
Date:   Mon, 14 Nov 2022 17:21:51 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/14] dt-bindings: phy: qcom,qmp-usb3-dp: fix sc8280xp
 bindings
Message-ID: <Y3JrH+Om8qRV8JPJ@hovoldconsulting.com>
References: <20221111092457.10546-1-johan+linaro@kernel.org>
 <20221111092457.10546-3-johan+linaro@kernel.org>
 <ace91d8b-9a14-5569-7c59-344e9751fa96@linaro.org>
 <Y3JEh7wO394kepXq@hovoldconsulting.com>
 <42ae9612-43da-5f3a-534d-d30b9f399f90@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42ae9612-43da-5f3a-534d-d30b9f399f90@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 06:31:02PM +0300, Dmitry Baryshkov wrote:
> On 14/11/2022 16:37, Johan Hovold wrote:
> > On Sat, Nov 12, 2022 at 02:43:03PM +0300, Dmitry Baryshkov wrote:
> >> On 11/11/2022 12:24, Johan Hovold wrote:

> >>> +  "#clock-cells":
> >>> +    const: 1
> >>> +
> >>> +  clock-output-names:
> >>> +    items:
> >>> +      - const: usb3_pipe
> >>> +      - const: dp_link
> >>> +      - const: dp_vco_div
> >>> +
> >>> +  "#phy-cells":
> >>> +    const: 1
> >>> +    description: |
> >>> +      PHY index
> >>> +        - PHY_TYPE_USB3
> >>> +        - PHY_TYPE_DP
> >>
> >> I'm stepping on Rob's and Krzysztof's ground here, but it might be more
> >> logical and future proof to use indices instead of phy types.
> > 
> > Why would that be more future-proof?
> > 
> > I initially added defines for these indexes to a QMP header, but noticed
> > that we already have PHY drivers that use the PHY types for this. So
> > there's already a precedent for this and I didn't see any real benefit
> > to adding multiple per-SoC defines for the same thing.
> 
> As you guessed from my question, I was thinking about USB4 (for which we 
> do not have a separate PHY_TYPE, but that probably shouldn't matter). 

Yeah, that's easy enough to add.

> Would it be a separate PHY here, or would it be a combo UBS3+USB4 plus 
> separate DP phy?

We don't know yet.

> Yes, we have other PHYs, which use types as an index, however it's 
> slightly more common to have indices instead.

If you look at (yaml) bindings using a single phy-cell, the majority
simply ignores describing what the index is used for and which values
are valid. Of the few that do describe it, the cell index is either used
for something which does not allow itself for mapping to PHY_TYPE or
PHY_TYPE is used.

> Anyway, this is a minor issue. It might be just that I'm more common to 
> using indices everywhere (in other words, I have preference here, but 
> it's not a strong requirement from my side).

I don't have a strong preference here either. Let's see what Krzysztof
and Rob says.

Johan
