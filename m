Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF394628438
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 16:39:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237139AbiKNPjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 10:39:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237119AbiKNPjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 10:39:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC10F26;
        Mon, 14 Nov 2022 07:39:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8E238B81058;
        Mon, 14 Nov 2022 15:39:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D6E3C433C1;
        Mon, 14 Nov 2022 15:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668440351;
        bh=mA1KjzPbfAQAfbaA1//CTR8f6auD5NBTZPXJkdjuph0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e+GIgsB99NI6a1guMLfwim6sPGuWTbYWG70mGVUecec1A59sE+3Jf8PZBYQl3p35h
         tAOnLGlAiZbkV2ZeXsCeN6hsZJcZtr5ON6okWWjQufi+dk5sehYm90VYknr6kOeFnQ
         emiGZdIzwl71nmeMc5ReFFJp3iRpSthweREHPzVymNmuXzPq/SKIAQV0LLN5BAjG5F
         cGUs6WEOsHFZKQ65c26ZYKAlbvlfXwkcm4wZJO+aM6p7QL2h03HcejFyfgK1pee75N
         kNELUZlZ9ZteHmeAbk11n5hl27ZhZ47/I7ZSdqDjdp75xVkq4TRcgGOxaCP/Ukzwd4
         lqaDT/CdV7viA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oubXi-0004Jr-IE; Mon, 14 Nov 2022 16:38:39 +0100
Date:   Mon, 14 Nov 2022 16:38:38 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/14] dt-bindings: phy: qcom,qmp-usb3-dp: fix sc8280xp
 bindings
Message-ID: <Y3Jg/qmMW3rC5Okc@hovoldconsulting.com>
References: <20221111092457.10546-1-johan+linaro@kernel.org>
 <20221111092457.10546-3-johan+linaro@kernel.org>
 <a22888cd-34cb-3453-0dc2-096da208564c@linaro.org>
 <Y3JCVzJ74YsfcDz4@hovoldconsulting.com>
 <de3a426a-03e8-ed15-a9a1-bb300e776e5f@linaro.org>
 <Y3JOO0kNnaNhnW3K@hovoldconsulting.com>
 <78cda6f8-849c-219a-8dbb-966c283c1a92@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78cda6f8-849c-219a-8dbb-966c283c1a92@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 06:19:25PM +0300, Dmitry Baryshkov wrote:
> On 14/11/2022 17:18, Johan Hovold wrote:
> > On Mon, Nov 14, 2022 at 03:07:41PM +0100, Krzysztof Kozlowski wrote:
> >> On 14/11/2022 14:27, Johan Hovold wrote:
> >>> On Fri, Nov 11, 2022 at 04:17:29PM +0100, Krzysztof Kozlowski wrote:
> >>>> On 11/11/2022 10:24, Johan Hovold wrote:

> >>> I noticed that several bindings leave the clock indexes unspecified, or
> >>> have header files defining some or all of them. I first added a QMP
> >>> header but that seemed like overkill, especially if we'd end up with
> >>> one header per SoC (cf. the GCC headers) due to (known and potential)
> >>> platform differences.

> >>> Shall I add back a shared header for all PHYs handled by this driver
> >>> (another implementation detail) even if this could eventually lead to
> >>> describing clocks not supported by a particular SoC (so such constraints
> >>> would still need to be described by the binding somehow):
> >>>
> >>> 	/* QMP clocks */
> >>> 	#define QMP_USB3_PIPE_CLK	0
> >>> 	#define QMP_DP_LINK_CLK		1
> >>> 	#define QMP_DP_VCO_DIV_CLK	2
> 
> Maybe QMP_COMBO_USB3_PIPE_CLK, QMP_COMBO_DP_LINK_CLK, 
> QMP_COMBO_DP_VCO_DIV_CLK?

"COMBO" is just the name of the Linux driver and does not belong in the
binding.
 
> I'll then extend this header with QMP_UFS_RX_SYMBOL_0_CLK 
> QMP_UFS_RX_SYMBOL_1_CLK and QMP_UFS_TX_SYMBOL_0_CLK.

Yeah, I had those in mind when creating the header and using a generic
QMP prefix (even if I didn't end up using the header in v1).

This could just be mapping of (arbitrary) QMP indexes to clocks and we
use it for USB3, DP, UFS and later also USB4.

This will however mean that the indexes are not necessarily zero-based
and consecutive for a specific SoC and PHY. But that's perhaps a
non-issue (cf. the PHY_TYPE defines).

We'd still need to describe which clocks are available on a particular
SoC and PHY, and that's partly why I used 'clock-output-names' to fix
the mapping in the binding. Guess we can just list the valid defines in
the property description as I did for #phy-cells.

Johan
