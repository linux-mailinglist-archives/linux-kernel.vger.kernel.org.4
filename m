Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75A246285B6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 17:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237677AbiKNQmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 11:42:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237736AbiKNQmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 11:42:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B5B5DF1;
        Mon, 14 Nov 2022 08:42:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB2EC61219;
        Mon, 14 Nov 2022 16:42:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1053EC433D6;
        Mon, 14 Nov 2022 16:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668444161;
        bh=hRBdhqMc6OYL10Q8b4E/JCySj2Eo2gVK3zL2fjOrMlo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j7FWgRcW0epR6TtBjy9YI9IU44+v3CQb8+1aTQKALfeopxj6uksUsPYQCaERdI87Y
         WNHL3o+tileeRlqet/v0sKD8oGgq5aY4YOT+3b+xuMETsMyjcsbFEfKQ5uEfV3uED/
         qv6SnWlTL/fYDBMiWojQAYBEf1aZpKXS9dvkc9moeAYMnVzZZ7PBGLYgz46iqMBx24
         /SP4bDN9g4SASSUYgMtD2rd9djJAgi4w0dj2cY6p2ioiNlBTRsouHpfLlWDf9RQBxd
         rdKM/E4uhK66OK239potugBbYQg6cVsUgpXIIR3Dmbgj7aGZPf3SF7sJOARq2pejwG
         imGQwDTHElY8A==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oucXB-00058e-9M; Mon, 14 Nov 2022 17:42:09 +0100
Date:   Mon, 14 Nov 2022 17:42:09 +0100
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
Message-ID: <Y3Jv4ePkPiKiG8wj@hovoldconsulting.com>
References: <20221111092457.10546-1-johan+linaro@kernel.org>
 <20221111092457.10546-3-johan+linaro@kernel.org>
 <a22888cd-34cb-3453-0dc2-096da208564c@linaro.org>
 <Y3JCVzJ74YsfcDz4@hovoldconsulting.com>
 <de3a426a-03e8-ed15-a9a1-bb300e776e5f@linaro.org>
 <Y3JOO0kNnaNhnW3K@hovoldconsulting.com>
 <78cda6f8-849c-219a-8dbb-966c283c1a92@linaro.org>
 <Y3Jg/qmMW3rC5Okc@hovoldconsulting.com>
 <bcc327b6-c38b-86a9-34cb-440ad33df210@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bcc327b6-c38b-86a9-34cb-440ad33df210@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 07:14:48PM +0300, Dmitry Baryshkov wrote:
> On 14/11/2022 18:38, Johan Hovold wrote:
> > On Mon, Nov 14, 2022 at 06:19:25PM +0300, Dmitry Baryshkov wrote:
> >> On 14/11/2022 17:18, Johan Hovold wrote:
> >>> On Mon, Nov 14, 2022 at 03:07:41PM +0100, Krzysztof Kozlowski wrote:
> >>>> On 14/11/2022 14:27, Johan Hovold wrote:
> >>>>> On Fri, Nov 11, 2022 at 04:17:29PM +0100, Krzysztof Kozlowski wrote:
> >>>>>> On 11/11/2022 10:24, Johan Hovold wrote:
> > 
> >>>>> I noticed that several bindings leave the clock indexes unspecified, or
> >>>>> have header files defining some or all of them. I first added a QMP
> >>>>> header but that seemed like overkill, especially if we'd end up with
> >>>>> one header per SoC (cf. the GCC headers) due to (known and potential)
> >>>>> platform differences.
> > 
> >>>>> Shall I add back a shared header for all PHYs handled by this driver
> >>>>> (another implementation detail) even if this could eventually lead to
> >>>>> describing clocks not supported by a particular SoC (so such constraints
> >>>>> would still need to be described by the binding somehow):
> >>>>>
> >>>>> 	/* QMP clocks */
> >>>>> 	#define QMP_USB3_PIPE_CLK	0
> >>>>> 	#define QMP_DP_LINK_CLK		1
> >>>>> 	#define QMP_DP_VCO_DIV_CLK	2
> >>
> >> Maybe QMP_COMBO_USB3_PIPE_CLK, QMP_COMBO_DP_LINK_CLK,
> >> QMP_COMBO_DP_VCO_DIV_CLK?
> > 
> > "COMBO" is just the name of the Linux driver and does not belong in the
> > binding.
> 
> We do not have any standard (iow, coming from the docs) name, so we can 
> invent it on our own.

I still think the naming should reflect the hardware and not the Linux
implementation if this is going into the binding.

And the USB4_USB3_DP defines are going to be a superset of USB3_DP (as
far we know know).

> >> I'll then extend this header with QMP_UFS_RX_SYMBOL_0_CLK
> >> QMP_UFS_RX_SYMBOL_1_CLK and QMP_UFS_TX_SYMBOL_0_CLK.
> > 
> > Yeah, I had those in mind when creating the header and using a generic
> > QMP prefix (even if I didn't end up using the header in v1).
> > 
> > This could just be mapping of (arbitrary) QMP indexes to clocks and we
> > use it for USB3, DP, UFS and later also USB4.
> > 
> > This will however mean that the indexes are not necessarily zero-based
> > and consecutive for a specific SoC and PHY. But that's perhaps a
> > non-issue (cf. the PHY_TYPE defines).
> 
> Ugh. Please, no. We have symbol clocks for UFS PHY, USB+DP clocks for 
> USB+DP PHY, but let's not go for the unified clocks index definition.

Yeah, this is the kind of issues I wanted to avoid by not using a per
SoC header for three clocks which will almost always use the same
indexes.

Because how can you be sure that your unified per-PHY type defines will
never have to be amended? Or some index left out?

The only way then is to have per-SoC defines which is a pain to
maintain (just consider that driver mapping table when some odd SoC
shows up).

Johan
